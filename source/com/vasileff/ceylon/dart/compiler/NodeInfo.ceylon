import ceylon.ast.core {
    BaseExpression,
    Primary,
    Node
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree,
    Message
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    ReferenceModel=Reference,
    TypeModel=Type,
    TypedReferenceModel=TypedReference,
    Scope
}

class NodeInfo<out NodeType>(shared NodeType node)
        given NodeType satisfies Node {

    value tcNode = package.tcNode.node(node);

    shared
    String location => tcNode.location;

    shared
    Scope scope => tcNode.scope;

    shared
    {Message*} errors => CeylonList(tcNode.errors);
}

class PrimaryInfo<out NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType satisfies Primary {

    value tcNode = package.tcNode.primary(node);

    "The type of this expression"
    shared
    TypeModel typeModel
        //Term
        =>  tcNode.typeModel;
}

class BaseExpressionInfo(BaseExpression node)
        extends PrimaryInfo<BaseExpression>(node) {

    value tcNode = package.tcNode.baseExpression(node);

    // MemberOrTypeExpression

    "The declaration and type arguments of the target
     of the BaseExpression"
    shared
    ReferenceModel? target
        =>  tcNode.target;

    "The declaration of the target of the BaseExpression"
    shared
    DeclarationModel? declaration
        =>  tcNode.declaration;

    shared
    {TypeModel*}? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    shared
    TypedReferenceModel? targetParameter
        =>  tcNode.targetParameter;

    shared
    TypeModel? parameterType
        =>  tcNode.parameterType;
}

object tcNode {
    shared
    Tree.StaticMemberOrTypeExpression baseExpression
            (BaseExpression node) {
        assert (is Tree.StaticMemberOrTypeExpression
                tcNode = node.get(keys.tcNode));
        return tcNode;
    }

    shared
    Tree.Primary primary(Primary node) {
        assert (is Tree.Primary tcNode = node.get(keys.tcNode));
        return tcNode;
    }

    shared
    TcNode node(Node node) {
        assert (is TcNode tcNode = node.get(keys.tcNode));
        return tcNode;
    }
}
