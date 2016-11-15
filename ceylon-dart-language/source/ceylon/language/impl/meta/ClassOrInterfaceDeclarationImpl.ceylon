import ceylon.dart.runtime.model {
    ClassOrInterfaceModel=ClassOrInterface,
    PackageModel=Package,
    DeclarationModel=Declaration
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    NestableDeclaration,
    OpenType,
    OpenInterfaceType,
    OpenClassType,
    TypeParameter
}
import ceylon.language.meta.model {
    AppliedType=Type,
    Member,
    ClassOrInterface
}

shared abstract
class ClassOrInterfaceDeclarationImpl() /* satisfies ClassOrInterfaceDeclaration */ {

    shared formal ClassOrInterfaceModel modelDeclaration;

    // FROM ClassOrInterfaceDeclaration

    shared
    OpenType[] caseTypesImpl
        =>  modelDeclaration.caseTypes.collect(newOpenType);

    shared
    OpenClassType? extendedTypeImpl {
        if (exists modelExtendedType = modelDeclaration.extendedType) {
            assert (is OpenClassType result = newOpenType(modelExtendedType));
            return result;
        }
        "Only 'Anything' has no extended type."
        assert (modelDeclaration.isAnything);
        return null;
    }

    shared
    Boolean isAliasImpl
        =>  modelDeclaration.isAlias;

    shared
    OpenInterfaceType[] satisfiedTypesImpl
        =>  modelDeclaration.satisfiedTypes.collect((st) {
                assert (is OpenInterfaceType ot = newOpenType(st));
                return ot;
            });

    shared Kind[] annotatedDeclaredMemberDeclarationsImpl<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared Kind[] annotatedMemberDeclarationsImpl<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared ClassOrInterface<Type> applyImpl<Type>
            (AppliedType<Anything>* typeArguments) => nothing;

    shared Kind[] declaredMemberDeclarationsImpl<Kind>()
            given Kind satisfies NestableDeclaration
        =>  [ for (member in modelDeclaration.members.map(Entry.item)
                                     .map(newNestableDeclaration))
              if (is Kind member) member ];

    shared Kind? getDeclaredMemberDeclarationImpl<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = modelDeclaration.getDirectMember(name),
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared Kind? getMemberDeclarationImpl<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = modelDeclaration.getMember(name, null),
                memberModel.isShared,
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type>
    memberApplyImpl<Container, Type>(
            AppliedType<Object> containerType,
            AppliedType<Anything>* typeArguments) => nothing;

    shared Kind[] memberDeclarationsImpl<Kind>()
            given Kind satisfies NestableDeclaration
        // FIXME should include inherited members
        =>  [ for (member in modelDeclaration.members.map(Entry.item)
                                     .map(newNestableDeclaration))
              if (is Kind member) member ];

    // FROM Declaration

    shared String nameImpl => modelDeclaration.name;
    
    shared String qualifiedNameImpl => modelDeclaration.qualifiedName;

    // FROM GenericDeclaration

    shared
    TypeParameter[] typeParameterDeclarationsImpl
        =>  modelDeclaration.typeParameters.collect(TypeParameterImpl);

    shared TypeParameter? getTypeParameterDeclarationImpl(String name) => nothing;

    // FROM NestableDeclaration

    shared Boolean actualImpl => modelDeclaration.isActual;

    shared NestableDeclaration | Package containerImpl {
        switch (containerModel = modelDeclaration.container)
        case (is PackageModel) {
            return PackageImpl(containerModel);
        }
        case (is DeclarationModel) {
            if (exists declaration = newNestableDeclaration(containerModel)) {
                return declaration;
            }
            throw AssertionError("unimplemented declaration type for ``containerModel``");
        }
    }

    shared Module containingModuleImpl => ModuleImpl(modelDeclaration.mod);

    shared Package containingPackageImpl => PackageImpl(modelDeclaration.pkg);

    shared Boolean defaultImpl => modelDeclaration.isDefault;

    shared Boolean formalImpl => modelDeclaration.isFormal;

    shared Boolean sharedImpl => modelDeclaration.isShared;

    shared Boolean toplevelImpl => modelDeclaration.isToplevel;

    // FROM TypedDeclaration

    shared
    OpenType openTypeImpl
        =>  newOpenType(modelDeclaration.type);

    // FROM AnnotatedDeclaration

    shared Annotation[] annotationsImpl<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    // FROM Annotated

    shared Boolean annotatedImpl<Annotation>()
            given Annotation satisfies AnnotationType => nothing;    
}
