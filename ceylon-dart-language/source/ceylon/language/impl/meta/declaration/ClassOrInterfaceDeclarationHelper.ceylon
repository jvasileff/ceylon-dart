import ceylon.dart.runtime.model {
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
    ClassOrInterface
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
    ClassOrInterface<Type> apply<Type>
            (ClosedType<Anything>* typeArguments) => nothing;

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
    Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type>
    memberApply<Container, Type>(
            ClosedType<Object> containerType,
            ClosedType<Anything>* typeArguments) => nothing;

    shared
    Kind[] memberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration
            // FIXME should include inherited members
        =>  [ for (member in modelDeclaration.members.map(Entry.item)
                                .map(newNestableDeclaration))
              if (is Kind member) member ];
}