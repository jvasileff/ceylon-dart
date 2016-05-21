shared abstract
class FunctionOrValue()
        of Function | Value | Setter
        extends TypedDeclaration() {

    shared actual default FunctionOrValue refinedDeclaration {
        assert(is FunctionOrValue f = super.refinedDeclaration);
        return f;
    }
}
