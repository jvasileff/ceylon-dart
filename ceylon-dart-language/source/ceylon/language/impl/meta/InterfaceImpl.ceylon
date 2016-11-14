import ceylon.language.meta.model {
    AppliedType = Type, Interface, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute
}
import ceylon.language.meta.declaration {
    InterfaceDeclaration
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelInterface = Interface
}

shared class InterfaceImpl<out Type=Anything>(modelType)
        extends ClassOrInterfaceImpl<Type>()
        satisfies Interface<Type> {

    shared actual ModelType modelType;

    "The declaration for a Interface Type must be a Interface"
    assert (modelType.declaration is ModelInterface);

    // FROM ClassOrInterface

    extendedType => extendedTypeImpl;
    satisfiedTypes => satisfiedTypesImpl;
    caseValues => caseValuesImpl;

    shared actual Member<Container, Kind>? getClassOrInterface
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  getClassOrInterfaceImpl<Container, Kind>(name, *types);

    shared actual Member<Container, Kind>? getDeclaredClassOrInterface
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  getDeclaredClassOrInterfaceImpl<Container, Kind>(name, *types);

    shared actual MemberClass<Container, Type, Arguments>? getClass
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  getClassImpl<Container, Type, Arguments>(name, *types);

    shared actual MemberClass<Container, Type, Arguments>? getDeclaredClass
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  getDeclaredClassImpl<Container, Type, Arguments>(name, *types);

    shared actual MemberInterface<Container, Type>? getInterface
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types)
        =>  getInterfaceImpl<Container, Type>(name, *types);

    shared actual MemberInterface<Container, Type>? getDeclaredInterface
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types)
        =>  getDeclaredInterfaceImpl<Container, Type>(name, *types);
    
    shared actual Method<Container, Type, Arguments>? getMethod
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  getMethodImpl<Container, Type, Arguments>(name, *types);

    shared actual Method<Container, Type, Arguments>? getDeclaredMethod
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  getDeclaredMethodImpl<Container, Type, Arguments>(name, *types);

    shared actual Attribute<Container, Get, Set>? getAttribute
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name)
        =>  getAttributeImpl<Container, Get, Set>(name);

    shared actual Attribute<Container, Get, Set>? getDeclaredAttribute
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name)
        =>  getDeclaredAttributeImpl<Container, Get, Set>(name);

    shared actual Attribute<Container, Get, Set>[] getDeclaredAttributes
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        =>  getDeclaredAttributesImpl<Container, Get, Set>(*annotationTypes);

    shared actual Attribute<Container, Get, Set>[] getAttributes
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        =>  getAttributesImpl<Container, Get, Set>(*annotationTypes);

    shared actual Method<Container, Type, Arguments>[] getDeclaredMethods
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  getDeclaredMethodsImpl<Container, Type, Arguments>(*annotationTypes);

    shared actual Method<Container, Type, Arguments>[] getMethods
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  getMethodsImpl<Container, Type, Arguments>(*annotationTypes);

    shared actual MemberClass<Container, Type, Arguments>[] getDeclaredClasses
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  getDeclaredClasses<Container, Type, Arguments>(*annotationTypes);

    shared actual MemberClass<Container, Type, Arguments>[] getClasses
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  getClassesImpl<Container, Type, Arguments>(*annotationTypes);

    shared actual MemberInterface<Container, Type>[] getDeclaredInterfaces
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes)
        =>  getDeclaredInterfacesImpl<Container, Type>(*annotationTypes);

    shared actual MemberInterface<Container, Type>[] getInterfaces
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes)
        =>  getInterfaces<Container, Type>(*annotationTypes);

    // FROM Generic

    typeArguments => typeArgumentsImpl;
    typeArgumentList => typeArgumentListImpl;
    typeArgumentWithVariances => typeArgumentWithVariancesImpl;
    typeArgumentWithVarianceList => typeArgumentWithVarianceListImpl;

    // FROM Model

    container => containerImpl;

    // FROM InterfaceModel

    shared actual InterfaceDeclaration declaration {
        assert (is ModelInterface modelDeclaration = modelType.declaration);
        return nothing;
    }
}
