import ceylon.dart.runtime.model {
    ClassModel=Class
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    ValueDeclaration,
    NestableDeclaration,
    ClassWithConstructorsDeclaration,
    FunctionOrValueDeclaration,
    CallableConstructorDeclaration,
    ConstructorDeclaration,
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    Class,
    MemberClass,
    AppliedType=Type,
    Member,
    ClassOrInterface
}

shared class ClassWithConstructorsDeclarationImpl(delegate)
        extends ClassOrInterfaceDeclarationImpl()
        satisfies ClassWithConstructorsDeclaration {

    shared actual ClassModel delegate;

    shared actual CallableConstructorDeclaration[]
    annotatedConstructorDeclarations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Boolean annotation => nothing;

    shared actual Boolean anonymous => delegate.isAnonymous;

    shared actual Class<Type,Arguments> classApply<Type, Arguments>
            (AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared actual CallableConstructorDeclaration defaultConstructor => nothing;

    shared actual Boolean final => delegate.isFinal;

    shared actual Boolean abstract => delegate.isAbstract;

    shared actual FunctionOrValueDeclaration? getParameterDeclaration
            (String name) => nothing;

    shared actual MemberClass<Container,Type,Arguments> memberClassApply
            <Container, Type, Arguments>
            (AppliedType<Object> containerType, AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared actual ValueDeclaration? objectValue => nothing;

    shared actual FunctionOrValueDeclaration[] parameterDeclarations => nothing;

    shared actual Boolean serializable => nothing;

    shared actual ConstructorDeclaration[] constructorDeclarations() => nothing;

    shared actual <CallableConstructorDeclaration|ValueConstructorDeclaration>?
    getConstructorDeclaration(String name) => nothing;

    string => "class ``qualifiedName``";

    // FROM ClassOrInterfaceDeclaration

    caseTypes => caseTypesImpl;
    extendedType => extendedTypeImpl;
    isAlias => isAliasImpl;
    satisfiedTypes => satisfiedTypesImpl;

    shared actual Kind[] annotatedDeclaredMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType
        =>  annotatedDeclaredMemberDeclarationsImpl<Kind, Annotation>();

    shared actual Kind[] annotatedMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType
        =>  annotatedMemberDeclarationsImpl<Kind, Annotation>();

    shared actual ClassOrInterface<Type> apply<Type>
            (AppliedType<Anything>* typeArguments)
        =>  applyImpl<Type>(*typeArguments);

    shared actual Kind[] declaredMemberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
        =>  declaredMemberDeclarationsImpl<Kind>();

    shared actual Kind? getDeclaredMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  getDeclaredMemberDeclarationImpl<Kind>(name);

    shared actual Kind? getMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  getMemberDeclarationImpl<Kind>(name);

    shared actual Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type>
    memberApply<Container, Type>(
            AppliedType<Object> containerType,
            AppliedType<Anything>* typeArguments)
        =>  memberApplyImpl<Container, Type>(containerType, *typeArguments);

    shared actual Kind[] memberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
        =>  memberDeclarationsImpl<Kind>();

    // FROM Declaration

    name => nameImpl;
    qualifiedName => qualifiedNameImpl;

    // FROM GenericDeclaration

    typeParameterDeclarations => typeParameterDeclarationsImpl;
    getTypeParameterDeclaration(String name) => getTypeParameterDeclarationImpl(name);

    // FROM NestableDeclaration

    actual => actualImpl;
    container => containerImpl;
    containingModule => containingModuleImpl;
    containingPackage => containingPackageImpl;
    default => defaultImpl;
    formal => formalImpl;
    shared => sharedImpl;
    toplevel => toplevelImpl;

    // FROM TypedDeclaration

    openType => openTypeImpl;

    // FROM AnnotatedDeclaration

    shared actual Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType
        =>  annotationsImpl<Annotation>();

    // FROM Annotated

    shared actual Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType
        =>  annotatedImpl<Annotation>();
}
