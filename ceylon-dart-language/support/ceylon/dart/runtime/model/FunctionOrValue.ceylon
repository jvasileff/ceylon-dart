shared abstract
class FunctionOrValue()
        of Function | Value | Setter
        extends TypedDeclaration() {

    shared actual default FunctionOrValue refinedDeclaration {
        assert(is FunctionOrValue f = super.refinedDeclaration);
        return f;
    }

    "The [[Parameter]] if the container is a [[Functional]] and this function or value is
     a `Parameter` in the containing `Functional`'s parameter list."
    shared Parameter? parameter
        =>  if (is Functional container = this.container)
            then container.parameterLists
                .flatMap(ParameterList.parameters)
                .find((p) => p.model == this)
            else null;

    "If this `Function` is a constructor, the constructor's anonymous
     [[CallableConstructor]]."
    shared formal
    Constructor? constructor;
}
