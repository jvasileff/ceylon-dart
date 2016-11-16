import ceylon.language.meta.model {
    UnionType,
    ClosedType = Type
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelUnionType = UnionType
}

class UnionTypeImpl<out Type=Anything>(modelType)
        extends TypeImpl<Type>()
        satisfies UnionType<Type> {

    shared actual ModelType modelType;

    "The declaration for a UnionType must be a UnionType"
    assert (modelType.declaration is ModelUnionType);

    shared actual List<ClosedType<>> caseTypes
        =>  [ for (type in modelType.caseTypes) newType(type) ];

    shared actual object helper satisfies TypeHelper<Type> {
        thisType => outer;
        modelType => outer.modelType;
    }
}
