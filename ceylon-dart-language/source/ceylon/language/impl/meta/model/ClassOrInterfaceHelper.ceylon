import ceylon.language.meta.model {
    ClosedType = Type, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute,
    nothingType,
    IncompatibleTypeException
}
import ceylon.language.impl.meta.declaration {
    newClassDeclaration
}
import ceylon.dart.runtime.model {
    unionDeduped,
    ModelClass = Class,
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
    Member<Container, Kind>?
    getClassOrInterface<Container=Nothing, Kind=ClassOrInterface<>>
            (String name, ClosedType<Anything>* types)
            given Kind satisfies ClassOrInterface<Anything> => nothing;

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
        if (!is ModelClass modelMember) {
            throw IncompatibleTypeException("Specified member is not a class: ``name``");
        }

        assert (is ModelClassOrInterface modelMemberContainer
            =   modelMember.container);

        assert (exists modelQualifyingType
            =   union.getSupertype(modelMemberContainer));

        value classDeclaration
            =   newClassDeclaration(modelMember);

        return classDeclaration.memberClassApply<Container, Type, Arguments> {
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
            (String name, ClosedType<Anything>* types) => nothing;

    shared
    MemberInterface<Container, Type>?
    getDeclaredInterface<Container=Nothing, Type=Anything>
            (String name, ClosedType<Anything>* types) => nothing;
    
    shared
    Method<Container, Type, Arguments>?
    getMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] => nothing;

    shared
    Method<Container, Type, Arguments>?
    getDeclaredMethod<Container=Nothing, Type=Anything, Arguments=Nothing>
            (String name, ClosedType<Anything>* types)
            given Arguments satisfies Anything[] => nothing;

    shared
    Attribute<Container, Get, Set>?
    getAttribute<Container=Nothing, Get=Anything, Set=Nothing>
            (String name) => nothing;

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
