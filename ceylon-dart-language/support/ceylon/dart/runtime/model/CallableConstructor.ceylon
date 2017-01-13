shared final
class CallableConstructor(
        name, container, isDeprecated = false, isSealed = false,
        isShared = false, isAbstract = false, isDynamic = false, annotations = [],
        unit = container.pkg.defaultUnit)
        extends Constructor()
        satisfies Functional {

    variable Type? extendedTypeMemo = null;

    shared actual Class container;
    shared actual String name;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual Boolean isDeprecated;
    shared actual Boolean isSealed;
    shared actual Boolean isShared;
    shared actual Boolean isDynamic;

    shared Boolean isAbstract;

    variable [ParameterList] _parameterLists = [ParameterList()];

    shared actual Type extendedType
        =>  extendedTypeMemo else (
                extendedTypeMemo = container.type);

    shared actual
    [ParameterList] parameterLists
        =>  _parameterLists;

    shared
    ParameterList parameterList => _parameterLists.first;

    "Set the parameter list. Models (FunctionOrValues) for all parameters must already
     be members of this element."
    throws(`class AssertionError`, "If the underlying FunctionOrValue of one of the
                                    parameters is not a member of this element.")
    assign parameterList {
        for (member in parameterList.parameters.map(Parameter.model)) {
            "A parameter's function or value must be a member of the parameter list's \
             container."
            assert (members.contains(member.name -> member));
        }
        _parameterLists = [parameterList];
    }

    shared actual
    Boolean isDeclaredVoid => false;

    shared actual
    CallableConstructor refinedDeclaration => this;

    shared actual
    Boolean canEqual(Object other)
        =>  other is CallableConstructor;

    shared actual
    String string
        =>  "new ``partiallyQualifiedNameWithTypeParameters````valueParametersAsString``";
}
