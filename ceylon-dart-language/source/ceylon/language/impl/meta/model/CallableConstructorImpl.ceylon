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
    ClassModel,
    CallableConstructor
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelDeclaration = Declaration,
    ModelPackage = Package,
    ModelCallableConstructor = CallableConstructor
}

class CallableConstructorImpl<out Type=Anything, in Arguments=Nothing>(
        modelReference,
        Anything qualifyingInstance = null)
        satisfies CallableConstructor<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelReference;

    "The declaration for a Constructor Type must be a CallableConstructor"
    assert (modelReference.declaration is ModelCallableConstructor);

    "A CallableConstructor must either be for a toplevel class or have a
     qualifyingInstance"
    assert(qualifyingInstance exists
            != modelReference.declaration.container.container is ModelPackage);

    object helper satisfies FunctionModelHelper<Type, Arguments>
                          & ApplicableHelper<Type, Arguments> {
        modelReference => outer.modelReference;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelCallableConstructor model = modelReference.declaration);
        return newCallableConstructorDeclaration(model);
    }

    container => type;

    // Functional

    ModelType modelQualifyingType {
        assert (exists qt = modelReference.qualifyingType);
        return qt;
    }

    // TODO possibly change after https://github.com/ceylon/ceylon/issues/6903
    type => unsafeCast<ClassModel<Type>>(newClassModel(modelQualifyingType));

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

    // Object

    string => helper.string;
}
