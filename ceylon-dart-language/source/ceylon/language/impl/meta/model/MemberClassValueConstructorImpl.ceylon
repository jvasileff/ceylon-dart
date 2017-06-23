import ceylon.language.dart {
    CustomCallable
}
import ceylon.language.impl.meta.declaration {
    newValueConstructorDeclaration
}
import ceylon.language.meta {
    metaType = type
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    MemberClass,
    MemberClassValueConstructor,
    ValueConstructor,
    IncompatibleTypeException
}
import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor,
    ModelDeclaration = Declaration,
    ModelType = Type
}

class MemberClassValueConstructorImpl<in Container, out Type>(modelReference)
        satisfies MemberClassValueConstructor<Container, Type>
                & CustomCallable<ValueConstructor<Type>, [Container]> {

    shared ModelType modelReference;

    "The declaration for a value constructor must be a value constructor"
    assert (modelReference.declaration is ModelValueConstructor);

    "A MemberClassValueConstructor must not have a toplevel container"
    assert (is ModelDeclaration modelClass = modelReference.declaration.container,
            !modelClass.isToplevel);

    shared
    ValueConstructor<Type> bindSafe(Container container)
        =>  unsafeCast<ValueConstructor<Type>>
                (newValueConstructor(modelReference, container));

    shared actual
    ValueConstructor<Type>(Container) invoke
        =   bindSafe;

    object helper satisfies HasModelReference {
        modelReference => outer.modelReference;
    }

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelValueConstructor model = modelReference.declaration);
        return newValueConstructorDeclaration(model);
    }

    shared actual
    ValueConstructor<Type> bind(Anything container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container else "<null>"``, expected type \
                 `` `Container` `` but got `` metaType(container) ``");
        }
        return bindSafe(container);
    }

    ModelType modelQualifyingType {
        assert (exists qt = modelReference.qualifyingType);
        return qt;
    }

    container => type;

    type => unsafeCast<MemberClass<Container, Type, Nothing>>
                (newMemberClass(modelQualifyingType));

    // Object

    string => helper.string;
}
