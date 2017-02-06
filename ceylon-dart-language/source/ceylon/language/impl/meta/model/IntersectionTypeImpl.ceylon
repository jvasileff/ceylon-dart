import ceylon.language.meta.model {
    IntersectionType,
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelIntersectionType = IntersectionType
}

class IntersectionTypeImpl<out Type=Anything>(modelReference)
        extends TypeImpl<Type>()
        satisfies IntersectionType<Type> {

    shared actual ModelType modelReference;

    "The declaration for a IntersectionType must be a IntersectionType"
    assert (modelReference.declaration is ModelIntersectionType);

    shared actual List<ClosedType<>> satisfiedTypes
        =>  [ for (type in modelReference.satisfiedTypes) newType(type) ];

    shared actual object helper satisfies TypeHelper<Type> {
        thisType => outer;
        modelReference => outer.modelReference;
    }
}
