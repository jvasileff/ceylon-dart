import ceylon.ast.core {
    Visitor,
    CompilationUnit,
    Assertion,
    IsCondition,
    ExistsOrNonemptyCondition
}

import com.redhat.ceylon.model.typechecker.model {
    ClassModel=Class,
    FunctionOrValueModel=FunctionOrValue,
    Element
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo
}
import com.vasileff.jl4c.guava.collect {
    ImmutableSetMultimapBuilder,
    ImmutableSet
}

shared
void computeClassCaptures(CompilationUnit unit, CompilationContext ctx) {
    // Note: This works, and is ok for now. But we should calculate captures for all
    //       declarations, not just those made by `assert`. And for `assert` replacements,
    //       perhaps a separate visitor should be used to figure out which replacment
    //       declarations we care about (rather than letting generateConditionExpression
    //       to this.)

    // Idea: Regarding replacements, see if we can make the decision to replace or not
    //       completely flexible, in order to try out different strategies. We would never
    //       be able to trust that declarations provided by the typechecker indicate
    //       correct types, but instead would need to search for the most refined
    //       declaration we are actually using in the Dart code. May not be too hard...
    //       withLhs (or withBoxing) could probably handle this.

    value builder = ImmutableSetMultimapBuilder<ClassModel, FunctionOrValueModel>();

    object classCaptureVisitor satisfies Visitor {

        shared actual
        void visitCompilationUnit(CompilationUnit that) {
            super.visitCompilationUnit(that);
        }

        shared actual
        void visitAssertion(Assertion that) {
            value info = NodeInfo(that);
            assert (is Element element = info.scope);

            ClassModel classModel;
            if (is ClassModel realScope = getRealScope(element)) {
                classModel = realScope;
            }
            else {
                return;
            }

            // Transform code using generateConditionExpression to find new declarations.
            // A bit slow, but should produce good results.
            value declarations
                =   that.conditions.conditions
                        .narrow<IsCondition | ExistsOrNonemptyCondition>()
                        .map(ctx.statementTransformer.generateConditionExpression)
                        .flatMap((conditionTuple) => conditionTuple[2...])
                        .map(VariableTriple.declarationModel);

            builder.putMultiple(classModel, *declarations);

            // Keep going, could have classes defined within an expression of a Condition!
            that.visitChildren(this);
        }
    }

    // Populate the `builder`
    unit.visit(classCaptureVisitor);

    // Save results to the context
    ctx.initializerCaptures = builder.build();
    ctx.capturedInitializerDeclarations = ImmutableSet(ctx.initializerCaptures.items);
}
