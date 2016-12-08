shared
class ClassWithConstructors(
        container, name, extendedTypeLG, qualifier = null,
        satisfiedTypesLG = [], caseTypesLG = [], caseValuesLG = [],
        isShared = false, isFormal = false, isActual = false, isDefault = false,
        isAnnotation = false, isDeprecated = false, isStatic = false, isSealed = false,
        isAbstract = false, isAnonymous = false, isNamed = true, isFinal = false,
        annotations = [], unit = container.pkg.defaultUnit)
        extends ClassDefinition(
            extendedTypeLG, satisfiedTypesLG, caseTypesLG, caseValuesLG) {

    {Type | Type(Scope)*} satisfiedTypesLG;
    {Type | Type(Scope)*} caseTypesLG;
    {Value | Value(Scope)*} caseValuesLG;
    Type | Type(Scope) | Null extendedTypeLG;

    shared actual Scope container;
    shared actual String name;
    shared actual Integer? qualifier;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual Boolean isAbstract;
    shared actual Boolean isActual;
    shared actual Boolean isAnnotation;
    shared actual Boolean isAnonymous;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFinal;
    shared actual Boolean isFormal;
    shared actual Boolean isNamed;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;
}
