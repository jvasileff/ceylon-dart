import ceylon.collection {
    HashMap,
    unlinked
}

shared abstract
class Reference() of Type | TypedReference {

    shared formal
    Declaration declaration;

    shared formal
    Map<TypeParameter, Type> specifiedTypeArguments;

    shared formal
    Type? qualifyingType;

    shared
    Map<TypeParameter, Type> typeArguments {
        if (is Generic declaration = declaration) {
            // Fill in default type arguments, makeing sure to pass all available
            // args to substitute() and avoid creating a new HashMap() unless necessary.

            variable HashMap<TypeParameter, Type>? allArgs = null;

            for (typeParameter in declaration.typeParameters) {
                if (!specifiedTypeArguments.defines(typeParameter),
                    exists defaultArg = typeParameter.defaultTypeArgument) {

                    value map = allArgs else (allArgs = HashMap<TypeParameter, Type> {
                        stability = unlinked;
                        *specifiedTypeArguments
                    });

                    map.put(typeParameter, defaultArg.substitute(map, emptyMap));
                }
            }
            return allArgs else specifiedTypeArguments;
        }
        else {
            return emptyMap;
        }
    }
}
