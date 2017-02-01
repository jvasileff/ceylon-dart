import ceylon.dart.runtime.nativecollection {
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

    "The type or return type of the referenced thing:

        - for a value, this is its type,
        - for a function, this is its return type, and
        - for a class or constructor, it is the class type.

     The \"whole\" type of the reference may be obtained
     using `fullType`."
    shared formal
    Type type;

    "The type or callable type of the referenced thing:

        - for a value, this is its type,
        - for a function, class, or constructor, this is its
          callable type.

     This type encodes all the types you could assemble
     using `type` and `getTypedParameter(Parameter)`"
    shared
    Type fullType
        =>  getFullType();


    shared
    Type getFullType(
            "the return type of this member for a `?.` or `*.` expression, i.e.
             `T?`, `[T*]`, or `[T+]`"
            Type wrappedType = type)
        =>  if (declaration is Functional)
            then declaration.unit.getCallableType(this, wrappedType)
            else wrappedType;

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

    shared
    TypedReference getTypedParameter(Parameter p)
        =>  TypedReference {
                declaration = p.model;
                specifiedTypeArguments = typeArguments;
                qualifyingType = qualifyingType;
                variance = contravariant;
            };
}
