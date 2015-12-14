import ceylon.ast.core {
    NamedArgument,
    SpecifiedArgument,
    AnonymousArgument,
    InlineDefinitionArgument,
    FunctionArgument,
    ValueArgument,
    ObjectArgument
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    ParameterModel=Parameter,
    ClassModel=Class,
    FunctionModel=Function
}

shared abstract
class NamedArgumentInfo()
        of AnonymousArgumentInfo
            | SpecifiedArgumentInfo
            | InlineDefinitionArgumentInfo
        extends NodeInfo() {

    shared actual formal NamedArgument node;

    shared actual formal Tree.NamedArgument tcNode;

    shared ParameterModel parameter => tcNode.parameter;
}

shared final
class AnonymousArgumentInfo(shared actual AnonymousArgument node)
        extends NamedArgumentInfo() {

    shared alias TcNodeType => Tree.SpecifiedArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class InlineDefinitionArgumentInfo()
        of ValueArgumentInfo
            | FunctionArgumentInfo
            | ObjectArgumentInfo
        extends NamedArgumentInfo() {

    shared actual formal InlineDefinitionArgument node;
}

shared
class FunctionArgumentInfo(shared actual FunctionArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.MethodArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared FunctionModel declarationModel
        =>  tcNode.declarationModel;
}

shared
class ObjectArgumentInfo(shared actual ObjectArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.ObjectArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class ValueArgumentInfo(shared actual ValueArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.AttributeArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class SpecifiedArgumentInfo(shared actual SpecifiedArgument node)
        extends NamedArgumentInfo() {

    shared alias TcNodeType
        =>  Tree.SpecifiedArgument | Tree.AttributeArgument | Tree.MethodArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}
