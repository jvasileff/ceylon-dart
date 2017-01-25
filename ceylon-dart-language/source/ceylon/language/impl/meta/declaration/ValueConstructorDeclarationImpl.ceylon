import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor
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
import ceylon.language.impl.meta.model {
    modelTypeFromType,
    newValueConstructor,
    newMemberClassValueConstructor
}

class ValueConstructorDeclarationImpl(modelDeclaration)
        satisfies ValueConstructorDeclaration {

    shared ModelValueConstructor modelDeclaration;

    object helper satisfies NestableDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    ValueConstructor<Result> apply<Result=Object>()
        =>  newValueConstructor<Result> {
                modelDeclaration.appliedType {
                    modelTypeFromType {
                        // TODO call with <> and perform our own type arg checking
                        container.apply<Result>();
                    };
                    [];
                };
            };

    shared actual
    MemberClassValueConstructor<Container, Result>
    memberApply<Container=Nothing, Result=Object>
            (ClosedType<Object> containerType)
        =>  newMemberClassValueConstructor<Container, Result> {
                modelDeclaration.appliedType {
                    modelTypeFromType {
                        // TODO call with <> and perform our own type arg checking
                        container.memberApply<Container, Result>(containerType);
                    };
                    [];
                };
            };

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
