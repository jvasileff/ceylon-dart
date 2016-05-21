import ceylon.dart.runtime.model {
    ModuleModel=Module,
    PackageModel=Package
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    Import,
    FunctionDeclaration,
    ValueDeclaration,
    AliasDeclaration,
    ClassOrInterfaceDeclaration,
    NestableDeclaration
}
import ceylon.language {
    AnnotationType=Annotation
}

shared
class ModuleImpl(ModuleModel delegate) satisfies Module {
    shared actual Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Import[] dependencies => nothing;

    shared actual Package? findImportedPackage(String name) => nothing;

    shared actual Package? findPackage(String name) => nothing;

    shared actual [Package*] members => delegate.packages.collect(PackageImpl);

    shared actual String name => delegate.nameAsString;

    shared actual String qualifiedName => nothing;

    shared actual Resource? resourceByPath(String path) => nothing;

    shared actual String version => delegate.version else "unknownVersion";

    shared actual String string => "module ``name``/``version``";
}

shared
class PackageImpl(PackageModel delegate) satisfies Package {

    shared actual Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Kind[] annotatedMembers<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared actual Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Module container => ModuleImpl(delegate.mod);

    shared actual AliasDeclaration? getAlias(String name) => nothing;

    shared actual ClassOrInterfaceDeclaration? getClassOrInterface(String name) => nothing;

    shared actual FunctionDeclaration? getFunction(String name) => nothing;

    shared actual Kind? getMember<Kind>(String name)
            given Kind satisfies NestableDeclaration => nothing;

    shared actual ValueDeclaration? getValue(String name) => nothing;

    shared actual Kind[] members<Kind>()
            given Kind satisfies NestableDeclaration => nothing;

    shared actual String name => qualifiedName;

    shared actual String qualifiedName => delegate.qualifiedName;

    shared actual Boolean shared => nothing;

    shared actual String string => "package ``name``";
}
