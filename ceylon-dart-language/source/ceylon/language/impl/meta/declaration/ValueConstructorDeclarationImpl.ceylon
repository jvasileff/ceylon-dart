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
    MemberClassValueConstructor,
    TypeApplicationException,
    IncompatibleTypeException
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
    ValueConstructor<Result> apply<Result = Object>() {
        if (!toplevel) {
            throw TypeApplicationException(
                "Cannot apply a member declaration with no container type: \
                 use memberApply");
        }

        value result
            =   newValueConstructor {
                    modelDeclaration.appliedType {
                        modelTypeFromType {
                            container.apply<>();
                        };
                        [];
                    };
                    null;
                };

        if (!is ValueConstructor<Result> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Result");
        }

        return result;
    }

    shared actual
    MemberClassValueConstructor<Container, Result>
    memberApply<Container=Nothing, Result=Object>
            (ClosedType<Object> containerType) {

        if (toplevel) {
            throw TypeApplicationException(
                "Cannot apply a toplevel declaration to a container type: use apply");
        }

        value result
            =   newMemberClassValueConstructor {
                    modelDeclaration.appliedType {
                        modelTypeFromType {
                            container.memberApply<>(containerType);
                        };
                        [];
                    };
                };

        if (!is MemberClassValueConstructor<Container, Result> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Container or Result");
        }

        return result;
    }

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
