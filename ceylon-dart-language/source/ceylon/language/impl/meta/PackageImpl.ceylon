import ceylon.dart.runtime.model {
    PackageModel=Package,
    ClassModel=Class
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    FunctionDeclaration,
    ValueDeclaration,
    AliasDeclaration,
    ClassOrInterfaceDeclaration,
    NestableDeclaration
}

shared
class PackageImpl(PackageModel delegate) satisfies Package {

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Kind[] annotatedMembers<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Module container
        =>  ModuleImpl(delegate.mod);

    shared actual
    AliasDeclaration? getAlias(String name)
        =>  nothing;

    shared actual
    ClassOrInterfaceDeclaration? getClassOrInterface(String name)
        =>  nothing;

    shared actual
    FunctionDeclaration? getFunction(String name)
        =>  nothing;

    shared actual
    Kind? getMember<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  nothing;

    shared actual
    ValueDeclaration? getValue(String name)
        =>  nothing;

    shared actual
    Kind[] members<Kind>()
            given Kind satisfies NestableDeclaration
        // TODO filter out native headers, support all declaration types
        =>  delegate.members.items
                .narrow<ClassModel>() // just classes for now...
                .map(ClassWithConstructorsDeclarationImpl) // ignoring withInitializer
                .narrow<Kind>()
                .sequence();

    shared actual
    String name
        =>  qualifiedName;

    shared actual
    String qualifiedName
        =>  delegate.qualifiedName;

    shared actual
    Boolean shared
        =>  nothing;

    shared actual
    String string
        =>  "package ``name``";
}
