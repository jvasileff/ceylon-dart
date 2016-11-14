import ceylon.language.meta.model {
    AppliedType = Type, Class, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute, FunctionModel, ValueModel,
    CallableConstructor, ValueConstructor
}
import ceylon.language.meta.declaration {
    ClassDeclaration
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}

shared class ClassImpl<out Type=Anything, in Arguments=Nothing>(modelType)
        extends ClassOrInterfaceImpl<Type>()
        satisfies Class<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared actual ModelType modelType;

    "The declaration for a Class Type must be a Class"
    assert (modelType.declaration is ModelClass);

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

    // FROM ClassModel

    shared actual ClassDeclaration declaration {
        assert (is ModelClass modelDeclaration = modelType.declaration);
        // FIXME could be ClassWithInitializerDeclaration
        return ClassWithConstructorsDeclarationImpl(modelDeclaration);
    }

    // shared actual FunctionModel<Type, Arguments>? defaultConstructor => nothing;

    // shared actual FunctionModel<Type, Arguments>|ValueModel<Type>? getConstructor
    //         <Arguments>
    //         (String name)
    //             given Arguments satisfies Anything[] => nothing;

    shared actual FunctionModel<Type, Arguments>|ValueModel<Type>? getDeclaredConstructor
            <Arguments>
            (String name)
                given Arguments satisfies Anything[] => nothing;

    shared actual FunctionModel<Type, Arguments>[] getDeclaredCallableConstructors
            <Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared actual FunctionModel<Type, Arguments>[] getCallableConstructors
            <Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared actual ValueModel<Type>[] getDeclaredValueConstructors
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared actual ValueModel<Type>[] getValueConstructors
            (AppliedType<Annotation>* annotationTypes) => nothing;

    // FROM Class

    shared actual CallableConstructor<Type, Arguments>? defaultConstructor => nothing;

    shared actual CallableConstructor<Type, Arguments>|ValueConstructor<Type>?
    getConstructor<Arguments>(String name)
            given Arguments satisfies Anything[] => nothing;

    // FROM Applicable

    shared actual Type apply(Anything* arguments) => nothing;

    shared actual Type namedApply({<String->Anything>*} arguments) => nothing;
}
