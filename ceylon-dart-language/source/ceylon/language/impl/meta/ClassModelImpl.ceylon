import ceylon.language.meta.model {
    AppliedType = Type, FunctionModel, ValueModel
}
import ceylon.language.meta.declaration {
    ClassDeclaration
}
import ceylon.dart.runtime.model {
    ModelClass = Class
}

interface ClassModelHelper<out Type>
        satisfies ClassOrInterfaceHelper<Type> {

    shared
    ClassDeclaration declaration {
        assert (is ModelClass modelDeclaration = modelType.declaration);
        // FIXME could be ClassWithInitializerDeclaration
        return ClassWithConstructorsDeclarationImpl(modelDeclaration);
    }

    shared
    FunctionModel<Type, Arguments>[] getCallableConstructors<Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  nothing;

    shared
    FunctionModel<Type, Arguments>[] getDeclaredCallableConstructors<Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  nothing;


    shared
    FunctionModel<Type, Arguments>|ValueModel<Type>? getDeclaredConstructor<Arguments>
            (String name)
            given Arguments satisfies Anything[]
        =>  nothing;

    shared
    ValueModel<Type>[] getDeclaredValueConstructors
            (AppliedType<Annotation>* annotationTypes)
        =>  nothing;

    shared
    ValueModel<Type>[] getValueConstructors(AppliedType<Annotation>* annotationTypes)
        =>  nothing;
}
