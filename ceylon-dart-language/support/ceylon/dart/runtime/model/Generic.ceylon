shared
interface Generic of TypeDeclaration | Function {
    shared formal {TypeParameter*} typeParameters;

    shared
    String typeParametersAsString
        =>  if (nonempty typeParameters = this.typeParameters.sequence())
            then "<``", ".join(typeParameters.map(TypeParameter.name))``>"
            else "";
}
