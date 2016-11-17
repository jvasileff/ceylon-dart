import ceylon.language.meta.model {
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelTypedReference = TypedReference,
    ModelType = Type
}

interface ValueModelHelper<Get> satisfies ModelHelper {
    shared
    ClosedType<Get> type
        =>  switch (modelType = this.modelType)
            case (is ModelTypedReference) // value or attribute
                newType<Get>(modelType.type)
            case (is ModelType) // value constructor
                newType<Get>(modelType);
}
