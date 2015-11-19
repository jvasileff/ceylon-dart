import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope
}
import ceylon.ast.core {
    Node
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo
}

shared
interface DScope {
    shared formal Node node;
    shared formal NodeInfo nodeInfo;
    shared formal ScopeModel scope;
}
