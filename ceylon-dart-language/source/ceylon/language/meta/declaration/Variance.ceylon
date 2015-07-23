"Variance information."
native shared interface Variance of invariant | covariant | contravariant {}

"Invariant means that neither subtype nor supertype can be accepted, the
 type has to be exactly that which is declared."
native shared object invariant satisfies Variance {
    string => "Invariant";
}

"Covariant means that subtypes of the given type may be returned."
native shared object covariant satisfies Variance {
    string => "Covariant";
}

"Contravariant means that supertypes of the given type may be accepted."
native shared object contravariant satisfies Variance {
    string => "Contravariant";
}
