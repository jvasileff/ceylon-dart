shared
class ClassAlias(
        container, name, extendedType, parameterLists = [ParameterList.empty],
        isAbstract = false, isActual = false, isDefault = false,
        isDeprecated = false, isFormal = false, isSealed = false,
        isShared = false, qualifier = null, unit = container.pkg.defaultUnit)
        extends Class() {

    shared actual Scope container;
    shared actual Type extendedType;
    shared actual Boolean isAbstract;
    shared actual String name;
    shared actual [ParameterList+] parameterLists;
    shared actual Unit unit;
    shared actual Integer? qualifier;

    shared actual Boolean isActual;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFormal;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;

    shared actual [] caseTypes => [];
    shared actual [] caseValues => [];
    shared actual Boolean declaredVoid => false;
    shared actual [] satisfiedTypes => [];
    shared actual Null selfType => null;

    shared actual Boolean isAnnotation => false;
    shared actual Boolean isAnonymous => false;
    shared actual Boolean isFinal => false;
    shared actual Boolean isNamed => true;
    shared actual Boolean isStatic => false;

    shared actual
    Boolean inherits(ClassOrInterface | TypeParameter that)
        =>  extendedType.declaration.inherits(that);

    shared actual
    Boolean canEqual(Object other)
        =>  other is ClassAlias;
}
