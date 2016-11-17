import ceylon.language.impl.meta.declaration {
    newValueDeclaration
}
import ceylon.language.meta.declaration {
    ValueDeclaration
}
import ceylon.language.meta.model {
    Value
}
import ceylon.dart.runtime.model {
    ModelValue = Value,
    ModelTypedReference = TypedReference
}

class ValueImpl<out Get=Anything, in Set=Nothing>(modelType)
        satisfies Value<Get, Set> {

    shared ModelTypedReference modelType;

    "The declaration for a Value Type must be a Value"
    assert (modelType.declaration is ModelValue);

    object helper
            satisfies ValueModelHelper<Get> & GettableHelper<Get, Set> {
        modelType => outer.modelType;
    }

    shared actual
    ValueDeclaration declaration {
        assert (is ModelValue model = modelType.declaration);
        return newValueDeclaration(model);
    }

    // ValueModel

    type => helper.type;

    // Gettable

    get() => helper.get();
    set(Set newValue) => helper.set(newValue);
    setIfAssignable(Anything newValue) => setIfAssignable(newValue);

    // Model

    container => helper.container;
}
