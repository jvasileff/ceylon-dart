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

    shared formal ClassOrInterfaceModel delegate;

    // FROM ClassOrInterfaceDeclaration

    shared OpenType[] caseTypesImpl => nothing;

    shared OpenClassType? extendedTypeImpl => nothing;

    shared Boolean isAliasImpl => delegate.isAlias;

    shared OpenInterfaceType[] satisfiedTypesImpl => nothing;

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
        =>  [ for (member in delegate.members.map(Entry.item)
                                     .map(newNestableDeclaration))
              if (is Kind member) member ];

    shared Kind? getDeclaredMemberDeclarationImpl<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = delegate.getDirectMember(name),
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared Kind? getMemberDeclarationImpl<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = delegate.getMember(name, null),
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
        =>  [ for (member in delegate.members.map(Entry.item)
                                     .map(newNestableDeclaration))
              if (is Kind member) member ];

    // FROM Declaration

    shared String nameImpl => delegate.name;
    
    shared String qualifiedNameImpl => delegate.qualifiedName;

    // FROM GenericDeclaration

    shared TypeParameter[] typeParameterDeclarationsImpl => nothing;

    shared TypeParameter? getTypeParameterDeclarationImpl(String name) => nothing;

    // FROM NestableDeclaration

    shared Boolean actualImpl => delegate.isActual;

    shared NestableDeclaration | Package containerImpl {
        switch (containerModel = delegate.container)
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

    shared Module containingModuleImpl => ModuleImpl(delegate.mod);

    shared Package containingPackageImpl => PackageImpl(delegate.pkg);

    shared Boolean defaultImpl => delegate.isDefault;

    shared Boolean formalImpl => delegate.isFormal;

    shared Boolean sharedImpl => delegate.isShared;

    shared Boolean toplevelImpl => delegate.isToplevel;

    // FROM TypedDeclaration

    shared OpenType openTypeImpl => nothing;

    // FROM AnnotatedDeclaration

    shared Annotation[] annotationsImpl<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    // FROM Annotated

    shared Boolean annotatedImpl<Annotation>()
            given Annotation satisfies AnnotationType => nothing;    
}
