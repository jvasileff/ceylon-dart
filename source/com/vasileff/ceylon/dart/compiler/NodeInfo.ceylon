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
    Parameter
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree,
    Message
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    TypedDeclarationModel=TypedDeclaration,
    ReferenceModel=Reference,
    TypeModel=Type,
    FunctionModel=Function,
    ParameterModel=Parameter,
    ValueModel=Value,
    TypedReferenceModel=TypedReference,
    Scope
}

class NodeInfo<out NodeType>(shared NodeType node)
        given NodeType satisfies Node {

    value tcNode = assertedTcNode<TcNode>(node);
    shared String location => tcNode.location;
    shared Scope scope => tcNode.scope;
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
    shared TypeModel? typeModel => tcNode.typeModel;
}

class BaseExpressionInfo(BaseExpression node)
        extends ExpressionInfo<BaseExpression>(node) {

    value tcNode = assertedTcNode<Tree.StaticMemberOrTypeExpression>(node);

    // MemberOrTypeExpression

    "The declaration and type arguments of the target
     of the BaseExpression"
    shared ReferenceModel? target => tcNode.target;

    "The declaration of the target of the BaseExpression"
    shared DeclarationModel? declaration => tcNode.declaration;

    shared
    {TypeModel*}? signature
        =>  if (exists sig = tcNode.signature)
            then CeylonList(sig)
            else null;

    // StaticMemberOrTypeExpression

    shared TypedReferenceModel? targetParameter => tcNode.targetParameter;
    shared TypeModel? parameterType => tcNode.parameterType;
}

class TypedDeclarationInfo<out NodeType>(NodeType node)
        extends NodeInfo<TypedDeclaration>(node)
        given NodeType satisfies TypedDeclaration {

    value tcNode = assertedTcNode<Tree.TypedDeclaration>(node);
    shared default TypedDeclarationModel? declarationModel => tcNode.declarationModel;
}

abstract
class AnyFunctionInfo<out NodeType>(NodeType node)
        extends TypedDeclarationInfo<NodeType>(node)
        given NodeType satisfies AnyFunction {

    shared actual formal FunctionModel? declarationModel;
}

class FunctionExpressionInfo(FunctionExpression node)
        extends ExpressionInfo<FunctionExpression>(node) {

    value tcNode = assertedTcNode<Tree.FunctionArgument>(node);
    shared FunctionModel? declarationModel => tcNode.declarationModel;
}

class FunctionDeclarationInfo(FunctionDeclaration node)
        extends AnyFunctionInfo<FunctionDeclaration>(node) {

    value tcNode = assertedTcNode<Tree.MethodDeclaration>(node);
    shared actual FunctionModel? declarationModel => tcNode.declarationModel;
}

class FunctionDefinitionInfo(FunctionDefinition node)
        extends AnyFunctionInfo<FunctionDefinition>(node) {

    value tcNode = assertedTcNode<Tree.MethodDefinition>(node);
    shared actual FunctionModel? declarationModel => tcNode.declarationModel;
}

class FunctionShortcutDefinitionInfo(FunctionShortcutDefinition node)
        extends AnyFunctionInfo<FunctionShortcutDefinition>(node) {

    value tcNode = assertedTcNode<Tree.MethodDeclaration>(node);
    shared actual FunctionModel? declarationModel => tcNode.declarationModel;
}

class ParameterInfo<out NodeType>(NodeType node)
        extends NodeInfo<NodeType>(node)
        given NodeType satisfies Parameter {

    value tcNode = assertedTcNode<Tree.Parameter>(node);

    shared ParameterModel? parameterModel => tcNode.parameterModel;
}

class ValueDefinitionInfo(ValueDefinition node)
        extends NodeInfo<ValueDefinition>(node) {

    value tcNode = assertedTcNode<Tree.AttributeDeclaration>(node);
    shared ValueModel? declarationModel => tcNode.declarationModel;
}

TcNodeType assertedTcNode<TcNodeType>(Node node)
        given TcNodeType satisfies TcNode {
    assert (is TcNodeType tcNode = node.get(keys.tcNode));
    return tcNode;
}