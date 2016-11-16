import ceylon.language.meta.model {
    AppliedType = Type, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    unionDeduped,
    intersectionDedupedCanonical
}

abstract
class TypeImpl<out Type=Anything>() satisfies AppliedType<Type> {
    shared formal ModelType modelType;
    shared formal TypeHelper<Type> helper;

    typeOf(Anything instance) => helper.typeOf(instance);
    supertypeOf(AppliedType<> type) => helper.supertypeOf(type);
    exactly(AppliedType<> type) => helper.exactly(type);
    string => helper.string;

    shared actual
    AppliedType<Type|Other> union<Other>(AppliedType<Other> other)
        =>  helper.union<Other>(other);

    shared actual
    AppliedType<Type&Other> intersection<Other>(AppliedType<Other> other)
        =>  helper.intersection<Other>(other);
}

interface TypeHelper<out Type> satisfies HasModelReference {
    shared actual formal ModelType modelType;
    shared formal TypeImpl<Type> thisType;

    function assertedTypeImpl(AppliedType<> type) {
        assert (is TypeImpl<> type);
        return type;
    }

    shared 
    Boolean typeOf(Anything instance) => nothing;

    shared
    Boolean supertypeOf(AppliedType<> type)
        =>  switch (type)
            case (nothingType) true
            else modelType.isSupertypeOf(assertedTypeImpl(type).modelType);

    shared
    Boolean exactly(AppliedType<> type)
        =>  switch (type)
            case (nothingType) modelType.isExactlyNothing // in theory, always false...
            else modelType.isExactly(assertedTypeImpl(type).modelType);

    shared
    AppliedType<Type|Other> union<Other>(AppliedType<Other> other)
        =>  switch (other)
            case (nothingType) thisType
            else newType<Type | Other> {
                unionDeduped {
                    [modelType, assertedTypeImpl(other).modelType];
                    modelType.unit;
                };
            };

    shared
    AppliedType<Type&Other> intersection<Other>(AppliedType<Other> other)
        =>  switch (other)
            case (nothingType) nothingType
            else newType<Type & Other> {
                intersectionDedupedCanonical {
                    [modelType, assertedTypeImpl(other).modelType];
                    modelType.unit;
                };
            };

    // TODO use same format as Metamodel.toTypeString
    string => modelType.string;
}
