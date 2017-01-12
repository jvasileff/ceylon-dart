shared
class ClassAlias(
        container, name, extendedTypeLG, parameterLists = [ParameterList()],
        isAbstract = false, isActual = false, isDefault = false,
        isDeprecated = false, isFormal = false, isStatic = false, isSealed = false,
        isDynamic = false, isShared = false, qualifier = null, annotations = [],
        unit = container.pkg.defaultUnit)
        extends Class(extendedTypeLG)
        satisfies Functional {

    Type | Type(Scope) extendedTypeLG;

    shared actual Type extendedType {
        assert (exists extendedType = super.extendedType);
        return extendedType;
    }

    shared actual Scope container;
    shared actual Boolean isAbstract;
    shared actual String name;
    shared actual [ParameterList+] parameterLists;
    shared actual Unit unit;
    shared actual Integer? qualifier;
    shared actual [Annotation*] annotations;

    shared actual Boolean isActual;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFormal;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;
    shared actual Boolean isDynamic;

    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Boolean isDeclaredVoid => false;
    shared actual [] satisfiedTypes => [];
    shared actual Null selfType => null;

    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isNamed => true;

    shared actual Boolean isAlias => true;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    Boolean canEqual(Object other)
        =>  other is ClassAlias;
}
