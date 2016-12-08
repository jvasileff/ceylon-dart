shared final
class ValueConstructor(
        name, container, isDeprecated = false, isSealed = false,
        isShared = false, annotations = [], unit = container.pkg.defaultUnit)
        extends Constructor() {

    variable Type? extendedTypeMemo = null;

    shared actual Class container;
    shared actual String name;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual Boolean isDeprecated;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;

    shared actual Type extendedType
        =>  extendedTypeMemo else (
                extendedTypeMemo = container.type);

    shared actual
    ValueConstructor refinedDeclaration => this;

    shared actual
    Boolean canEqual(Object other)
        =>  other is ValueConstructor;

    shared actual
    String string
        =>  "new ``partiallyQualifiedNameWithTypeParameters``";
}
