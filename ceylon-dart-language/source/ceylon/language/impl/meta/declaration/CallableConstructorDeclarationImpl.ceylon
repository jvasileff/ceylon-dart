import ceylon.dart.runtime.model {
    ModelConstructor = Constructor,
    ModelCallableConstructor = CallableConstructor
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
    MemberClassCallableConstructor,
    IncompatibleTypeException,
    TypeApplicationException
}
import ceylon.language.impl.meta.model {
    modelTypeFromType,
    newCallableConstructor,
    newMemberClassCallableConstructor
}

class CallableConstructorDeclarationImpl(modelDeclaration)
        satisfies CallableConstructorDeclaration {

    shared ModelCallableConstructor modelDeclaration;

    object helper satisfies FunctionalDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    Boolean abstract => modelDeclaration.isAbstract;

    shared actual
    Boolean defaultConstructor => name.empty;

    shared actual
    Object invoke(ClosedType<>[] typeArguments, Anything* arguments)
        =>  nothing;

    shared actual
    CallableConstructor<Result, Arguments>
    staticApply<Result=Anything, Arguments=Nothing>
            (ClosedType<Object> containerType, ClosedType<>* typeArguments)
            given Arguments satisfies Anything[]
        =>  nothing; // TODO

    shared actual
    CallableConstructor<Result, Arguments>
    apply<Result=Object, Arguments=Nothing>
            (ClosedType<>* typeArguments)
            given Arguments satisfies Anything[] {

        if (!toplevel) {
            throw TypeApplicationException(
                "Cannot apply a member declaration with no container type: \
                 use memberApply");
        }

        value result
            =   newCallableConstructor {
                    modelDeclaration.appliedType {
                        modelTypeFromType {
                            container.apply<>(*typeArguments);
                        };
                        [];
                    };
                    null;
                };

        if (!is CallableConstructor<Result, Arguments> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Result or Arguments");
        }

        return result;
    }

    shared actual
    MemberClassCallableConstructor<Container,Result,Arguments>
    memberApply<Container=Nothing,Result=Object,Arguments=Nothing>
            (ClosedType<Object> containerType, ClosedType<>* typeArguments)
            given Arguments satisfies Anything[] {

        if (toplevel) {
            throw TypeApplicationException(
                "Cannot apply a toplevel declaration to a container type: use apply");
        }

        value result
            =   newMemberClassCallableConstructor {
                    modelDeclaration.appliedType {
                        modelTypeFromType {
                            container.memberApply<>(containerType, *typeArguments);
                        };
                        [];
                    };
                };

        if (!is MemberClassCallableConstructor<Container, Result, Arguments> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Container, Result or Arguments");
        }

        return result;
    }

    // FunctionalDeclaration

    annotation => helper.annotation;

    parameterDeclarations => helper.parameterDeclarations;

    getParameterDeclaration(String name) => helper.getParameterDeclaration(name);

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
    static => helper.static;

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
