import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope
}

shared
interface DScope {
    shared formal ScopeModel scope;

    shared formal void addError(String string);

    shared formal void addUnsupportedError(String string);

    shared formal void addUnexpectedError(String string);

    shared formal void addWarning(Warning warning, String message);
}
