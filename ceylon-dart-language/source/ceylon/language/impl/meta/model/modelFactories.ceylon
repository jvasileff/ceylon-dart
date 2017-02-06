import ceylon.language.meta.model {
    ClosedType = Type, Class, MemberClass, Interface, MemberInterface, UnionType,
    InterfaceModel, CallableConstructor, ValueConstructor, ClassModel,
    MemberClassCallableConstructor, MemberClassValueConstructor,
    IntersectionType, nothingType,
    Function, Method, Value, Attribute
}
import ceylon.dart.runtime.model {
    ModelReference = Reference,
    ModelType = Type,
    ModelTypedReference = TypedReference,
    ModelClass = Class,
    ModelClassDefinition = ClassDefinition,
    ModelClassWithInitializer = ClassWithInitializer,
    ModelConstructor = Constructor,
    ModelValueConstructor = ValueConstructor,
    ModelCallableConstructor = CallableConstructor,
    ModelTypeAlias = TypeAlias,
    ModelTypeParameter = TypeParameter,
    ModelInterface = Interface,
    ModelPackage = Package,
    ModelUnknownType = UnknownType,
    ModelValue = Value,
    ModelUnionType = UnionType,
    ModelIntersectionType = IntersectionType,
    ModelNothingDeclaration = NothingDeclaration
}
import ceylon.dart.runtime.model.runtime {
    TypeDescriptor,
    TypeDescriptorImpl
}

shared CallableConstructor<> newCallableConstructor
        (ModelType modelReference, Anything qualifyingInstance)
    =>  let ([returnType, argumentsTuple] = returnTypeAndArguments(modelReference))
        createCallableConstructor {
            typeTP = TypeDescriptorImpl(returnType);
            argumentsTP = TypeDescriptorImpl(argumentsTuple);
            modelReference = modelReference;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberClassCallableConstructor<> newMemberClassCallableConstructor
        (ModelType modelReference) {
    assert (exists qualifyingType = modelReference.qualifyingType?.qualifyingType);
    return let ([returnType, argumentsTuple] = returnTypeAndArguments(modelReference))
        createMemberClassCallableConstructor {
            containerTP = TypeDescriptorImpl(qualifyingType);
            typeTP = TypeDescriptorImpl(returnType);
            argumentsTP = TypeDescriptorImpl(argumentsTuple);
            modelReference = modelReference;
        };
}

shared ValueConstructor<> newValueConstructor
        (ModelType modelReference, Anything qualifyingInstance)
    =>  createValueConstructor {
            typeTP = TypeDescriptorImpl(modelReference);
            modelReference = modelReference;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberClassValueConstructor<> newMemberClassValueConstructor
        (ModelType modelReference) {
    assert (exists qualifyingType = modelReference.qualifyingType?.qualifyingType);
    return createMemberClassValueConstructor {
            containerTP = TypeDescriptorImpl(qualifyingType);
            typeTP = TypeDescriptorImpl(modelReference);
            modelReference = modelReference;
        };
}

shared Value<> newValue(ModelTypedReference modelReference, Anything qualifyingInstance)
    =>  let (typeTD = TypeDescriptorImpl(modelReference.type))
        createValue {
            getTP = typeTD;
            setTP = if (isVariableOrHasSetter(modelReference))
                    then typeTD
                    else TypeDescriptorImpl(
                        modelReference.declaration.unit.getNothingType());
            modelReference = modelReference;
            qualifyingInstance = qualifyingInstance;
        };

shared Attribute<> newAttribute(ModelTypedReference modelReference) {
    assert (exists qualifyingType = modelReference.qualifyingType);
    value typeTD = TypeDescriptorImpl(modelReference.type);
    return createAttribute {
        containerTP = TypeDescriptorImpl(qualifyingType);
        getTP = typeTD;
        setTP = if (isVariableOrHasSetter(modelReference))
                then typeTD
                else TypeDescriptorImpl(
                    modelReference.declaration.unit.getNothingType());
        modelReference = modelReference;
    };
}

shared Function<> newFunction
        (ModelTypedReference modelReference, Anything qualifyingInstance)
    =>  let ([returnType, argumentsTuple] = returnTypeAndArguments(modelReference))
        createFunction {
            TypeDescriptorImpl(returnType);
            TypeDescriptorImpl(argumentsTuple);
            modelReference;
            qualifyingInstance;
        };

shared Method<> newMethod(ModelTypedReference modelReference) {
    assert (exists containerType = modelReference.qualifyingType);
    return let ([returnType, argumentsTuple] = returnTypeAndArguments(modelReference))
        createMethod {
            TypeDescriptorImpl(containerType);
            TypeDescriptorImpl(returnType);
            TypeDescriptorImpl(argumentsTuple);
            modelReference;
        };
}

shared Class<> newClass(ModelType | TypeDescriptor type, Anything qualifyingInstance)
    =>  let (modelReference = if (is TypeDescriptor type) then type.type else type)
        createClass {
            typeTP = TypeDescriptorImpl(modelReference);
            argumentsTP = TypeDescriptorImpl(argumentsTupleForClass(modelReference));
            modelReference = modelReference;
            // not validating the container instance
            qualifyingInstance = qualifyingInstance;
        };

shared MemberClass<> newMemberClass(ModelType | TypeDescriptor type) {
    value modelReference = if (is TypeDescriptor type) then type.type else type;

    "A member class must have a qualifying type."
    assert (exists qualifyingTypeModel = modelReference.qualifyingType);

    return
    createMemberClass {
        containerTP = TypeDescriptorImpl(qualifyingTypeModel);
        typeTP = TypeDescriptorImpl(modelReference);
        argumentsTP = TypeDescriptorImpl(argumentsTupleForClass(modelReference));
        modelReference = modelReference;
    };
}

shared Interface<> newInterface
        (ModelType | TypeDescriptor type, Anything qualifyingInstance)
    =>  let (modelReference = if (is TypeDescriptor type) then type.type else type)
        createInterface {
            typeTP = TypeDescriptorImpl(modelReference);
            modelReference = modelReference;
            qualifyingInstance = qualifyingInstance;
        };

shared MemberInterface<> newMemberInterface(ModelType | TypeDescriptor type) {
    value modelReference = if (is TypeDescriptor type) then type.type else type;
    assert (exists qualifyingType = modelReference.qualifyingType);
    return  createMemberInterface {
        containerTP = TypeDescriptorImpl(qualifyingType);
        typeTP = TypeDescriptorImpl(modelReference);
        modelReference = modelReference;
    };
}

shared UnionType<> newUnionType(ModelType | TypeDescriptor type)
    =>  let (modelReference = if (is TypeDescriptor type) then type.type else type)
        createUnionType {
            typeTP = TypeDescriptorImpl(modelReference);
            modelReference = modelReference;
        };

shared IntersectionType<> newIntersectionType(ModelType | TypeDescriptor type)
    =>  let (modelReference = if (is TypeDescriptor type) then type.type else type)
        createIntersectionType {
            typeTP = TypeDescriptorImpl(modelReference);
            modelReference = modelReference;
        };

shared ClassModel<> newClassModel(ModelType modelReference)
    =>  if (modelReference.declaration.isMember)
        then newMemberClass(modelReference)
        else newClass(modelReference, null);

shared InterfaceModel<> newInterfaceModel(ModelType modelReference)
    =>  if (modelReference.declaration.isMember)
        then newMemberInterface(modelReference)
        else newInterface(modelReference, null);

"Return the ceylon metamodel type for the type."
shared ClosedType<> newType(ModelType | TypeDescriptor type) {
    value modelReference
        =   if (is TypeDescriptor type)
            then type.type
            else type;

    switch (d = modelReference.declaration)
    case (is ModelClass) {
        return newClassModel(modelReference);
    }
    case (is ModelInterface) {
        return newInterfaceModel(modelReference);
    }
    case (is ModelUnionType) {
        return newUnionType(modelReference);
    }
    case (is ModelIntersectionType) {
        return newIntersectionType(modelReference);
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

MemberClassCallableConstructor<> | MemberClassValueConstructor<>
newMemberClassConstructor(ModelType modelReference) {
    "must be constructor for a member class (use newConstructor())"
    assert(modelReference.declaration.container is ModelClass);

    switch (d = modelReference.declaration)
    case (is ModelValueConstructor) {
        return newMemberClassValueConstructor(modelReference);
    }
    case (is ModelCallableConstructor) {
        return newMemberClassCallableConstructor(modelReference);
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}

CallableConstructor<> | ValueConstructor<> newConstructor
        (ModelType modelReference, Anything qualifyingInstance) {

    "A containing instance must be provided xor the constructor must be for a
     toplevel class"
    assert(qualifyingInstance exists
        != modelReference.declaration.container.container is ModelPackage);

    switch (d = modelReference.declaration)
    case (is ModelValueConstructor) {
        return newValueConstructor(modelReference, qualifyingInstance);
    }
    case (is ModelCallableConstructor) {
        return newCallableConstructor(modelReference, qualifyingInstance);
    }
    case (is ModelClass | ModelInterface | ModelUnionType | ModelIntersectionType |
                ModelNothingDeclaration | ModelTypeAlias | ModelUnknownType |
                ModelTypeParameter) {
        throw AssertionError(
            "Argument does not represent a constructor; use newType() instead.");
    }
}

[ModelType, ModelType] returnTypeAndArguments
        (ModelReference modelReference) {
    // Note: For constructors, the return type's declaration is the constructor and the
    //       extended type is the class, which is a bit weird, but ok since usually used
    //       for the covariant `Type` TA?
    value callableType = modelReference.fullType;
    assert (exists result = callableType.unit.getCallableReturnAndTuple(callableType));
    return result;
}

Boolean isVariableOrHasSetter(ModelTypedReference modelReference)
    =>  if (is ModelValue v = modelReference.declaration)
        then v.isVariable || v.setter exists
        else false;

ModelType argumentsTupleForClass(ModelType modelReference) {
    assert (is ModelClassDefinition modelDeclaration = modelReference.declaration);
    if (is ModelClassWithInitializer modelDeclaration) {
        assert (exists t = modelReference.unit.getCallableTuple(modelReference.fullType));
        return t;
    }
    else if (is ModelConstructor defaultCtor = modelDeclaration.getDirectMember(""),
             defaultCtor.isShared) {
        assert (exists t = modelReference.unit.getCallableTuple {
            defaultCtor.appliedType(modelReference, [], emptyMap);
        });
        return t;
    }
    else {
        return modelReference.unit.getNothingType();
    }
}

native
Function<> createFunction(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelTypedReference modelReference,
        Anything qualifyingInstance);

native
Method<> createMethod(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelTypedReference modelReference);

native
Value<> createValue(
        TypeDescriptor getTP,
        TypeDescriptor setTP,
        ModelTypedReference modelReference,
        Anything qualifyingInstance);

native
Attribute<> createAttribute(
        TypeDescriptor containerTP,
        TypeDescriptor getTP,
        TypeDescriptor setTP,
        ModelTypedReference modelReference);

native
CallableConstructor<> createCallableConstructor(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelReference,
        Anything qualifyingInstance);

native
Class<> createClass(
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelReference,
        Anything qualifyingInstance);

native
Interface<> createInterface(
        TypeDescriptor typeTP,
        ModelType modelReference,
        Anything qualifyingInstance);

native
IntersectionType<> createIntersectionType(
        TypeDescriptor typeTP,
        ModelType modelReference);

native
MemberClass<> createMemberClass(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelReference);

native
MemberInterface<> createMemberInterface(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        ModelType modelReference);

native
MemberClassCallableConstructor<>
createMemberClassCallableConstructor(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        TypeDescriptor argumentsTP,
        ModelType modelReference);

native
MemberClassValueConstructor<> createMemberClassValueConstructor(
        TypeDescriptor containerTP,
        TypeDescriptor typeTP,
        ModelType modelReference);

native
UnionType<> createUnionType(
        TypeDescriptor typeTP,
        ModelType modelReference);

native
ValueConstructor<> createValueConstructor(
        TypeDescriptor typeTP,
        ModelType modelReference,
        Anything qualifyingInstance);
