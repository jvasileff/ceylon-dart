import ceylon.language.impl.meta.declaration {
    newValueDeclaration
}
import ceylon.language.meta {
    metaType = type
}
import ceylon.language.meta.declaration {
    ValueDeclaration
}
import ceylon.language.meta.model {
    Attribute, Value,
    IncompatibleTypeException
}
import ceylon.dart.runtime.model {
    ModelValue = Value,
    ModelTypedReference = TypedReference
}

class AttributeImpl<in Container = Nothing, out Get=Anything, in Set=Nothing>(modelType)
        satisfies Attribute<Container, Get, Set> {

    shared ModelTypedReference modelType;

    "The declaration for a Value Type must be a Value"
    assert (modelType.declaration is ModelValue);

    object helper
            satisfies ValueModelHelper<Get> & MemberHelper {
        modelType => outer.modelType;
    }

    shared actual
    ValueDeclaration declaration {
        assert (is ModelValue model = modelType.declaration);
        return newValueDeclaration(model);
    }

    shared actual
    Value<Get, Set> bind(Object container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container``, expected type `` `Container` `` \
                 but got `` metaType(container) ``");
        }
        return bindSafe(container);
    }

    shared
    Value<Get, Set> bindSafe(Container container)
        =>  unsafeCast<Value<Get, Set>>(newValue(modelType, container));

    // Member

    declaringType => helper.declaringType;

    // ValueModel

    type => helper.type;

    // Model

    container => helper.container;
}
