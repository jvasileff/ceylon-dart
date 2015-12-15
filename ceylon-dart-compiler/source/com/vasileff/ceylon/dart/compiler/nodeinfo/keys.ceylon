import ceylon.ast.core {
    Key,
    ScopedKey,
    Node
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node
}

"A Ceylon box for the Java typechecker node to be used as a performance
 workaround for https://github.com/ceylon/ceylon.ast/issues/108"
shared class NodeBox(shared TcNode node) {}

shared
object keys {
    shared
    Key<NodeBox> tcNode = ScopedKey<NodeBox>(`value keys`, "tcNode");
}

TcNode getTcNode(Node astNode) {
    assert (exists nodeBox = astNode.get(keys.tcNode));
    return nodeBox.node;
}
