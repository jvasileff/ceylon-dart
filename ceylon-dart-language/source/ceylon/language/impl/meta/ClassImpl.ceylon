import ceylon.language.meta.model {
    AppliedType = Type, Class, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute, FunctionModel, ValueModel,
    CallableConstructor, ValueConstructor
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}

class ClassImpl<out Type=Anything, in Arguments=Nothing>(modelType)
        extends TypeImpl<Type>()
        satisfies Class<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared actual ModelType modelType;

    "The declaration for a Class Type must be a Class"
    assert (modelType.declaration is ModelClass);

    shared actual object helper
            satisfies ClassModelHelper<Type> & ApplicableHelper<Type, Arguments> {
        thisType => outer;
        modelType => outer.modelType;
    }

    shared actual
    CallableConstructor<Type, Arguments>? defaultConstructor
        =>  nothing;

    shared actual
    CallableConstructor<Type, Arguments>|ValueConstructor<Type>?
    getConstructor<Arguments>(String name)
            given Arguments satisfies Anything[]
        =>  nothing;

    // Applicable

    apply(Anything* arguments) => helper.apply(arguments);
    namedApply({<String->Anything>*} arguments) => helper.namedApply(arguments);

    // ClassModel

    declaration => helper.declaration;

    shared actual
    FunctionModel<Type, Arguments>[]
    getCallableConstructors<Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getCallableConstructors<Arguments>(*annotationTypes);

    shared actual
    FunctionModel<Type, Arguments>[]
    getDeclaredCallableConstructors<Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredCallableConstructors<Arguments>(*annotationTypes);

    shared actual
    FunctionModel<Type, Arguments>|ValueModel<Type>?
    getDeclaredConstructor<Arguments>
            (String name)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredConstructor<Arguments>(name);

    getDeclaredValueConstructors(AppliedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredValueConstructors(*annotationTypes);

    getValueConstructors(AppliedType<Annotation>* annotationTypes)
        =>  helper.getValueConstructors(*annotationTypes);

    // ClassOrInterface

    extendedType => helper.extendedType;
    satisfiedTypes => helper.satisfiedTypes;
    caseValues => helper.caseValues;

    shared actual
    Member<Container, Kind>?
    getClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  helper.getClassOrInterface<Container, Kind>(name, *types);

    shared actual
    Member<Container, Kind>?
    getDeclaredClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  helper.getDeclaredClassOrInterface<Container, Kind>(name, *types);

    shared actual
    MemberClass<Container, Type, Arguments>?
    getClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getClass<Container, Type, Arguments>(name, *types);

    shared actual
    MemberClass<Container, Type, Arguments>?
    getDeclaredClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredClass<Container, Type, Arguments>(name, *types);

    shared actual
    MemberInterface<Container, Type>?
    getInterface<Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types)
        =>  helper.getInterface<Container, Type>(name, *types);

    shared actual
    MemberInterface<Container, Type>?
    getDeclaredInterface<Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types)
        =>  helper.getDeclaredInterface<Container, Type>(name, *types);
    
    shared actual
    Method<Container, Type, Arguments>?
    getMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getMethod<Container, Type, Arguments>(name, *types);

    shared actual
    Method<Container, Type, Arguments>?
    getDeclaredMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredMethod<Container, Type, Arguments>(name, *types);

    shared actual
    Attribute<Container, Get, Set>?
    getAttribute<Container=Nothing, Get=Anything, Set=Nothing>
            (String name)
        =>  helper.getAttribute<Container, Get, Set>(name);

    shared actual
    Attribute<Container, Get, Set>?
    getDeclaredAttribute<Container=Nothing, Get=Anything, Set=Nothing>
            (String name)
        =>  helper.getDeclaredAttribute<Container, Get, Set>(name);

    shared actual
    Attribute<Container, Get, Set>[]
    getDeclaredAttributes<Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredAttributes<Container, Get, Set>(*annotationTypes);

    shared actual
    Attribute<Container, Get, Set>[]
    getAttributes<Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        =>  helper.getAttributes<Container, Get, Set>(*annotationTypes);

    shared actual
    Method<Container, Type, Arguments>[]
    getDeclaredMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredMethods<Container, Type, Arguments>(*annotationTypes);

    shared actual
    Method<Container, Type, Arguments>[]
    getMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getMethods<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberClass<Container, Type, Arguments>[]
    getDeclaredClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredClasses<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberClass<Container, Type, Arguments>[]
    getClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getClasses<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberInterface<Container, Type>[]
    getDeclaredInterfaces<Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredInterfaces<Container, Type>(*annotationTypes);

    shared actual
    MemberInterface<Container, Type>[]
    getInterfaces<Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes)
        =>  helper.getInterfaces<Container, Type>(*annotationTypes);

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;

    // Model

    container => helper.container;
}
