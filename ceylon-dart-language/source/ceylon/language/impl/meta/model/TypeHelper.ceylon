import ceylon.language.meta.model {
    ClosedType = Type, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    unionDeduped,
    intersectionDedupedCanonical
}

interface TypeHelper<out Type> satisfies HasModelReference {
    shared actual formal ModelType modelReference;
    shared formal TypeImpl<Type> thisType;

    function assertedTypeImpl(ClosedType<> type) {
        assert (is TypeImpl<> type);
        return type;
    }

    shared 
    Boolean typeOf(Anything instance) => nothing;

    shared
    Boolean supertypeOf(ClosedType<> type)
        =>  switch (type)
            case (nothingType) true
            else modelReference.isSupertypeOf(assertedTypeImpl(type).modelReference);

    shared
    Boolean exactly(ClosedType<> type)
        =>  switch (type)
            case (nothingType) modelReference.isExactlyNothing // in theory, always false
            else modelReference.isExactly(assertedTypeImpl(type).modelReference);

    shared
    ClosedType<Type | Other> union<Other>(ClosedType<Other> other)
        =>  unsafeCast<ClosedType<Type | Other>> {
                switch (other)
                case (nothingType) thisType
                else newType {
                    unionDeduped {
                        [modelReference, assertedTypeImpl(other).modelReference];
                        modelReference.unit;
                    };
                };
            };

    shared
    ClosedType<Type & Other> intersection<Other>(ClosedType<Other> other)
        =>  unsafeCast<ClosedType<Type & Other>> {
                switch (other)
                case (nothingType) nothingType
                else newType {
                    intersectionDedupedCanonical {
                        [modelReference, assertedTypeImpl(other).modelReference];
                        modelReference.unit;
                    };
                };
            };
}
