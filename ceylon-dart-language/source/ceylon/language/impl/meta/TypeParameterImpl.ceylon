import ceylon.language.meta.declaration {
    OpenType, OpenClassOrInterfaceType, OpenClassType, OpenInterfaceType,
    ClassOrInterfaceDeclaration, TypeParameter, OpenTypeArgument,
    NestableDeclaration, Variance, ClassDeclaration,
    invariant, covariant, contravariant
}
import ceylon.language.meta.model {
    AppliedType = Type, ClassOrInterface, ClassModel, InterfaceModel, Member,
    MemberClass, MemberInterface, Method, Attribute, TypeArgument
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class,
    ModelVariance = Variance,
    ModelTypeParameter = TypeParameter,
    modelInvariant = invariant,
    modelCovariant = covariant,
    modelContravariant = contravariant
}

class
TypeParameterImpl(shared ModelTypeParameter modelTypeParameter) satisfies TypeParameter {
    shared actual String name => modelTypeParameter.name;
    shared actual String qualifiedName => modelTypeParameter.qualifiedName;

    shared actual NestableDeclaration container => nothing;
    shared actual Boolean defaulted => modelTypeParameter.defaultTypeArgument exists;
    shared actual OpenType? defaultTypeArgument => nothing;
    shared actual Variance variance => varianceFor(modelTypeParameter.variance);
    shared actual OpenType[] satisfiedTypes => nothing;
    shared actual OpenType[] caseTypes => nothing;

    shared actual Boolean equals(Object other)
        =>  if (is TypeParameterImpl other)
            then modelTypeParameter == other.modelTypeParameter
            else false;

    shared actual Integer hash
        =>  modelTypeParameter.hash;
}
