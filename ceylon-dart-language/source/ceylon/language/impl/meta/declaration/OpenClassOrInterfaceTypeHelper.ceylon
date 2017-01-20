import ceylon.language.meta.declaration {
    OpenType, OpenClassType, OpenInterfaceType,
    ClassOrInterfaceDeclaration, TypeParameter, OpenTypeArgument,
    invariant
}
import ceylon.dart.runtime.model {
    ModelType = Type
}

abstract
class OpenClassOrInterfaceTypeHelper() {

    shared formal
    ModelType modelType;

    shared formal
    ClassOrInterfaceDeclaration declaration;

    shared
    OpenClassType? extendedType {
        if (exists modelExtendedType = modelType.extendedType) {
            assert (is OpenClassType result = newOpenType(modelExtendedType));
            return result;
        }
        "Only 'Anything' has no extended type."
        assert (modelType.isAnything);
        return null;
    }

    shared
    OpenInterfaceType[] satisfiedTypes
        =>  modelType.satisfiedTypes.collect((st) {
                assert (is OpenInterfaceType ot = newOpenType(st));
                return ot;
            });

    shared
    Map<TypeParameter, OpenType> typeArguments
        =>  typeArgumentWithVariances.mapItems((_, ta) => ta.first);

    shared
    OpenType[] typeArgumentList
        =>  let (typeArguments = this.typeArguments)
            declaration.typeParameterDeclarations.collect((tp) {
                assert (exists typeArgument = typeArguments[tp]);
                return typeArgument;
            });

    shared
    Map<TypeParameter, OpenTypeArgument> typeArgumentWithVariances
        =>  map {
                declaration.typeParameterDeclarations.map((typeParameter) {
                    assert (is TypeParameterImpl typeParameter);

                    value modelTypeParameter
                        =   typeParameter.modelDeclaration;

                    // assuming we only care about use site overrides; "invariant" means
                    // no override, even if the TP is covariant or contravariant.
                    value variance
                        =   varianceFor(modelType.varianceOverrides[modelTypeParameter])
                            else invariant;

                    assert (exists modelTypeArgument
                        =   modelType.typeArguments[modelTypeParameter]);

                    return typeParameter -> [newOpenType(modelTypeArgument), variance];            
                });
            };

    shared
    OpenTypeArgument[] typeArgumentWithVarianceList
        =>  let (typeArgumentWithVariances = this.typeArgumentWithVariances)
            declaration.typeParameterDeclarations.collect((tp) {
                assert (exists ta = typeArgumentWithVariances[tp]);
                return ta;
            });
}
