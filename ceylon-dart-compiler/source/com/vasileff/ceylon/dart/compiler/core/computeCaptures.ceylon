import ceylon.ast.core {
    Visitor,
    BaseExpression,
    CompilationUnit,
    Declaration,
    DynamicBlock,
    DynamicInterfaceDefinition,
    DynamicModifier,
    DynamicValue,
    Node,
    ValueSpecification,
    ClassAliasDefinition,
    ClassDefinition
}

import com.redhat.ceylon.compiler.typechecker.tree {
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    FunctionOrValueModel=FunctionOrValue,
    ClassOrInterfaceModel=ClassOrInterface,
    ValueModel=Value,
    ClassModel=Class,
    ConstructorModel=Constructor,
    InterfaceModel=Interface
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    BaseExpressionInfo,
    ValueSpecificationInfo,
    getTcNode,
    AnyClassInfo,
    NodeInfo
}
import com.vasileff.jl4c.guava.collect {
    LinkedHashMultimap,
    ImmutableSetMultimap
}

"Identify captured functions and values. For each class and interface, determine list of
 captures. Store results in [[ctx]] properties [[CompilationContext.capturedDeclarations]]
 and [[CompilationContext.captures]]."
shared
void computeCaptures(CompilationUnit unit, CompilationContext ctx) {

    value builder = LinkedHashMultimap<ClassOrInterfaceModel, FunctionOrValueModel>();

    "For proper operation, this visitor must be visited by a [[CompilationUnit]]."
    object captureVisitor satisfies Visitor {

        shared actual
        void visitNode(Node that) {
            // ceylon.ast 1.2.0 optimization
            for (child in that.children) {
                child.visit(this);
            }
        }

        shared actual
        void visitDeclaration(Declaration that) {
            // skip native declarations entirely, for now
            if (isForDartBackend(that)) {
                super.visitDeclaration(that);
            }
        }

        shared actual
        void visitDynamicBlock(DynamicBlock that) {
            // 1. we don't currently support dynamic blocks
            // 2. visiting dynamic blocks results in NPEs when
            //    we try to obtain model objects.
        }

        shared actual
        void visitDynamicInterfaceDefinition(DynamicInterfaceDefinition that) {}

        shared actual
        void visitDynamicModifier(DynamicModifier that) {}

        shared actual
        void visitDynamicValue(DynamicValue that) {}

        shared actual
        void visitValueSpecification(ValueSpecification that) {
            // TODO ask Lucas to include the BaseExpression | QualifiedExpression as
            //      a child node, so we don't have to create our own.
            //      And, use separate nodes for named-args vs non-named-args
            //      specifications. Trying to re-use the same class for two very
            //      different things will be very difficult.
            //
            //      For now, hack in an exception to not try to create a NodeInfo if
            //      this ValueSpecification is for a named argument.

            if (getTcNode(that) is Tree.SpecifierStatement) {
                value info = ValueSpecificationInfo(that);
                info.target.visit(this);
            }
            that.specifier.visit(this);
        }

        shared actual
        void visitClassAliasDefinition(ClassAliasDefinition that) {
            value info = AnyClassInfo(that);

            // Only capture for shared member classes aliases
            if (info.declarationModel.shared && !info.declarationModel.toplevel) {
                captureForClass(info, info.declarationModel);
            }
        }

        shared actual
        void visitClassDefinition(ClassDefinition that) {
            value info = AnyClassInfo(that);

            // Only capture for shared member classes
            if (info.declarationModel.shared && !info.declarationModel.toplevel) {
                // Capture any captures made by the supertypes of the member class!
                // We'll need these for the generated member class factory method.
                captureForClass(info, info.declarationModel);
            }

            super.visitClassDefinition(that);
        }

        shared actual
        void visitBaseExpression(BaseExpression that) {
            value info
                =   BaseExpressionInfo(that);

            value targetDeclaration
                =   info.declaration;

            assert (is FunctionOrValueModel | InterfaceModel
                    | ClassModel | ConstructorModel targetDeclaration);

            switch (targetDeclaration)
            case (is InterfaceModel) {
                return;
            }
            case (is ClassModel | ConstructorModel) {
                captureForClass(info, targetDeclaration);
            }
            case (is FunctionOrValueModel) {
                maybeCapture {
                    targetDeclaration;
                    getContainingClassOrInterface(toScopeModel(targetDeclaration));
                    getContainingClassOrInterface(info.scope);
                };
            }
        }

        void captureForClass(
            NodeInfo info,
            ClassModel | ConstructorModel declaration) {

            value classModel
                =   getClassOfConstructor(resolveClassAliases(declaration));

            // capture all that the class captures.
            value targets
                =   supertypeDeclarations(classModel)
                        .flatMap(builder.get)
                        .distinct;

            for (target in targets) {
                value expressionsClassOrInterface
                    =   getContainingClassOrInterface(info.scope);

                value targetsClassOrInterface
                    =>  getContainingClassOrInterface(toScopeModel(target));

                maybeCapture {
                    target;
                    targetsClassOrInterface;
                    expressionsClassOrInterface;
                };
            }
        }

        void maybeCapture(
                FunctionOrValueModel target,
                ClassOrInterfaceModel? targetsClassOrInterface,
                ClassOrInterfaceModel? by) {

            // Capture is not required for:
            //  - class or interface members, which can be accessed via "outer" refs
            //  - toplevels, which can be accessed directly
            //  - declarations in the same class or interface as the expression,
            //    which can be accessed directly

            if (exists by,
                !isClassOrInterfaceMember(target)
                    && !isToplevel(target)
                    && !eq(by, targetsClassOrInterface)) {

                capture {
                    target;
                    targetsClassOrInterface;
                    by;
                };

                // Also capture the setter, if one exists
                if (is ValueModel target,
                        exists setter = target.setter) {
                    capture {
                        setter;
                        targetsClassOrInterface;
                        by;
                    };
                }
            }
        }

        """
           Mark [[target]] as captured by [[by]] or [[by]]'s ancestor class or interface
           that shares a containing class or interface with [[target]]. In the example:

                void run() {
                    value x = "";
                    Interface I1 {
                        Interface I2 {
                            shared String foo => x;
                        }
                    }
                }

           the inputs to this function would be "value x" and "interface I2", and the
           resultant capture would be "value x" by "Interface I1".
        """
        void capture(FunctionOrValueModel target,
                ClassOrInterfaceModel? targetsClassOrInterface,
                variable ClassOrInterfaceModel by) {

            // TODO Replacement declarations are captured even if we are not defining new
            //      Dart variables for them. We should problaby capture the original
            //      declaration in this case

            while (true) {
                value byClassOrInterface = getContainingClassOrInterface(by.container);
                if (eq(targetsClassOrInterface, byClassOrInterface)) {
                    builder.put(by, target);
                    return;
                }
                assert (exists byClassOrInterface);
                by = byClassOrInterface;
            }
        }
    }

    unit.visit(captureVisitor);

    "Is the capture also captured by a supertype?"
    function redundant(ClassOrInterfaceModel->FunctionOrValueModel entry)
        =>  let (by->target = entry)
            supertypeDeclarations(by).skip(1).any((d)
                =>  builder.contains(d->target));

    value captures = ImmutableSetMultimap(builder.filter(not(redundant)));
    ctx.captures = captures;
    ctx.capturedDeclarations = captures.inverse;
}
