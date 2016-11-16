import ceylon.dart.runtime.model {
    ModelSetter = Setter
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    SetterDeclaration
}

class SetterDeclarationImpl(modelDeclaration)
        satisfies SetterDeclaration {

    shared ModelSetter modelDeclaration;

    object helper satisfies NestableDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    variable => ValueDeclarationImpl(modelDeclaration.getter);

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
