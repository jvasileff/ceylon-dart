import ceylon.language {
    CString = String
}

shared abstract
class String() {
    // TODO support Dart constructors

    shared formal CString toLowerCase();
    shared formal CString toUpperCase();
    shared formal CString trim();
    shared formal CString trimLeft();
    shared formal CString trimRight();
}
