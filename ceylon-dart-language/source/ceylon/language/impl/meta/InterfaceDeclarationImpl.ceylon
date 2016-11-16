import ceylon.dart.runtime.model {
    ModelInterface = Interface
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    InterfaceDeclaration,
    NestableDeclaration
}
import ceylon.language.meta.model {
    Interface,
    MemberInterface,
    AppliedType = Type,
    Member,
    ClassOrInterface
}

shared
class InterfaceDeclarationImpl(modelDeclaration)
        satisfies InterfaceDeclaration {

    shared ModelInterface modelDeclaration;

    object helper satisfies ClassOrInterfaceDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual Interface<Type> interfaceApply<Type=Anything>
            (AppliedType<>* typeArguments)
        =>  nothing;

    shared actual MemberInterface<Container, Type> memberInterfaceApply
            <Container=Nothing, Type=Anything>
            (AppliedType<Object> containerType, AppliedType<>* typeArguments)
        =>  nothing;

    string => "interface ``qualifiedName``";

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
            (AppliedType<Anything>* typeArguments)
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
            AppliedType<Object> containerType,
            AppliedType<Anything>* typeArguments)
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
