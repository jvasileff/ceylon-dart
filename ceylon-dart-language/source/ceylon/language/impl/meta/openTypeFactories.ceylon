import ceylon.language.meta.declaration {
    OpenType, nothingType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class,
    ModelInterface = Interface,
    ModelNothingDeclaration = NothingDeclaration,
    ModelTypeParameter = TypeParameter,
    ModelUnionType = UnionType,
    ModelIntersectionType = IntersectionType,
    ModelUnknownType = UnknownType,
    ModelTypeAlias = TypeAlias,
    ModelConstructor = Constructor
}

OpenType newOpenType(ModelType modelType) {
    value modelDeclaration = modelType.declaration;
    switch (modelDeclaration)
    case (is ModelNothingDeclaration) {
        return nothingType;
    }
    case (is ModelClass) {
        return OpenClassTypeImpl(modelType);
    }
    case (is ModelInterface) {
        return OpenInterfaceTypeImpl(modelType);
    }
    case (is ModelTypeParameter) {
        return OpenTypeVariableImpl(modelType);
    }
    case (is ModelUnionType) {
        return OpenUnionImpl(modelType);
    }
    case (is ModelIntersectionType) {
        return OpenIntersectionImpl(modelType);
    }
    case (is ModelUnknownType | ModelTypeAlias | ModelConstructor) {
        throw AssertionError("Unsupported declaration kind for type ``modelType``");
    }
}
