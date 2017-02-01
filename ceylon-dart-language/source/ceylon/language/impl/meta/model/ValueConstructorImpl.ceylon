import ceylon.language.impl.meta.declaration {
    newValueConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    Class,
    ValueConstructor
}
import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor,
    ModelDeclaration = Declaration,
    ModelType = Type,
    ModelPackage = Package
}

class ValueConstructorImpl<out Type=Object>(modelType, qualifyingInstance = null)
        satisfies ValueConstructor<Type> {

    shared ModelType modelType;
    Anything qualifyingInstance;

    "The declaration for a Constructor Type must be a ValueConstructor"
    assert (modelType.declaration is ModelValueConstructor);

    "A ValueConstructor must either be for a toplevel class or have a qualifyingInstance"
    assert(qualifyingInstance exists != modelType.declaration.container is ModelPackage);

    object helper
            satisfies ValueModelHelper<Type> & GettableHelper<Type, Nothing> {
        modelType => outer.modelType;
    }

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelValueConstructor model = modelType.declaration);
        return newValueConstructorDeclaration(model);
    }

    container => type;

    // ValueModel

    ModelType modelQualifyingType {
        assert (exists qt = modelType.qualifyingType);
        return qt;
    }

    // TODO possibly change after https://github.com/ceylon/ceylon/issues/6903
    type => unsafeCast<Class<Type,Nothing>>(
                newClass(modelQualifyingType, qualifyingInstance));

    // Gettable

    get() => helper.get();
    shared actual void set(Nothing newValue) {}
    setIfAssignable(Anything newValue) => setIfAssignable(newValue);
}
