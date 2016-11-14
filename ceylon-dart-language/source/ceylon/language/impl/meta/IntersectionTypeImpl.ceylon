import ceylon.language.meta.model {
    IntersectionType,
    AppliedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelIntersectionType = IntersectionType
}

shared class IntersectionTypeImpl<out Type=Anything>(modelType)
        extends TypeImpl<Type>()
        satisfies IntersectionType<Type> {

    shared actual ModelType modelType;

    "The declaration for a IntersectionType must be a IntersectionType"
    assert (modelType.declaration is ModelIntersectionType);

    shared actual List<AppliedType<>> satisfiedTypes
        =>  [ for (type in modelType.satisfiedTypes) newType(type) ];
}
