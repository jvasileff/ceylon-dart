import ceylon.ast.core {
    Node
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo
}


// TODO better location info
shared
class CompilerBug(
        shared DScope|Node node, String description,
        Throwable? cause = null)
        extends Exception(
            let (DScope info = if (is DScope node) then node else NodeInfo(node))
            description + " at '``info.filename``: ``info.location``'") {}
