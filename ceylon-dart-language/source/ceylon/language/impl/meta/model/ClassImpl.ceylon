import ceylon.language.dart {
    CustomCallable
}
import ceylon.language.meta.model {
    ClosedType = Type, Class, ClassOrInterface, Member,
    MemberClass, MemberInterface, Method, Attribute, FunctionModel, ValueModel,
    CallableConstructor, ValueConstructor,
    IncompatibleTypeException
}
import ceylon.language.impl.meta.model {
    newConstructor
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class,
    ModelConstructor = Constructor
}

class ClassImpl<out Type, in Arguments>(modelReference, qualifyingInstance)
        extends TypeImpl<Type>()
        satisfies Class<Type, Arguments>
                & CustomCallable<Type, Arguments>
        given Arguments satisfies Anything[] {

    shared actual ModelType modelReference;
    Anything qualifyingInstance;

    "The declaration for a Class Type must be a Class"
    assert (is ModelClass modelDeclaration = modelReference.declaration);

    shared actual
    Type(*Arguments) callableDelegate
        // TODO make this a reference value once apply() is implemented
        //      (avoid creating new callables each time)
        =>  apply;

    shared actual object helper
            satisfies ClassModelHelper<Type> & ApplicableHelper<Type, Arguments> {
        thisType => outer;
        modelReference => outer.modelReference;
    }

    CallableConstructor<Type, Arguments> | ValueConstructor<Type>?
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
        value result = newConstructor {
            modelConstructor.appliedType(modelReference, [], emptyMap);
            qualifyingInstance;
        };
        if (!is CallableConstructor<Type, Arguments>
                | ValueConstructor<Type> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Type or Arguments");
        }
        return result;
    }

    shared actual
    CallableConstructor<Type, Arguments>? defaultConstructor
        =>  if (is CallableConstructor<> result
                =   getConstructorInternal<Arguments>("", false))
            then result
            else null;

    shared actual
    CallableConstructor<Type, Arguments>|ValueConstructor<Type>?
    getConstructor<Arguments>(String name)
            given Arguments satisfies Anything[]
        =>  getConstructorInternal(name, false);

    // Applicable

    apply(Anything* arguments) => helper.apply(arguments);
    namedApply({<String->Anything>*} arguments) => helper.namedApply(arguments);

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
        // TODO why the crummy return type?
        =>  getConstructorInternal(name, true);

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
