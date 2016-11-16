import ceylon.dart.runtime.model {
    ModelValue = Value
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    ValueDeclaration,
    ClassDeclaration,
    SetterDeclaration
}
import ceylon.language.meta.model {
    ClosedType = Type,
    Value,
    Attribute
}

class ValueDeclarationImpl(modelDeclaration)
        satisfies ValueDeclaration {

    shared ModelValue modelDeclaration;

    object helper satisfies FunctionOrValueDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    Boolean late => nothing;//modelDeclaration.isLate;

    shared actual
    Boolean variable => nothing;//modelDeclaration.isVariable;

    shared actual
    Boolean objectValue => nothing;

    shared actual
    ClassDeclaration? objectClass => nothing;

    shared actual
    Value<Get, Set> apply<Get=Anything, Set=Nothing>() => nothing;

    shared actual
    Attribute<Container, Get, Set>
    memberApply<Container=Nothing, Get=Anything, Set=Nothing>
            (ClosedType<Object> containerType)
        =>  nothing;

    shared actual
    void memberSet(Object container, Anything newValue) { throw; }

    shared actual
    SetterDeclaration? setter => nothing;

    // FunctionOrValueDeclaration

    parameter => helper.parameter;
    defaulted => helper.defaulted;
    variadic => helper.variadic;

    // Declaration

    name => helper.name;
    qualifiedName => helper.qualifiedName;

    // NestableDeclaration

    actual => helper.actual;
    container => helper.container;
    containingModule => helper.containingModule;
    containingPackage => helper.containingPackage;
    default => helper.default;
    formal => helper.formal;
    shared => helper.shared;
    toplevel => helper.toplevel;

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
