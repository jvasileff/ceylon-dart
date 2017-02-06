import ceylon.language.meta.model {
    UnionType,
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelUnionType = UnionType
}

class UnionTypeImpl<out Type>(modelReference)
        extends TypeImpl<Type>()
        satisfies UnionType<Type> {

    shared actual ModelType modelReference;

    "The declaration for a UnionType must be a UnionType"
    assert (modelReference.declaration is ModelUnionType);

    shared actual List<ClosedType<>> caseTypes
        =>  [ for (type in modelReference.caseTypes) newType(type) ];

    shared actual object helper satisfies TypeHelper<Type> {
        thisType => outer;
        modelReference => outer.modelReference;
    }
}
