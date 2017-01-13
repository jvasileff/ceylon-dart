shared
class InterfaceAlias(
        container, name, extendedTypeLG,
        qualifier = null, isShared = false, isDeprecated = false, isStatic = false,
        isDynamic = false, isSealed = false, annotations = [],
        unit = container.pkg.defaultUnit)
        extends Interface() {

    Type | Type(Scope) extendedTypeLG;
    variable Type? extendedTypeMemo = null;

    shared actual Boolean isAlias => true;

    shared actual Scope container;
    shared actual String name;
    shared actual Integer? qualifier;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual Type[] satisfiedTypes => [];
    shared actual Type[] caseTypes => [];
    shared actual Value[] caseValues => [];

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;
    shared actual Boolean isDynamic;

    "Used to avoid circularities, particularly with Scope.getBase() attempting to search
     inherited members while lazily generating the supertypes that define inheritance.

     When `true`, supertype members will be effectively not in scope."
    variable value definingInheritance = false;

    shared actual
    Type extendedType {
        if (exists result = extendedTypeMemo) {
            return result;
        }
        else if (definingInheritance) {
            // TODO ok? Hopefully no-one caches this!
            return unit.anythingDeclaration.type;
        }
        else {
            try {
                definingInheritance = true;
                return extendedTypeMemo
                    =   switch (extendedTypeLG)
                        case (is Type) (extendedTypeMemo = extendedTypeLG)
                        else (extendedTypeMemo = extendedTypeLG(this));
            }
            finally {
                definingInheritance = false;
            }
        }
    }

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    Boolean canEqual(Object other) => other is InterfaceAlias;
}
