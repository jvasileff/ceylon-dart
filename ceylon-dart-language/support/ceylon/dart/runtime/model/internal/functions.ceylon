import ceylon.dart.runtime.model {
    TypeDeclaration,
    Class,
    ClassWithInitializer,
    ClassWithConstructors,
    Declaration,
    Value,
    Scope,
    Interface,
    Type,
    Package
}

shared
Boolean eq(Anything first, Anything second)
    =>  if (exists first, exists second)
        then first == second
        else (!first exists) && (!second exists);

shared
Type toType(Scope scope)(Type | Type(Scope) lt)
    =>  switch (lt)
        case (is Type) lt
        else (lt(scope));

shared
Value toValue(Scope scope)(Value | Value(Scope) lv)
    =>  switch (lv)
        case (is Value) lv
        else (lv(scope));

shared
Class assertedClass(Declaration? d) {
    assert (is Class d);
    return d;
}

shared
ClassWithInitializer assertedClassWithInitializer(Declaration? d) {
    assert (is ClassWithInitializer d);
    return d;
}

shared
ClassWithConstructors assertedClassWithConstructors(Declaration? d) {
    assert (is ClassWithConstructors d);
    return d;
}

shared
Interface assertedInterface(Declaration? d) {
    assert (is Interface d);
    return d;
}

shared
Package assertedPackage(Package? p) {
    assert (exists p);
    return p;
}

shared
TypeDeclaration assertedTypeDeclaration(Scope? declaration) {
    assert (is TypeDeclaration declaration);
    return declaration;
}

shared
Value assertedValue(Declaration? d) {
    assert (is Value d);
    return d;
}

shared
Return? omap<Return, Argument>
        (Return(Argument) collecting)(Argument? item)
    =>  if (exists item)
        then collecting(item)
        else null;

shared
[Element&Object]|[] opt<Element>(Element element)
    =>  emptyOrSingleton<Element>(element);
