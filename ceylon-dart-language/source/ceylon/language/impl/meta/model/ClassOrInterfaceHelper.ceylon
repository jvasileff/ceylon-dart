import ceylon.language.meta.model {
    ClosedType = Type, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute,
    nothingType,
    IncompatibleTypeException
}
import ceylon.language.impl.meta.declaration {
    newClassDeclaration,
    newInterfaceDeclaration,
    newFunctionDeclaration,
    newValueDeclaration,
    newClassOrInterfaceDeclaration
}
import ceylon.dart.runtime.model {
    unionDeduped,
    ModelDeclaration = Declaration,
    ModelClass = Class,
    ModelFunction = Function,
    ModelValue = Value,
    ModelInterface = Interface,
    ModelClassOrInterface = ClassOrInterface,
    ModelType = Type
}

interface ClassOrInterfaceHelper<out Type>
        satisfies TypeHelper<Type> & ModelHelper & GenericHelper {

    shared
    ClassModel<>? extendedType
        =>  if (exists et = modelType.declaration.extendedType)
            then newClass(et)
            else null;

    shared
    InterfaceModel<>[] satisfiedTypes
        =>  modelType.satisfiedTypes.collect((mst) => newInterfaceModel(mst));

    shared
    Type[] caseValues => nothing;

    [ModelType, ModelDeclaration]? getModelMember<Container>(String name) {
        // Regarding Container, see https://github.com/ceylon/ceylon/issues/5137    

        value containerType = `Container`;

        ModelType union;
        if (containerType == nothingType) {
            union = modelType;
        }
        else {
            assert (is TypeImpl<Anything> containerType);
            union = unionDeduped([modelType, containerType.modelType], modelType.unit);
        }

        value modelMember = union.declaration.getMember(name, null);
        if (!exists modelMember) {
            return null;
        }

        assert (is ModelClassOrInterface modelMemberContainer
            =   modelMember.container);

        assert (exists modelQualifyingType
            =   union.getSupertype(modelMemberContainer));

        return [modelQualifyingType, modelMember];
    }

    Member<Container, Kind>?
    appliedMemberClassOrInterface<Container, Kind>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types)
            given Kind satisfies ClassOrInterface<Anything> {

        if (!exists modelMember) {
            return null;
        }

        if (!is ModelClassOrInterface modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a class or interface: ``modelMember.name``");
        }

        value result
            =   newClassOrInterfaceDeclaration(modelMember)
                        .memberApply<Container, Nothing> {
                    containerType = newType(modelQualifyingType);
                    typeArguments = types.sequence();
                };

        if (!is Member<Container, Kind> result) {
            // TODO Improve. The JVM code claims to do better in applyClassOrInterface()
            throw IncompatibleTypeException("Incorrect Kind: `` `Kind` ``");
        }
        return result;
    }

    shared
    Member<Container, Kind>?
    getClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything>
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedMemberClassOrInterface<Container, Kind> {
                modelQualifyingType;
                modelMember;
                types;
            }
            else null;

    shared
    Member<Container, Kind>?
    getDeclaredClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything> {
        validateDeclaredContainer(`Container`);
        return appliedMemberClassOrInterface<Container, Kind> {
            modelType;
            modelType.declaration.getDirectMember(name);
            types;
        };
    }

    MemberClass<Container, Type, Arguments>?
    appliedMemberClass<Container, Type, Arguments>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types)
            given Arguments satisfies Anything[] {

        if (!exists modelMember) {
            return null;
        }

        if (!is ModelClass modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a class: ``modelMember.name``");
        }

        return newClassDeclaration(modelMember)
                .memberClassApply<Container, Type, Arguments> {
            containerType = newType(modelQualifyingType);
            typeArguments = types.sequence();
        };
    }

    shared
    MemberClass<Container, Type, Arguments>?
    getClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedMemberClass<Container, Type, Arguments> {
                modelQualifyingType;
                modelMember;
                types;
            }
            else null;

    shared
    MemberClass<Container, Type, Arguments>?
    getDeclaredClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {
        validateDeclaredContainer(`Container`);
        return appliedMemberClass<Container, Type, Arguments> {
            modelType;
            modelType.declaration.getDirectMember(name);
            types;
        };
    }

    MemberInterface<Container, Type>?
    appliedMemberInterface<Container, Type>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types) {

        if (!exists modelMember) {
            return null;
        }

        if (!is ModelInterface modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not an interface: ``modelMember.name``");
        }

        value result
            =   newInterfaceDeclaration(modelMember)
                        .memberApply<Container, Type> {
                    containerType = newType(modelQualifyingType);
                    typeArguments = types.sequence();
                };

        // TODO eliminate expesive reified is test
        assert (is MemberInterface<Container, Type> result);
        return result;
    }

    shared
    MemberInterface<Container, Type>?
    getInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types)
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedMemberInterface<Container, Type> {
                modelQualifyingType;
                modelMember;
                types;
            }
            else null;

    shared
    MemberInterface<Container, Type>?
    getDeclaredInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types) {
        validateDeclaredContainer(`Container`);
        return appliedMemberInterface<Container, Type> {
            modelType;
            modelType.declaration.getDirectMember(name);
            types;
        };
    }

    Method<Container, Type, Arguments>?
    appliedMethod<Container, Type, Arguments>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types)
            given Arguments satisfies Anything[] {

        if (!exists modelMember) {
            return null;
        }

        if (!is ModelFunction modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a method: ``modelMember.name``");
        }

        return newFunctionDeclaration(modelMember)
                .memberApply<Container, Type, Arguments> {
            containerType = newType(modelQualifyingType);
            typeArguments = types.sequence();
        };
    }

    shared
    Method<Container, Type, Arguments>?
    getMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[]
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedMethod<Container, Type, Arguments> {
                modelQualifyingType;
                modelMember;
                types;
            }
            else null;

    shared
    Method<Container, Type, Arguments>?
    getDeclaredMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {
        validateDeclaredContainer(`Container`);
        return appliedMethod<Container, Type, Arguments> {
            modelType;
            modelType.declaration.getDirectMember(name);
            types;
        };
    }

    Attribute<Container, Get, Set>?
    appliedAttribute<Container, Get, Set>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember) {

        if (!exists modelMember) {
            return null;
        }

        if (!is ModelValue modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a value: ``modelMember.name``");
        }

        return newValueDeclaration(modelMember)
                .memberApply<Container, Get, Set> {
            containerType = newType(modelQualifyingType);
        };
    }

    shared
    Attribute<Container, Get, Set>?
    getAttribute<Container=Nothing, Get=Anything, Set=Nothing>(String name)
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedAttribute<Container, Get, Set> {
                modelQualifyingType;
                modelMember;
            }
            else null;

    shared
    Attribute<Container, Get, Set>?
    getDeclaredAttribute<Container=Nothing, Get=Anything, Set=Nothing>(String name) {
        validateDeclaredContainer(`Container`);
        return appliedAttribute<Container, Get, Set> {
            modelType;
            modelType.declaration.getDirectMember(name);
        };
    }

    shared
    Attribute<Container, Get, Set>[]
    getDeclaredAttributes<Container=Nothing, Get=Anything, Set=Nothing>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared
    Attribute<Container, Get, Set>[]
    getAttributes<Container=Nothing, Get=Anything, Set=Nothing>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared
    Method<Container, Type, Arguments>[]
    getDeclaredMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    Method<Container, Type, Arguments>[]
    getMethods<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    MemberClass<Container, Type, Arguments>[]
    getDeclaredClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    MemberClass<Container, Type, Arguments>[]
    getClasses<Container=Nothing, Type=Anything, Arguments=Nothing>
            (ClosedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared
    MemberInterface<Container, Type>[]
    getDeclaredInterfaces<Container=Nothing, Type=Anything>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared MemberInterface<Container, Type>[]
    getInterfaces<Container=Nothing, Type=Anything>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    "For use only by the getDeclared*() functions."
    void validateDeclaredContainer(ClosedType<> container) {
        if (!container.subtypeOf(thisType)) {
            // TODO use same error message as JVM impl
            throw IncompatibleTypeException(
                "Specified Container '``container``' is not a subtype of this \
                 type '``thisType``'");
        }
    }
}
