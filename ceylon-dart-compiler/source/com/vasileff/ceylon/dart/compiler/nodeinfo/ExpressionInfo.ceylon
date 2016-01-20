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
    IfElseExpression,
    Operation,
    Atom,
    Package,
    SwitchCaseElseExpression,
    AliasDec,
    ComplementOperation,
    ThenOperation,
    NotOperation,
    CompareOperation,
    ScaleOperation,
    MultiplyAssignmentOperation,
    StringLiteral,
    RemainderAssignmentOperation,
    SumOperation,
    AndAssignmentOperation,
    AssignOperation,
    EqualOperation,
    OfOperation,
    LargeAsOperation,
    PrefixIncrementOperation,
    IntersectAssignmentOperation,
    ArithmeticAssignmentOperation,
    IdentityOperation,
    DivideAssignmentOperation,
    PrefixOperation,
    PostfixDecrementOperation,
    GroupedExpression,
    MemberMeta,
    AndOperation,
    MeasureOperation,
    ElseOperation,
    SetAssignmentOperation,
    AssignmentOperation,
    FloatLiteral,
    Meta,
    UnaryOperation,
    UnaryArithmeticOperation,
    EqualityOperation,
    Dec,
    ComparisonOperation,
    InOperation,
    ComplementAssignmentOperation,
    UnionOperation,
    RemainderOperation,
    FunctionDec,
    GivenDec,
    ProductOperation,
    NegationOperation,
    PostfixIncrementOperation,
    ValueDec,
    PackageDec,
    DifferenceOperation,
    ModuleDec,
    BinaryOperation,
    TypeMeta,
    SpanOperation,
    PrefixDecrementOperation,
    Iterable,
    OrAssignmentOperation,
    ElementOrSubrangeExpression,
    IsOperation,
    InterfaceDec,
    QuotientOperation,
    WithinOperation,
    MemberDec,
    SmallAsOperation,
    AddAssignmentOperation,
    DynamicValue,
    SmallerOperation,
    ExistsOperation,
    OrOperation,
    UnaryIshOperation,
    ArithmeticOperation,
    LogicalAssignmentOperation,
    UnionAssignmentOperation,
    ConstructorDec,
    ExponentiationOperation,
    IdenticalOperation,
    LogicalOperation,
    NonemptyOperation,
    IntegerLiteral,
    StringTemplate,
    CharacterLiteral,
    IntersectionOperation,
    ClassDec,
    PostfixOperation,
    BaseMeta,
    Tuple,
    Literal,
    SubtractAssignmentOperation,
    LargerOperation,
    SetOperation,
    NotEqualOperation,
    EntryOperation,
    TypeDec,
    UnaryTypeOperation,
    LetExpression
}
import ceylon.interop.java {
    CeylonList
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

shared abstract
class ExpressionInfo()
        of  ValueExpressionInfo | FunctionExpressionInfo
            | LetExpressionInfo | ConditionalExpressionInfo
        extends NodeInfo() {

    shared actual formal Expression node;

    shared actual formal Tree.Term tcNode;

    "The type of this expression"
    shared TypeModel typeModel => tcNode.typeModel;
}

shared abstract
class ValueExpressionInfo()
        of PrimaryInfo | OperationInfo
        extends ExpressionInfo() {}

shared abstract
class PrimaryInfo()
        of  AtomInfo | BaseExpressionInfo | QualifiedExpressionInfo | InvocationInfo
            | DefaultPrimaryInfo
        extends ValueExpressionInfo() {}

shared
class DefaultPrimaryInfo(shared actual Expression node)
        //of MetaInfo | DecInfo | ElementOrSubrangeExpressionInfo
        extends PrimaryInfo() {

    shared alias TcNodeType => Tree.Term;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class OperationInfo()
        of DefaultOperationInfo
        extends ValueExpressionInfo() {}

shared
class DefaultOperationInfo(shared actual Operation node)
        // of UnaryIshOperation | BinaryOperation | WithinOperation
        extends OperationInfo() {

    shared alias TcNodeType => Tree.Term;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class AtomInfo()
        of ObjectExpressionInfo | SelfReferenceInfo | DefaultAtomInfo
        extends PrimaryInfo() {}

shared
class DefaultAtomInfo(shared actual Atom node)
        //of LiteralInfo | StringTemplateInfo | GroupedExpressionInfo
        //   | IterableInfo | TupleInfo | DynamicValueInfo
        extends AtomInfo() {

    shared alias TcNodeType => Tree.Term;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class LetExpressionInfo(shared actual LetExpression node)
        extends ExpressionInfo() {

    shared alias TcNodeType => Tree.Term;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class SelfReferenceInfo()
        of ThisInfo | SuperInfo | OuterInfo | PackageInfo
        extends AtomInfo() {}

shared
class ThisInfo(shared actual This node)
        extends SelfReferenceInfo() {

    shared alias TcNodeType => Tree.This;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class SuperInfo(shared actual Super node)
        extends SelfReferenceInfo() {

    shared alias TcNodeType => Tree.Super;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class OuterInfo(shared actual Outer node)
        extends SelfReferenceInfo() {

    shared alias TcNodeType => Tree.Outer;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class PackageInfo(shared actual Package node)
        extends SelfReferenceInfo() {

    shared alias TcNodeType => Tree.Package;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class BaseExpressionInfo(shared actual BaseExpression node)
        extends PrimaryInfo() {

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

shared abstract
class ConditionalExpressionInfo()
        of IfElseExpressionInfo | SwitchCaseElseExpressionInfo
        extends ExpressionInfo() {}

shared
class IfElseExpressionInfo(shared actual IfElseExpression node)
        extends ConditionalExpressionInfo() {

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
class SwitchCaseElseExpressionInfo(shared actual SwitchCaseElseExpression node)
        extends ConditionalExpressionInfo() {

    shared alias TcNodeType => Tree.SwitchExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class InvocationInfo(shared actual Invocation node)
        extends PrimaryInfo() {

    shared alias TcNodeType => Tree.InvocationExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class ObjectExpressionInfo(shared actual ObjectExpression node)
        extends AtomInfo() {

    shared alias TcNodeType => Tree.ObjectExpression;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class QualifiedExpressionInfo(shared actual QualifiedExpression node)
        extends PrimaryInfo() {

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

shared class BinaryOperationInfo(BinaryOperation that) => DefaultOperationInfo(that);

shared class ArithmeticOperationInfo(ArithmeticOperation that) => BinaryOperationInfo(that);
shared class DifferenceOperationInfo(DifferenceOperation that) => ArithmeticOperationInfo(that);
shared class ExponentiationOperationInfo(ExponentiationOperation that) => ArithmeticOperationInfo(that);
shared class ProductOperationInfo(ProductOperation that) => ArithmeticOperationInfo(that);
shared class QuotientOperationInfo(QuotientOperation that) => ArithmeticOperationInfo(that);
shared class RemainderOperationInfo(RemainderOperation that) => ArithmeticOperationInfo(that);
shared class SumOperationInfo(SumOperation that) => ArithmeticOperationInfo(that);

shared class ArithmeticAssignmentOperationInfo(ArithmeticAssignmentOperation that) => AssignmentOperationInfo(that);
shared class AddAssignmentOperationInfo(AddAssignmentOperation that) => ArithmeticAssignmentOperationInfo(that);
shared class DivideAssignmentOperationInfo(DivideAssignmentOperation that) => ArithmeticAssignmentOperationInfo(that);
shared class MultiplyAssignmentOperationInfo(MultiplyAssignmentOperation that) => ArithmeticAssignmentOperationInfo(that);
shared class RemainderAssignmentOperationInfo(RemainderAssignmentOperation that) => ArithmeticAssignmentOperationInfo(that);
shared class SubtractAssignmentOperationInfo(SubtractAssignmentOperation that) => ArithmeticAssignmentOperationInfo(that);

shared class AssignOperationInfo(AssignOperation that) => BinaryOperationInfo(that);

shared class AssignmentOperationInfo(AssignmentOperation that) => BinaryOperationInfo(that);
shared class LogicalAssignmentOperationInfo(LogicalAssignmentOperation that) => AssignmentOperationInfo(that);

shared class AndAssignmentOperationInfo(AndAssignmentOperation that) => LogicalAssignmentOperationInfo(that);
shared class OrAssignmentOperationInfo(OrAssignmentOperation that) => LogicalAssignmentOperationInfo(that);

shared class SetAssignmentOperationInfo(SetAssignmentOperation that) => AssignmentOperationInfo(that);

shared class ComplementAssignmentOperationInfo(ComplementAssignmentOperation that) => SetAssignmentOperationInfo(that);
shared class IntersectAssignmentOperationInfo(IntersectAssignmentOperation that) => SetAssignmentOperationInfo(that);
shared class UnionAssignmentOperationInfo(UnionAssignmentOperation that) => SetAssignmentOperationInfo(that);

shared class CompareOperationInfo(CompareOperation that) => BinaryOperationInfo(that);

shared class ComparisonOperationInfo(ComparisonOperation that) => BinaryOperationInfo(that);
shared class LargeAsOperationInfo(LargeAsOperation that) => ComparisonOperationInfo(that);
shared class LargerOperationInfo(LargerOperation that) => ComparisonOperationInfo(that);
shared class SmallAsOperationInfo(SmallAsOperation that) => ComparisonOperationInfo(that);
shared class SmallerOperationInfo(SmallerOperation that) => ComparisonOperationInfo(that);

shared class ElseOperationInfo(ElseOperation that) => BinaryOperationInfo(that);
shared class EntryOperationInfo(EntryOperation that) => BinaryOperationInfo(that);

shared class EqualityOperationInfo(EqualityOperation that) => BinaryOperationInfo(that);

shared class EqualOperationInfo(EqualOperation that) => EqualityOperationInfo(that);
shared class IdenticalOperationInfo(IdenticalOperation that) => EqualityOperationInfo(that);
shared class NotEqualOperationInfo(NotEqualOperation that) => EqualityOperationInfo(that);

shared class InOperationInfo(InOperation that) => BinaryOperationInfo(that);

shared class LogicalOperationInfo(LogicalOperation that) => BinaryOperationInfo(that);

shared class AndOperationInfo(AndOperation that) => LogicalOperationInfo(that);
shared class OrOperationInfo(OrOperation that) => LogicalOperationInfo(that);

shared class MeasureOperationInfo(MeasureOperation that) => BinaryOperationInfo(that);
shared class ScaleOperationInfo(ScaleOperation that) => BinaryOperationInfo(that);

shared class SetOperationInfo(SetOperation that) => BinaryOperationInfo(that);

shared class ComplementOperationInfo(ComplementOperation that) => SetOperationInfo(that);
shared class IntersectionOperationInfo(IntersectionOperation that) => SetOperationInfo(that);
shared class UnionOperationInfo(UnionOperation that) => SetOperationInfo(that);

shared class SpanOperationInfo(SpanOperation that) => BinaryOperationInfo(that);
shared class ThenOperationInfo(ThenOperation that) => BinaryOperationInfo(that);

shared class UnaryIshOperationInfo(UnaryIshOperation that) => DefaultOperationInfo(that);
shared class UnaryOperationInfo(UnaryOperation that) => UnaryIshOperationInfo(that);

shared class ExistsOperationInfo(ExistsOperation that) => UnaryOperationInfo(that);
shared class NonemptyOperationInfo(NonemptyOperation that) => UnaryOperationInfo(that);
shared class NotOperationInfo(NotOperation that) => UnaryOperationInfo(that);

shared class PostfixOperationInfo(PostfixOperation that) => UnaryOperationInfo(that);

shared class PostfixDecrementOperationInfo(PostfixDecrementOperation that) => PostfixOperationInfo(that);
shared class PostfixIncrementOperationInfo(PostfixIncrementOperation that) => PostfixOperationInfo(that);

shared class PrefixOperationInfo(PrefixOperation that) => UnaryOperationInfo(that);

shared class PrefixDecrementOperationInfo(PrefixDecrementOperation that) => PrefixOperationInfo(that);
shared class PrefixIncrementOperationInfo(PrefixIncrementOperation that) => PrefixOperationInfo(that);

shared class UnaryArithmeticOperationInfo(UnaryArithmeticOperation that) => UnaryOperationInfo(that);
shared class IdentityOperationInfo(IdentityOperation that) => UnaryArithmeticOperationInfo(that);
shared class NegationOperationInfo(NegationOperation that) => UnaryArithmeticOperationInfo(that);

shared class UnaryTypeOperationInfo(UnaryTypeOperation that) => UnaryIshOperationInfo(that);
shared class IsOperationInfo(IsOperation that) => UnaryTypeOperationInfo(that);
shared class OfOperationInfo(OfOperation that) => UnaryTypeOperationInfo(that);

shared class WithinOperationInfo(WithinOperation that) => DefaultOperationInfo(that);

shared class DynamicValueInfo(DynamicValue that) => DefaultAtomInfo(that);
shared class GroupedExpressionInfo(GroupedExpression that) => DefaultAtomInfo(that);
shared class IterableInfo(Iterable that) => DefaultAtomInfo(that);

shared class LiteralInfo(Literal that) => DefaultAtomInfo(that);

shared class CharacterLiteralInfo(CharacterLiteral that) => LiteralInfo(that);
shared class FloatLiteralInfo(FloatLiteral that) => LiteralInfo(that);
shared class IntegerLiteralInfo(IntegerLiteral that) => LiteralInfo(that);
shared class StringLiteralInfo(StringLiteral that) => LiteralInfo(that);

shared class StringTemplateInfo(StringTemplate that) => DefaultAtomInfo(that);
shared class TupleInfo(Tuple that) => DefaultAtomInfo(that);

shared class DecInfo(Dec that) => DefaultPrimaryInfo(that);

shared class ConstructorDecInfo(ConstructorDec that) => DecInfo(that);

shared class MemberDecInfo(MemberDec that) => DecInfo(that);

shared class FunctionDecInfo(FunctionDec that) => MemberDecInfo(that);
shared class ValueDecInfo(ValueDec that) => MemberDecInfo(that);

shared class ModuleDecInfo(ModuleDec that) => DecInfo(that);
shared class PackageDecInfo(PackageDec that) => DecInfo(that);

shared class TypeDecInfo(TypeDec that) => DecInfo(that);

shared class AliasDecInfo(AliasDec that) => TypeDecInfo(that);
shared class ClassDecInfo(ClassDec that) => TypeDecInfo(that);
shared class GivenDecInfo(GivenDec that) => TypeDecInfo(that);
shared class InterfaceDecInfo(InterfaceDec that) => TypeDecInfo(that);

shared class ElementOrSubrangeExpressionInfo(ElementOrSubrangeExpression that) => DefaultPrimaryInfo(that);

shared class MetaInfo(Meta that) => DefaultPrimaryInfo(that);

shared class BaseMetaInfo(BaseMeta that) => MetaInfo(that);
shared class MemberMetaInfo(MemberMeta that) => MetaInfo(that);
shared class TypeMetaInfo(TypeMeta that) => MetaInfo(that);
