import ceylon.dart.runtime.model {
    ModelConstructor = Constructor
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    ClassDeclaration,
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    ClosedType = Type,
    ValueConstructor,
    MemberClassValueConstructor
}

class ValueConstructorDeclarationImpl(modelDeclaration)
        satisfies ValueConstructorDeclaration {

    shared ModelConstructor modelDeclaration;

    object helper satisfies NestableDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    ValueConstructor<Result> apply<Result=Object>()
        =>  nothing;

    shared actual
    MemberClassValueConstructor<Container,Result>
    memberApply<Container=Nothing,Result=Object>
            (ClosedType<Object> containerType)
        =>  nothing;

    // Declaration

    name => helper.name;
    qualifiedName => helper.qualifiedName;

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
