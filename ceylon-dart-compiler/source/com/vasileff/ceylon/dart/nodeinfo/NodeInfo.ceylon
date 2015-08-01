import ceylon.ast.core {
    BaseExpression,
    Node,
    ValueDefinition,
    FunctionExpression,
    Expression,
    FunctionDefinition,
    TypedDeclaration,
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
    LetExpression,
    TryClause,
    While,
    ValueSpecification,
    Invocation,
    QualifiedExpression,
    ValueDeclaration,
    AnyValue,
    ValueGetterDefinition,
    TypeDeclaration,
    Declaration,
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
    Outer
}
import ceylon.interop.java {
    CeylonList,
    CeylonIterable
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
    ReferenceModel=Reference,
    TypeModel=Type,
    FunctionModel=Function,
    ParameterModel=Parameter,
    ValueModel=Value,
    TypedReferenceModel=TypedReference,
    ControlBlockModel=ControlBlock,
    ScopeModel=Scope
}

import org.antlr.runtime {
    Token
}


shared
class NodeInfo(Node astNode) {

    shared default Node node => astNode;
    value tcNode = assertedTcNode<TcNode>(astNode);

    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    // FIXME location and filename doesn't work for ArgumentListInfo
    // https://github.com/ceylon/ceylon-spec/issues/1385
    shared String location => tcNode.location;
    shared String filename => tcNode.unit?.filename else "unknown file";

    shared ScopeModel scope => tcNode.scope;
    shared {Message*} errors => CeylonList(tcNode.errors);
    shared void addError(String string) => tcNode.addError(string);
    shared void addUnexpectedError(String string) => tcNode.addUnexpectedError(string);
    shared void addUnsupportedError(String string) => tcNode.addUnsupportedError(string);
}

shared
class ExpressionInfo(Expression astNode)
        extends NodeInfo(astNode) {

    shared actual default Expression node => astNode;
    value tcNode = assertedTcNode<Tree.Term>(astNode);

    "The type of this expression"
    shared TypeModel typeModel => tcNode.typeModel;
}

shared
class BaseExpressionInfo(BaseExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default BaseExpression node => astNode;
    value tcNode = assertedTcNode<Tree.StaticMemberOrTypeExpression>(astNode);

    // MemberOrTypeExpression

    "The declaration and type arguments of the target
     of the BaseExpression"
    shared ReferenceModel target => tcNode.target;

    "The declaration of the target of the BaseExpression"
    shared DeclarationModel declaration => tcNode.declaration;

    shared
    {TypeModel*}? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    shared TypedReferenceModel? targetParameter => tcNode.targetParameter;
    shared TypeModel? parameterType => tcNode.parameterType;
}

shared
class QualifiedExpressionInfo(QualifiedExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default QualifiedExpression node => astNode;
    value tcNode = assertedTcNode<Tree.QualifiedMemberOrTypeExpression>(astNode);

    // MemberOrTypeExpression

    "The declaration and type arguments of the target
     of the QualifiedExpression"
    shared TypedReferenceModel target {
        assert (is TypedReferenceModel result = tcNode.target);
        return result;
    }

    "The declaration of the target of the QualifiedExpression"
    shared DeclarationModel declaration => tcNode.declaration;

    "If being invoked, the signature (parameters)."
    shared
    {TypeModel*}? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    "If being passed as an argument, the parameter."
    shared TypedReferenceModel? targetParameter => tcNode.targetParameter;

    "If being passed as an argument, the parameter type."
    shared TypeModel? parameterType => tcNode.parameterType;
}

shared
class DeclarationInfo(Declaration astNode)
        extends NodeInfo(astNode) {

    shared actual default Declaration node => astNode;
    value tcNode = assertedTcNode<Tree.Declaration>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class TypedDeclarationInfo(TypedDeclaration astNode)
        extends DeclarationInfo(astNode) {

    shared actual default TypedDeclaration node => astNode;

    shared actual default
    TypedDeclarationModel declarationModel {
        assert (is TypedDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared
class AnyValueInfo(AnyValue astNode)
        extends TypedDeclarationInfo(astNode) {

    shared actual default AnyValue node => astNode;
    value tcNode = assertedTcNode<Tree.AttributeDeclaration>(astNode);

    shared actual default
    ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ValueDefinitionInfo(ValueDefinition astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueDefinition node => astNode;
}

shared
class ValueDeclarationInfo(ValueDeclaration astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueDeclaration node => astNode;
}

shared
class ValueGetterDefinitionInfo(ValueGetterDefinition astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueGetterDefinition node => astNode;
}

shared
class ArgumentListInfo(ArgumentList astNode)
        extends NodeInfo(astNode) {

    shared actual default ArgumentList node => astNode;
    value tcNode = assertedTcNode<Tree.SequencedArgument>(astNode);

    // what's this for?
    shared ParameterModel? parameter => tcNode.parameter;

    // FIXME last argument may be JSpreadArgument or JComprehension
    // see ceylon.ast.redhat::argumentListToCeylon code
    "A stream of pairs containing each argument's type and corresponding parameter.
     The parameter will be null for invocations on values."
    shared {[TypeModel, ParameterModel?]*} listedArgumentModels
        =>  CeylonIterable(tcNode.positionalArguments).map((arg)
                =>  [arg.typeModel, arg.parameter else null]);
}

shared
class FunctionExpressionInfo(FunctionExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default FunctionExpression node => astNode;
    value tcNode = assertedTcNode<Tree.FunctionArgument>(astNode);
    shared FunctionModel declarationModel => tcNode.declarationModel;
}

shared
class AnyFunctionInfo(AnyFunction astNode)
        extends TypedDeclarationInfo(astNode) {

    shared actual default AnyFunction node => astNode;
    value tcNode = assertedTcNode<Tree.AnyMethod>(astNode);
    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

"Tree.ExecutableStatement"
shared
class StatementInfo(Statement astNode)
        extends NodeInfo(astNode) {

    shared actual default Statement node => astNode;
}

shared
class VariableInfo(Variable astNode)
        extends NodeInfo(astNode) {

    shared actual default Variable node => astNode;
}

shared
class UnspecifiedVariableInfo(UnspecifiedVariable astNode)
        extends VariableInfo(astNode) {

    // ForIterator -> VariablePattern -> UnspecifiedVariable
    //      Tree.ValueIterator -> Tree.Variable
    // ForIterator -> ... -> VariablePattern -> UnspecifiedValue
    //      Tree.PatternIterator -> Tree.VariablePattern -> Tree.Variable

    shared actual default UnspecifiedVariable node => astNode;
    value tcNode = assertedTcNode<Tree.Variable>(astNode);
    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ForFailInfo(ForFail astNode)
        extends StatementInfo(astNode) {

    shared actual default ForFail node => astNode;
}

shared
class ForClauseInfo(ForClause astNode)
        extends NodeInfo(astNode) {

    shared actual default ForClause node => astNode;
}

shared
class ForIteratorInfo(ForIterator astNode)
        extends NodeInfo(astNode) {

    shared actual default ForIterator node => astNode;

    // Tree.ForIterator of PatternIterator | ValueIterator
    //
    //   Tree.PatternIterator
    //        Tree.KeyValuePattern -> Pattern (key), Pattern (value)
    //      | Tree.TuplePattern -> List<Pattern>
    //      | Tree.VariablePattern -> Tree.Variable
    // | Tree.ValueIterator -> Tree.Variable
}

shared
class FunctionDeclarationInfo(FunctionDeclaration astNode)
        extends AnyFunctionInfo(astNode) {

    shared actual default AnyFunction node => astNode;
}

shared
class FunctionDefinitionInfo(FunctionDefinition astNode)
        extends AnyFunctionInfo(astNode) {

    shared actual default FunctionDefinition node => astNode;
}

shared
class FunctionShortcutDefinitionInfo(FunctionShortcutDefinition astNode)
        extends AnyFunctionInfo(astNode) {}

shared
class ParameterInfo(Parameter astNode)
        extends NodeInfo(astNode) {

    shared actual default Parameter node => astNode;
    value tcNode = assertedTcNode<Tree.Parameter>(astNode);

    shared ParameterModel parameterModel => tcNode.parameterModel;
}

shared
class TypeInfo(Type astNode)
        extends NodeInfo(astNode) {

    shared actual default Type node => astNode;
    value tcNode = assertedTcNode<Tree.Type>(astNode);

    shared TypeModel typeModel => tcNode.typeModel;
}

shared
class IsConditionInfo(IsCondition astNode)
        extends NodeInfo(astNode) {

    shared actual default IsCondition node => astNode;
    value tcNode = assertedTcNode<Tree.IsCondition>(astNode);

    shared ValueModel variableDeclarationModel => tcNode.variable.declarationModel;
}

shared
alias ControlClauseNodeType => CaseClause | CatchClause | ComprehensionClause |
        DynamicBlock | ElseClause | FinallyClause | ForClause |
        IfClause | LetExpression | TryClause | While;

shared
class ControlClauseInfo(ControlClauseNodeType astNode)
        extends NodeInfo(astNode) {

    shared actual default ControlClauseNodeType node => astNode;
    value tcNode = assertedTcNode<Tree.ControlClause>(astNode);

    shared ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class ComprehensionClauseInfo(ComprehensionClause astNode)
        extends ControlClauseInfo(astNode) {

    shared actual default ComprehensionClause node => astNode;
    value tcNode = assertedTcNode<Tree.ComprehensionClause>(astNode);

    shared TypeModel typeModel => tcNode.typeModel;
    shared TypeModel firstTypeModel => tcNode.firstTypeModel;
}

shared
class ValueSpecificationInfo(ValueSpecification astNode)
        extends NodeInfo(astNode) {

    shared actual default ValueSpecification node => astNode;
    value tcNode = assertedTcNode<Tree.SpecifierStatement>(astNode);
    shared ValueModel declaration {
        assert (is ValueModel result = tcNode.declaration);
        return result;
    }
    //shared TypedDeclarationModel? refined => tcNode.refined;
}

shared
class InvocationInfo(Invocation astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Invocation node => astNode;
    //value tcNode = assertedTcNode<Tree.InvocationExpression>(node);
}

shared
class TypeDeclarationInfo(TypeDeclaration astNode)
        extends DeclarationInfo(astNode) {

    shared actual default TypeDeclaration node => astNode;

    shared actual default
    TypeDeclarationModel declarationModel {
        assert (is TypeDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared
class ClassOrInterfaceDefinitionInfo(ClassOrInterface astNode)
        extends TypeDeclarationInfo(astNode) {

    shared actual default ClassOrInterface node => astNode;

    shared actual default
    ClassOrInterfaceModel declarationModel {
        assert (is ClassOrInterfaceModel result = super.declarationModel);
        return result;
    }
}

shared
class AnyInterfaceInfo(AnyInterface astNode)
        extends TypeDeclarationInfo(astNode) {

    shared actual default AnyInterface node => astNode;

    shared actual default
    InterfaceModel declarationModel {
        assert (is InterfaceModel result = super.declarationModel);
        return result;
    }
}

shared
class AnyClassInfo(AnyClass astNode)
        extends TypeDeclarationInfo(astNode) {

    shared actual default AnyClass node => astNode;

    shared actual default
    ClassModel declarationModel {
        assert (is ClassModel result = super.declarationModel);
        return result;
    }
}

shared
class OuterInfo(Outer astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Outer node => astNode;

    value tcNode = assertedTcNode<Tree.Outer>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class SuperInfo(Super astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Super node => astNode;

    value tcNode = assertedTcNode<Tree.Super>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class ThisInfo(This astNode)
        extends ExpressionInfo(astNode) {

    shared actual default This node => astNode;

    value tcNode = assertedTcNode<Tree.This>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

TcNodeType assertedTcNode<TcNodeType>(Node astNode)
        given TcNodeType satisfies TcNode {
    assert (is TcNodeType tcNode = astNode.get(keys.tcNode));
    return tcNode;
}
