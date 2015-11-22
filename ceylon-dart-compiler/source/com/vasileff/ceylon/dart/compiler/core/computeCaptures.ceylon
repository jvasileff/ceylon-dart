import ceylon.ast.core {
    Visitor,
    BaseExpression,
    CompilationUnit,
    Declaration,
    DynamicBlock,
    DynamicInterfaceDefinition,
    DynamicModifier,
    DynamicValue
}

import com.redhat.ceylon.model.typechecker.model {
    FunctionOrValueModel=FunctionOrValue,
    ClassOrInterfaceModel=ClassOrInterface
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    BaseExpressionInfo
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
        void visitCompilationUnit(CompilationUnit that) {
            super.visitCompilationUnit(that);
        }

        shared actual
        void visitDeclaration(Declaration that) {
            // skip native declarations entirely, for now
            if (!isForDartBackend(that)) {
                return;
            }
            super.visitDeclaration(that);
        }

        shared actual
        void visitDynamicBlock(DynamicBlock that) {
            // 1. we don't currently support dynamic blocks
            // 2. visiting dynamic blocks results in NPEs when
            //    we try to obtain model objects.
            return;
        }

        shared actual
        void visitDynamicInterfaceDefinition(DynamicInterfaceDefinition that) {
            return;
        }

        shared actual
        void visitDynamicModifier(DynamicModifier that) {
            return;
        }

        shared actual
        void visitDynamicValue(DynamicValue that) {
            return;
        }

        shared actual
        void visitBaseExpression(BaseExpression that) {
            value info = BaseExpressionInfo(that);
            value targetDeclaration = info.declaration;

            value expressionsClassOrInterface
                =   getContainingClassOrInterface(that);

            value targetsClassOrInterface
                =>  getContainingClassOrInterface(targetDeclaration);

            // Capture is not required for:
            //  - class or interface members, which can be accessed via "outer" refs
            //  - toplevels, which can be accessed directly
            //  - declarations in the same class or interface as the expression,
            //    which can be accessed directly
            if (is FunctionOrValueModel targetDeclaration,
                exists expressionsClassOrInterface,
                !isClassOrInterfaceMember(targetDeclaration)
                    && !isToplevel(targetDeclaration)
                    && !eq(expressionsClassOrInterface, targetsClassOrInterface)) {

                capture(targetDeclaration, expressionsClassOrInterface);
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
        void capture(FunctionOrValueModel target, variable ClassOrInterfaceModel by) {
            // TODO Replacement declarations are captured even if we are not defining new
            //      Dart variables for them. We should problaby capture the original
            //      declaration in this case

            value targetsClassOrInterface => getContainingClassOrInterface(target);
            while (true) {
                value bysClassOrInterface = getContainingClassOrInterface(by.container);
                if (eq(targetsClassOrInterface, bysClassOrInterface)) {
                    builder.put(by, target);
                    return;
                }
                assert (exists bysClassOrInterface);
                by = bysClassOrInterface;
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
