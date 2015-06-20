import ceylon.ast.core {
    Node
}

// TODO better location info
shared
class CompilerBug(
        shared Node node, String description,
        Throwable? cause = null)
        extends Exception(description + " at "
                    + NodeInfo(node).location, cause) {}
