import ceylon.language.impl.meta.declaration {
    newValueConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    ValueConstructor, Class
}
import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor,
    ModelType = Type
}

class ValueConstructorImpl<out Type=Object>(modelType)
        satisfies ValueConstructor<Type> {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a ValueConstructor"
    assert (modelType.declaration is ModelValueConstructor);

    object helper
            satisfies ValueModelHelper<Type> & GettableHelper<Type, Nothing> {
        modelType => outer.modelType;
    }

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelValueConstructor model = modelType.declaration);
        return newValueConstructorDeclaration(model);
    }

    shared actual
    Class<Type, Nothing> container {
        // FIXME is this right? (See also CallableConstructorImpl)
        assert (exists qt = modelType.qualifyingType);
        return newClass<Type, Nothing>(qt);
    }

    // ValueModel

    type => ClassImpl(modelType);

    // Gettable

    get() => helper.get();
    shared actual void set(Nothing newValue) {}
    setIfAssignable(Anything newValue) => setIfAssignable(newValue);
}
