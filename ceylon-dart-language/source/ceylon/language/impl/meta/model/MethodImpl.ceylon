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
        given Arguments satisfies Anything[] {

    shared ModelTypedReference modelReference;

    "The declaration for a Function Type must be a Function"
    assert (modelReference.declaration is ModelFunction);

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
    Function<Type, Arguments> bind(Object container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container``, expected type `` `Container` `` \
                 but got `` metaType(container) ``");
        }
        return bindSafe(container);
    }

    shared
    Function<Type, Arguments> bindSafe(Container container)
        =>  unsafeCast<Function<Type, Arguments>>(newFunction(modelReference, container));

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
