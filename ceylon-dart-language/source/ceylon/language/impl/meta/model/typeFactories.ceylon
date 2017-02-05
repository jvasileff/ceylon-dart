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
            typeTP = TypeDescriptorImpl(returnType);
            argumentsTP = TypeDescriptorImpl(argumentsTuple);
            modelType = modelType;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberClassCallableConstructor<Nothing, Anything, Nothing>
newMemberClassCallableConstructor(ModelType modelType) {
    assert (exists qualifyingType = modelType.qualifyingType?.qualifyingType);
    return let ([returnType, argumentsTuple]
            =   returnTypeAndArgumentsTupleForReference(modelType))
        createMemberClassCallableConstructor {
            containerTP = TypeDescriptorImpl(qualifyingType);
            typeTP = TypeDescriptorImpl(returnType);
            argumentsTP = TypeDescriptorImpl(argumentsTuple);
            modelType = modelType;
        };
}

shared ValueConstructor<Anything>
newValueConstructor(ModelType modelType, Anything qualifyingInstance)
    =>  createValueConstructor {
            typeTP = TypeDescriptorImpl(modelType);
            modelType = modelType;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberClassValueConstructor<Nothing, Anything>
newMemberClassValueConstructor(ModelType modelType) {
    assert (exists qualifyingType = modelType.qualifyingType?.qualifyingType);
    return createMemberClassValueConstructor {
            containerTP = TypeDescriptorImpl(qualifyingType);
            typeTP = TypeDescriptorImpl(modelType);
            modelType = modelType;
        };
}

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

shared Interface<Anything> newInterface
        (ModelType | TypeDescriptor type, Anything qualifyingInstance)
    =>  let (modelType = if (is TypeDescriptor type) then type.type else type)
        createInterface {
            typeTP = TypeDescriptorImpl(modelType);
            modelType = modelType;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberInterface<Nothing, Anything>
newMemberInterface(ModelType | TypeDescriptor type) {
    value modelType = if (is TypeDescriptor type) then type.type else type;
    assert (exists qualifyingType = modelType.qualifyingType);
    return  createMemberInterface {
        containerTP = TypeDescriptorImpl(qualifyingType);
        typeTP = TypeDescriptorImpl(modelType);
        modelType = modelType;
    };
}

shared UnionType<Anything> newUnionType(ModelType | TypeDescriptor type)
    =>  let (modelType = if (is TypeDescriptor type) then type.type else type)
        createUnionType {
            typeTP = TypeDescriptorImpl(modelType);
            modelType = modelType;
        };

shared IntersectionType<Anything> newIntersectionType(ModelType | TypeDescriptor type)
    =>  let (modelType = if (is TypeDescriptor type) then type.type else type)
        createIntersectionType {
            typeTP = TypeDescriptorImpl(modelType);
            modelType = modelType;
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

shared InterfaceModel<Anything> newInterfaceModel(ModelType modelType)
    =>  if (modelType.declaration.isMember)
        then newMemberInterface(modelType)
        else newInterface(modelType, null);

"Return the ceylon metamodel type for the type."
shared ClosedType<Anything> newType(ModelType | TypeDescriptor type) {
    value modelType
        =   if (is TypeDescriptor type)
            then type.type
            else type;

    switch (d = modelType.declaration)
    case (is ModelClass) {
        return newClassModel(modelType);
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

MemberClassCallableConstructor<Nothing, Anything, Nothing> |
MemberClassValueConstructor<Nothing, Anything>
newMemberClassConstructor(ModelType modelType) {
    "must be constructor for a member class (use newConstructor())"
    assert(modelType.declaration.container is ModelClass);

    switch (d = modelType.declaration)
    case (is ModelValueConstructor) {
        return newMemberClassValueConstructor(modelType);
    }
    case (is ModelCallableConstructor) {
        return newMemberClassCallableConstructor(modelType);
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}

CallableConstructor<Anything, Nothing> | ValueConstructor<Anything>
newConstructor(ModelType modelType, Anything qualifyingInstance) {
    "A containing instance must be provided xor the constructor must be for a
     toplevel class"
    assert(qualifyingInstance exists
        != modelType.declaration.container.container is ModelPackage);

    switch (d = modelType.declaration)
    case (is ModelValueConstructor) {
        return newValueConstructor(modelType, qualifyingInstance);
    }
    case (is ModelCallableConstructor) {
        return newCallableConstructor(modelType, qualifyingInstance);
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
        ModelType modelType,
        Anything qualifyingInstance);

native
Class<Anything, Nothing> createClass(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelType,
        Anything qualifyingInstance);

native
Interface<Anything> createInterface(
        TypeDescriptor typeTP,
        ModelType modelType,
        Anything qualifyingInstance);

native
IntersectionType<Anything> createIntersectionType(
        TypeDescriptor typeTP,
        ModelType modelType);

native
MemberClass<Nothing, Anything, Nothing> createMemberClass(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelType);

native
MemberInterface<Nothing, Anything> createMemberInterface(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        ModelType modelType);

native
MemberClassCallableConstructor<Nothing, Anything, Nothing>
createMemberClassCallableConstructor(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelType);

native
MemberClassValueConstructor<Nothing, Anything> createMemberClassValueConstructor(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        ModelType modelType);

native
UnionType<Anything> createUnionType(
        TypeDescriptor typeTP,
        ModelType modelType);

native
ValueConstructor<Anything> createValueConstructor(
        TypeDescriptor typeTP,
        ModelType modelType,
        Anything qualifyingInstance);
