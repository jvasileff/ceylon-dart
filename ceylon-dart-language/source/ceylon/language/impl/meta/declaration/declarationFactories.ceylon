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
    SetterModel=Setter,
    ClassModel=Class,
    InterfaceModel=Interface
}
import ceylon.language.meta.declaration {
    NestableDeclaration, ClassDeclaration, InterfaceDeclaration,
    FunctionDeclaration, ValueDeclaration, SetterDeclaration,
    AliasDeclaration, nothingType
}

shared
ClassDeclaration newClassDeclaration(ClassModel model) {
    // TODO various declaration types
    switch (model)
    case (is ClassDefinitionModel) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
    case (is ClassAliasModel) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
}

shared
InterfaceDeclaration newInterfaceDeclaration(InterfaceModel model) {
    // TODO various declaration types
    switch (model)
    case (is InterfaceDefinitionModel) {
        return InterfaceDeclarationImpl(model);
    }
    case (is InterfaceAliasModel) {
        return InterfaceDeclarationImpl(model);
    }
}

shared
FunctionDeclaration newFunctionDeclaration(FunctionModel model)
    =>  FunctionDeclarationImpl(model);

shared
ValueDeclaration newValueDeclaration(ValueModel model)
    =>  ValueDeclarationImpl(model);

shared
SetterDeclaration newSetterDeclaration(SetterModel model)
    =>  SetterDeclarationImpl(model);

shared
AliasDeclaration newAliasDeclaration(TypeAliasModel model)
    =>  AliasDeclarationImpl(model);

shared
NestableDeclaration? newNestableDeclaration(DeclarationModel model) {
    // TODO incomplete. Make non-optional after finishing
    switch (model)
    case (is ClassModel) {
        return newClassDeclaration(model);
    }
    case (is InterfaceModel) {
        return newInterfaceDeclaration(model);
    }
    case (is FunctionModel) {
        return newFunctionDeclaration(model);
    }
    case (is ValueModel) {
        return newValueDeclaration(model);
    }
    case (is SetterModel) {
        return newSetterDeclaration(model);
    }
    case (is TypeAliasModel) {
        return newAliasDeclaration(model);
    }
    case (is ConstructorModel) {
        // TODO need ceylon-model to split ConstructorModel
        //      into CallableConstructor & ValueConstructor
        throw AssertionError {
            "ConstructorDeclarations not yet supported; unable to create declaration \
             for ``model``";
        };
    }
    case (is TypeParameterModel | IntersectionTypeModel | UnionTypeModel
                | NothingDeclarationModel | UnknownTypeModel) {
        throw AssertionError("Unexpected declaration type for ``model``");
    }
}
