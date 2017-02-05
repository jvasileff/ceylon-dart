import ceylon.language.meta.model {
    ClosedType = Type
}

interface MemberHelper satisfies HasModelReference {
    shared
    ClosedType<> declaringType {
        assert (exists qualifyingType = modelType.qualifyingType);
        return newType(qualifyingType);
    }
}
