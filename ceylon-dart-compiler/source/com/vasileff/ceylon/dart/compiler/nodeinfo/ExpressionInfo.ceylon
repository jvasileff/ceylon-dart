import ceylon.ast.core {
    Expression,
    BaseExpression,
    QualifiedExpression,
    FunctionExpression,
    Invocation,
    ObjectExpression,
    This,
    Outer,
    Super,
    IfElseExpression
}
import com.redhat.ceylon.compiler.typechecker.tree {
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    TypeModel=Type,
    TypedReferenceModel=TypedReference,
    DeclarationModel=Declaration,
    FunctionModel=Function,
    ClassModel=Class,
    TypeDeclarationModel=TypeDeclaration,
    ValueModel=Value
}
import ceylon.interop.java {
    CeylonList
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
    shared Boolean staticMethodReferencePrimary => tcNode.staticMethodReferencePrimary;
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
class InvocationInfo(shared actual Invocation node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.InvocationExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
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
