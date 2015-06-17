import ceylon.ast.core {
    Key,
    ScopedKey
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node
}
import com.redhat.ceylon.model.typechecker.model {
    ModelType=Type,
    ModelTypeAlias=TypeAlias,
    ModelClass=Class,
    ModelInterface=Interface,
    ModelClassOrInterface=ClassOrInterface,
    ModelConstructor=Constructor,
    ModelFunction=Function,
    ModelValue=Value,
    ModelSetter=Setter,
    ModelTypeDeclaration=TypeDeclaration,
    ModelTypedDeclaration=TypedDeclaration,
    ModelParameterList=ParameterList,
    ModelParameter=Parameter,
    ModelTypeParameter=TypeParameter,
    ModelReferenceable=Referenceable,
    ModelDeclaration=Declaration,
    ModelImport=Import
}

object keys {
    shared
    Key<TcNode> tcNode
        =   ScopedKey<TcNode>(`value keys`,
                "tcNode");

    shared
    Key<ModelType> typeModel
        =   ScopedKey<ModelType>(`value keys`,
                "typeModel");

    shared
    Key<ModelTypeAlias> typeAliasModel
        =   ScopedKey<ModelTypeAlias>(`value keys`,
                "typeAliasModel");

    shared
    Key<ModelClass> classModel
        =   ScopedKey<ModelClass>(`value keys`,
                "classModel");

    shared
    Key<ModelInterface> interfaceModel
        =   ScopedKey<ModelInterface>(`value keys`,
                "interfaceModel");

    shared
    Key<ModelClassOrInterface> classOrInterfaceModel
        =   ScopedKey<ModelClassOrInterface>(`value keys`,
                "classOrInterfaceModel");

    shared
    Key<ModelType> firstTypeModel
        =   ScopedKey<ModelType>(`value keys`,
                "firstTypeModel");

    shared
    Key<List<ModelType>> typeModels
        =   ScopedKey<List<ModelType>>(`value keys`,
                "typeModels");

    shared
    Key<ModelSetter> setterModel
        =   ScopedKey<ModelSetter>(`value keys`,
                "setterModel");

    shared
    Key<ModelValue> valueModel
        =   ScopedKey<ModelValue>(`value keys`,
                "valueModel");

    shared
    Key<ModelFunction> functionModel
        =   ScopedKey<ModelFunction>(`value keys`,
                "functionModel");

    shared
    Key<ModelConstructor> constructorModel
        =   ScopedKey<ModelConstructor>(`value keys`,
                "constructorModel");

    shared
    Key<ModelTypeDeclaration> typeDeclarationModel
        =   ScopedKey<ModelTypeDeclaration>(`value keys`,
                "typeDeclarationModel");

    shared
    Key<ModelTypedDeclaration> typedDeclarationModel
        =   ScopedKey<ModelTypedDeclaration>(`value keys`,
                "typedDeclarationModel");

    shared
    Key<ModelParameterList> parameterListModel
        =   ScopedKey<ModelParameterList>(`value keys`,
                "parameterListModel");

    shared
    Key<ModelTypeParameter> typeParameterModel
        =   ScopedKey<ModelTypeParameter>(`value keys`,
                "typeParameterModel");

    shared
    Key<ModelParameter> parameterModel
        =   ScopedKey<ModelParameter>(`value keys`,
                "parameterModel");

    shared
    Key<ModelReferenceable> referenceableModel
        =   ScopedKey<ModelReferenceable>(`value keys`,
                "referenceableModel");

    shared
    Key<ModelDeclaration> declarationModel
        =   ScopedKey<ModelDeclaration>(`value keys`,
                "declarationModel");

    shared
    Key<ModelImport> importModel
        =   ScopedKey<ModelImport>(`value keys`,
                "importModel");

    shared
    Key<String> location
        =   ScopedKey<String>(`value keys`,
                "location");

    shared
    Key<String> identifierName
        =   ScopedKey<String>(`value keys`,
                "identifierName");
}
