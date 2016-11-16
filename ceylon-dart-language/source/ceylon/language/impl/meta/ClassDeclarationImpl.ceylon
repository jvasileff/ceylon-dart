import ceylon.dart.runtime.model {
    ModelClass = Class
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    ValueDeclaration,
    FunctionOrValueDeclaration,
    CallableConstructorDeclaration,
    ConstructorDeclaration,
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    AppliedType = Type,
    MemberClass,
    Class
}

interface ClassDeclarationHelper
        satisfies ClassOrInterfaceDeclarationHelper {

    shared actual formal
    ModelClass modelDeclaration;

    shared
    Boolean abstract => modelDeclaration.isAbstract;

    shared
    Boolean annotation => modelDeclaration.isAnnotation;

    shared
    Boolean anonymous => modelDeclaration.isAnonymous;

    shared
    CallableConstructorDeclaration? defaultConstructor => nothing;

    shared
    Boolean final => modelDeclaration.isFinal;

    shared
    ValueDeclaration? objectValue => nothing;

    shared
    FunctionOrValueDeclaration[] parameterDeclarations => nothing;

    shared
    Boolean serializable => nothing;

    shared
    CallableConstructorDeclaration[] annotatedConstructorDeclarations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared
    Class<Type,Arguments> classApply<Type, Arguments>
            (AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared
    ConstructorDeclaration[] constructorDeclarations() => nothing;

    shared
    <CallableConstructorDeclaration|ValueConstructorDeclaration>?
    getConstructorDeclaration(String name) => nothing;

    shared
    FunctionOrValueDeclaration? getParameterDeclaration(String name) => nothing;

    shared
    MemberClass<Container,Type,Arguments> memberClassApply<Container, Type, Arguments>
            (AppliedType<Object> containerType, AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    string => "class ``qualifiedName``";
}
