import ceylon.language.meta.model {
    AppliedType = Type, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute, TypeArgument
}
import ceylon.language.meta.declaration {
    TypeParameter
}

shared abstract class ClassOrInterfaceImpl<out Type=Anything>()
        extends TypeImpl<Type>() /* satisfies ClassOrInterface<Type> */ {

    // FROM ClassOrInterface

    shared ClassModel<>? extendedTypeImpl
        =>  if (exists et = modelType.declaration.extendedType)
            then newClass(et)
            else null;

    shared InterfaceModel<>[] satisfiedTypesImpl => nothing;

    shared Type[] caseValuesImpl => nothing;

    shared Member<Container, Kind>? getClassOrInterfaceImpl
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
        given Kind satisfies ClassOrInterface<Anything> => nothing;

    shared Member<Container, Kind>? getDeclaredClassOrInterfaceImpl
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
        given Kind satisfies ClassOrInterface<Anything> => nothing;

    shared MemberClass<Container, Type, Arguments>? getClassImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared MemberClass<Container, Type, Arguments>? getDeclaredClassImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared MemberInterface<Container, Type>? getInterfaceImpl
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types) => nothing;

    shared MemberInterface<Container, Type>? getDeclaredInterfaceImpl
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types) => nothing;
    
    shared Method<Container, Type, Arguments>? getMethodImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared Method<Container, Type, Arguments>? getDeclaredMethodImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared Attribute<Container, Get, Set>? getAttributeImpl
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

    shared Attribute<Container, Get, Set>? getDeclaredAttributeImpl
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

    shared Attribute<Container, Get, Set>[] getDeclaredAttributesImpl
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared Attribute<Container, Get, Set>[] getAttributesImpl
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared Method<Container, Type, Arguments>[] getDeclaredMethodsImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        given Arguments satisfies Anything[] => nothing;

    shared Method<Container, Type, Arguments>[] getMethodsImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared MemberClass<Container, Type, Arguments>[] getDeclaredClassesImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared MemberClass<Container, Type, Arguments>[] getClassesImpl
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared MemberInterface<Container, Type>[] getDeclaredInterfacesImpl
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared MemberInterface<Container, Type>[] getInterfacesImpl
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    // FROM Generic

    shared Map<TypeParameter, AppliedType<>> typeArgumentsImpl => nothing;

    shared AppliedType<>[] typeArgumentListImpl
        =>  modelType.typeArguments.map(Entry.item).collect(newType);

    shared Map<TypeParameter, TypeArgument> typeArgumentWithVariancesImpl => nothing;

    shared TypeArgument[] typeArgumentWithVarianceListImpl => nothing;

    // FROM Model

    shared AppliedType<>? containerImpl
        =>  if (exists qt = modelType.qualifyingType)
            then newType(qt)
            else null;
}
