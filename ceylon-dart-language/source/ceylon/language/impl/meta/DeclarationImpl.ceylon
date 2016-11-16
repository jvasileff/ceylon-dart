import ceylon.dart.runtime.model {
    ModelDeclaration = Declaration
}

interface DeclarationHelper {
    shared formal
    ModelDeclaration modelDeclaration;

    shared
    String name => modelDeclaration.name;

    shared
    String qualifiedName => modelDeclaration.qualifiedName;
}
