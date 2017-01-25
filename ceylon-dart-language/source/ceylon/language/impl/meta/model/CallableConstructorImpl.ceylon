import ceylon.language.impl.meta.declaration {
    newCallableConstructorDeclaration
}
import ceylon.language.impl.meta.model {
    newClass
}
import ceylon.language.meta.declaration {
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    CallableConstructor
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelDeclaration = Declaration,
    ModelCallableConstructor = CallableConstructor
}

class CallableConstructorImpl<out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies CallableConstructor<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a CallableConstructor"
    assert (modelType.declaration is ModelCallableConstructor);

    "A CallableConstructor must have a toplevel container"
    assert (is ModelDeclaration modelClass = modelType.declaration.container,
            modelClass.isToplevel);

    object helper satisfies FunctionModelHelper<Type, Arguments>
                          & ApplicableHelper<Type, Arguments> {
        modelType => outer.modelType;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelCallableConstructor model = modelType.declaration);
        return newCallableConstructorDeclaration(model);
    }

    container => type;

    // Functional

    ModelType modelQualifyingType {
        assert (exists qt = modelType.qualifyingType);
        return qt;
    }

    type => newClass<Type>(modelQualifyingType);

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
