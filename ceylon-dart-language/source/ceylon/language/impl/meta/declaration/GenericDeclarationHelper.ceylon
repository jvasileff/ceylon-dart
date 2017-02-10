import ceylon.dart.runtime.model {
    ModelTypeParameter = TypeParameter,
    ModelTypedDeclaration = TypedDeclaration,
    ModelTypeDeclaration = TypeDeclaration,
    ModelGeneric = Generic
}
import ceylon.language.meta.declaration {
    TypeParameter
}

interface GenericDeclarationHelper satisfies NestableDeclarationHelper {
    shared actual formal
    ModelGeneric & <ModelTypeDeclaration | ModelTypedDeclaration> modelDeclaration;

    shared
    TypeParameter[] typeParameterDeclarations
        =>  modelDeclaration.typeParameters.collect(newTypeParameter);

    shared
    TypeParameter? getTypeParameterDeclaration(String name)
        =>  if (is ModelTypeParameter modelTypeParameter
                =   modelDeclaration.getDirectMember(name))
            then newTypeParameter(modelTypeParameter)
            else null;
}
