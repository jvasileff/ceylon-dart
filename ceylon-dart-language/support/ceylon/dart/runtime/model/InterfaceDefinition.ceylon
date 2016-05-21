import ceylon.dart.runtime.model.internal {
    toType
}

shared
class InterfaceDefinition(
        container, name,
        qualifier = null, satisfiedTypesLG = [], caseTypesLG = [], caseValues = [],
        isShared = false, isFormal = false, isActual = false,
        isDefault = false, isAnnotation = false, isDeprecated = false,
        isStatic = false, isSealed = false, isFinal = false,
        unit = container.pkg.defaultUnit)
        extends Interface() {

    {Type | Type(Scope)*} satisfiedTypesLG;
    {Type | Type(Scope)*} caseTypesLG;

    variable [Type*]? satisfiesTypesMemo = null;
    variable [Type*]? caseTypesMemo = null;

    "Used to avoid circularities, particularly with Scope.getBase() attempting to search
     inherited members while lazily generating the supertypes that define inheritance.

     When `true`, supertype members will be effectively not in scope."
    variable value definingInheritance = false;

    shared actual Type[] satisfiedTypes {
        if (exists result = satisfiesTypesMemo) {
            return result;
        }
        else if (definingInheritance) {
            return [];
        }
        else {
            try {
                definingInheritance = true;
                return satisfiesTypesMemo
                    =   satisfiedTypesLG.collect(toType(this));
            }
            finally {
                definingInheritance = false;
            }
        }
    }

    shared actual Type[] caseTypes
        // FIXME remove types with declarations == this; see ceylon-model
        =>  caseTypesMemo else (caseTypesMemo
            =   caseTypesLG.collect(toType(this)));

    shared actual [Value*] caseValues;
    shared actual Scope container;
    shared actual String name;
    shared actual Integer? qualifier;
    shared actual Unit unit;

    shared actual Boolean isActual;
    shared actual Boolean isAnnotation;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFinal;
    shared actual Boolean isFormal;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;

    shared actual Type extendedType => unit.anythingDeclaration.type;

    shared actual
    Boolean canEqual(Object other)
        =>  other is InterfaceDefinition;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that) {
        if (that.isAnything || that.isObject) {
            return true;
        }

        if (that is Class) {
            // interface can't inherit any other class
            return false;
        }

        if (this == that) {
            return true;
        }

        // Copied todo: optimize this to avoid walking the same supertypes multiple times
        if (is Interface that) {
            return satisfiedTypes.any((t) => t.declaration.inherits(that));
        }

        return false;
    }
}
