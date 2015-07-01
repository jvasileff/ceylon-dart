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
    AnyInterfaceDefinition,
    TypeDeclaration,
    Declaration,
    ClassOrInterface,
    AnyInterface,
    AnyClass
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

class NodeInfo<out NodeType>(shared NodeType node)
        given NodeType satisfies Node {

    value tcNode = assertedTcNode<TcNode>(node);
    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    shared String location => tcNode.location;
    shared ScopeModel scope => tcNode.scope;
    shared {Message*} errors => CeylonList(tcNode.errors);
    shared void addError(String string) => tcNode.addError(string);
    shared void addUnexpectedError(String string) => tcNode.addUnexpectedError(string);
    shared void addUnsupportedError(String string) => tcNode.addUnsupportedError(string);
}

class ExpressionInfo<out NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType satisfies Expression {

    value tcNode = assertedTcNode<Tree.Term>(node);

    "The type of this expression"
    shared TypeModel typeModel => tcNode.typeModel;
}

class BaseExpressionInfo(BaseExpression node)
        extends ExpressionInfo<BaseExpression>(node) {

    value tcNode = assertedTcNode<Tree.StaticMemberOrTypeExpression>(node);

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

class QualifiedExpressionInfo(QualifiedExpression node)
        extends ExpressionInfo<QualifiedExpression>(node) {

    value tcNode = assertedTcNode<Tree.QualifiedMemberOrTypeExpression>(node);

    // MemberOrTypeExpression

    "The declaration and type arguments of the target
     of the QualifiedExpression"
    shared ReferenceModel target => tcNode.target;

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

class DeclarationInfo<out NodeType>(NodeType node)
        extends NodeInfo<Declaration>(node)
        given NodeType satisfies Declaration {

    value tcNode = assertedTcNode<Tree.Declaration>(node);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

class TypedDeclarationInfo<out NodeType>(NodeType node)
        extends DeclarationInfo<TypedDeclaration>(node)
        given NodeType satisfies TypedDeclaration {

    shared actual default
    TypedDeclarationModel declarationModel {
        assert (is TypedDeclarationModel result = super.declarationModel);
        return result;
    }
}

class AnyValueInfo<out NodeType>(NodeType node)
        extends TypedDeclarationInfo<NodeType>(node)
        given NodeType satisfies AnyValue {

    value tcNode = assertedTcNode<Tree.AttributeDeclaration>(node);

    shared actual default
    ValueModel declarationModel => tcNode.declarationModel;
}

class ValueDefinitionInfo(ValueDefinition node)
        extends AnyValueInfo<ValueDefinition>(node) {}

class ValueDeclarationInfo(ValueDeclaration node)
        extends AnyValueInfo<ValueDeclaration>(node) {}

class ValueGetterDefinitionInfo(ValueGetterDefinition node)
        extends AnyValueInfo<ValueGetterDefinition>(node) {}

class ArgumentListInfo(ArgumentList node)
        extends NodeInfo<ArgumentList>(node) {

    value tcNode = assertedTcNode<Tree.SequencedArgument>(node);

    // what's this for?
    shared ParameterModel? parameter => tcNode.parameter;

    // FIXME last argument may be JSpreadArgument or JComprehension
    // see ceylon.ast.redhat::argumentListToCeylon code
    // note: arg.parameter will be null when calling a value
    shared {[TypeModel, ParameterModel?]*} listedArgumentModels
        =>  CeylonIterable(tcNode.positionalArguments).map((arg)
                =>  [arg.typeModel, arg.parameter else null]);
}

abstract
class AnyFunctionInfo<out NodeType>(NodeType node)
        extends TypedDeclarationInfo<NodeType>(node)
        given NodeType satisfies AnyFunction {

    shared actual formal FunctionModel declarationModel;
}

class FunctionExpressionInfo(FunctionExpression node)
        extends ExpressionInfo<FunctionExpression>(node) {

    value tcNode = assertedTcNode<Tree.FunctionArgument>(node);
    shared FunctionModel declarationModel => tcNode.declarationModel;
}

class FunctionDeclarationInfo(FunctionDeclaration node)
        extends AnyFunctionInfo<FunctionDeclaration>(node) {

    value tcNode = assertedTcNode<Tree.MethodDeclaration>(node);
    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

class FunctionDefinitionInfo(FunctionDefinition node)
        extends AnyFunctionInfo<FunctionDefinition>(node) {

    value tcNode = assertedTcNode<Tree.MethodDefinition>(node);
    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

class FunctionShortcutDefinitionInfo(FunctionShortcutDefinition node)
        extends AnyFunctionInfo<FunctionShortcutDefinition>(node) {

    value tcNode = assertedTcNode<Tree.MethodDeclaration>(node);
    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

class ParameterInfo<out NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType satisfies Parameter {

    value tcNode = assertedTcNode<Tree.Parameter>(node);

    shared ParameterModel parameterModel => tcNode.parameterModel;
}

class TypeInfo<out NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType satisfies Type {

    value tcNode = assertedTcNode<Tree.Type>(node);

    shared TypeModel typeModel => tcNode.typeModel;
}

class IsConditionInfo(IsCondition node)
        extends NodeInfo<IsCondition>(node) {

    value tcNode = assertedTcNode<Tree.IsCondition>(node);

    shared ValueModel variableDeclarationModel => tcNode.variable.declarationModel;
}

class ControlClauseInfo<NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType of CaseClause | CatchClause | ComprehensionClause
                | DynamicBlock | ElseClause | FinallyClause | ForClause
                | IfClause | LetExpression | TryClause | While
         satisfies Node  {

    value tcNode = assertedTcNode<Tree.ControlClause>(node);

    shared ControlBlockModel controlBlock => tcNode.controlBlock;
}

class ComprehensionClauseInfo<NodeType>(NodeType node)
        extends ControlClauseInfo<NodeType>(node)
        given NodeType satisfies ComprehensionClause {

    value tcNode = assertedTcNode<Tree.ComprehensionClause>(node);

    shared TypeModel typeModel => tcNode.typeModel;
    shared TypeModel firstTypeModel => tcNode.firstTypeModel;
}

class ValueSpecificationInfo(ValueSpecification node)
        extends NodeInfo<ValueSpecification>(node) {

    value tcNode = assertedTcNode<Tree.SpecifierStatement>(node);
    shared ValueModel declaration {
        assert (is ValueModel result = tcNode.declaration);
        return result;
    }
    //shared TypedDeclarationModel? refined => tcNode.refined;
}

class InvocationInfo<NodeType>(NodeType node)
        extends ExpressionInfo<NodeType>(node)
        given NodeType satisfies Invocation {

    //value tcNode = assertedTcNode<Tree.InvocationExpression>(node);
}

class TypeDeclarationInfo<out NodeType>(NodeType node)
        extends DeclarationInfo<TypeDeclaration>(node)
        given NodeType satisfies TypeDeclaration {

    shared actual default
    TypeDeclarationModel declarationModel {
        assert (is TypeDeclarationModel result = super.declarationModel);
        return result;
    }
}

class ClassOrInterfaceDefinitionInfo<NodeType>(NodeType node)
        extends TypeDeclarationInfo<NodeType>(node)
        given NodeType satisfies ClassOrInterface {


    shared actual default
    ClassOrInterfaceModel declarationModel {
        assert (is ClassOrInterfaceModel result = super.declarationModel);
        return result;
    }
}

class AnyInterfaceInfo<NodeType>(NodeType node)
        extends TypeDeclarationInfo<NodeType>(node)
        given NodeType satisfies AnyInterface {


    shared actual default
    InterfaceModel declarationModel {
        assert (is InterfaceModel result = super.declarationModel);
        return result;
    }
}

class AnyClassInfo<NodeType>(NodeType node)
        extends TypeDeclarationInfo<NodeType>(node)
        given NodeType satisfies AnyClass {

    shared actual default
    ClassModel declarationModel {
        assert (is ClassModel result = super.declarationModel);
        return result;
    }
}

TcNodeType assertedTcNode<TcNodeType>(Node node)
        given TcNodeType satisfies TcNode {
    assert (is TcNodeType tcNode = node.get(keys.tcNode));
    return tcNode;
}
