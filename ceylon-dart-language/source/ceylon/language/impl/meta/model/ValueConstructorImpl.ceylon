import ceylon.language.impl.meta.declaration {
    newConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    ValueConstructor, Class
}
import ceylon.dart.runtime.model {
    ModelConstructor = Constructor,
    ModelType = Type
}

class ValueConstructorImpl<out Type=Object>(modelType)
        satisfies ValueConstructor<Type> {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a Constructor"
    assert (modelType.declaration is ModelConstructor);

    object helper
            satisfies ValueModelHelper<Type> & GettableHelper<Type, Nothing> {
        modelType => outer.modelType;
    }

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelConstructor model = modelType.declaration);
        assert (is ValueConstructorDeclaration result = newConstructorDeclaration(model));
        return result;
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
