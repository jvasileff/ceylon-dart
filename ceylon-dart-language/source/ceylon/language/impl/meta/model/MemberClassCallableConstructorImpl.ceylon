import ceylon.language.impl.meta.declaration {
    newConstructorDeclaration
}
import ceylon.language.impl.meta.model {
    newClass, newMemberClass
}
import ceylon.language.meta.declaration {
    CallableConstructorDeclaration
}
import ceylon.language.meta.model {
    CallableConstructor,
    MemberClassCallableConstructor,
    ClassModel
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelConstructor = Constructor
}

class MemberClassCallableConstructorImpl
        <in Container=Nothing, out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies MemberClassCallableConstructor<Container, Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelType;

    "The declaration for a Constructor Type must be a Constructor"
    assert (modelType.declaration is ModelConstructor);

    object helper satisfies FunctionModelHelper<Type, Arguments> {
        modelType => outer.modelType;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelConstructor model
            =   modelType.declaration);

        assert (is CallableConstructorDeclaration result
            =   newConstructorDeclaration(model));

        return result;
    }

    shared actual ClassModel<Type, Nothing> container {
        // FIXME is this right?
        assert (exists qt = modelType.qualifyingType);
        return newClass<Type, Nothing>(qt);
    }

    shared actual
    CallableConstructor<Type, Arguments> bind(Object container) => nothing;

    // Functional

    type => newMemberClass(modelType);

    // FunctionModel

    parameterTypes => helper.parameterTypes; 

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;
}
