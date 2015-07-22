import ceylon.ast.core {
    Node
}

// TODO better location info
shared
class CompilerBug(
        shared Node node, String description,
        Throwable? cause = null)
        extends Exception(
            let (NodeInfo info = NodeInfo(node))
            description + " at '``info.filename``: ``info.location``'") {}
