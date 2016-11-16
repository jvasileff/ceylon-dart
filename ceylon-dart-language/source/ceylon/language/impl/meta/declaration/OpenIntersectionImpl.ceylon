import ceylon.language.meta.declaration {
    OpenIntersection, OpenType
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelIntersectionType = IntersectionType
}

class OpenIntersectionImpl(modelType)
        satisfies OpenIntersection {

    shared ModelType modelType;

    "The declaration for an OpenUnion must be a Union"
    assert (modelType.declaration is ModelIntersectionType);

    // TODO
    shared actual
    String string => modelType.format { printFullyQualified = true; };

    shared actual
    [OpenType+] satisfiedTypes {
        assert (is ModelIntersectionType modelIntersectionType = modelType.declaration);
        return modelIntersectionType.satisfiedTypes.collect(newOpenType);
    }
}
