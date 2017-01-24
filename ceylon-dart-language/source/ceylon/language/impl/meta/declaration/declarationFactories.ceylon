import ceylon.dart.runtime.model {
    ModelClassDefinition = ClassDefinition,
    ModelClassWithInitializer = ClassWithInitializer,
    ModelClassWithConstructors = ClassWithConstructors,
    ModelClassAlias = ClassAlias,
    ModelClassOrInterface = ClassOrInterface,
    ModelFunction = Function,
    ModelValue = Value,
    ModelTypeParameter = TypeParameter,
    ModelNothingDeclaration = NothingDeclaration,
    ModelDeclaration = Declaration,
    ModelTypeAlias = TypeAlias,
    ModelConstructor = Constructor,
    ModelValueConstructor = ValueConstructor,
    ModelCallableConstructor = CallableConstructor,
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
    AliasDeclaration, ConstructorDeclaration, ClassOrInterfaceDeclaration,
    ValueConstructorDeclaration, CallableConstructorDeclaration
}

shared
ClassDeclaration newClassDeclaration(ModelClass model)
    =>  switch (model)
        case (is ModelClassWithInitializer) ClassWithInitializerDeclarationImpl(model)
        case (is ModelClassWithConstructors) ClassWithConstructorsDeclarationImpl(model)
        case (is ModelClassAlias) ClassWithInitializerDeclarationImpl(model);

shared
InterfaceDeclaration newInterfaceDeclaration(ModelInterface model)
    =>  InterfaceDeclarationImpl(model);

shared
CallableConstructorDeclaration newCallableConstructorDeclaration
        (ModelCallableConstructor model)
    =>  CallableConstructorDeclarationImpl(model);

shared
ValueConstructorDeclaration newValueConstructorDeclaration
        (ModelValueConstructor model)
    =>  ValueConstructorDeclarationImpl(model);

shared
ConstructorDeclaration newConstructorDeclaration(ModelConstructor model)
    =>  switch (model)
        case (is ModelCallableConstructor)
            CallableConstructorDeclarationImpl(model)
        case (is ModelValueConstructor)
            ValueConstructorDeclarationImpl(model);

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
ClassOrInterfaceDeclaration newClassOrInterfaceDeclaration(ModelClassOrInterface model) {
    switch (model)
    case (is ModelClass) {
        return newClassDeclaration(model);
    }
    case (is ModelInterface) {
        return newInterfaceDeclaration(model);
    }
}

shared
NestableDeclaration newNestableDeclaration(ModelDeclaration model) {
    switch (model)
    case (is ModelClass) {
        return newClassDeclaration(model);
    }
    case (is ModelInterface) {
        return newInterfaceDeclaration(model);
    }
    case (is ModelConstructor) {
        return newConstructorDeclaration(model);
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
    case (is ModelTypeParameter | ModelIntersectionType | ModelUnionType
                | ModelNothingDeclaration | ModelUnknownType) {
        throw AssertionError("Unexpected declaration type for ``model``");
    }
}
