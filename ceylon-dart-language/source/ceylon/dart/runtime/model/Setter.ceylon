shared
class Setter(getter, isActual = false, isDeprecated = false)
        extends FunctionOrValue() {

    shared Value getter;

    shared actual Boolean isActual;
    shared actual Boolean isDeprecated;
    shared actual Setter refinedDeclaration {
        assert(is Setter c = super.refinedDeclaration);
        return c;
    }

    shared actual Scope container => getter.container;
    shared actual String name => getter.name;
    shared actual Integer? qualifier => getter.qualifier;
    shared actual Unit unit => getter.unit;

    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;

    shared actual Boolean isDefault => getter.isDefault;
    shared actual Boolean isFormal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isShared => getter.isShared;
    shared actual Boolean isStatic => getter.isStatic;

    shared actual Type type => getter.type;

    shared actual
    Boolean canEqual(Object other)
        => other is Setter;

    shared actual
    String string
        =>  "assign ``partiallyQualifiedNameWithTypeParameters``";
}
