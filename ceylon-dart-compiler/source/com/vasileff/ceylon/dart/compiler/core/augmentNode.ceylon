import ceylon.ast.core {
    Node,
    PositionalArguments
}
import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    keys,
    NodeBox
}

shared
void augmentNode(TcNode tcNode, Node node) {
    node.set(keys.tcNode, NodeBox(tcNode));

    // hack to populate info for synthetic node
    if (is PositionalArguments node,
        is Tree.SequencedArgument sa = node.argumentList.get(keys.tcNode)?.node,
            !sa.token exists) {
        sa.scope = tcNode.scope;
        sa.unit = tcNode.unit;
        sa.token = tcNode.token;
        sa.endToken = tcNode.endToken;
        for (error in CeylonIterable(tcNode.errors)) {
            sa.addError(error);
        }
    }
}
