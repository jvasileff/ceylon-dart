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
    ClosedType = Type,
    MemberClass,
    Class,
    IncompatibleTypeException
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
            (ClosedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] {

        value result = apply<>(*typeArguments);

        if (!is Class<Type, Arguments> result) {
            // TODO Improve
            throw IncompatibleTypeException("Incorrect Type, or Arguments");
        }

        return result;
    }

    shared
    ConstructorDeclaration[] constructorDeclarations() => nothing;

    shared
    <CallableConstructorDeclaration|ValueConstructorDeclaration>?
    getConstructorDeclaration(String name) => nothing;

    shared
    FunctionOrValueDeclaration? getParameterDeclaration(String name) => nothing;

    shared
    MemberClass<Container,Type,Arguments> memberClassApply<Container, Type, Arguments>
            (ClosedType<Object> containerType, ClosedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] {

        value result = memberApply<>(containerType, *typeArguments);

        if (!is MemberClass<Container,Type,Arguments> result) {
            // TODO Improve. The JVM code claims to do better with
            //      checkReifiedTypeArgument()
            throw IncompatibleTypeException("Incorrect Container, Type, or Arguments");
        }

        return result;
    }

    string => "class ``qualifiedName``";
}
