import ceylon.ast.core {
    Key,
    ScopedKey
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node
}

shared
object keys {
    shared
    Key<TcNode> tcNode = ScopedKey<TcNode>(`value keys`, "tcNode");
}
