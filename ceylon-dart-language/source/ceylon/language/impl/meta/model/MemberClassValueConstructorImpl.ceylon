import ceylon.language.impl.meta.declaration {
    newConstructorDeclaration
}
import ceylon.language.meta.declaration {
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    MemberClassValueConstructor, ValueConstructor, Class
}
import ceylon.dart.runtime.model {
    ModelConstructor = Constructor,
    ModelType = Type
}

class MemberClassValueConstructorImpl<in Container = Nothing, out Type=Object>(modelType)
        satisfies MemberClassValueConstructor<Container, Type> {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a Constructor"
    assert (modelType.declaration is ModelConstructor);

    shared actual
    ValueConstructorDeclaration declaration {
        assert (is ModelConstructor model = modelType.declaration);
        assert (is ValueConstructorDeclaration result = newConstructorDeclaration(model));
        return result;
    }

    shared actual
    ValueConstructor<Type> bind(Object container) => nothing;

    shared actual
    Class<Type, Nothing> container {
        // FIXME is this right? (See also CallableConstructorImpl)
        assert (exists qt = modelType.qualifyingType);
        return newClass<Type, Nothing>(qt);
    }

    type => newMemberClass(modelType);
}
