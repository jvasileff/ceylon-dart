shared
class TypeAlias(
        container, name, extendedTypeLG, isDeprecated = false, isShared = false,
        isStatic = false, isDynamic = false, qualifier = null, isAnonymous = false,
        annotations = [], unit = container.pkg.defaultUnit)
        extends TypeDeclaration() {

    Type | Type(Scope) extendedTypeLG;

    variable Type? extendedTypeMemo = null;

    shared actual Scope container;
    shared actual String name;
    shared actual Integer? qualifier;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual Type[] satisfiedTypes = [];
    shared actual Type[] caseTypes = [];
    shared actual Value[] caseValues = [];

    shared actual Boolean isActual => false;
    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous;
    shared actual Boolean isDefault => false;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFinal => false;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isSealed => false;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;
    shared actual Boolean isDynamic;

    shared actual Boolean isAlias => true;

    shared actual
    Type extendedType
        =>  extendedTypeMemo else
            (extendedTypeMemo
                =   switch (extendedTypeLG)
                    case (is Type) (extendedTypeMemo = extendedTypeLG)
                    else (extendedTypeMemo = extendedTypeLG(this)));

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    String string
        =>  "alias ``partiallyQualifiedNameWithTypeParameters``";

    shared actual
    Boolean canEqual(Object other)
        =>  other is TypeAlias;
}
