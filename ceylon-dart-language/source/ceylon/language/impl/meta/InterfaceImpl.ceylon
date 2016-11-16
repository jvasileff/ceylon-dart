import ceylon.language.meta.model {
    ClosedType = Type, Interface, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute
}
import ceylon.language.meta.declaration {
    InterfaceDeclaration
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelInterface = Interface
}

class InterfaceImpl<out Type=Anything>(modelType)
        extends TypeImpl<Type>()
        satisfies Interface<Type> {

    shared actual ModelType modelType;

    "The declaration for a Interface Type must be a Interface"
    assert (modelType.declaration is ModelInterface);

    shared actual object helper satisfies ClassOrInterfaceHelper<Type> {
        thisType => outer;
        modelType => outer.modelType;
    }

    shared actual InterfaceDeclaration declaration {
        assert (is ModelInterface modelDeclaration = modelType.declaration);
        return InterfaceDeclarationImpl(modelDeclaration);
    }

    // ClassOrInterface

    extendedType => helper.extendedType;
    satisfiedTypes => helper.satisfiedTypes;
    caseValues => helper.caseValues;

    shared actual
    Member<Container, Kind>?
    getClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  helper.getClassOrInterface<Container, Kind>(name, *types);

    shared actual
    Member<Container, Kind>?
    getDeclaredClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  helper.getDeclaredClassOrInterface<Container, Kind>(name, *types);

    shared actual
    MemberClass<Container, Type, Arguments>?
    getClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getClass<Container, Type, Arguments>(name, *types);

    shared actual
    MemberClass<Container, Type, Arguments>?
    getDeclaredClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredClass<Container, Type, Arguments>(name, *types);

    shared actual
    MemberInterface<Container, Type>?
    getInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types)
        =>  helper.getInterface<Container, Type>(name, *types);

    shared actual
    MemberInterface<Container, Type>?
    getDeclaredInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types)
        =>  helper.getDeclaredInterface<Container, Type>(name, *types);
    
    shared actual
    Method<Container, Type, Arguments>?
    getMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  helper.getMethod<Container, Type, Arguments>(name, *types);

    shared actual
    Method<Container, Type, Arguments>?
    getDeclaredMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
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
            (ClosedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredAttributes<Container, Get, Set>(*annotationTypes);

    shared actual
    Attribute<Container, Get, Set>[]
    getAttributes<Container=Nothing, Get=Anything, Set=Nothing>
            (ClosedType<Annotation>* annotationTypes)
        =>  helper.getAttributes<Container, Get, Set>(*annotationTypes);

    shared actual
    Method<Container, Type, Arguments>[]
    getDeclaredMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredMethods<Container, Type, Arguments>(*annotationTypes);

    shared actual
    Method<Container, Type, Arguments>[]
    getMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getMethods<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberClass<Container, Type, Arguments>[]
    getDeclaredClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredClasses<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberClass<Container, Type, Arguments>[]
    getClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getClasses<Container, Type, Arguments>(*annotationTypes);

    shared actual
    MemberInterface<Container, Type>[]
    getDeclaredInterfaces<Container=Nothing, Type=Anything>
            (ClosedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredInterfaces<Container, Type>(*annotationTypes);

    shared actual
    MemberInterface<Container, Type>[]
    getInterfaces<Container=Nothing, Type=Anything>
            (ClosedType<Annotation>* annotationTypes)
        =>  helper.getInterfaces<Container, Type>(*annotationTypes);

    // Generic

    typeArguments => helper.typeArguments;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;

    // Model

    container => helper.container;
}
