import ceylon.language.impl.meta.declaration {
    newValueConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    ValueConstructor
}
import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor,
    ModelDeclaration = Declaration,
    ModelType = Type
}

class ValueConstructorImpl<out Type=Object>(modelType)
        satisfies ValueConstructor<Type> {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a ValueConstructor"
    assert (modelType.declaration is ModelValueConstructor);

    "A ValueConstructor must have a toplevel container"
    assert (is ModelDeclaration modelClass = modelType.declaration.container,
            modelClass.isToplevel);

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

    type => newClass<Type>(modelQualifyingType);

    // Gettable

    get() => helper.get();
    shared actual void set(Nothing newValue) {}
    setIfAssignable(Anything newValue) => setIfAssignable(newValue);
}
