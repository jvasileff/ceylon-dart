import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope
}
import ceylon.ast.core {
    Node
}
import com.vasileff.ceylon.dart.nodeinfo {
    NodeInfo
}

shared
interface DScope {
    shared formal ScopeModel scope;
    shared formal String location;
    shared formal String filename;
}

shared
DScope dScope(Node|NodeInfo node, ScopeModel scope = toScopeModel(node))
    =>  let (theScope = scope)
        object satisfies DScope {
            shared actual ScopeModel scope = theScope;
            shared actual String location;
            shared actual String filename;
            if (is Node node) {
                value info = NodeInfo(node);
                location = info.location;
                filename = info.filename;
            }
            else {
                location = node.location;
                filename = node.filename;
            }
        };
