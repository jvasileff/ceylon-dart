import ceylon.language.meta.model {
    ClosedType = Type, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    unionDeduped,
    intersectionDedupedCanonical
}

interface TypeHelper<out Type> satisfies HasModelReference {
    shared actual formal ModelType modelType;
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
            else modelType.isSupertypeOf(assertedTypeImpl(type).modelType);

    shared
    Boolean exactly(ClosedType<> type)
        =>  switch (type)
            case (nothingType) modelType.isExactlyNothing // in theory, always false...
            else modelType.isExactly(assertedTypeImpl(type).modelType);

    shared
    ClosedType<Type | Other> union<Other>(ClosedType<Other> other)
        =>  unsafeCast<ClosedType<Type | Other>> {
                switch (other)
                case (nothingType) thisType
                else newType {
                    unionDeduped {
                        [modelType, assertedTypeImpl(other).modelType];
                        modelType.unit;
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
                        [modelType, assertedTypeImpl(other).modelType];
                        modelType.unit;
                    };
                };
            };
}
