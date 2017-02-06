import ceylon.language.meta.model {
    ClosedType = Type, FunctionModel, ValueModel
}
import ceylon.language.meta.declaration {
    ClassDeclaration
}
import ceylon.dart.runtime.model {
    ModelClass = Class
}
import ceylon.language.impl.meta.declaration {
    newClassDeclaration
}

interface ClassModelHelper<out Type>
        satisfies ClassOrInterfaceHelper<Type> {

    shared
    ClassDeclaration declaration {
        assert (is ModelClass modelDeclaration = modelReference.declaration);
        return newClassDeclaration(modelDeclaration);
    }

    shared
    FunctionModel<Type, Arguments>[] getCallableConstructors<Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  nothing;

    shared
    FunctionModel<Type, Arguments>[] getDeclaredCallableConstructors<Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  nothing;

    shared
    ValueModel<Type>[] getDeclaredValueConstructors
            (ClosedType<Annotation>* annotationTypes)
        =>  nothing;

    shared
    ValueModel<Type>[] getValueConstructors(ClosedType<Annotation>* annotationTypes)
        =>  nothing;
}
