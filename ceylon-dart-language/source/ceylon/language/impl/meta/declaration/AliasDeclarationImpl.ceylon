import ceylon.dart.runtime.model {
    ModelTypeAlias = TypeAlias
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    AliasDeclaration
}

class AliasDeclarationImpl(modelDeclaration)
        satisfies AliasDeclaration {

    shared ModelTypeAlias modelDeclaration;

    object helper satisfies NestableDeclarationHelper & GenericDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    extendedType => newOpenType(modelDeclaration.extendedType);

    // GenericDeclaration

    typeParameterDeclarations => helper.typeParameterDeclarations;
    getTypeParameterDeclaration(String name) => helper.getTypeParameterDeclaration(name);

    // NestableDeclaration

    actual => helper.actual;
    container => helper.container;
    containingModule => helper.containingModule;
    containingPackage => helper.containingPackage;
    default => helper.default;
    formal => helper.formal;
    shared => helper.shared;
    toplevel => helper.toplevel;
    static => helper.static;

    // Declaration

    name => helper.name;
    qualifiedName => helper.qualifiedName;

    // TypedDeclaration

    openType => helper.openType;

    // AnnotatedDeclaration

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType
        =>  helper.annotations<Annotation>();

    // Annotated

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType
        =>  helper.annotated<Annotation>();
}
