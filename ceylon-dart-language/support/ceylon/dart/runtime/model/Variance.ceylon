shared abstract
class Variance(string) of invariant | covariant | contravariant {
    shared actual String string;

    shared Boolean isInvariant => this == invariant;
    shared Boolean isCovariant => this == covariant;
    shared Boolean isContravariant => this == contravariant;

    shared Variance opposite
        =>  switch (this)
            case (covariant) contravariant
            case (contravariant) covariant
            case (invariant) invariant;
}

shared object invariant extends Variance("invariant") {}
shared object covariant extends Variance("covariant") {}
shared object contravariant extends Variance("contravariant") {}
