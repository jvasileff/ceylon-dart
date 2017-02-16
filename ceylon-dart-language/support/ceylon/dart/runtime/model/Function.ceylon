shared
class Function(
        container, name, typeLG, qualifier = null, isDeclaredVoid = false, isShared = false,
        isFormal = false, isActual = false, isDefault = false, isAnnotation = false,
        isDeprecated = false, isStatic = false, isAnonymous = false, isNamed = true,
        isDynamic = false, annotations = [], unit = container.pkg.defaultUnit)
        extends FunctionOrValue()
        satisfies Functional & Generic {

    Type | Type(Scope) typeLG;

    variable [ParameterList+] _parameterLists = [ParameterList()];

    variable Type? typeMemo = null;

    shared actual
    Type type
        =>  typeMemo else (
                switch (typeLG)
                case (is Type) (typeMemo = typeLG)
                else (typeMemo = typeLG(this)));

    shared actual String name;

    shared actual Function refinedDeclaration {
        assert(is Function f = super.refinedDeclaration);
        return f;
    }

    shared actual Scope container;
    shared actual Integer? qualifier;
    shared actual Unit unit;
    shared actual [Annotation*] annotations;

    shared actual default
    {TypeParameter*} typeParameters
        =>  { for (member in members.items)
                if (is TypeParameter member)
                  member };

    shared actual
    [ParameterList+] parameterLists
        =>  _parameterLists;

    shared
    ParameterList parameterList => _parameterLists.first;

    "Set the parameter list. Models (FunctionOrValues) for all parameters must already
     be members of this element."
    throws(`class AssertionError`, "If the underlying FunctionOrValue of one of the
                                    parameters is not a member of this element.")
    assign parameterLists {
        for (parameterList in parameterLists) {
            for (member in parameterList.parameters.map(Parameter.model)) {
                "A parameter's function or value must be a member of the parameter
                 list's container."
                assert (members.contains(member.name -> member));
            }
        }
        _parameterLists = parameterLists;
    }

    shared actual Boolean isActual;
    shared actual Boolean isAnnotation;
    shared actual Boolean isAnonymous;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFormal;
    shared actual Boolean isNamed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;
    shared actual Boolean isDynamic;

    shared actual Boolean isDeclaredVoid;

    "If this `Function` is a constructor, the constructor's anonymous
     [[CallableConstructor]]."
    shared actual
    CallableConstructor? constructor
        =>  if (is CallableConstructor td = type.declaration)
            then td
            else null;

    shared actual
    String string
        =>  "function ``partiallyQualifiedNameWithTypeParameters``\
             ``valueParametersAsString`` \
             => ``type.formatted``";

    shared actual
    Boolean canEqual(Object other)
        =>  other is Function;
}
