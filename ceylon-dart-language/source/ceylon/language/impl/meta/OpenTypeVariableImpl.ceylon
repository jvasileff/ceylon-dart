import ceylon.language.meta.declaration {
    OpenTypeVariable, TypeParameter
}
import ceylon.dart.runtime.model {
    ModelType=Type,
    ModelTypeParameter=TypeParameter
}

class OpenTypeVariableImpl(modelType)
        satisfies OpenTypeVariable {

    shared ModelType modelType;

    "The declaration for an OpenTypeVariable must be a TypeParameter"
    assert (modelType.declaration is ModelTypeParameter);

    // TODO
    shared actual
    String string => modelType.format { printFullyQualified = true; };

    shared actual
    TypeParameter declaration {
        assert (is ModelTypeParameter modelDeclaration = modelType.declaration);
        return TypeParameterImpl(modelDeclaration);
    }
}
