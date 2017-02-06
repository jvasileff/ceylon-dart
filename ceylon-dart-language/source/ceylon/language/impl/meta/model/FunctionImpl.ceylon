import ceylon.language.impl.meta.declaration {
    newFunctionDeclaration
}
import ceylon.language.meta.declaration {
    FunctionDeclaration
}
import ceylon.language.meta.model {
    Function
}
import ceylon.dart.runtime.model {
    ModelPackage = Package,
    ModelFunction = Function,
    ModelTypedReference = TypedReference
}

class FunctionImpl<out Type=Anything, in Arguments=Nothing>
        (modelType, qualifyingInstance)
        satisfies Function<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelTypedReference modelType;
    Anything qualifyingInstance;

    "The declaration for a Function Type must be a Function"
    assert (modelType.declaration is ModelFunction);

    "Must either be for a toplevel class or have a qualifyingInstance"
    assert(qualifyingInstance exists
            != modelType.declaration.container is ModelPackage);

    object helper
            satisfies FunctionModelHelper<Type, Arguments>
                    & ApplicableHelper<Type, Arguments> {
        modelType => outer.modelType;
    }

    shared actual
    FunctionDeclaration declaration {
        assert (is ModelFunction model = modelType.declaration);
        return newFunctionDeclaration(model);
    }

    // Functional

    type => helper.type;

    // FunctionModel

    parameterTypes => helper.parameterTypes; 

    // Applicable

    apply(Anything* arguments) => helper.apply(arguments);
    namedApply({<String->Anything>*} arguments) => helper.namedApply(arguments);

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
