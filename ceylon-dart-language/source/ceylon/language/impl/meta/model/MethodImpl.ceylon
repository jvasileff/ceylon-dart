import ceylon.language.dart {
    CustomCallable
}
import ceylon.language.impl.meta.declaration {
    newFunctionDeclaration
}
import ceylon.language.meta {
    metaType = type
}
import ceylon.language.meta.declaration {
    FunctionDeclaration
}
import ceylon.language.meta.model {
    Method, Function,
    IncompatibleTypeException
}
import ceylon.dart.runtime.model {
    ModelFunction = Function,
    ModelTypedReference = TypedReference
}

class MethodImpl<in Container, out Type, in Arguments>(modelReference)
        satisfies Method<Container, Type, Arguments>
                & CustomCallable<Function<Type, Arguments>, [Container]>
        given Arguments satisfies Anything[] {

    shared ModelTypedReference modelReference;

    "The declaration for a Function Type must be a Function"
    assert (modelReference.declaration is ModelFunction);

    shared
    Function<Type, Arguments> bindSafe(Container container)
        =>  unsafeCast<Function<Type, Arguments>>(newFunction(modelReference, container));

    shared actual
    Function<Type, Arguments>(Container) invoke
        =   bindSafe;

    object helper
            satisfies FunctionModelHelper<Type, Arguments>
                    & MemberHelper {
        modelReference => outer.modelReference;
    }

    shared actual
    FunctionDeclaration declaration {
        assert (is ModelFunction model = modelReference.declaration);
        return newFunctionDeclaration(model);
    }

    shared actual
    Function<Type, Arguments> bind(Anything container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container else "<null>"``, expected type \
                 `` `Container` `` but got `` metaType(container) ``");
        }
        return bindSafe(container);
    }

    // Member

    declaringType => helper.declaringType;

    // Functional

    type => helper.type;

    // FunctionModel

    parameterTypes => helper.parameterTypes; 

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;

    // Model

    container => helper.container;

    // Object

    string => helper.string;
}
