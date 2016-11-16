import ceylon.dart.runtime.model {
    ModelClassDefinition = ClassDefinition,
    ModelClassAlias = ClassAlias,
    ModelInterfaceDefinition = InterfaceDefinition,
    ModelInterfaceAlias = InterfaceAlias,
    ModelFunction = Function,
    ModelValue = Value,
    ModelTypeParameter = TypeParameter,
    ModelNothingDeclaration = NothingDeclaration,
    ModelDeclaration = Declaration,
    ModelTypeAlias = TypeAlias,
    ModelConstructor = Constructor,
    ModelIntersectionType = IntersectionType,
    ModelUnionType = UnionType,
    ModelUnknownType = UnknownType,
    ModelSetter = Setter,
    ModelClass = Class,
    ModelInterface = Interface
}
import ceylon.language.meta.declaration {
    NestableDeclaration, ClassDeclaration, InterfaceDeclaration,
    FunctionDeclaration, ValueDeclaration, SetterDeclaration,
    AliasDeclaration
}

shared
ClassDeclaration newClassDeclaration(ModelClass model) {
    // TODO various declaration types
    switch (model)
    case (is ModelClassDefinition) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
    case (is ModelClassAlias) {
        return ClassWithConstructorsDeclarationImpl(model);
    }
}

shared
InterfaceDeclaration newInterfaceDeclaration(ModelInterface model) {
    // TODO various declaration types
    switch (model)
    case (is ModelInterfaceDefinition) {
        return InterfaceDeclarationImpl(model);
    }
    case (is ModelInterfaceAlias) {
        return InterfaceDeclarationImpl(model);
    }
}

shared
FunctionDeclaration newFunctionDeclaration(ModelFunction model)
    =>  FunctionDeclarationImpl(model);

shared
ValueDeclaration newValueDeclaration(ModelValue model)
    =>  ValueDeclarationImpl(model);

shared
SetterDeclaration newSetterDeclaration(ModelSetter model)
    =>  SetterDeclarationImpl(model);

shared
AliasDeclaration newAliasDeclaration(ModelTypeAlias model)
    =>  AliasDeclarationImpl(model);

shared
NestableDeclaration newNestableDeclaration(ModelDeclaration model) {
    // TODO incomplete. Make non-optional after finishing
    switch (model)
    case (is ModelClass) {
        return newClassDeclaration(model);
    }
    case (is ModelInterface) {
        return newInterfaceDeclaration(model);
    }
    case (is ModelFunction) {
        return newFunctionDeclaration(model);
    }
    case (is ModelValue) {
        return newValueDeclaration(model);
    }
    case (is ModelSetter) {
        return newSetterDeclaration(model);
    }
    case (is ModelTypeAlias) {
        return newAliasDeclaration(model);
    }
    case (is ModelConstructor) {
        // TODO need ceylon-model to split ModelConstructor
        //      into CallableConstructor & ValueConstructor
        throw AssertionError {
            "ConstructorDeclarations not yet supported; unable to create declaration \
             for ``model``";
        };
    }
    case (is ModelTypeParameter | ModelIntersectionType | ModelUnionType
                | ModelNothingDeclaration | ModelUnknownType) {
        throw AssertionError("Unexpected declaration type for ``model``");
    }
}
