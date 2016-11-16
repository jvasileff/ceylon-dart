import ceylon.dart.runtime.model {
    ModelConstructor = Constructor
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    ClassDeclaration,
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    ClosedType = Type,
    CallableConstructor,
    MemberClassCallableConstructor
}

class CallableConstructorDeclarationImpl(modelDeclaration)
        satisfies CallableConstructorDeclaration {

    shared ModelConstructor modelDeclaration;

    object helper satisfies FunctionalDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    Boolean abstract => nothing;

    shared actual
    Boolean defaultConstructor => nothing;

    shared actual
    Object invoke(ClosedType<>[] typeArguments, Anything* arguments)
        =>  nothing;

    shared actual
    CallableConstructor<Result,Arguments>
    apply<Result=Object,Arguments=Nothing>
            (ClosedType<>* typeArguments)
            given Arguments satisfies Anything[]
        =>  nothing;

    shared actual
    MemberClassCallableConstructor<Container,Result,Arguments>
    memberApply<Container=Nothing,Result=Object,Arguments=Nothing>
            (ClosedType<Object> containerType, ClosedType<>* typeArguments)
            given Arguments satisfies Anything[]
        =>  nothing;

    // FunctionalDeclaration

    annotation => helper.annotation;

    parameterDeclarations => helper.parameterDeclarations;

    getParameterDeclaration(String name) => getParameterDeclaration(name);

    shared actual
    Object memberInvoke
            (Object container, ClosedType<>[] typeArguments, Anything* arguments) {
        assert (exists result
            =   helper.memberInvoke(container, typeArguments, *arguments));
        return result;
    }

    // Declaration

    name => helper.name;
    qualifiedName => helper.qualifiedName;

    // GenericDeclaration

    typeParameterDeclarations => helper.typeParameterDeclarations;
    getTypeParameterDeclaration(String name) => helper.getTypeParameterDeclaration(name);

    // NestableDeclaration

    shared actual
    ClassDeclaration container {
        assert (is ClassDeclaration result = helper.container);
        return result;
    }

    actual => helper.actual;
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
