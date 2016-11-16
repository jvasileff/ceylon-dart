import ceylon.language.meta.model {
    IntersectionType,
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelIntersectionType = IntersectionType
}

class IntersectionTypeImpl<out Type=Anything>(modelType)
        extends TypeImpl<Type>()
        satisfies IntersectionType<Type> {

    shared actual ModelType modelType;

    "The declaration for a IntersectionType must be a IntersectionType"
    assert (modelType.declaration is ModelIntersectionType);

    shared actual List<ClosedType<>> satisfiedTypes
        =>  [ for (type in modelType.satisfiedTypes) newType(type) ];

    shared actual object helper satisfies TypeHelper<Type> {
        thisType => outer;
        modelType => outer.modelType;
    }
}
