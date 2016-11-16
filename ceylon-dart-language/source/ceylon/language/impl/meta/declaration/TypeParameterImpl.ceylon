import ceylon.language.meta.declaration {
    OpenType, TypeParameter,
    NestableDeclaration, Variance
}
import ceylon.dart.runtime.model {
    ModelTypeParameter = TypeParameter
}

class TypeParameterImpl(modelTypeParameter)
        satisfies TypeParameter {

    shared ModelTypeParameter modelTypeParameter;

    shared actual String name => modelTypeParameter.name;
    shared actual String qualifiedName => modelTypeParameter.qualifiedName;

    shared actual NestableDeclaration container => nothing;
    shared actual Boolean defaulted => modelTypeParameter.defaultTypeArgument exists;
    shared actual OpenType? defaultTypeArgument => nothing;
    shared actual Variance variance => varianceFor(modelTypeParameter.variance);
    shared actual OpenType[] satisfiedTypes => nothing;
    shared actual OpenType[] caseTypes => nothing;

    // TODO
    shared actual
    String string
        =>  modelTypeParameter.string;

    shared actual
    Boolean equals(Object other)
        =>  if (is TypeParameterImpl other)
            then modelTypeParameter == other.modelTypeParameter
            else false;

    shared actual
    Integer hash
        =>  modelTypeParameter.hash;
}
