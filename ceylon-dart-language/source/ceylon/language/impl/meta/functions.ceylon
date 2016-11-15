import ceylon.dart.runtime.model {
    ClassDefinitionModel=ClassDefinition,
    ClassAliasModel=ClassAlias,
    InterfaceDefinitionModel=InterfaceDefinition,
    InterfaceAliasModel=InterfaceAlias,
    FunctionModel=Function,
    ValueModel=Value,
    TypeParameterModel=TypeParameter,
    NothingDeclarationModel=NothingDeclaration,
    DeclarationModel=Declaration,
    TypeAliasModel=TypeAlias,
    ConstructorModel=Constructor,
    IntersectionTypeModel=IntersectionType,
    UnionTypeModel=UnionType,
    UnknownTypeModel=UnknownType,
    SetterModel=Setter
}
import ceylon.language.meta.declaration {
    NestableDeclaration
}

NestableDeclaration? wrapNestableDeclaration(DeclarationModel model) {
    // TODO incomplete. Make non-optional after finishing
    switch (model)
    case (is ClassDefinitionModel) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
    case (is ClassAliasModel) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
    case (is InterfaceDefinitionModel) {
        return InterfaceDeclarationImpl(model);
    }
    case (is InterfaceAliasModel) {
        return InterfaceDeclarationImpl(model);
    }
    case (is TypeParameterModel) {}
    case (is NothingDeclarationModel) {}
    case (is TypeAliasModel) {}
    case (is FunctionModel) {}
    case (is ValueModel) {}
    case (is SetterModel) {}
    case (is ConstructorModel) {}
    case (is IntersectionTypeModel | UnionTypeModel | UnknownTypeModel) {
        throw AssertionError("Unexpected declaration type for ``model``");
    }
    return null;
}
