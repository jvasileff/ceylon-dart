import ceylon.dart.runtime.model {
    ModelClass = Class
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    NestableDeclaration,
    ClassWithConstructorsDeclaration,
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    Class,
    MemberClass,
    ClosedType=Type,
    Member,
    ClassOrInterface
}

class ClassWithConstructorsDeclarationImpl(modelDeclaration)
        satisfies ClassWithConstructorsDeclaration {

    shared ModelClass modelDeclaration;

    object helper satisfies ClassDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    string => "class ``qualifiedName``";

    // ClassDeclaration

    abstract => helper.abstract;
    annotation => helper.annotation;
    anonymous => helper.anonymous;
    defaultConstructor => helper.defaultConstructor;
    final => helper.final;
    objectValue => helper.objectValue;
    parameterDeclarations => helper.parameterDeclarations;
    serializable => helper.serializable;

    shared actual
    CallableConstructorDeclaration[] annotatedConstructorDeclarations<Annotation>()
            given Annotation satisfies AnnotationType
        =>  helper.annotatedConstructorDeclarations<Annotation>();

    shared actual
    Class<Type,Arguments> classApply<Type, Arguments>
            (ClosedType<Anything>* typeArguments)
            given Arguments satisfies Anything[]
        =>  helper.classApply<Type, Arguments>(*typeArguments);

    constructorDeclarations() => helper.constructorDeclarations();
    getConstructorDeclaration(String name) => helper.getConstructorDeclaration(name);
    getParameterDeclaration(String name) => helper.getParameterDeclaration(name);

    shared actual
    MemberClass<Container,Type,Arguments> memberClassApply<Container, Type, Arguments>
            (ClosedType<Object> containerType, ClosedType<Anything>* typeArguments)
            given Arguments satisfies Anything[]
        =>  helper.memberClassApply<Container, Type, Arguments>(
                    containerType, *typeArguments);

    // ClassOrInterfaceDeclaration

    caseTypes => helper.caseTypes;
    extendedType => helper.extendedType;
    isAlias => helper.isAlias;
    satisfiedTypes => helper.satisfiedTypes;

    shared actual
    Kind[] annotatedDeclaredMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType
        =>  helper.annotatedDeclaredMemberDeclarations<Kind, Annotation>();

    shared actual
    Kind[] annotatedMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType
        =>  helper.annotatedMemberDeclarations<Kind, Annotation>();

    shared actual
    ClassOrInterface<Type> apply<Type>
            (ClosedType<Anything>* typeArguments)
        =>  helper.apply<Type>(*typeArguments);

    shared actual
    Kind[] declaredMemberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
        =>  helper.declaredMemberDeclarations<Kind>();

    shared actual
    Kind? getDeclaredMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  helper.getDeclaredMemberDeclaration<Kind>(name);

    shared actual
    Kind? getMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  helper.getMemberDeclaration<Kind>(name);

    shared actual
    Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type>
    memberApply<Container, Type>(
            ClosedType<Object> containerType,
            ClosedType<Anything>* typeArguments)
        =>  helper.memberApply<Container, Type>(containerType, *typeArguments);

    shared actual
    Kind[] memberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
        =>  helper.memberDeclarations<Kind>();

    // Declaration

    name => helper.name;
    qualifiedName => helper.qualifiedName;

    // GenericDeclaration

    typeParameterDeclarations => helper.typeParameterDeclarations;
    getTypeParameterDeclaration(String name) => helper.getTypeParameterDeclaration(name);

    // NestableDeclaration

    actual => helper.actual;
    container => helper.container;
    containingModule => helper.containingModule;
    containingPackage => helper.containingPackage;
    default => helper.default;
    formal => helper.formal;
    shared => helper.shared;
    toplevel => helper.toplevel;

    // TypedDeclaration

    openType => helper.openType;

    // AnnotatedDeclaration

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType
        =>  helper.annotations<Annotation>();

    // Annotated

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType
        =>  helper.annotated<Annotation>();
}
