import ceylon.language.meta.declaration {
    OpenUnion, OpenType
}
import ceylon.dart.runtime.model {
    ModelType=Type,
    ModelUnionType=UnionType
}

class OpenUnionImpl(modelType)
        satisfies OpenUnion {

    shared ModelType modelType;

    "The declaration for an OpenUnion must be a Union"
    assert (modelType.declaration is ModelUnionType);

    // TODO
    shared actual
    String string => modelType.format { printFullyQualified = true; };

    shared actual
    [OpenType+] caseTypes {
        assert (is ModelUnionType modelUnionType = modelType.declaration);
        return modelUnionType.caseTypes.collect(newOpenType);
    }
}
