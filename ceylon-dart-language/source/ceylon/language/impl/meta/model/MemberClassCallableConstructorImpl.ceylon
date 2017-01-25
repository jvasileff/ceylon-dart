import ceylon.language.impl.meta.declaration {
    newCallableConstructorDeclaration
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
    ModelDeclaration = Declaration,
    ModelCallableConstructor = CallableConstructor
}

class MemberClassCallableConstructorImpl
        <in Container=Nothing, out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies MemberClassCallableConstructor<Container, Type, Arguments>
        given Arguments satisfies Anything[] {

    shared ModelType modelType;

    "The declaration for a callable constructor must be a callable constructor"
    assert (modelType.declaration is ModelCallableConstructor);

    "A MemberClassCallableConstructor must not have a toplevel container"
    assert (is ModelDeclaration modelClass = modelType.declaration.container,
            !modelClass.isToplevel);

    object helper satisfies FunctionModelHelper<Type, Arguments> {
        modelType => outer.modelType;
    }

    shared actual
    CallableConstructorDeclaration declaration {
        assert (is ModelCallableConstructor model = modelType.declaration);
        return newCallableConstructorDeclaration(model);
    }

    container => type;

    shared actual
    CallableConstructor<Type, Arguments> bind(Object container) => nothing;

    // Functional

    ModelType modelQualifyingType {
        assert (exists qt = modelType.qualifyingType);
        return qt;
    }

    type => newMemberClass<Container, Type>(modelQualifyingType);

    // FunctionModel

    parameterTypes => helper.parameterTypes; 

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;
}
