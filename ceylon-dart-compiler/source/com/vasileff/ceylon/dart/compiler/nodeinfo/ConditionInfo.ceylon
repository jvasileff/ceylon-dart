import ceylon.ast.core {
    NonemptyCondition,
    ExistsCondition,
    ExistsOrNonemptyCondition,
    IsCondition,
    BooleanCondition
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    ValueModel=Value
}

shared abstract sealed
class ConditionInfo()
        of BooleanConditionInfo | IsConditionInfo | ExistsOrNonemptyConditionInfo
        extends NodeInfo() {}

shared final sealed
class BooleanConditionInfo(shared actual BooleanCondition node)
        extends ConditionInfo() {

    shared actual TcNode tcNode = getTcNode(node);
}

shared abstract
class ExistsOrNonemptyConditionInfo()
        of ExistsConditionInfo | NonemptyConditionInfo
        extends ConditionInfo() {

    shared actual formal ExistsOrNonemptyCondition node;

    shared actual formal Tree.ExistsOrNonemptyCondition tcNode;

    /*
        tcNode.variable is one of:

        1. a `Tree.Variable` with type `Tree.SyntheticVariable`, or
        2. a `Tree.Variable` with type `Tree.StaticType|Tree.ValueModifier`, or
        3. a `Tree.Destructure`

        For 1, we are testing an existing variable, and will have astNode.tested is
            LIdentifier

        For 2, we are testing and defining a new variable, and will have
            astNode.tested is SpecifiedPattern w/ VariablePattern

        For 3, we are destructuring, and will have
            astNode.tested is SpecifiedPattern w/ TuplePattern | EntryPattern
    */

    "The type of the replacement variable for this [[ExistsOrNonemptyCondition]],
     or [[Null]] if this condition defines a new variable or involves a destructure."
    shared ValueModel? variableDeclarationModel
        // We could leave off the Tree.SyntheticVariable test if we wanted to return
        // declarations for case 2 as well.
        =>  if (is Tree.Variable v = tcNode.variable,
                v.type is Tree.SyntheticVariable)
            then v.declarationModel
            else null;
}

shared final
class ExistsConditionInfo(shared actual ExistsCondition node)
        extends ExistsOrNonemptyConditionInfo() {

    shared alias TcNodeType => Tree.ExistsOrNonemptyCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class NonemptyConditionInfo(shared actual NonemptyCondition node)
        extends ExistsOrNonemptyConditionInfo() {

    shared alias TcNodeType => Tree.ExistsOrNonemptyCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class IsConditionInfo(shared actual IsCondition node)
        extends ConditionInfo() {

    shared alias TcNodeType => Tree.IsCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel variableDeclarationModel => tcNode.variable.declarationModel;
}
