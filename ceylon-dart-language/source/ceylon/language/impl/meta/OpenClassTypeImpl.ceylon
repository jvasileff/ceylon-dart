import ceylon.language.meta.declaration {
    OpenClassType, ClassDeclaration
}
import ceylon.dart.runtime.model {
    ModelType = Type,
    ModelClass = Class
}

class OpenClassTypeImpl(modelType)
        satisfies OpenClassType {

    shared ModelType modelType;

    "The declaration for an OpenClassType must be a Class"
    assert (modelType.declaration is ModelClass);

    object helper extends OpenClassOrInterfaceTypeHelper() {
        modelType => outer.modelType;

        shared actual
        ClassDeclaration declaration {
            assert (is ModelClass declaration = modelType.declaration);
            return newClassDeclaration(declaration);
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
