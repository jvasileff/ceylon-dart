shared
class ClassWithInitializer(
        container, name, extendedTypeLG, qualifier = null,
        satisfiedTypesLG = [], caseTypesLG = [], caseValuesLG = [],
        isShared = false, isFormal = false, isActual = false, isDefault = false,
        isAnnotation = false, isDeprecated = false, isStatic = false, isSealed = false,
        isAbstract = false, isAnonymous = false, isNamed = true, isFinal = false,
        annotations = [], unit = container.pkg.defaultUnit)
        extends ClassDefinition(
            extendedTypeLG, satisfiedTypesLG, caseTypesLG, caseValuesLG)
        satisfies Functional {

    {Type | Type(Scope)*} satisfiedTypesLG;
    {Type | Type(Scope)*} caseTypesLG;
    {Value | Value(Scope)*} caseValuesLG;
    Type | Type(Scope) | Null extendedTypeLG;

    variable [ParameterList] _parameterLists = [ParameterList()];

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

    shared actual
    Boolean isDeclaredVoid
        =>  false;

    shared actual
    [ParameterList+] parameterLists
        =>  _parameterLists;

    shared
    ParameterList parameterList => _parameterLists.first;

    "Set the parameter list. Models (FunctionOrValues) for all parameters must already
     be members of this Class."
    throws(`class AssertionError`, "If the underlying FunctionOrValue of one of the
                                    parameters is not a member of this Class.")
    assign parameterList {
        for (member in parameterList.parameters.map(Parameter.model)) {
            "A parameter's function or value must be a member of the parameter list's \
             container."
            assert (members.contains(member.name -> member));
        }
        _parameterLists = [parameterList];
    }
}
