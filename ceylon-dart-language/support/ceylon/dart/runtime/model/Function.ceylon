shared
class Function(
        container, name, typeLG, parameterLists = [ParameterList.empty],
        qualifier = null, declaredVoid = false, isShared = false,
        isFormal = false, isActual = false, isDefault = false,
        isAnnotation = false, isDeprecated = false, isStatic = false,
        isAnonymous = false, isNamed = true, typeParameters = [],
        unit = container.pkg.defaultUnit)
        extends FunctionOrValue()
        satisfies Functional & Generic {

    Type | Type(Scope) typeLG;

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
    shared actual {TypeParameter*} typeParameters;
    shared actual [ParameterList+] parameterLists;

    shared actual Boolean isActual;
    shared actual Boolean isAnnotation;
    shared actual Boolean isAnonymous;
    shared actual Boolean isDefault;
    shared actual Boolean isDeprecated;
    shared actual Boolean isFormal;
    shared actual Boolean isNamed;
    shared actual Boolean isShared;
    shared actual Boolean isStatic;

    shared actual Boolean declaredVoid;

    shared actual
    String string
        =>  "function ``partiallyQualifiedNameWithTypeParameters``\
             ``valueParametersAsString`` \
             => ``type.formatted``";

    shared actual
    Boolean canEqual(Object other)
        =>  other is Function;
}
