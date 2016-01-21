import ceylon.ast.core {
    Node,
    PositionalArguments
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo
}

TcNode? getTcNode(Node node)
    =>  if (is NodeData data = node.data)
        then data.tcNode
        else null;

shared
void augmentNode(TcNode tcNode, Node node) {
    node.data = NodeData(null, tcNode);

    // hack to populate info for synthetic node
    if (is PositionalArguments node,
        is Tree.SequencedArgument sa = getTcNode(node.argumentList),
            !sa.token exists) {
        sa.scope = tcNode.scope;
        sa.unit = tcNode.unit;
        sa.token = tcNode.token;
        sa.endToken = tcNode.endToken;
        for (error in tcNode.errors) {
            sa.addError(error);
        }
    }
}

shared class NodeData(shared NodeInfo? info, shared TcNode tcNode) {}
