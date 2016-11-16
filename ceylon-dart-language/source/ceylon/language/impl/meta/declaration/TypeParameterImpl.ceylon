import ceylon.language.meta.declaration {
    TypeParameter
}
import ceylon.dart.runtime.model {
    ModelTypeParameter = TypeParameter
}

class TypeParameterImpl(modelTypeParameter)
        satisfies TypeParameter {

    shared ModelTypeParameter modelTypeParameter;

    name => modelTypeParameter.name;

    qualifiedName => modelTypeParameter.qualifiedName;

    container => newNestableDeclaration(modelTypeParameter.container);

    defaulted => modelTypeParameter.defaultTypeArgument exists;

    defaultTypeArgument
        =>  if (exists defaultArgument = modelTypeParameter.defaultTypeArgument)
            then newOpenType(defaultArgument)
            else null;

    variance => varianceFor(modelTypeParameter.variance);

    satisfiedTypes => modelTypeParameter.satisfiedTypes.collect(newOpenType);

    caseTypes => modelTypeParameter.caseTypes.collect(newOpenType);

    // TODO
    string => modelTypeParameter.string;

    equals(Object other)
        =>  if (is TypeParameterImpl other)
            then modelTypeParameter == other.modelTypeParameter
            else false;

    hash => modelTypeParameter.hash;
}
