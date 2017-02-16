import ceylon.language.meta.model {
    ClosedType = Type, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute,
    nothingType,
    IncompatibleTypeException
}
import ceylon.language.meta.declaration {
    ValueDeclaration,
    FunctionDeclaration
}
import ceylon.language.impl.meta.declaration {
    newDeclaration,
    newClassDeclaration,
    newInterfaceDeclaration,
    newClassOrInterfaceDeclaration
}
import ceylon.dart.runtime.model {
    unionDeduped,
    ModelDeclaration = Declaration,
    ModelClass = Class,
    ModelInterface = Interface,
    ModelClassOrInterface = ClassOrInterface,
    ModelType = Type
}

interface ClassOrInterfaceHelper<out Type>
        satisfies TypeHelper<Type> & ModelHelper & GenericHelper {

    shared
    ClassModel<>? extendedType
        =>  if (exists et = modelReference.declaration.extendedType)
            then newClassModel(et)
            else null;

    shared
    InterfaceModel<>[] satisfiedTypes
        =>  modelReference.satisfiedTypes.collect((mst) => newInterfaceModel(mst));

    shared
    Type[] caseValues => nothing;

    [ModelType, ModelDeclaration]? getModelMember<Container>(String name) {
        // Regarding Container, see https://github.com/ceylon/ceylon/issues/5137    

        value containerType = `Container`;

        ModelType union;
        if (containerType == nothingType) {
            union = modelReference;
        }
        else {
            assert (is TypeImpl<Anything> containerType);
            union = unionDeduped {
                [modelReference, containerType.modelReference];
                modelReference.unit;
            };
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

        if (!is ModelClassOrInterface modelMember) {
            return null;
        }

        value result
            =   newClassOrInterfaceDeclaration(modelMember)
                        .memberApply<Container, Nothing> {
                    containerType = unsafeCast<ClosedType<Object>> {
                        newType(modelQualifyingType);
                    };
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
    getClassOrInterface<Container, Kind>(String name, ClosedType<Anything>* types)
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
    getDeclaredClassOrInterface<Container, Kind>(String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything> {
        validateDeclaredContainer(`Container`);
        return appliedMemberClassOrInterface<Container, Kind> {
            modelReference;
            modelReference.declaration.getDirectMember(name);
            types;
        };
    }

    MemberClass<Container, Type, Arguments>?
    appliedMemberClass<Container, Type, Arguments>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types)
            given Arguments satisfies Anything[] {

        if (!is ModelClass modelMember) {
            return null;
        }

        return newClassDeclaration(modelMember)
                .memberClassApply<Container, Type, Arguments> {
            containerType = unsafeCast<ClosedType<Object>>(newType(modelQualifyingType));
            typeArguments = types.sequence();
        };
    }

    shared
    MemberClass<Container, Type, Arguments>? getClass<Container, Type, Arguments>
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
    MemberClass<Container, Type, Arguments>? getDeclaredClass<Container, Type, Arguments>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {
        validateDeclaredContainer(`Container`);
        return appliedMemberClass<Container, Type, Arguments> {
            modelReference;
            modelReference.declaration.getDirectMember(name);
            types;
        };
    }

    MemberInterface<Container, Type>?
    appliedMemberInterface<Container, Type>(
            ModelType modelQualifyingType,
            ModelDeclaration? modelMember,
            [ClosedType<Anything>*] types) {

        if (!is ModelInterface modelMember) {
            return null;
        }

        value result
            =   newInterfaceDeclaration(modelMember)
                        .memberApply<Container, Type> {
                    containerType = unsafeCast<ClosedType<Object>> {
                        newType(modelQualifyingType);
                    };
                    typeArguments = types.sequence();
                };

        // TODO eliminate expesive reified is test
        assert (is MemberInterface<Container, Type> result);
        return result;
    }

    shared
    MemberInterface<Container, Type>?
    getInterface<Container, Type>(String name, ClosedType<Anything>* types)
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
    getDeclaredInterface<Container, Type>(String name, ClosedType<Anything>* types) {
        validateDeclaredContainer(`Container`);
        return appliedMemberInterface<Container, Type> {
            modelReference;
            modelReference.declaration.getDirectMember(name);
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

        value declaration = newDeclaration(modelMember);

        if (!is FunctionDeclaration declaration) {
            return null;
        }

        return declaration.memberApply<Container, Type, Arguments> {
            containerType = unsafeCast<ClosedType<Object>>(newType(modelQualifyingType));
            typeArguments = types.sequence();
        };
    }

    shared
    Method<Container, Type, Arguments>? getMethod<Container, Type, Arguments>
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
    Method<Container, Type, Arguments>? getDeclaredMethod<Container, Type, Arguments>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {
        validateDeclaredContainer(`Container`);
        return appliedMethod<Container, Type, Arguments> {
            modelReference;
            modelReference.declaration.getDirectMember(name);
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

        value declaration = newDeclaration(modelMember);

        if (!is ValueDeclaration declaration) {
            return null;
        }

        return declaration.memberApply<Container, Get, Set> {
            containerType = unsafeCast<ClosedType<Object>>(newType(modelQualifyingType));
        };
    }

    shared
    Attribute<Container, Get, Set>? getAttribute<Container, Get, Set>(String name)
        =>  if (exists [modelQualifyingType, modelMember]
                =   getModelMember<Container>(name))
            then appliedAttribute<Container, Get, Set> {
                modelQualifyingType;
                modelMember;
            }
            else null;

    shared
    Attribute<Container, Get, Set>? getDeclaredAttribute<Container, Get, Set>
            (String name) {
        validateDeclaredContainer(`Container`);
        return appliedAttribute<Container, Get, Set> {
            modelReference;
            modelReference.declaration.getDirectMember(name);
        };
    }

    shared
    Attribute<Container, Get, Set>[] getDeclaredAttributes<Container, Get, Set>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared
    Attribute<Container, Get, Set>[] getAttributes<Container, Get, Set>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared
    Method<Container, Type, Arguments>[] getDeclaredMethods<Container, Type, Arguments>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    Method<Container, Type, Arguments>[] getMethods<Container, Type, Arguments>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    MemberClass<Container, Type, Arguments>[]
    getDeclaredClasses<Container, Type, Arguments>
            (ClosedType<Annotation>* annotationTypes)
            given Arguments satisfies Anything[] => nothing;

    shared
    MemberClass<Container, Type, Arguments>[] getClasses<Container, Type, Arguments>
            (ClosedType<Annotation>* annotationTypes)
                given Arguments satisfies Anything[] => nothing;

    shared
    MemberInterface<Container, Type>[] getDeclaredInterfaces<Container, Type>
            (ClosedType<Annotation>* annotationTypes) => nothing;

    shared MemberInterface<Container, Type>[] getInterfaces<Container, Type>
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
