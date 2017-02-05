import ceylon.language.meta.model {
    ClosedType = Type, Class, MemberClass, Interface, MemberInterface, UnionType,
    InterfaceModel, CallableConstructor, ValueConstructor, ClassModel,
    MemberClassCallableConstructor, MemberClassValueConstructor,
    IntersectionType, nothingType,
    Function, Method, Value, Attribute
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelTypedReference = TypedReference,
    ModelClass = Class,
    ModelClassDefinition = ClassDefinition,
    ModelClassWithInitializer = ClassWithInitializer,
    ModelClassWithConstructors = ClassWithConstructors,
    ModelParameter = Parameter,
    ModelConstructor = Constructor,
    ModelValueConstructor = ValueConstructor,
    ModelCallableConstructor = CallableConstructor,
    ModelTypeAlias = TypeAlias,
    ModelTypeParameter = TypeParameter,
    ModelInterface = Interface,
    ModelFunction = Function,
    ModelFunctional = Functional,
    ModelPackage = Package,
    ModelUnknownType = UnknownType,
    ModelValue = Value,
    ModelSetter = Setter,
    ModelUnionType = UnionType,
    ModelIntersectionType = IntersectionType,
    ModelNothingDeclaration = NothingDeclaration
}
import ceylon.dart.runtime.model.runtime {
    TypeDescriptor,
    TypeDescriptorImpl
}

[ModelType, ModelType] returnTypeAndArgumentsTupleForReference(ModelType modelType) {
    // Note: For constructors, the return type's declaration is the constructor and the
    //       extended type is the class, which is a bit weird, but ok since usually used
    //       for the covariant `Type` TA?
    value callableType = modelType.fullType;
    assert (exists result = callableType.unit.getCallableReturnAndTuple(callableType));
    return result;
}

shared CallableConstructor<Anything, Nothing>
newCallableConstructor(ModelType modelType, Anything qualifyingInstance)
    =>  let ([returnType, argumentsTuple]
            =   returnTypeAndArgumentsTupleForReference(modelType))
        createCallableConstructor {
            constructorType = modelType;    
            typeTP = TypeDescriptorImpl(returnType);
            argumentsTP = TypeDescriptorImpl(argumentsTuple);
            qualifyingInstance = qualifyingInstance;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared MemberClassCallableConstructor<Container, Type, Arguments>
newMemberClassCallableConstructor
        <in Container = Nothing, out Type=Object, in Arguments=Nothing>
        (ModelType type)
        given Arguments satisfies Anything[]
    =>  MemberClassCallableConstructorImpl<Container, Type, Arguments>(type);

// FIXME make this native & provide correct type arguments to the type's constructor
shared ValueConstructor<Type>
newValueConstructor<out Type=Anything>(
        ModelType type,
        Anything qualifyingInstance)
    =>  ValueConstructorImpl<Type>(type, qualifyingInstance);

// FIXME make this native & provide correct type arguments to the type's constructor
shared MemberClassValueConstructor<Container, Type>
newMemberClassValueConstructor<in Container = Nothing, out Type=Object>
        (ModelType type)
    =>  MemberClassValueConstructorImpl<Container, Type>(type);

// FIXME make this native & provide correct type arguments to the type's constructor
shared Value<Get, Set>
newValue<out Get=Anything, in Set=Nothing>
        (ModelTypedReference typedReference)
    =>  ValueImpl<Get, Set>(typedReference);

// FIXME make this native & provide correct type arguments to the type's constructor
shared Attribute<Container, Get, Set>
newAttribute<in Container = Nothing, out Get=Anything, in Set=Nothing>
        (ModelTypedReference typedReference)
    =>  AttributeImpl<Container, Get, Set>(typedReference);

// FIXME make this native & provide correct type arguments to the type's constructor
shared Function<Type, Arguments>
newFunction<out Type=Anything, in Arguments=Nothing>
        (ModelTypedReference typedReference)
        given Arguments satisfies Anything[]
    =>  FunctionImpl<Type, Arguments>(typedReference);

// FIXME make this native & provide correct type arguments to the type's constructor
shared Method<Container, Type, Arguments>
newMethod<in Container = Nothing, out Type=Anything, in Arguments=Nothing>
        (ModelTypedReference typedReference)
        given Arguments satisfies Anything[]
    =>  MethodImpl<Container, Type, Arguments>(typedReference);

shared Class<Anything, Nothing> newClass
        (ModelType | TypeDescriptor type, Anything qualifyingInstance) {

    value modelType = if (is TypeDescriptor type) then type.type else type;

    return
    createClass {
        typeTP = TypeDescriptorImpl(modelType);
        argumentsTP = TypeDescriptorImpl(argumentsTupleForClass(modelType));
        modelType = modelType;
        // not validating the container instance
        qualifyingInstance = qualifyingInstance;
    };
}

ModelType argumentsTupleForClass(ModelType modelType) {
    assert (is ModelClassDefinition modelDeclaration = modelType.declaration);
    if (is ModelClassWithInitializer modelDeclaration) {
        assert (exists t = modelType.unit.getCallableTuple(modelType.fullType));
        return t;
    }
    else if (is ModelConstructor defaultCtor = modelDeclaration.getDirectMember(""),
             defaultCtor.isShared) {
        assert (exists t = modelType.unit.getCallableTuple {
            defaultCtor.appliedType(modelType, [], emptyMap);
        });
        return t;
    }
    else {
        return modelType.unit.getNothingType();
    }
}

shared MemberClass<Nothing, Anything, Nothing> newMemberClass
        (ModelType | TypeDescriptor type) {

    value modelType = if (is TypeDescriptor type) then type.type else type;

    "A member class must have a qualifying type."
    assert (exists qualifyingTypeModel = modelType.qualifyingType);

    return
    createMemberClass {
        containerTP = TypeDescriptorImpl(qualifyingTypeModel);
        typeTP = TypeDescriptorImpl(modelType);
        argumentsTP = TypeDescriptorImpl(argumentsTupleForClass(modelType));
        modelType = modelType;
    };
}

// FIXME make this native & provide correct type arguments to the type's constructor
shared Interface<Type> newInterface<out Type=Anything>(
        ModelType | TypeDescriptor type,
        Anything qualifyingInstance)
    =>  InterfaceImpl<Type> {
            if (is TypeDescriptor type)
                then type.type
                else type;
            qualifyingInstance;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared MemberInterface<Container, Type>
newMemberInterface<in Container=Nothing, out Type=Anything>
        (ModelType | TypeDescriptor type)
    =>  MemberInterfaceImpl<Container, Type> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared UnionType<Type> newUnionType<out Type=Anything>(ModelType | TypeDescriptor type)
    =>  UnionTypeImpl<Type> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared IntersectionType<Type> newIntersectionType<out Type=Anything>
        (ModelType | TypeDescriptor type)
    =>  IntersectionTypeImpl<Type> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

shared Function<> | Method<> | Value<> | Attribute<> newFunctionOrValue
        (ModelTypedReference typedReference) {
    switch (d = typedReference.declaration)
    case (is ModelFunction) {
        return if (d.isMember)
               then newMethod<>(typedReference)
               else newFunction<>(typedReference);
    }
    case (is ModelValue) {
        return if (d.isMember)
               then newAttribute<>(typedReference)
               else newValue<>(typedReference);
    }
    case (is ModelSetter) {
        throw AssertionError("creating models for setters is not supported");
    }
}

shared ClassModel<Anything> newClassModel(ModelType modelType)
    =>  if (modelType.declaration.isMember)
        then newMemberClass(modelType)
        else newClass(modelType, null);

shared InterfaceModel<Type> newInterfaceModel<out Type=Anything>(ModelType modelType)
    =>  if (modelType.declaration.isMember)
        then newMemberInterface(modelType)
        else newInterface(modelType, null);

// FIXME return ClosedType<Anything> and let caller call unsafeCast
"Return the ceylon metamodel type for the type. The type parameters are not actually
 used or verified, but are provided as a convenience in order for callers to avoid an
 expensive assert() on the returned value."
shared ClosedType<Type> newType<out Type=Anything>(ModelType | TypeDescriptor type) {
    value modelType
        =   if (is TypeDescriptor type)
            then type.type
            else type;

    switch (d = modelType.declaration)
    case (is ModelClass) {
        return unsafeCast<ClassModel<Type>>(newClassModel(modelType));
    }
    case (is ModelInterface) {
        return newInterfaceModel(modelType);
    }
    case (is ModelUnionType) {
        return newUnionType(modelType);
    }
    case (is ModelIntersectionType) {
        return newIntersectionType(modelType);
    }
    case (is ModelNothingDeclaration) {
        return nothingType;
    }
    case (is ModelConstructor) {
        throw AssertionError(
            "Constructors are not supported; use newConstructor() instead.");
    }
    case (is ModelTypeAlias | ModelUnknownType | ModelTypeParameter) {
        throw AssertionError(
            "Meta expressions not yet supported for type declaration type: \
            ``className(d)``");
    }
}

MemberClassCallableConstructor<Container, Type, Arguments> |
MemberClassValueConstructor<Container, Type>
newMemberClassConstructor<in Container = Nothing, out Type=Anything, in Arguments=Nothing>
        (ModelType modelType)
        given Arguments satisfies Anything[] {

    "must be constructor for a member class (use newConstructor())"
    assert(modelType.declaration.container is ModelClass);

    switch (d = modelType.declaration)
    case (is ModelValueConstructor) {
        return newMemberClassValueConstructor<Container, Type>(modelType);
    }
    case (is ModelCallableConstructor) {
        return newMemberClassCallableConstructor<Container, Type, Arguments>(modelType);
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}

// TODO return worse types and let caller call unsafeCast()
CallableConstructor<Type, Arguments> | ValueConstructor<Type>
newConstructor<out Type=Anything, in Arguments=Nothing>(
        ModelType modelType,
        Anything qualifyingInstance)
        given Arguments satisfies Anything[] {

    "A containing instance must be provided xor the constructor must be for a
     toplevel class"
    assert(qualifyingInstance exists
        != modelType.declaration.container.container is ModelPackage);

    switch (d = modelType.declaration)
    case (is ModelValueConstructor) {
        return newValueConstructor<Type>(modelType, qualifyingInstance);
    }
    case (is ModelCallableConstructor) {
        return unsafeCast<CallableConstructor<Type, Arguments>>(
                newCallableConstructor(modelType, qualifyingInstance));
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}

native
CallableConstructor<Anything, Nothing> createCallableConstructor(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType constructorType,
        Anything qualifyingInstance);

native
Class<Anything, Nothing> createClass(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelType,
        Anything qualifyingInstance);

native
MemberClass<Nothing, Anything, Nothing> createMemberClass(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelType);
