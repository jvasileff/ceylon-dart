import ceylon.language.meta.model {
    AppliedType = Type, Class, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute, FunctionModel, ValueModel,
    CallableConstructor, ValueConstructor, TypeArgument
}
import ceylon.language.meta.declaration {
    ClassDeclaration, TypeParameter
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}

shared class ClassImpl<out Type=Anything, in Arguments=Nothing>(modelType)
        satisfies Class<Type, Arguments>
        given Arguments satisfies Anything[] {

    ModelType modelType;

    "The declaration for a Class Type must be a Class"
    assert (modelType.declaration is ModelClass);

    // FROM Type

    shared actual Boolean typeOf(Anything instance) => nothing;

    shared actual Boolean supertypeOf(AppliedType<> type) => nothing;

    shared actual Boolean exactly(AppliedType<> type) => nothing;

    shared actual AppliedType<Type|Other> union<Other>(AppliedType<Other> other) => nothing;

    shared actual AppliedType<Type&Other> intersection<Other>(AppliedType<Other> other) => nothing;

    // FROM ClassOrInterface

    // shared actual ClassOrInterfaceDeclaration declaration => nothing;

    shared actual ClassModel<>? extendedType
        // FIXME we can't instantiate ClassImpl this way; need correct type args
        =>  if (exists et = modelType.declaration.extendedType)
            then ClassImpl(et)
            else null;

    shared actual InterfaceModel<>[] satisfiedTypes => nothing;

    shared actual Type[] caseValues => nothing;

    shared actual Member<Container, Kind>? getClassOrInterface
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
        given Kind satisfies ClassOrInterface<Anything> => nothing;

    shared actual Member<Container, Kind>? getDeclaredClassOrInterface
            <Container=Nothing, Kind=ClassOrInterface<>>
            (String name, AppliedType<Anything>* types)
        given Kind satisfies ClassOrInterface<Anything> => nothing;

    shared actual MemberClass<Container, Type, Arguments>? getClass
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared actual MemberClass<Container, Type, Arguments>? getDeclaredClass
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared actual MemberInterface<Container, Type>? getInterface
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types) => nothing;

    shared actual MemberInterface<Container, Type>? getDeclaredInterface
            <Container=Nothing, Type=Anything>
            (String name, AppliedType<Anything>* types) => nothing;
    
    shared actual Method<Container, Type, Arguments>? getMethod
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared actual Method<Container, Type, Arguments>? getDeclaredMethod
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, AppliedType<Anything>* types)
        given Arguments satisfies Anything[] => nothing;

    shared actual Attribute<Container, Get, Set>? getAttribute
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

    shared actual Attribute<Container, Get, Set>? getDeclaredAttribute
            <Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

    shared actual Attribute<Container, Get, Set>[] getDeclaredAttributes
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared actual Attribute<Container, Get, Set>[] getAttributes
            <Container=Nothing, Get=Anything, Set=Nothing>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared actual Method<Container, Type, Arguments>[] getDeclaredMethods
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
        given Arguments satisfies Anything[] => nothing;

    shared actual Method<Container, Type, Arguments>[] getMethods
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared actual MemberClass<Container, Type, Arguments>[] getDeclaredClasses
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared actual MemberClass<Container, Type, Arguments>[] getClasses
            <Container=Nothing, Type=Anything, Arguments=Nothing>
            (AppliedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared actual MemberInterface<Container, Type>[] getDeclaredInterfaces
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes) => nothing;

    shared actual MemberInterface<Container, Type>[] getInterfaces
            <Container=Nothing, Type=Anything>
            (AppliedType<Annotation>* annotationTypes) => nothing;

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

    shared actual CallableConstructor<Type, Arguments>|ValueConstructor<Type>? getConstructor
            <Arguments>
            (String name)
                given Arguments satisfies Anything[] => nothing;

    // FROM Generic

    shared actual Map<TypeParameter, AppliedType<>> typeArguments => nothing;

    shared actual AppliedType<>[] typeArgumentList {
        // FIXME account for types other than Class
        // FIXME we can't instantiate ClassImpl this way; need correct type args
        return modelType.typeArguments.collect((ta) => ClassImpl(ta.item));
    }

    shared actual Map<TypeParameter, TypeArgument> typeArgumentWithVariances => nothing;

    shared actual TypeArgument[] typeArgumentWithVarianceList => nothing;

    // FROM Applicable

    shared actual Type apply(Anything* arguments) => nothing;

    shared actual Type namedApply({<String->Anything>*} arguments) => nothing;

    // FROM Model

    shared actual AppliedType<>? container
        // FIXME we can't instantiate ClassImpl this way; need correct type args
        =>  if (exists qt = modelType.qualifyingType,
                is ModelClass qtDeclaration = qt.declaration)
            then ClassImpl<Nothing, Nothing>(qt)
            else nothing; // TODO other types of Types
}
