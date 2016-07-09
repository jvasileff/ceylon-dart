import ceylon.dart.runtime.model {
    Type,
    Scope
}

shared
Type parseTypeLG(String type)(Scope scope)
    =>  parseType(type, scope);
