shared abstract
class TypedDeclaration()
        of FunctionOrValue
        extends Declaration() {

    shared actual default TypedDeclaration refinedDeclaration {
        assert(is TypedDeclaration c = super.refinedDeclaration);
        return c;
    }

    shared actual formal
    Scope container;

    shared formal
    Type type;
}
