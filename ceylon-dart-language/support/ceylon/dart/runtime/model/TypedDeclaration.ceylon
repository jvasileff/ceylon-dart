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

    shared actual
    TypedReference appliedReference(
            Type? qualifyingType,
            {Type?*} typeArguments,
            Map<TypeParameter, Variance> varianceOverrides)
        =>  appliedTypedReference(qualifyingType, typeArguments, varianceOverrides);

    shared
    TypedReference appliedTypedReference(
            Type? qualifyingType,
            {Type?*} typeArguments,
            Map<TypeParameter, Variance> varianceOverrides = emptyMap,
            "the reference occurs on the LHS of an assignment"
            Boolean assignment = false)
        =>  TypedReference {
                declaration = this;
                qualifyingType = qualifyingType;
                specifiedTypeArguments = aggregateTypeArguments {
                    qualifyingType;
                    this;
                    typeArguments;
                };
                variance = assignment then contravariant else covariant;
            };

    "The type of this declaration, as viewed from within itself."
    shared
    TypedReference typedReference
        =>  TypedReference {
                declaration = this;
                qualifyingType = memberContainerType;
                specifiedTypeArguments = typeParametersAsArguments;
                // this is what ceylon.model does, so I guess it's right:
                variance = covariant;
            };
}
