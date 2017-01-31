import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelDeclaration = Declaration,
    ModelClassOrInterface = ClassOrInterface
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    NestableDeclaration,
    OpenType,
    OpenInterfaceType,
    OpenClassType
}
import ceylon.language.meta.model {
    ClosedType = Type,
    Member,
    ClassOrInterface,
    IncompatibleTypeException,
    TypeApplicationException
}
import ceylon.language.impl.meta.model {
    modelTypeFromType,
    newType
}

interface ClassOrInterfaceDeclarationHelper
        satisfies NestableDeclarationHelper & GenericDeclarationHelper {

    shared actual formal
    ModelClassOrInterface modelDeclaration;

    shared
    OpenType[] caseTypes
        =>  modelDeclaration.caseTypes.collect(newOpenType);

    shared
    OpenClassType? extendedType {
        if (exists modelExtendedType = modelDeclaration.extendedType) {
            assert (is OpenClassType result = newOpenType(modelExtendedType));
            return result;
        }
        "Only 'Anything' has no extended type."
        assert (modelDeclaration.isAnything);
        return null;
    }

    shared
    Boolean isAlias
        =>  modelDeclaration.isAlias;

    shared
    OpenInterfaceType[]
    satisfiedTypes
        =>  modelDeclaration.satisfiedTypes.collect((st) {
                assert (is OpenInterfaceType ot = newOpenType(st));
                return ot;
            });

    shared
    Kind[] annotatedDeclaredMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared
    Kind[] annotatedMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared
    ClassOrInterface<Type> apply<out Type = Anything>
            (ClosedType<Anything>* typeArguments) {

        if (!toplevel) {
            throw TypeApplicationException(
                "Cannot apply a member declaration with no container type: \
                 use memberApply");
        }

        value modelTypeArgs
            =   typeArguments.collect(modelTypeFromType);

        validateTypeArgumentsOrThrow {
            null;
            modelDeclaration;
            modelTypeArgs;
        };

        value result
            =   newType {
                    modelDeclaration.appliedType {
                        qualifyingType = null;
                        typeArguments = modelTypeArgs;
                        varianceOverrides = emptyMap;
                    };
                };

        // TODO optimize away type argument checks when Type = Anything
        if (!is ClassOrInterface<Type> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Type");
        }

        return result;
    }

    shared
    Kind[] declaredMemberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
        =>  [ for (member in modelDeclaration.members.map(Entry.item)
                                     .map(newNestableDeclaration))
              if (is Kind member) member ];

    shared
    Kind? getDeclaredMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = modelDeclaration.getDirectMember(name),
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared
    Kind? getMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = modelDeclaration.getMember(name, null),
                memberModel.isShared,
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared
    Member<Container, ClassOrInterface<Type>> & ClassOrInterface<Type>
    memberApply<in Container = Nothing, out Type = Anything>(
            ClosedType<Object> containerType,
            ClosedType<Anything>* typeArguments) {

        if (toplevel) {
            throw TypeApplicationException(
                "Cannot apply a toplevel declaration to a container type: use apply");
        }

        value qualifyingType
            =   getQualifyingSupertypeOrThrow {
                    modelTypeFromType(containerType);
                    modelDeclaration;
                };

        value modelTypeArgs
            =   typeArguments.collect(modelTypeFromType);

        validateTypeArgumentsOrThrow {
            qualifyingType;
            modelDeclaration;
            modelTypeArgs;
        };

        value result 
            =   newType {
                    modelDeclaration.appliedType {
                        qualifyingType = qualifyingType;
                        typeArguments = modelTypeArgs;
                        varianceOverrides = emptyMap;
                    };
                };

        // TODO optimize away type argument checks when Container=Nothing, Type=Anything
        if (!is Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type> result) {
            // TODO Improve. The JVM code claims to do better with
            //      checkReifiedTypeArgument()
            throw IncompatibleTypeException("Incorrect Container or Type");
        }

        return result;
    }

    shared
    Kind[] memberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
            // FIXME should include inherited members
        =>  [ for (member in modelDeclaration.members.map(Entry.item)
                                .map(newNestableDeclaration))
              if (is Kind member) member ];
}
