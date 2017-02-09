import ceylon.dart.runtime.model {
    ModelPackage = Package,
    ModelNothingDeclaration = NothingDeclaration,
    ModelClassOrInterface = ClassOrInterface,
    ModelFunction = Function,
    ModelValue = Value,
    ModelTypeAlias = TypeAlias
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    FunctionDeclaration,
    ValueDeclaration,
    AliasDeclaration,
    ClassOrInterfaceDeclaration,
    NestableDeclaration
}

shared
class PackageImpl(shared ModelPackage modelPackage) satisfies Package {

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
        =>  ModuleImpl(modelPackage.mod);

    shared actual
    AliasDeclaration? getAlias(String name)
        =>  if (exists memberModel = modelPackage.getDirectMember(name),
                is ModelTypeAlias memberModel)
            then newAliasDeclaration(memberModel)
            else null;

    shared actual
    ClassOrInterfaceDeclaration? getClassOrInterface(String name)
        =>  if (exists memberModel = modelPackage.getDirectMember(name),
                is ModelClassOrInterface memberModel)
            then newClassOrInterfaceDeclaration(memberModel)
            else null;

    shared actual
    FunctionDeclaration? getFunction(String name)
        =>  if (exists memberModel = modelPackage.getDirectMember(name),
                is ModelFunction memberModel)
            then newFunctionDeclaration(memberModel)
            else null;

    shared actual
    Kind? getMember<Kind>(String name)
            given Kind satisfies NestableDeclaration
        =>  if (exists memberModel = modelPackage.getDirectMember(name),
                // TODO is this right? See same in 'members' below
                !memberModel is ModelNothingDeclaration,
                is Kind member = newNestableDeclaration(memberModel))
            then member
            else null;

    shared actual
    ValueDeclaration? getValue(String name)
        =>  if (exists memberModel = modelPackage.getDirectMember(name),
                is ModelValue memberModel)
            then newValueDeclaration(memberModel)
            else null;

    shared actual
    Kind[] members<Kind>()
            given Kind satisfies NestableDeclaration
        // TODO filter out native headers
        =>  modelPackage.members.items
                // TODO is this right? JVM doesn't seem to provide access to
                //      `class Nothing`.
                .filter((d) => !d is ModelNothingDeclaration)
                .map(newNestableDeclaration)
                .narrow<Kind>()
                .sequence();

    shared actual
    String name
        =>  qualifiedName;

    shared actual
    String qualifiedName
        =>  modelPackage.qualifiedName;

    shared actual
    Boolean shared
        =>  modelPackage.isShared;

    shared actual
    String string
        =>  "package ``name``";
}
