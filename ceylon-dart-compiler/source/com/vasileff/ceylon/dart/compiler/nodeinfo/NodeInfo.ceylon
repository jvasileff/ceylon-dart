import ceylon.ast.core {
    BaseExpression,
    Node,
    ValueDefinition,
    FunctionExpression,
    Expression,
    FunctionDefinition,
    AnyFunction,
    FunctionShortcutDefinition,
    FunctionDeclaration,
    Parameter,
    ArgumentList,
    Type,
    IsCondition,
    IfClause,
    ElseClause,
    CaseClause,
    CatchClause,
    ComprehensionClause,
    DynamicBlock,
    FinallyClause,
    ForClause,
    TryClause,
    While,
    ValueSpecification,
    Invocation,
    QualifiedExpression,
    ValueDeclaration,
    AnyValue,
    ValueGetterDefinition,
    TypeDeclaration,
    ClassOrInterface,
    AnyInterface,
    AnyClass,
    ForFail,
    Statement,
    ForIterator,
    UnspecifiedVariable,
    Variable,
    This,
    Super,
    Outer,
    ExistsOrNonemptyCondition,
    ExistsCondition,
    NonemptyCondition,
    IfElseExpression,
    ValueSetterDefinition,
    TypeNameWithTypeArguments,
    ObjectDefinition,
    Specification,
    LazySpecification,
    ObjectExpression,
    IsCase,
    SpecifiedVariable,
    Comprehension,
    SpreadArgument,
    NamedArgument,
    AnonymousArgument,
    SpecifiedArgument,
    ValueArgument,
    FunctionArgument,
    ObjectArgument,
    InlineDefinitionArgument,
    CompilationUnit,
    ConstructorDefinition,
    ExtensionOrConstruction,
    Extension,
    Construction,
    VariadicVariable,
    TypeAliasDefinition,
    TypedVariable
}
import ceylon.ast.redhat {
    primaryToCeylon
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.context {
    TypecheckerUnit
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree,
    Message
}
import com.redhat.ceylon.model.typechecker.model {
    ClassOrInterfaceModel=ClassOrInterface,
    InterfaceModel=Interface,
    ClassModel=Class,
    DeclarationModel=Declaration,
    TypeDeclarationModel=TypeDeclaration,
    TypedDeclarationModel=TypedDeclaration,
    TypeModel=Type,
    FunctionModel=Function,
    ParameterModel=Parameter,
    ValueModel=Value,
    SetterModel=Setter,
    TypedReferenceModel=TypedReference,
    ControlBlockModel=ControlBlock,
    ScopeModel=Scope,
    ConstructorModel=Constructor
}
import com.vasileff.ceylon.dart.compiler {
    DScope,
    dartBackend,
    Warning
}
import com.vasileff.ceylon.dart.compiler.core {
    augmentNode
}

import org.antlr.runtime {
    Token
}

shared
class DefaultNodeInfo(shared actual Node node) extends NodeInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared abstract
class NodeInfo()
        of  ExpressionInfo | DeclarationInfo | ExistsOrNonemptyConditionInfo
          | ExtensionOrConstructionInfo | NamedArgumentInfo | ArgumentListInfo
          | CompilationUnitInfo | ComprehensionInfo |ComprehensionClauseInfo
          | ElseClauseInfo | ForClauseInfo | ForIteratorInfo | IsCaseInfo
          | IsConditionInfo | ParameterInfo | SpreadArgumentInfo | StatementInfo
          | TypeInfo | TypeNameWithTypeArgumentsInfo
          | VariableInfo | ControlClauseInfo | DefaultNodeInfo
        satisfies DScope {

    shared actual formal Node node;

    shared formal TcNode tcNode;

    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    shared TypecheckerUnit typecheckerUnit => tcNode.unit;

    // FIXME location and filename doesn't work for ArgumentListInfo
    // https://github.com/ceylon/ceylon-spec/issues/1385
    shared String location => tcNode.location;
    shared String filename => tcNode.unit?.filename else "unknown file";

    shared actual ScopeModel scope => tcNode.scope;

    shared actual default NodeInfo nodeInfo => this;

    shared {Message*} errors => CeylonList(tcNode.errors);

    shared void addError(String string)
        =>  tcNode.addError(string, dartBackend);

    shared void addUnsupportedError(String string)
        =>  tcNode.addUnsupportedError(string, dartBackend);

    shared void addUnexpectedError(String string)
        =>  tcNode.addUnexpectedError(string, dartBackend);

    shared void addWarning(Warning warning, String message)
        =>  tcNode.addUsageWarning(warning, message, dartBackend);
}

shared abstract
class ExpressionInfo()
        of BaseExpressionInfo | FunctionExpressionInfo | InvocationInfo
            | ObjectExpressionInfo | OuterInfo | QualifiedExpressionInfo
            | SuperInfo | ThisInfo | DefaultExpressionInfo | IfElseExpressionInfo
        extends NodeInfo() {

    shared actual formal Expression node;

    shared actual formal Tree.Term tcNode;

    "The type of this expression"
    shared TypeModel typeModel => tcNode.typeModel;
}

shared
class DefaultExpressionInfo(shared actual Expression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.Term;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class CompilationUnitInfo(shared actual CompilationUnit node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.CompilationUnit;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class BaseExpressionInfo(shared actual BaseExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.StaticMemberOrTypeExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    // MemberOrTypeExpression

    "The declaration and type arguments of the target of the BaseExpression, or the
     type if the target is a type."
    shared TypeModel | TypedReferenceModel target {
        assert (is TypeModel | TypedReferenceModel result = tcNode.target);
        return result;
    }

    "The declaration of the target of the BaseExpression"
    shared DeclarationModel declaration => tcNode.declaration;

    "If being invoked, the signature (arguments). This is based on the call-site, so
     type information matches the argument expressions, not the expected types. And,
     arguments not provided (for defaulted params) are not included."
    shared
    List<TypeModel>? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    shared TypedReferenceModel? targetParameter => tcNode.targetParameter;
    shared TypeModel? parameterType => tcNode.parameterType;
    shared Boolean staticMethodReference => tcNode.staticMethodReference;
}

shared
class QualifiedExpressionInfo(shared actual QualifiedExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.QualifiedMemberOrTypeExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    // MemberOrTypeExpression

    "The declaration and type arguments of the target of the QualifiedExpression, or the
     type if the target is a type."
    shared TypeModel | TypedReferenceModel target {
        assert (is TypeModel | TypedReferenceModel result = tcNode.target);
        return result;
    }

    "The declaration of the target of the QualifiedExpression"
    shared DeclarationModel declaration => tcNode.declaration;

    "If being invoked, the signature (arguments). This is based on the call-site, so
     type information matches the argument expressions, not the expected types. And,
     arguments not provided (for defaulted params) are not included."
    shared
    List<TypeModel>? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    "If being passed as an argument, the parameter."
    shared TypedReferenceModel? targetParameter => tcNode.targetParameter;

    "If being passed as an argument, the parameter type."
    shared TypeModel? parameterType => tcNode.parameterType;

    shared Boolean staticMethodReference => tcNode.staticMethodReference;
    shared Boolean staticMethodReferencePrimary => tcNode.staticMethodReferencePrimary;
}

shared abstract
class DeclarationInfo()
        of ConstructorDefinitionInfo
            | ObjectDefinitionInfo
            | TypeDeclarationInfo
            | TypedDeclarationInfo
            | ValueSetterDefinitionInfo
        extends NodeInfo() {

    shared actual formal Tree.Declaration tcNode;

    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

abstract shared
class TypedDeclarationInfo()
        of AnyValueInfo | AnyFunctionInfo
        extends DeclarationInfo() {

    shared actual default
    TypedDeclarationModel declarationModel {
        assert (is TypedDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared abstract
class AnyValueInfo()
        of ValueDeclarationInfo
            | ValueDefinitionInfo
            | ValueGetterDefinitionInfo
        extends TypedDeclarationInfo() {

    shared actual formal AnyValue node;

    shared actual formal Tree.TypedDeclaration tcNode;

    shared actual default
    ValueModel declarationModel {
        assert (is ValueModel result = tcNode.declarationModel);
        return result;
    }
}

shared final
class ValueDefinitionInfo(shared actual ValueDefinition node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeDeclaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueDeclarationInfo(shared actual ValueDeclaration node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeDeclaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueGetterDefinitionInfo(shared actual ValueGetterDefinition node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeGetterDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueSetterDefinitionInfo(shared actual ValueSetterDefinition node)
        extends DeclarationInfo() {

    shared alias TcNodeType => Tree.AttributeSetterDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    SetterModel declarationModel => tcNode.declarationModel;
}

shared final
class ArgumentListInfo(shared actual ArgumentList node)
        extends NodeInfo() {

    // This is probably only Tree.SequenceEnumeration for empty iterables {}
    //
    // It can be Tree.NamedArgumentList for NamedArguments.iterableArgument when
    // no iterableArgument exists.
    shared alias TcNodeType
        =>  Tree.SequencedArgument | Tree.SequenceEnumeration | Tree.NamedArgumentList;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;


    "The [[ParameterModel]], if this argument list is used as an argument (e.g. within
     [[ceylon.ast.core::NamedArguments]])."
    shared ParameterModel? parameter
            =>  if (is Tree.SequencedArgument tcNode)
                then tcNode.parameter
                else null;
}

shared abstract
class NamedArgumentInfo()
        of AnonymousArgumentInfo
            | SpecifiedArgumentInfo
            | InlineDefinitionArgumentInfo
        extends NodeInfo() {

    shared actual formal NamedArgument node;

    shared actual formal Tree.NamedArgument tcNode;

    shared ParameterModel parameter => tcNode.parameter;
}

shared final
class AnonymousArgumentInfo(shared actual AnonymousArgument node)
        extends NamedArgumentInfo() {

    shared alias TcNodeType => Tree.SpecifiedArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class SpecifiedArgumentInfo(shared actual SpecifiedArgument node)
        extends NamedArgumentInfo() {

    shared alias TcNodeType
        =>  Tree.SpecifiedArgument | Tree.AttributeArgument | Tree.MethodArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class InlineDefinitionArgumentInfo()
        of ValueArgumentInfo
            | FunctionArgumentInfo
            | ObjectArgumentInfo
        extends NamedArgumentInfo() {

    shared actual formal InlineDefinitionArgument node;
}

shared
class ValueArgumentInfo(shared actual ValueArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.AttributeArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class FunctionArgumentInfo(shared actual FunctionArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.MethodArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared FunctionModel declarationModel
        =>  tcNode.declarationModel;
}

shared
class ObjectArgumentInfo(shared actual ObjectArgument node)
        extends InlineDefinitionArgumentInfo() {

    shared alias TcNodeType => Tree.ObjectArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class ComprehensionInfo(shared actual Comprehension node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.Comprehension;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared TypeModel typeModel => tcNode.typeModel;
    shared ParameterModel? parameter => tcNode.parameter;
}

shared
class ComprehensionClauseInfo(shared actual ComprehensionClause node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.ComprehensionClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared TypeModel typeModel => tcNode.typeModel;
    shared TypeModel firstTypeModel => tcNode.firstTypeModel;
    shared Boolean possiblyEmpty => tcNode.possiblyEmpty;
}

shared
class SpreadArgumentInfo(shared actual SpreadArgument node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.SpreadArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared TypeModel typeModel => tcNode.typeModel;
    shared ParameterModel? parameter => tcNode.parameter;
}

shared
class FunctionExpressionInfo(shared actual FunctionExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.FunctionArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared FunctionModel declarationModel => tcNode.declarationModel;
}

shared abstract
class AnyFunctionInfo()
        of FunctionDeclarationInfo
            | FunctionDefinitionInfo
            | FunctionShortcutDefinitionInfo
        extends TypedDeclarationInfo() {

    shared actual formal AnyFunction node;

    shared actual formal Tree.AnyMethod tcNode;

    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

shared final
class ObjectDefinitionInfo(shared actual ObjectDefinition node)
        extends DeclarationInfo() {

    shared alias TcNodeType => Tree.ObjectDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ValueModel declarationModel => tcNode.declarationModel;
    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class ObjectExpressionInfo(shared actual ObjectExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.ObjectExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

"Tree.ExecutableStatement"
shared abstract
class StatementInfo()
        of ForFailInfo | SpecificationInfo | DefaultStatementInfo
        extends NodeInfo() {

    shared actual formal Statement node;
}

shared
class DefaultStatementInfo(shared actual Statement node)
        extends StatementInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared abstract
class SpecificationInfo()
        of ValueSpecificationInfo | LazySpecificationInfo
        extends StatementInfo() {

    shared actual formal Specification node;

    // tcNode may be a MethodArgument for lazy specifier named arguments.
    shared actual formal Tree.SpecifierStatement | Tree.MethodArgument tcNode;

    shared formal FunctionModel | ValueModel declaration;

    shared formal TypedDeclarationModel? refined;
}

shared
class LazySpecificationInfo(shared actual LazySpecification node)
        extends SpecificationInfo() {

    // tcNode may be a MethodArgument for lazy specifier named arguments.
    shared alias TcNodeType => Tree.SpecifierStatement | Tree.MethodArgument;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual FunctionModel | ValueModel declaration {
        assert (is FunctionModel | ValueModel d
            =   switch (tcn = tcNode)
                case (is Tree.SpecifierStatement) tcn.declaration
                else tcn.declarationModel);
        return d;
    }

    shared actual TypedDeclarationModel? refined
        =>  if (is Tree.SpecifierStatement tcn = tcNode)
            then tcn.refined
            else null;
}

shared abstract
class VariableInfo()
        of SpecifiedVariableInfo
            | UnspecifiedVariableInfo
            | TypedVariableInfo
            | VariadicVariableInfo
        extends NodeInfo() {
    shared actual formal Variable node;
}

shared final
class TypedVariableInfo(shared actual TypedVariable node)
        extends VariableInfo() {

    shared actual TcNode tcNode = getTcNode(node);
}

shared final
class SpecifiedVariableInfo(shared actual SpecifiedVariable node)
        extends VariableInfo() {

    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class UnspecifiedVariableInfo(shared actual UnspecifiedVariable node)
        extends VariableInfo() {

    // ForIterator -> VariablePattern -> UnspecifiedVariable
    //      Tree.ValueIterator -> Tree.Variable
    // ForIterator -> ... -> VariablePattern -> UnspecifiedValue
    //      Tree.PatternIterator -> Tree.VariablePattern -> Tree.Variable
    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class VariadicVariableInfo(shared actual VariadicVariable node)
        extends VariableInfo() {

    shared alias TcNodeType => Tree.Variable;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ForFailInfo(shared actual ForFail node)
        extends StatementInfo() {

    shared alias TcNodeType => Tree.ForStatement;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared Boolean exits => tcNode.exits;
}

shared
class ForClauseInfo(shared actual ForClause node)
        extends NodeInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared
class ForIteratorInfo(shared actual ForIterator node)
        extends NodeInfo() {
    // Tree.ForIterator of PatternIterator | ValueIterator
    //
    //   Tree.PatternIterator
    //        Tree.KeyValuePattern -> Pattern (key), Pattern (value)
    //      | Tree.TuplePattern -> List<Pattern>
    //      | Tree.VariablePattern -> Tree.Variable
    // | Tree.ValueIterator -> Tree.Variable

    shared actual TcNode tcNode = getTcNode(node);
}

shared final
class FunctionDeclarationInfo(shared actual FunctionDeclaration node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class FunctionDefinitionInfo(shared actual FunctionDefinition node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class FunctionShortcutDefinitionInfo(shared actual FunctionShortcutDefinition node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class ParameterInfo(shared actual Parameter node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ParameterModel parameterModel => tcNode.parameterModel;
}

shared
class TypeInfo(shared actual Type node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.Type;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared TypeModel typeModel => tcNode.typeModel;
}

shared
class IsConditionInfo(shared actual IsCondition node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.IsCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel variableDeclarationModel => tcNode.variable.declarationModel;
}

shared abstract
class ExistsOrNonemptyConditionInfo()
        of ExistsConditionInfo | NonemptyConditionInfo
        extends NodeInfo() {

    shared actual formal ExistsOrNonemptyCondition node;

    shared actual formal Tree.ExistsOrNonemptyCondition tcNode;

    /*
        tcNode.variable is one of:

        1. a `Tree.Variable` with type `Tree.SyntheticVariable`, or
        2. a `Tree.Variable` with type `Tree.StaticType|Tree.ValueModifier`, or
        3. a `Tree.Destructure`

        For 1, we are testing an existing variable, and will have astNode.tested is
            LIdentifier

        For 2, we are testing and defining a new variable, and will have
            astNode.tested is SpecifiedPattern w/ VariablePattern

        For 3, we are destructuring, and will have
            astNode.tested is SpecifiedPattern w/ TuplePattern | EntryPattern
    */

    "The type of the replacement variable for this [[ExistsOrNonemptyCondition]],
     or [[Null]] if this condition defines a new variable or involves a destructure."
    shared ValueModel? variableDeclarationModel
        // We could leave off the Tree.SyntheticVariable test if we wanted to return
        // declarations for case 2 as well.
        =>  if (is Tree.Variable v = tcNode.variable,
                v.type is Tree.SyntheticVariable)
            then v.declarationModel
            else null;
}

shared final
class ExistsConditionInfo(shared actual ExistsCondition node)
        extends ExistsOrNonemptyConditionInfo() {

    shared alias TcNodeType => Tree.ExistsOrNonemptyCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class NonemptyConditionInfo(shared actual NonemptyCondition node)
        extends ExistsOrNonemptyConditionInfo() {

    shared alias TcNodeType => Tree.ExistsOrNonemptyCondition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
alias ControlClauseNodeType
    =>  CaseClause | CatchClause | DynamicBlock | FinallyClause
            | IfClause | TryClause | While;

shared
class ControlClauseInfo(ControlClauseNodeType tn)
        extends NodeInfo() {

    // FIXME backend bug; tn workaround
    shared actual ControlClauseNodeType node = tn;

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class IsCaseInfo(shared actual IsCase node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.IsCase;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel? variableDeclarationModel => tcNode.variable?.declarationModel;
}

shared
class ElseClauseInfo(shared actual ElseClause node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.ElseClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel? variableDeclarationModel => tcNode.variable?.declarationModel;
}

shared
class IfElseExpressionInfo(shared actual IfElseExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.IfExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel? elseVariableDeclarationModel
        =>  tcNode.elseClause.variable?.declarationModel;
}

shared
class ValueSpecificationInfo(shared actual ValueSpecification node)
        extends SpecificationInfo() {

    shared alias TcNodeType => Tree.SpecifierStatement;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual FunctionModel | ValueModel declaration {
        if (node.qualifier exists) {
            // If qualified with `this`, the `tcNode.declaration` isn't set (for
            // whatever reason).
            assert (is Tree.QualifiedMemberExpression qme = tcNode.baseMemberExpression);
            assert (is FunctionModel | ValueModel result = qme.declaration);
            return result;
        }
        else {
            // tcNode.baseMemberExpression is a Tree.BaseMemberExpression
            assert (is FunctionModel | ValueModel result = tcNode.declaration);
            return result;
        }
    }

    shared actual TypedDeclarationModel refined
        =>  tcNode.refined;

    shared QualifiedExpression | BaseExpression target {
        assert (is Tree.BaseMemberExpression | Tree.QualifiedMemberExpression
                baseMemberExpression = tcNode.baseMemberExpression);

        assert (is QualifiedExpression | BaseExpression result =
                primaryToCeylon(baseMemberExpression, augmentNode));

        return result;
    }
}

shared
class InvocationInfo(shared actual Invocation node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.InvocationExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class TypeDeclarationInfo()
        of ClassOrInterfaceDefinitionInfo | TypeAliasDefinitionInfo
        extends DeclarationInfo() {

    shared actual formal TypeDeclaration node;

    shared actual default
    TypeDeclarationModel declarationModel {
        assert (is TypeDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared final
class TypeAliasDefinitionInfo(shared actual TypeAliasDefinition node)
        extends TypeDeclarationInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class ClassOrInterfaceDefinitionInfo()
        of AnyClassInfo | AnyInterfaceInfo
        extends TypeDeclarationInfo() {

    shared actual formal ClassOrInterface node;

    shared actual default
    ClassOrInterfaceModel declarationModel {
        assert (is ClassOrInterfaceModel result = super.declarationModel);
        return result;
    }
}

shared final
class AnyInterfaceInfo(shared actual AnyInterface node)
        extends ClassOrInterfaceDefinitionInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    InterfaceModel declarationModel {
        assert (is InterfaceModel result = super.declarationModel);
        return result;
    }
}

shared final
class AnyClassInfo(shared actual AnyClass node)
        extends ClassOrInterfaceDefinitionInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ClassModel declarationModel {
        assert (is ClassModel result = super.declarationModel);
        return result;
    }
}

shared final
class ConstructorDefinitionInfo(shared actual ConstructorDefinition node)
        extends DeclarationInfo() {

    shared alias TcNodeType => Tree.Constructor;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual FunctionModel declarationModel => tcNode.declarationModel;

    shared ConstructorModel constructorModel => tcNode.constructor;
}

shared abstract
class ExtensionOrConstructionInfo()
        of ConstructionInfo | ExtensionInfo
        extends NodeInfo() {

    shared actual formal ExtensionOrConstruction node;

    shared actual formal Tree.InvocationExpression | Tree.SimpleType tcNode;

    value tcExtendedTypeExpression {
        if (is Tree.InvocationExpression n = tcNode) {
            assert (is Tree.ExtendedTypeExpression result = n.primary);
            return result;
        }
        return null;
    }

    shared
    TypeModel | TypedReferenceModel? target {
        assert(is TypeModel | TypedReferenceModel | Null result
            =   tcExtendedTypeExpression?.target);
        return result;
    }

    // we *could* fall back to SimpleType.declarationModel, for class extends clauses for
    // classes w/constructors.
    shared default
    ClassModel | ConstructorModel | Null declaration {
        assert (is ClassModel | ConstructorModel | Null result
            =   tcExtendedTypeExpression?.declaration);
        return result;
    }

    shared default List<TypeModel>? signature
        =>  if (exists s = tcExtendedTypeExpression?.signature)
            then CeylonList(s)
            else null;

    "Appears to be the same as `target.fullType`; a Callable."
    shared default TypeModel? typeModel
        =>  tcExtendedTypeExpression?.typeModel;
}

shared final
class ExtensionInfo(shared actual Extension node)
        extends ExtensionOrConstructionInfo() {

    shared alias TcNodeType => Tree.InvocationExpression | Tree.SimpleType;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ClassModel? declaration {
        assert (is ClassModel? result = super.declaration);
        return result;
    }
}

shared final
class ConstructionInfo(shared actual Construction node)
        extends ExtensionOrConstructionInfo() {

    shared alias TcNodeType => Tree.InvocationExpression | Tree.SimpleType;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ConstructorModel declaration {
        assert (is ConstructorModel result = super.declaration);
        return result;
    }

    shared actual
    List<TypeModel> signature {
        assert (exists result = super.signature);
        return result;
    }

    shared actual
    TypeModel typeModel {
        assert (exists result = super.typeModel);
        return result;
    }
}

shared
class OuterInfo(shared actual Outer node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.Outer;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class SuperInfo(shared actual Super node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.Super;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class ThisInfo(shared actual This node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.This;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class TypeNameWithTypeArgumentsInfo(shared actual TypeNameWithTypeArguments node)
        extends NodeInfo() {

    shared alias TcNodeType
        =>  Tree.SimpleType | Tree.BaseTypeExpression | Tree.QualifiedTypeExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default TypeDeclarationModel declarationModel {
        switch (tcNode)
        case (is Tree.SimpleType) {
            return tcNode.declarationModel;
        }
        case (is Tree.BaseTypeExpression) {
            assert (is TypeDeclarationModel result = tcNode.declaration);
            return result;
        }
        case (is Tree.QualifiedTypeExpression) {
            assert  (is TypeDeclarationModel result = tcNode.declaration);
            return result;
        }
    }
}

TcNode getTcNode(Node astNode) {
    assert (exists node = astNode.get(keys.tcNode));
    return node;
}
