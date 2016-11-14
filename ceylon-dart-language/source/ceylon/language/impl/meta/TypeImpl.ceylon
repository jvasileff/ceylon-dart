import ceylon.language.meta.model {
    AppliedType = Type, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    unionDeduped,
    intersectionDedupedCanonical
}

shared abstract class TypeImpl<out Type=Anything>()
        satisfies AppliedType<Type> {

    function assertedTypeImpl(AppliedType<> type) {
        assert (is TypeImpl<> type);
        return type;
    }

    shared formal ModelType modelType;

    shared actual Boolean typeOf(Anything instance) => nothing;

    shared actual Boolean supertypeOf(AppliedType<> type)
        =>  switch (type)
            case (nothingType) true
            else modelType.isSupertypeOf(assertedTypeImpl(type).modelType);

    shared actual Boolean exactly(AppliedType<> type)
        =>  switch (type)
            case (nothingType) modelType.isExactlyNothing // in theory, always false...
            else modelType.isExactly(assertedTypeImpl(type).modelType);

    shared actual AppliedType<Type|Other> union<Other>(AppliedType<Other> other)
        =>  switch (other)
            case (nothingType) this
            else newType<Type | Other> {
                unionDeduped {
                    [modelType, assertedTypeImpl(other).modelType];
                    modelType.unit;
                };
            };

    shared actual AppliedType<Type&Other> intersection<Other>(AppliedType<Other> other)
        =>  switch (other)
            case (nothingType) nothingType
            else newType<Type & Other> {
                intersectionDedupedCanonical {
                    [modelType, assertedTypeImpl(other).modelType];
                    modelType.unit;
                };
            };

    shared actual String string
        // TODO use same format as Metamodel.toTypeString
        =>  modelType.string;
}
