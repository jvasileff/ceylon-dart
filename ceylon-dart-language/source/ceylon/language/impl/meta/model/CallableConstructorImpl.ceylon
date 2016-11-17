import ceylon.language.impl.meta.declaration {
    newConstructorDeclaration
}
import ceylon.language.impl.meta.model {
    newClass
}
import ceylon.language.meta.declaration {
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    CallableConstructor, ClassModel
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelConstructor = Constructor
}

class CallableConstructorImpl<out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies CallableConstructor<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a Constructor"
    assert (modelType.declaration is ModelConstructor);

    object helper satisfies FunctionModelHelper<Type, Arguments>
                          & ApplicableHelper<Type, Arguments> {
        modelType => outer.modelType;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelConstructor model
            =   modelType.declaration);

        assert (is CallableConstructorDeclaration result
            =   newConstructorDeclaration(model));

        return result;
    }

    shared actual ClassModel<Type, Nothing> container {
        // FIXME is this right?
        assert (exists qt = modelType.qualifyingType);
        return newClass<Type, Nothing>(qt);
    }

    // Functional

    type => newClass(modelType);

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
}
