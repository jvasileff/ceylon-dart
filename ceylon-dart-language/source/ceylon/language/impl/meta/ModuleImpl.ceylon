import ceylon.dart.runtime.model {
    ModuleModel=Module,
    PackageModel=Package,
    ClassModel=Class
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    Import,
    FunctionDeclaration,
    ValueDeclaration,
    AliasDeclaration,
    ClassOrInterfaceDeclaration,
    NestableDeclaration,
    ClassWithConstructorsDeclaration,
    OpenType,
    FunctionOrValueDeclaration,
    CallableConstructorDeclaration,
    OpenInterfaceType,
    OpenClassType,
    TypeParameter,
    ConstructorDeclaration,
    ValueConstructorDeclaration
}
import ceylon.language.meta.model {
    Class,
    MemberClass,
    AppliedType=Type,
    Member,
    ClassOrInterface
}

shared
class ModuleImpl(ModuleModel delegate) satisfies Module {

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Import[] dependencies
        =>  nothing;

    shared actual
    Package? findImportedPackage(String name)
        =>  if (exists p = delegate.findPackage(name))
            then PackageImpl(p)
            else null;

    shared actual
    Package? findPackage(String name)
        =>  if (exists p = delegate.findDirectPackage(name))
            then PackageImpl(p)
            else null;

    shared actual
    [Package*] members
        =>  delegate.packages.collect(PackageImpl);

    shared actual
    String name
        =>  delegate.nameAsString;

    shared actual
    String qualifiedName
        =>  delegate.nameAsString;

    shared actual
    Resource? resourceByPath(String path)
        =>  nothing;

    shared actual
    String version
        =>  delegate.version else "unknownVersion";

    shared actual
    String string
        =>  "module ``name``/``version``";

    shared actual
    {Service*} findServiceProviders<Service>(ClassOrInterface<Service> service)
        =>  [];
}

shared
class PackageImpl(PackageModel delegate) satisfies Package {

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Kind[] annotatedMembers<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Module container
        =>  ModuleImpl(delegate.mod);

    shared actual
    AliasDeclaration? getAlias(String name)
        =>  nothing;

    shared actual
    ClassOrInterfaceDeclaration? getClassOrInterface(String name)
        =>  nothing;

    shared actual
    FunctionDeclaration? getFunction(String name)
        =>  nothing;

    shared actual
    Kind? getMember<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  nothing;

    shared actual
    ValueDeclaration? getValue(String name)
        =>  nothing;

    shared actual
    Kind[] members<Kind>()
            given Kind satisfies NestableDeclaration
        // TODO filter out native headers, support all declaration types
        =>  delegate.members.items
                .narrow<ClassModel>() // just classes for now...
                .map(ClassWithConstructorsDeclarationImpl) // ignoring withInitializer
                .narrow<Kind>()
                .sequence();

    shared actual
    String name
        =>  qualifiedName;

    shared actual
    String qualifiedName
        =>  delegate.qualifiedName;

    shared actual
    Boolean shared
        =>  nothing;

    shared actual
    String string
        =>  "package ``name``";
}

shared
class ClassWithConstructorsDeclarationImpl(ClassModel delegate)
        satisfies ClassWithConstructorsDeclaration {

    shared actual Boolean abstract => delegate.isAbstract;

    shared actual Boolean actual => delegate.isActual;

    shared actual Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual CallableConstructorDeclaration[] annotatedConstructorDeclarations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Kind[] annotatedDeclaredMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared actual Kind[] annotatedMemberDeclarations<Kind, Annotation>()
            given Kind satisfies NestableDeclaration
            given Annotation satisfies AnnotationType => nothing;

    shared actual Boolean annotation => nothing;

    shared actual Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual Boolean anonymous => delegate.isAnonymous;

    shared actual ClassOrInterface<Type> apply<Type>(AppliedType<Anything>* typeArguments) => nothing;

    shared actual OpenType[] caseTypes => nothing;

    shared actual Class<Type,Arguments> classApply<Type, Arguments>(AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared actual Class<Type, Arguments> staticClassApply<Type=Anything, Arguments=Nothing>
            (AppliedType<Object> containerType, AppliedType<>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared actual NestableDeclaration|Package container => nothing;

    shared actual Module containingModule => ModuleImpl(delegate.mod);

    shared actual Package containingPackage => PackageImpl(delegate.pkg);

    shared actual Kind[] declaredMemberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration => nothing;

    shared actual Boolean default => delegate.isDefault;

    shared actual CallableConstructorDeclaration defaultConstructor => nothing;

    shared actual OpenClassType? extendedType => nothing;

    shared actual Boolean final => delegate.isFinal;

    shared actual Boolean formal => delegate.isFormal;

    shared actual Kind? getDeclaredMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration => nothing;

    shared actual Kind? getMemberDeclaration<Kind>(String name)
            given Kind satisfies NestableDeclaration => nothing;

    shared actual FunctionOrValueDeclaration? getParameterDeclaration(String name) => nothing;

    shared actual TypeParameter? getTypeParameterDeclaration(String name) => nothing;

    shared actual Boolean isAlias => delegate.isAlias;

    shared actual Member<Container,ClassOrInterface<Type>>&ClassOrInterface<Type> memberApply<Container, Type>(AppliedType<Object> containerType, AppliedType<Anything>* typeArguments) => nothing;

    shared actual MemberClass<Container,Type,Arguments> memberClassApply<Container, Type, Arguments>(AppliedType<Object> containerType, AppliedType<Anything>* typeArguments)
            given Arguments satisfies Anything[] => nothing;

    shared actual Kind[] memberDeclarations<Kind>()
            given Kind satisfies NestableDeclaration => nothing;

    shared actual String name => delegate.name;

    shared actual ValueDeclaration? objectValue => nothing;

    shared actual OpenType openType => nothing;

    shared actual FunctionOrValueDeclaration[] parameterDeclarations => nothing;

    shared actual String qualifiedName => delegate.qualifiedName;

    shared actual OpenInterfaceType[] satisfiedTypes => nothing;

    shared actual Boolean serializable => nothing;

    shared actual Boolean shared => delegate.isShared;

    shared actual Boolean static => nothing; // TODO

    shared actual Boolean toplevel => delegate.isToplevel;

    shared actual TypeParameter[] typeParameterDeclarations => nothing;

    shared actual ConstructorDeclaration[] constructorDeclarations() => nothing;

    shared actual <CallableConstructorDeclaration|ValueConstructorDeclaration>? getConstructorDeclaration(String name) => nothing;

    shared actual String string => "class ``qualifiedName``";
}
