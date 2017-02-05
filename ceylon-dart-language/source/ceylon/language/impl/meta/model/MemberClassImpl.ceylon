import ceylon.language.meta {
    type
}
import ceylon.language.meta.model {
    ClosedType = Type, Class, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute, FunctionModel, ValueModel,
    MemberClassCallableConstructor,
    MemberClassValueConstructor,
    IncompatibleTypeException
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class,
    ModelConstructor = Constructor
}

class MemberClassImpl<in Container = Nothing, out Type=Anything, in Arguments=Nothing>
        (modelType)
        extends TypeImpl<Type>()
        satisfies MemberClass<Container, Type, Arguments>
        // TODO given Container satisfies Object
        given Arguments satisfies Anything[] {

    shared actual ModelType modelType;

    "The declaration for a Class Type must be a Class"
    assert (is ModelClass modelDeclaration = modelType.declaration);

    shared actual
    object helper satisfies ClassModelHelper<Type> & MemberHelper {
        thisType => outer;
        modelType => outer.modelType;
    }

    MemberClassCallableConstructor<Container, Type, Arguments> |
    MemberClassValueConstructor<Container, Type>?
    getConstructorInternal<Arguments>(String name, Boolean allowUnshared)
            given Arguments satisfies Anything[] {

        // TODO special case "constructor" for class initializers, to use as
        //      the default constructor (name == "")

        value modelConstructor = modelDeclaration.getDirectMember(name);
        if (!is ModelConstructor modelConstructor) {
            return null;
        }
        if (!allowUnshared && !modelConstructor.isShared) {
            return null;
        }

        value memberClassConstructor = newMemberClassConstructor {
            modelConstructor.appliedType(modelType, [], emptyMap);
        };
        if (!is MemberClassCallableConstructor<Container, Type, Arguments>
                | MemberClassValueConstructor<Container, Type>
                memberClassConstructor) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Type or Arguments");
        }

        return memberClassConstructor;
    }

    shared actual
    Class<Type, Arguments> bind(Object container) {
        if (!is Container container) {
            throw IncompatibleTypeException(
                "Invalid container ``container``, expected type `` `Container` `` \
                 but got `` type(container) ``");
        }
        return bindSafe(container);
    }

    shared
    Class<Type, Arguments> bindSafe(Container container)
        =>  ClassImpl<Type, Arguments>(modelType, container);

    shared actual
    MemberClassCallableConstructor<Container, Type, Arguments>? defaultConstructor
        =>  nothing;

    shared actual
    MemberClassCallableConstructor<Container,Type,Arguments> |
    MemberClassValueConstructor<Container,Type>?
    getConstructor<Arguments>(String name)
            given Arguments satisfies Anything[]
        =>  getConstructorInternal<Arguments>(name, false);

    // Member

    declaringType => helper.declaringType;

    // ClassModel

    declaration => helper.declaration;

    shared actual
    FunctionModel<Type, Arguments>[]
    getCallableConstructors<Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getCallableConstructors<Arguments>(*annotationTypes);

    shared actual
    FunctionModel<Type, Arguments>[]
    getDeclaredCallableConstructors<Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[]
        =>  helper.getDeclaredCallableConstructors<Arguments>(*annotationTypes);

    shared actual
    FunctionModel<Type, Arguments>|ValueModel<Type>?
    getDeclaredConstructor<Arguments>
            (String name)
            given Arguments satisfies Anything[]
        // TODO better would be MemberClass*Constructor<>, right?
        =>  getConstructorInternal<Arguments>(name, true);

    getDeclaredValueConstructors(ClosedType<Annotation>* annotationTypes)
        =>  helper.getDeclaredValueConstructors(*annotationTypes);

    getValueConstructors(ClosedType<Annotation>* annotationTypes)
        =>  helper.getValueConstructors(*annotationTypes);

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
