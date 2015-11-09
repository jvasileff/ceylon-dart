import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope
}

shared
interface DScope {
    shared formal ScopeModel scope;
    shared formal String location;
    shared formal String filename;
}
