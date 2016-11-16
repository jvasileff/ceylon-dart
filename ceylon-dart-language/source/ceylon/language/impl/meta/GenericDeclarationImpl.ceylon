import ceylon.dart.runtime.model {
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
        =>  modelDeclaration.typeParameters.collect(TypeParameterImpl);

    shared
    TypeParameter? getTypeParameterDeclaration(String name) => nothing;
}
