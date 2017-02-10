import ceylon.dart.runtime.model {
    ModelClass = Class,
    ModelConstructor = Constructor
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
    CallableConstructorDeclaration? defaultConstructor {
        "A default constructor, if it exists, will be a callable constructor."
        assert (is CallableConstructorDeclaration? c
            =   getConstructorDeclaration(""));
        return c;
    }

    shared
    Boolean final => modelDeclaration.isFinal;

    shared
    ValueDeclaration? objectValue => nothing;

    shared
    FunctionOrValueDeclaration[]? parameterDeclarations
        =>  defaultConstructor?.parameterDeclarations;

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
    ConstructorDeclaration[] constructorDeclarations()
        =>  modelDeclaration.members
                .narrow<ModelConstructor>()
                // .distinct // shouldn't be necessary w/runtime model
                .collect(newConstructorDeclaration);

    shared
    <CallableConstructorDeclaration|ValueConstructorDeclaration>?
    getConstructorDeclaration(String name)
        =>  if (is ModelConstructor c = modelDeclaration.getDirectMember(name))
            then newConstructorDeclaration(c)
            else null;

    shared
    FunctionOrValueDeclaration? getParameterDeclaration(String name)
        =>  defaultConstructor?.getParameterDeclaration(name);

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
