import ceylon.language.meta.declaration {
    Variance, invariant, covariant, contravariant
}
import ceylon.dart.runtime.model {
    ModelVariance = Variance,
    modelInvariant = invariant,
    modelCovariant = covariant,
    modelContravariant = contravariant
}

Variance | Absent varianceFor<Absent = Nothing>(ModelVariance | Absent variance)
        given Absent satisfies Null
    =>  switch (variance)
        case (modelInvariant) invariant
        case (modelCovariant) covariant
        case (modelContravariant) contravariant
        case (is Null) variance;
