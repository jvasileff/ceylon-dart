import com.redhat.ceylon.common {
    Backend
}
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
import com.vasileff.ceylon.dart.compiler.dartast {
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

shared class TypeDetails(
        shared TypeModel type,
        shared Boolean erasedToNative,
        shared Boolean erasedToObject) {}

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

shared class VariableTriple(
    shared ValueModel declarationModel,
    shared DartVariableDeclarationStatement dartDeclaration,
    shared DartStatement dartAssignment) {}

"Tuple containing:

 - replacement variables,
 - tempDefinition
 - conditionExpression"
shared alias ConditionCodeTuple
    =>  [DartVariableDeclarationStatement?, DartExpression, VariableTriple*];

shared Backend dartBackend
    =   Backend.registerBackend("Dart", "dart");

"A function, value, or operator."
shared abstract
class DartElementType() of
    dartValue | dartFunction | DartOperator {}

"A Dart Operator than can be used as a name for an instance method."
shared abstract
class DartOperator()
    of dartPrefixOperator | dartBinaryOperator | dartListAccess | dartListAssignment
    extends DartElementType() {}

shared
object dartValue extends DartElementType() {}

shared
object dartFunction extends DartElementType() {}

"The operators `-` and `~`."
shared
object dartPrefixOperator extends DartOperator() {}

"
 - equalityOperator: `==`
 - relationalOperator: `<`, `>`, `<=`, `>=`
 - additiveOperator: `-`, `+`
 - multiplicativeOperator: `/`, `~/`, `*`, `%`
 - bitwiseOperator: `|`, `ˆ`, `&`
 - shiftOperator: `<<`, `>>`
"
shared
object dartBinaryOperator extends DartOperator() {}

"The `[]` operator."
shared
object dartListAccess extends DartOperator() {}

"The `[]=` operator."
shared
object dartListAssignment extends DartOperator() {}
