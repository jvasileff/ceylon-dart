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
    Attribute,
    MemberClass,
    Class,
    Member,
    ClassOrInterface,
    IncompatibleTypeException,
    TypeApplicationException,
    FunctionModel,
    Function,
    Method,
    Qualified
}
import ceylon.language.impl.meta.model {
    modelTypeFromType,
    newType,
    newMethod,
    newValue,
    newAttribute
}

class ValueDeclarationImpl(modelDeclaration)
        satisfies ValueDeclaration {

    shared ModelValue modelDeclaration;

    object helper satisfies FunctionOrValueDeclarationHelper {
        modelDeclaration => outer.modelDeclaration;
    }

    shared actual
    Boolean late => modelDeclaration.isLate;

    shared actual
    Boolean variable => modelDeclaration.isVariable;

    shared actual
    Boolean objectValue => modelDeclaration.objectClass exists;

    shared actual
    ClassDeclaration? objectClass
        =>  if (exists c = modelDeclaration.objectClass)
            then newClassDeclaration(c)
            else null;

    shared actual
    Value<Get, Set> apply<Get=Anything, Set=Nothing>() {
        if (!toplevel) {
            throw TypeApplicationException(
                "Cannot apply a member declaration with no container type: \
                 use memberApply");
        }

        value result
            =   newValue {
                    modelDeclaration.appliedTypedReference {
                        qualifyingType = null;
                        typeArguments = [];
                        varianceOverrides = emptyMap;
                    };
                    null;
                };

        if (!is Value<Get, Set> result) {
            // TODO improve
            throw IncompatibleTypeException("Incorrect Get or Set");
        }

        return result;
    }

    shared actual
    Attribute<Container, Get, Set>
    memberApply<Container=Nothing, Get=Anything, Set=Nothing>
            (ClosedType<Object> containerType) {

        if (toplevel) {
            throw TypeApplicationException(
                "Cannot apply a toplevel declaration to a container type: use apply");
        }

        value qualifyingType
            =   getQualifyingSupertypeOrThrow {
                    modelTypeFromType(containerType);
                    modelDeclaration;
                };

        value result
            =   newAttribute {
                    modelDeclaration.appliedTypedReference {
                        qualifyingType = qualifyingType;
                        typeArguments = [];
                        varianceOverrides = emptyMap;
                    };
                };

        if (!is Attribute<Container, Get, Set> result) {
            // TODO Improve. The JVM code claims to do better with
            //      checkReifiedTypeArgument()
            throw IncompatibleTypeException("Incorrect Container, Get, or Set");
        }

        return result;
    }

    shared actual
    void memberSet(Object container, Anything newValue) { throw; }

    shared actual
    SetterDeclaration? setter
        =>  if (exists modelSetter = modelDeclaration.setter)
            then newSetterDeclaration(modelSetter)
            else null;

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

    // Object

    string => helper.string;
}
