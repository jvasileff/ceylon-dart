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
    shared [DartStatement+] dartAssignment) {}

"Tuple containing:

 - a Dart variable declaration for a value to test
 - a boolean test expression
 - new variables to declare for replacements and destructures"
shared alias ConditionCodeTuple
    =>  [DartVariableDeclarationStatement?, DartExpression, VariableTriple*];

"A function, value, or operator."
shared abstract
class DartElementType() of
    dartValue | dartFunction | DartOperator {}

"A Dart Operator than can be used as a name for an instance method."
shared abstract
class DartOperator()
        of DartPrefixOperator | DartBinaryOperator | dartListAccess | dartListAssignment
        extends DartElementType() {

    "The operator."
    shared actual formal String string;

    "Descriptive pair, including the string representation of the operator and it's
     object instance."
    shared [String, DartOperator] pair => [string, this];
}

shared
object dartValue extends DartElementType() {}

shared
object dartFunction extends DartElementType() {}

"The operators `-` and `~`."
shared abstract
class DartPrefixOperator()
    of dartNegationOperator | dartNotOperator
    extends DartOperator() {}

shared
object dartNegationOperator extends DartPrefixOperator() {
    shared actual String string => "-";
}

shared
object dartNotOperator extends DartPrefixOperator() {
    shared actual String string => "~";
}

"
 - equalityOperator: `==`
 - relationalOperator: `<`, `>`, `<=`, `>=`
 - additiveOperator: `-`, `+`
 - multiplicativeOperator: `/`, `~/`, `*`, `%`
 - bitwiseOperator: `|`, `ˆ`, `&`
 - shiftOperator: `<<`, `>>`
"
shared abstract
class DartBinaryOperator()
        of dartEqualityOperator | DartRelationalOperator | DartAdditiveOperator
            | DartMultiplicativeOperator | DartBitwiseOperator | DartShiftOperator
        extends DartOperator() {}

shared
object dartEqualityOperator extends DartBinaryOperator() {
    shared actual String string => "==";
}

shared abstract
class DartRelationalOperator()
    of dartLessThanOperator | dartGreaterThanOperator | dartNotGreaterThanOperator
        | dartNotLessThanOperator
    extends DartBinaryOperator() {}

shared
object dartLessThanOperator extends DartRelationalOperator() {
    shared actual String string => "<";
}

shared
object dartGreaterThanOperator extends DartRelationalOperator() {
    shared actual String string => ">";
}

shared
object dartNotGreaterThanOperator extends DartRelationalOperator() {
    shared actual String string => "<=";
}

shared
object dartNotLessThanOperator extends DartRelationalOperator() {
    shared actual String string => ">=";
}

shared abstract
class DartAdditiveOperator()
    of dartPlusOperator | dartMinusOperator
    extends DartBinaryOperator() {}

shared
object dartPlusOperator extends DartAdditiveOperator() {
    shared actual String string => "+";
}

shared
object dartMinusOperator extends DartAdditiveOperator() {
    shared actual String string => "-";
}

shared abstract
class DartMultiplicativeOperator()
    of dartTimesOperator | dartDivideOperator | dartDivideIntegerOperator
        | dartModuloOperator
    extends DartBinaryOperator() {}

shared
object dartTimesOperator extends DartMultiplicativeOperator() {
    shared actual String string => "*";
}

shared
object dartDivideOperator extends DartMultiplicativeOperator() {
    shared actual String string => "/";
}

shared
object dartDivideIntegerOperator extends DartMultiplicativeOperator() {
    shared actual String string => "~/";
}

shared
object dartModuloOperator extends DartMultiplicativeOperator() {
    shared actual String string => "%";
}

shared abstract
class DartBitwiseOperator()
    of dartAndOperator | dartOrOperator | dartXorOperator
    extends DartBinaryOperator() {}

shared
object dartAndOperator extends DartBitwiseOperator() {
    shared actual String string => "&";
}

shared
object dartOrOperator extends DartBitwiseOperator() {
    shared actual String string => "|";
}

shared
object dartXorOperator extends DartBitwiseOperator() {
    shared actual String string => "^";
}

shared abstract
class DartShiftOperator()
    of dartLeftShiftOperator | dartRightShiftOperator
    extends DartBinaryOperator() {}

shared
object dartLeftShiftOperator extends DartShiftOperator() {
    shared actual String string => "<<";
}

shared
object dartRightShiftOperator extends DartShiftOperator() {
    shared actual String string => ">>";
}

"The `[]` operator."
shared
object dartListAccess extends DartOperator() {
    shared actual String string => "[]";
}

"The `[]=` operator."
shared
object dartListAssignment extends DartOperator() {
    shared actual String string => "[]=";
}
