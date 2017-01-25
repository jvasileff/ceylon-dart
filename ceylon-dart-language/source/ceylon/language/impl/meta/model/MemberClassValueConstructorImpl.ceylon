import ceylon.language.impl.meta.declaration {
    newValueConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    MemberClass, MemberClassValueConstructor, ValueConstructor, Class
}
import ceylon.dart.runtime.model {
    ModelValueConstructor = ValueConstructor,
    ModelDeclaration = Declaration,
    ModelType = Type
}

class MemberClassValueConstructorImpl<in Container = Nothing, out Type=Object>(modelType)
        satisfies MemberClassValueConstructor<Container, Type> {

    shared ModelType modelType;

    "The declaration for a value constructor must be a value constructor"
    assert (modelType.declaration is ModelValueConstructor);

    "A MemberClassValueConstructor must not have a toplevel container"
    assert (is ModelDeclaration modelClass = modelType.declaration.container,
            !modelClass.isToplevel);

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelValueConstructor model = modelType.declaration);
        return newValueConstructorDeclaration(model);
    }

    shared actual
    ValueConstructor<Type> bind(Object container) => nothing;

    ModelType modelQualifyingType {
        assert (exists qt = modelType.qualifyingType);
        return qt;
    }

    container => type;

    type => newMemberClass<Container, Type>(modelQualifyingType);
}
