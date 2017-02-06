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

class MethodImpl<in Container=Nothing, out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies Method<Container, Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelTypedReference modelType;

    "The declaration for a Function Type must be a Function"
    assert (modelType.declaration is ModelFunction);

    object helper
            satisfies FunctionModelHelper<Type, Arguments>
                    & MemberHelper {
        modelType => outer.modelType;
    }

    shared actual
    FunctionDeclaration declaration {
        assert (is ModelFunction model = modelType.declaration);
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
        =>  unsafeCast<Function<Type, Arguments>>(newFunction(modelType, container));

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
