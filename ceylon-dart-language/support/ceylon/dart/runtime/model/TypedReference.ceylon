"An applied reference to a method or attribute - a typed declaration together with
 actual type arguments."
shared sealed
class TypedReference(
        declaration,
        specifiedTypeArguments,
        qualifyingType,
        variance = invariant)
        extends Reference() {

    shared actual TypedDeclaration declaration;
    shared actual Type? qualifyingType;

    shared actual Map<TypeParameter, Type> specifiedTypeArguments;
    shared Variance variance;

    shared Type type => declaration.type.substituteFromTypedReference(this);
}
