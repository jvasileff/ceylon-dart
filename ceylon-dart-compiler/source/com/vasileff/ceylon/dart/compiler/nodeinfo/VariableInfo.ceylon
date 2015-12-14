import ceylon.ast.core {
    UnspecifiedVariable,
    Variable,
    SpecifiedVariable,
    VariadicVariable,
    TypedVariable
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    ValueModel=Value
}

shared abstract
class VariableInfo()
        of SpecifiedVariableInfo
            | UnspecifiedVariableInfo
            | TypedVariableInfo
            | VariadicVariableInfo
        extends NodeInfo() {
    shared actual formal Variable node;
}

shared final
class SpecifiedVariableInfo(shared actual SpecifiedVariable node)
        extends VariableInfo() {

    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class TypedVariableInfo(shared actual TypedVariable node)
        extends VariableInfo() {

    shared actual TcNode tcNode = getTcNode(node);
}

shared final
class UnspecifiedVariableInfo(shared actual UnspecifiedVariable node)
        extends VariableInfo() {

    // ForIterator -> VariablePattern -> UnspecifiedVariable
    //      Tree.ValueIterator -> Tree.Variable
    // ForIterator -> ... -> VariablePattern -> UnspecifiedValue
    //      Tree.PatternIterator -> Tree.VariablePattern -> Tree.Variable
    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class VariadicVariableInfo(shared actual VariadicVariable node)
        extends VariableInfo() {

    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}
