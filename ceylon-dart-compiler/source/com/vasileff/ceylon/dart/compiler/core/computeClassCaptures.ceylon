import ceylon.ast.core {
    Visitor,
    CompilationUnit,
    Assertion,
    IsCondition,
    ExistsOrNonemptyCondition,
    Node
}

import com.redhat.ceylon.model.typechecker.model {
    ClassModel=Class,
    FunctionOrValueModel=FunctionOrValue,
    Element
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    nodeInfo
}
import com.vasileff.ceylon.structures {
    HashMultimap
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

    value initializerCaptures = HashMultimap<ClassModel, FunctionOrValueModel>();

    object classCaptureVisitor satisfies Visitor {

        shared actual
        void visitNode(Node that) {
            // ceylon.ast 1.2.0 optimization
            for (child in that.children) {
                child.visit(this);
            }
        }

        shared actual
        void visitCompilationUnit(CompilationUnit that) {
            super.visitCompilationUnit(that);
        }

        shared actual
        void visitAssertion(Assertion that) {
            value info = nodeInfo(that);
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
                        .map((condition)
                            =>  if (is IsCondition | ExistsOrNonemptyCondition condition)
                                then condition
                                else null)
                        .coalesced
                        .map(ctx.statementTransformer.generateConditionExpression)
                        .flatMap((conditionTuple) => conditionTuple[2...])
                        .map(VariableTriple.declarationModel);

            initializerCaptures.putMultiple(classModel, declarations);

            // Keep going, could have classes defined within an expression of a Condition!
            that.visitChildren(this);
        }
    }

    // Populate the `builder`
    unit.visit(classCaptureVisitor);

    // Save results to the context
    ctx.initializerCaptures = initializerCaptures;
    ctx.capturedInitializerDeclarations = set(ctx.initializerCaptures.items);
}
