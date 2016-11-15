import ceylon.language.meta.declaration {
    OpenInterfaceType, InterfaceDeclaration
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelInterface = Interface
}

class OpenInterfaceTypeImpl(modelType)
        satisfies OpenInterfaceType {

    shared ModelType modelType;

    "The declaration for an OpenInterfaceType must be a Interface"
    assert (modelType.declaration is ModelInterface);

    object helper extends OpenClassOrInterfaceTypeHelper() {
        modelType => outer.modelType;

        shared actual
        InterfaceDeclaration declaration {
            assert (is ModelInterface declaration = modelType.declaration);
            return newInterfaceDeclaration(declaration);
        }
    }

    declaration => helper.declaration;
    extendedType => helper.extendedType;
    satisfiedTypes => helper.satisfiedTypes;
    typeArguments => helper.typeArguments;
    typeArgumentWithVariances => helper.typeArgumentWithVariances;
    typeArgumentList => helper.typeArgumentList;
    typeArgumentWithVarianceList => helper.typeArgumentWithVarianceList;
}
