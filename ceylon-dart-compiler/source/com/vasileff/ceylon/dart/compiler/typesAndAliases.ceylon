import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type,
    ConstructorModel=Constructor,
    ControlBlockModel=ControlBlock,
    FunctionOrValueModel=FunctionOrValue,
    NamedArgumentListModel=NamedArgumentList,
    SpecificationModel=Specification,
    ClassModel=Class,
    ValueModel=Value,
    FunctionModel=Function,
    SetterModel=Setter,
    InterfaceModel=Interface
}
import com.vasileff.ceylon.dart.ast {
    DartExpression,
    DartVariableDeclarationStatement,
    DartStatement
}

"Indicates the absence of a type (like void). One use is to
 indicate the absence of a `lhsType` when determining if
 the result of an expression should be boxed."
shared interface NoType of noType {}

"The instance of `NoType`"
shared object noType satisfies NoType {}

shared alias TypeOrNoType => TypeModel | NoType;

shared alias LocalNonInitializerScope
    =>  ConstructorModel
        | ControlBlockModel
        | FunctionOrValueModel
        | NamedArgumentListModel
        | SpecificationModel;

shared alias DeclarationModelType
    =>  ClassModel
        | InterfaceModel
        | ConstructorModel
        | FunctionModel
        | ValueModel
        | SetterModel;

"Tuple containing:

 - replacementDeclarationModels,
 - replacementDeclarations
 - tempDefinition
 - conditionExpression
 - replacementDefinitions"
shared alias ConditionCodeTuple
    =>  [
            [ValueModel*],
            [DartVariableDeclarationStatement*],
            DartVariableDeclarationStatement?,
            DartExpression,
            [DartStatement*]
        ];
