import ceylon.language.dart {
    CustomCallable
}
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

class FunctionImpl<out Type, in Arguments>(modelReference, qualifyingInstance)
        satisfies Function<Type, Arguments>
                & CustomCallable<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelTypedReference modelReference;
    Anything qualifyingInstance;

    "The declaration for a Function Type must be a Function"
    assert (modelReference.declaration is ModelFunction);

    "Must either be for a toplevel class or have a qualifyingInstance"
    assert(qualifyingInstance exists
            != modelReference.declaration.container is ModelPackage);

    shared actual
    Type(*Arguments) invoke
        // TODO make this a reference value once apply() is implemented
        //      (avoid creating new callables each time)
        =>  apply;

    object helper
            satisfies FunctionModelHelper<Type, Arguments>
                    & ApplicableHelper<Type, Arguments> {
        modelReference => outer.modelReference;
    }

    shared actual
    FunctionDeclaration declaration {
        assert (is ModelFunction model = modelReference.declaration);
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
