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
    InterfaceModel<>[] satisfiedTypes => nothing;

    shared
    Type[] caseValues => nothing;

    shared
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

    shared
    Member<Container, Kind>?
    getClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything> {

        value models = getModelMember<Container>(name);
        if (!exists models) {
            return null;
        }
        value [modelQualifyingType, modelMember] = models;

        if (!is ModelClassOrInterface modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a class or interface: ``name``");
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
    getDeclaredClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything> => nothing;

    shared
    MemberClass<Container, Type, Arguments>?
    getClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {

        value models = getModelMember<Container>(name);
        if (!exists models) {
            return null;
        }
        value [modelQualifyingType, modelMember] = models;

        if (!is ModelClass modelMember) {
            throw IncompatibleTypeException("Specified member is not a class: ``name``");
        }

        return newClassDeclaration(modelMember)
                .memberClassApply<Container, Type, Arguments> {
            containerType = newType(modelQualifyingType);
            typeArguments = types.sequence();
        };
    }

    shared
    MemberClass<Container, Type, Arguments>?
    getDeclaredClass<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] => nothing;

    shared
    MemberInterface<Container, Type>?
    getInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types) {

        value models = getModelMember<Container>(name);
        if (!exists models) {
            return null;
        }
        value [modelQualifyingType, modelMember] = models;

        if (!is ModelInterface modelMember) {
            throw IncompatibleTypeException(
                "Specified member is not a class or interface: ``name``");
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
    getDeclaredInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types) => nothing;
    
    shared
    Method<Container, Type, Arguments>?
    getMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] {

        value models = getModelMember<Container>(name);
        if (!exists models) {
            return null;
        }
        value [modelQualifyingType, modelMember] = models;

        if (!is ModelFunction modelMember) {
            throw IncompatibleTypeException(
                    "Specified member is not a function: ``name``");
        }

        return newFunctionDeclaration(modelMember)
                .memberApply<Container, Type, Arguments> {
            containerType = newType(modelQualifyingType);
            typeArguments = types.sequence();
        };
    }

    shared
    Method<Container, Type, Arguments>?
    getDeclaredMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] => nothing;

    shared
    Attribute<Container, Get, Set>?
    getAttribute<Container=Nothing, Get=Anything, Set=Nothing>(String name) {

        value models = getModelMember<Container>(name);
        if (!exists models) {
            return null;
        }
        value [modelQualifyingType, modelMember] = models;

        if (!is ModelValue modelMember) {
            throw IncompatibleTypeException(
                    "Specified member is not a value: ``name``");
        }

        return newValueDeclaration(modelMember)
                .memberApply<Container, Get, Set> {
            containerType = newType(modelQualifyingType);
        };
    }

    shared
    Attribute<Container, Get, Set>?
    getDeclaredAttribute<Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

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
}
