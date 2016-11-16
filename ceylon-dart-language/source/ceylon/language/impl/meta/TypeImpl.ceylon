import ceylon.language.meta.model {
    ClosedType = Type, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    unionDeduped,
    intersectionDedupedCanonical
}

abstract
class TypeImpl<out Type=Anything>() satisfies ClosedType<Type> {
    shared formal ModelType modelType;
    shared formal TypeHelper<Type> helper;

    typeOf(Anything instance) => helper.typeOf(instance);
    supertypeOf(ClosedType<> type) => helper.supertypeOf(type);
    exactly(ClosedType<> type) => helper.exactly(type);
    string => helper.string;

    shared actual
    ClosedType<Type|Other> union<Other>(ClosedType<Other> other)
        =>  helper.union<Other>(other);

    shared actual
    ClosedType<Type&Other> intersection<Other>(ClosedType<Other> other)
        =>  helper.intersection<Other>(other);
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
    ClosedType<Type|Other> union<Other>(ClosedType<Other> other)
        =>  switch (other)
            case (nothingType) thisType
            else newType<Type | Other> {
                unionDeduped {
                    [modelType, assertedTypeImpl(other).modelType];
                    modelType.unit;
                };
            };

    shared
    ClosedType<Type&Other> intersection<Other>(ClosedType<Other> other)
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
