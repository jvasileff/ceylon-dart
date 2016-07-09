shared abstract
class Function(name, typeLG)
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

    shared actual
    String string
        =>  "function ``partiallyQualifiedNameWithTypeParameters``\
             ``valueParametersAsString`` \
             => ``type.formatted``";
}
