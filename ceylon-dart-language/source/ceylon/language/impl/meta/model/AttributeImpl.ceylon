import ceylon.language.dart {
    CustomCallable
}
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

class AttributeImpl<in Container, out Get, in Set>(modelReference)
        satisfies Attribute<Container, Get, Set>
                & CustomCallable<Value<Get, Set>, [Container]> {

    shared ModelTypedReference modelReference;

    "The declaration for a Value Type must be a Value"
    assert (modelReference.declaration is ModelValue);

    shared
    Value<Get, Set> bindSafe(Container container)
        =>  unsafeCast<Value<Get, Set>>(newValue(modelReference, container));

    shared actual
    Value<Get, Set>(Container) callableDelegate
        =   bindSafe;

    object helper
            satisfies ValueModelHelper<Get> & MemberHelper {
        modelReference => outer.modelReference;
    }

    shared actual
    ValueDeclaration declaration {
        assert (is ModelValue model = modelReference.declaration);
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

    // Member

    declaringType => helper.declaringType;

    // ValueModel

    type => helper.type;

    // Model

    container => helper.container;

    // Object

    string => helper.string;
}
