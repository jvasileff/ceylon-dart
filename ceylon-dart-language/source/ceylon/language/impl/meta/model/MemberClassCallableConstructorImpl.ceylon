import ceylon.language.impl.meta.declaration {
    newCallableConstructorDeclaration
}
import ceylon.language.meta {
    metaType = type
}
import ceylon.language.impl.meta.model {
    newMemberClass
}
import ceylon.language.meta.declaration {
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    CallableConstructor,
    MemberClass,
    MemberClassCallableConstructor,
    IncompatibleTypeException
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelDeclaration = Declaration,
    ModelCallableConstructor = CallableConstructor
}

class MemberClassCallableConstructorImpl<in Container, out Type, in Arguments>
        (modelReference)
        satisfies MemberClassCallableConstructor<Container, Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelReference;

    "The declaration for a callable constructor must be a callable constructor"
    assert (modelReference.declaration is ModelCallableConstructor);

    "A MemberClassCallableConstructor must not have a toplevel container"
    assert (is ModelDeclaration modelClass = modelReference.declaration.container,
            !modelClass.isToplevel);

    object helper satisfies FunctionModelHelper<Type, Arguments> {
        modelReference => outer.modelReference;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelCallableConstructor model = modelReference.declaration);
        return newCallableConstructorDeclaration(model);
    }

    container => type;

    shared actual
    CallableConstructor<Type, Arguments> bind(Object container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container``, expected type `` `Container` `` \
                 but got `` metaType(container) ``");
        }
        return bindSafe(container);
    }

    shared
    CallableConstructor<Type, Arguments> bindSafe(Container container)
        =>  unsafeCast<CallableConstructor<Type, Arguments>>(
                    newCallableConstructor(modelReference, container));

    // Functional

    ModelType modelQualifyingType {
        assert (exists qt = modelReference.qualifyingType);
        return qt;
    }

    type => unsafeCast<MemberClass<Container, Type, Nothing>>
                (newMemberClass(modelQualifyingType));

    // FunctionModel

    parameterTypes => helper.parameterTypes; 

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;

    // Object

    string => helper.string;
}
