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
    ModelConstructor = Constructor,
    ModelValueConstructor = ValueConstructor,
    ModelCallableConstructor = CallableConstructor,
    ModelTypeAlias = TypeAlias,
    ModelTypeParameter = TypeParameter,
    ModelInterface = Interface,
    ModelFunction = Function,
    ModelUnknownType = UnknownType,
    ModelValue = Value,
    ModelSetter = Setter,
    ModelUnionType = UnionType,
    ModelIntersectionType = IntersectionType,
    ModelNothingDeclaration = NothingDeclaration
}
import ceylon.dart.runtime.model.runtime {
    TypeDescriptor
}

// FIXME make this native & provide correct type arguments to the type's constructor
shared CallableConstructor<Type, Arguments>
newCallableConstructor<out Type=Anything, in Arguments=Nothing>
        (ModelType type)
        given Arguments satisfies Anything[]
    =>  CallableConstructorImpl<Type, Arguments>(type);

// FIXME make this native & provide correct type arguments to the type's constructor
shared MemberClassCallableConstructor<Container, Type>
newMemberClassCallableConstructor
        <in Container = Nothing, out Type=Object, in Arguments=Nothing>
        (ModelType type)
        given Arguments satisfies Anything[]
    =>  MemberClassCallableConstructorImpl<Container, Type, Arguments>(type);

// FIXME make this native & provide correct type arguments to the type's constructor
shared ValueConstructor<Type>
newValueConstructor<out Type=Anything>
        (ModelType type)
    =>  ValueConstructorImpl<Type>(type);

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

// FIXME make this native & provide correct type arguments to the type's constructor
shared Class<Type, Arguments> newClass<out Type=Anything, in Arguments=Nothing>
        (ModelType | TypeDescriptor type)
        given Arguments satisfies Anything[]
    =>  ClassImpl<Type, Arguments> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared MemberClass<Container, Type, Arguments>
newMemberClass<in Container = Nothing, out Type=Anything, in Arguments=Nothing>
        (ModelType | TypeDescriptor type)
        given Arguments satisfies Anything[]
    =>  MemberClassImpl<Container, Type, Arguments> {
            if (is TypeDescriptor type)
            then type.type
            else type;
        };

// FIXME make this native & provide correct type arguments to the type's constructor
shared Interface<Type> newInterface<out Type=Anything>(ModelType | TypeDescriptor type)
    =>  InterfaceImpl<Type> {
            if (is TypeDescriptor type)
            then type.type
            else type;
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

shared ClassModel<Type> newClassModel<out Type=Anything>(ModelType modelType)
    =>  if (modelType.declaration.isMember)
        then newMemberClass(modelType)
        else newClass(modelType);

shared InterfaceModel<Type> newInterfaceModel<out Type=Anything>(ModelType modelType)
    =>  if (modelType.declaration.isMember)
        then newMemberInterface(modelType)
        else newInterface(modelType);

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

// TODO remove if not needed
CallableConstructor<Type> | ValueConstructor<Type>
newConstructor<out Type=Anything>(ModelType modelType) {
    switch (d = modelType.declaration)
    case (is ModelValueConstructor) {
        return newValueConstructor<Type>(modelType);
    }
    case (is ModelCallableConstructor) {
        return newValueConstructor<Type>(modelType);
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}
