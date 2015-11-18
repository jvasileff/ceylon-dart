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
    Construction
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
import com.vasileff.ceylon.dart.compiler.core {
    augmentNode,
    asserted,
    assertExists
}

import org.antlr.runtime {
    Token
}
import com.vasileff.ceylon.dart.compiler {
    DScope
}

shared
class NodeInfo(Node astNode) satisfies DScope {

    shared default Node node => astNode;
    value tcNode = assertedTcNode<TcNode>(astNode);

    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    shared TypecheckerUnit typecheckerUnit = tcNode.unit;

    // FIXME location and filename doesn't work for ArgumentListInfo
    // https://github.com/ceylon/ceylon-spec/issues/1385
    shared actual String location => tcNode.location;
    shared actual String filename => tcNode.unit?.filename else "unknown file";

    shared actual ScopeModel scope => tcNode.scope;
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
class CompilationUnitInfo(CompilationUnit astNode)
        extends NodeInfo(astNode) {

    shared actual default CompilationUnit node => astNode;
    shared Tree.CompilationUnit tcNode = assertedTcNode<Tree.CompilationUnit>(astNode);
}

shared
class BaseExpressionInfo(BaseExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default BaseExpression node => astNode;
    shared Tree.StaticMemberOrTypeExpression tcNode = assertedTcNode<Tree.StaticMemberOrTypeExpression>(astNode);

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
class QualifiedExpressionInfo(QualifiedExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default QualifiedExpression node => astNode;
    value tcNode = assertedTcNode<Tree.QualifiedMemberOrTypeExpression>(astNode);

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
class DeclarationInfo(Declaration astNode)
        extends NodeInfo(astNode) {

    shared actual default Declaration node => astNode;
    value tcNode = assertedTcNode<Tree.Declaration>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

abstract shared
class TypedDeclarationInfo(TypedDeclaration astNode)
        of AnyValueInfo | AnyFunctionInfo
        extends DeclarationInfo(astNode) {

    shared actual default TypedDeclaration node => astNode;

    shared actual default
    TypedDeclarationModel declarationModel {
        assert (is TypedDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared
TypedDeclarationInfo typedDeclarationInfo(TypedDeclaration astNode)
    =>  switch (astNode)
        case (is AnyValue) AnyValueInfo(astNode)
        case (is AnyFunction) AnyFunctionInfo(astNode);

shared
class AnyValueInfo(AnyValue astNode)
        extends TypedDeclarationInfo(astNode) {

    shared actual default AnyValue node => astNode;
    value tcNode = assertedTcNode<Tree.TypedDeclaration>(astNode);

    shared actual default
    ValueModel declarationModel {
        assert (is ValueModel result = tcNode.declarationModel);
        return result;
    }
}

shared
class ValueDefinitionInfo(ValueDefinition astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueDefinition node => astNode;
    value tcNode = assertedTcNode<Tree.AttributeDeclaration>(astNode);

    shared actual default
    ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ValueDeclarationInfo(ValueDeclaration astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueDeclaration node => astNode;
    value tcNode = assertedTcNode<Tree.AttributeDeclaration>(astNode);

    shared actual default
    ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ValueGetterDefinitionInfo(ValueGetterDefinition astNode)
        extends AnyValueInfo(astNode) {

    shared actual default ValueGetterDefinition node => astNode;
    value tcNode = assertedTcNode<Tree.AttributeGetterDefinition>(astNode);

    shared actual default
    ValueModel declarationModel => tcNode.declarationModel;
}

shared
class ValueSetterDefinitionInfo(ValueSetterDefinition astNode)
        extends DeclarationInfo(astNode) {

    shared actual default ValueSetterDefinition node => astNode;
    value tcNode = assertedTcNode<Tree.AttributeSetterDefinition>(astNode);

    shared actual default
    SetterModel declarationModel => tcNode.declarationModel;
}

shared
class ArgumentListInfo(ArgumentList astNode)
        extends NodeInfo(astNode) {

    shared actual default ArgumentList node => astNode;

    // This is probably only Tree.SequenceEnumeration for empty iterables {}
    //
    // It can be Tree.NamedArgumentList for NamedArguments.iterableArgument when
    // no iterableArgument exists.
    value tcNode = assertedTcNode<Tree.SequencedArgument
                                    | Tree.SequenceEnumeration
                                    | Tree.NamedArgumentList>(astNode);

    "The [[ParameterModel]], if this argument list is used as an argument (e.g. within
     [[ceylon.ast.core::NamedArguments]])."
    shared ParameterModel? parameter
            =>  if (is Tree.SequencedArgument tcNode)
                then tcNode.parameter
                else null;
}

shared
NamedArgumentInfo namedArgumentInfo(NamedArgument astNode)
    =>  switch (astNode)
        case (is AnonymousArgument)
            AnonymousArgumentInfo(astNode)
        case (is SpecifiedArgument)
            SpecifiedArgumentInfo(astNode)
        case (is ValueArgument)
            ValueArgumentInfo(astNode)
        case (is FunctionArgument)
            FunctionArgumentInfo(astNode)
        case (is ObjectArgument)
            ObjectArgumentInfo(astNode);

shared abstract
class NamedArgumentInfo(NamedArgument astNode)
        of AnonymousArgumentInfo
            | SpecifiedArgumentInfo
            | InlineDefinitionArgumentInfo
        extends NodeInfo(astNode) {

    shared actual default NamedArgument node
        =>  astNode;

    shared formal Tree.NamedArgument tcNode;
        //=>  assertedTcNode<Tree.NamedArgument>(astNode);

    shared ParameterModel parameter => tcNode.parameter;
}

shared
class AnonymousArgumentInfo(AnonymousArgument astNode)
        extends NamedArgumentInfo(astNode) {

    shared actual default AnonymousArgument node
        =>  astNode;

    shared actual Tree.SpecifiedArgument tcNode
        =>  assertedTcNode<Tree.SpecifiedArgument>(astNode);
}

shared
class SpecifiedArgumentInfo(SpecifiedArgument astNode)
        extends NamedArgumentInfo(astNode) {

    shared actual default SpecifiedArgument node
        =>  astNode;

    shared actual Tree.SpecifiedArgument | Tree.AttributeArgument tcNode
        =>  assertedTcNode<Tree.SpecifiedArgument | Tree.AttributeArgument>(astNode);
}

shared abstract
class InlineDefinitionArgumentInfo(InlineDefinitionArgument astNode)
        of ValueArgumentInfo
            | FunctionArgumentInfo
            | ObjectArgumentInfo
        extends NamedArgumentInfo(astNode) {

    shared actual default InlineDefinitionArgument node
        =>  astNode;
}

shared
class ValueArgumentInfo(ValueArgument astNode)
        extends InlineDefinitionArgumentInfo(astNode) {

    shared actual default ValueArgument node
        =>  astNode;

    shared actual Tree.AttributeArgument tcNode
        =>  assertedTcNode<Tree.AttributeArgument>(astNode);
}

shared
class FunctionArgumentInfo(FunctionArgument astNode)
        extends InlineDefinitionArgumentInfo(astNode) {

    shared actual default FunctionArgument node
        =>  astNode;

    shared actual Tree.MethodArgument tcNode
        =>  assertedTcNode<Tree.MethodArgument>(astNode);

    shared FunctionModel declarationModel
        =>  tcNode.declarationModel;
}

shared
class ObjectArgumentInfo(ObjectArgument astNode)
        extends InlineDefinitionArgumentInfo(astNode) {

    shared actual default ObjectArgument node
        =>  astNode;

    shared actual Tree.ObjectArgument tcNode
        =>  assertedTcNode<Tree.ObjectArgument>(astNode);

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class ComprehensionInfo(Comprehension astNode)
        extends NodeInfo(astNode) {

    shared actual default Comprehension node => astNode;
    value tcNode = assertedTcNode<Tree.Comprehension>(astNode);

    shared TypeModel typeModel => tcNode.typeModel;
    shared ParameterModel? parameter => tcNode.parameter;
}

shared
class ComprehensionClauseInfo(ComprehensionClause astNode)
        extends NodeInfo(astNode) {

    shared actual default ComprehensionClause node => astNode;
    value tcNode = assertedTcNode<Tree.ComprehensionClause>(astNode);

    shared TypeModel typeModel => tcNode.typeModel;
    shared TypeModel firstTypeModel => tcNode.firstTypeModel;
    shared Boolean possiblyEmpty => tcNode.possiblyEmpty;
}

shared
class SpreadArgumentInfo(SpreadArgument astNode)
        extends NodeInfo(astNode) {

    shared actual default SpreadArgument node => astNode;
    value tcNode = assertedTcNode<Tree.SpreadArgument>(astNode);

    shared TypeModel typeModel => tcNode.typeModel;
    shared ParameterModel? parameter => tcNode.parameter;
}

shared
SpreadArgumentInfo | ComprehensionInfo | Null sequenceArgumentInfo
        (SpreadArgument | Comprehension | Null node)
    =>  switch (node)
        case (is SpreadArgument) SpreadArgumentInfo(node)
        case (is Comprehension) ComprehensionInfo(node)
        case (is Null) null;

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

shared
class ObjectDefinitionInfo(ObjectDefinition astNode)
        extends DeclarationInfo(astNode) {

    shared actual default ObjectDefinition node => astNode;
    value tcNode = assertedTcNode<Tree.ObjectDefinition>(astNode);

    shared actual ValueModel declarationModel => tcNode.declarationModel;
    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

shared
class ObjectExpressionInfo(ObjectExpression astNode)
        extends ExpressionInfo(astNode) {

    shared actual default ObjectExpression node => astNode;
    value tcNode = assertedTcNode<Tree.ObjectExpression>(astNode);

    shared ClassModel anonymousClass => tcNode.anonymousClass;
}

"Tree.ExecutableStatement"
shared
class StatementInfo(Statement astNode)
        extends NodeInfo(astNode) {

    shared actual default Statement node => astNode;
}

shared abstract
class SpecificationInfo(Specification astNode)
        of LazySpecificationInfo
        extends StatementInfo(astNode) {

    shared actual default Specification node => astNode;
    value tcNode = assertedTcNode<Tree.SpecifierStatement>(astNode);

    shared FunctionModel|ValueModel declaration {
        assert (is FunctionModel | ValueModel d = tcNode.declaration);
        return d;
    }

    shared TypedDeclarationModel? refined => tcNode.refined;
}

shared
class LazySpecificationInfo(LazySpecification astNode)
        extends SpecificationInfo(astNode) {
    shared actual default LazySpecification node => astNode;
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
    value tcNode = assertedTcNode<Tree.ForStatement>(astNode);

    shared Boolean exits => tcNode.exits;
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
class SpecifiedVariableInfo(SpecifiedVariable astNode)
        extends NodeInfo(astNode) {

    shared actual default SpecifiedVariable node => astNode;
    value tcNode = assertedTcNode<Tree.Variable>(astNode);

    shared ValueModel declarationModel => tcNode.declarationModel;
}

shared
class IsConditionInfo(IsCondition astNode)
        extends NodeInfo(astNode) {

    shared actual default IsCondition node => astNode;
    value tcNode = assertedTcNode<Tree.IsCondition>(astNode);

    shared ValueModel variableDeclarationModel => tcNode.variable.declarationModel;
}

shared
class ExistsOrNonemptyConditionInfo(ExistsOrNonemptyCondition astNode)
        extends NodeInfo(astNode) {

    shared actual default ExistsOrNonemptyCondition node => astNode;
    value tcNode = assertedTcNode<Tree.ExistsOrNonemptyCondition>(astNode);

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

shared
class ExistsConditionInfo(ExistsCondition astNode)
        extends ExistsOrNonemptyConditionInfo(astNode) {

    shared actual default ExistsCondition node => astNode;
}

shared
class NonemptyConditionInfo(NonemptyCondition astNode)
        extends ExistsOrNonemptyConditionInfo(astNode) {

    shared actual default NonemptyCondition node => astNode;
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
class IsCaseInfo(IsCase astNode)
        extends NodeInfo(astNode) {

    shared actual default IsCase node => astNode;
    value tcNode = assertedTcNode<Tree.IsCase>(astNode);

    shared ValueModel? variableDeclarationModel => tcNode.variable?.declarationModel;
}

shared
class ElseClauseInfo(ElseClause astNode)
        extends NodeInfo(astNode) {

    shared actual default ElseClause node => astNode;
    value tcNode = assertedTcNode<Tree.ElseClause>(astNode);

    shared ValueModel? variableDeclarationModel => tcNode.variable?.declarationModel;
}

shared
class IfElseExpressionInfo(IfElseExpression astNode)
        extends NodeInfo(astNode) {

    shared actual default IfElseExpression node => astNode;
    value tcNode = assertedTcNode<Tree.IfExpression>(astNode);

    shared ValueModel? elseVariableDeclarationModel
        =>  tcNode.elseClause.variable?.declarationModel;
}

shared
class ValueSpecificationInfo(ValueSpecification astNode)
        extends NodeInfo(astNode) {

    shared actual default ValueSpecification node => astNode;
    value tcNode = assertedTcNode<Tree.SpecifierStatement>(astNode);

    shared ValueModel declaration {
        if (astNode.qualifier exists) {
            // If qualified with `this`, the `tcNode.declaration` isn't set (for
            // whatever reason).
            assert (is Tree.QualifiedMemberExpression qme = tcNode.baseMemberExpression);
            assert (is ValueModel result = qme.declaration);
            return result;
        }
        else {
            // tcNode.baseMemberExpression is a Tree.BaseMemberExpression
            assert (is ValueModel result = tcNode.declaration);
            return result;
        }
    }

    //shared TypedDeclarationModel? refined => tcNode.refined;

    shared QualifiedExpression | BaseExpression target {
        assert (is Tree.BaseMemberExpression | Tree.QualifiedMemberExpression
                baseMemberExpression = tcNode.baseMemberExpression);

        assert (is QualifiedExpression | BaseExpression result =
                primaryToCeylon(baseMemberExpression, augmentNode));

        return result;
    }
}

shared
class InvocationInfo(Invocation astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Invocation node => astNode;
    //value tcNode = assertedTcNode<Tree.InvocationExpression>(astNode);
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
class ConstructorInfo(ConstructorDefinition astNode)
        extends DeclarationInfo(astNode) {

    shared actual default ConstructorDefinition node => astNode;

    value tcNode = assertedTcNode<Tree.Constructor>(astNode);

    shared actual FunctionModel declarationModel => tcNode.declarationModel;

    shared ConstructorModel constructorModel => tcNode.constructor;
}

shared
class ExtensionOrConstructionInfo(ExtensionOrConstruction astNode)
        extends NodeInfo(astNode) {

    shared actual default ExtensionOrConstruction node => astNode;

    value tcNode = assertedTcNode<Tree.InvocationExpression | Tree.SimpleType>(astNode);

    value tcExtendedTypeExpression
        =   if (is Tree.InvocationExpression tcNode)
            then asserted<Tree.ExtendedTypeExpression>(tcNode.primary)
            else null;

    shared TypeModel | TypedReferenceModel? target
        =>  asserted<TypeModel | TypedReferenceModel>(tcExtendedTypeExpression?.target);

    // we *could* fall back to SimpleType.declarationModel, for class extends clauses for
    // classes w/constructors.
    shared default ClassModel | ConstructorModel | Null declaration
        =>  asserted<ClassModel | ConstructorModel | Null>
                (tcExtendedTypeExpression?.declaration);

    shared default List<TypeModel>? signature
        =>  if (exists s = tcExtendedTypeExpression?.signature)
            then CeylonList(s)
            else null;

    "Appears to be the same as `target.fullType`; a Callable."
    shared default TypeModel? typeModel
        =>  tcExtendedTypeExpression?.typeModel;
}

shared
class ExtensionInfo(Extension astNode)
        extends ExtensionOrConstructionInfo(astNode) {

    shared actual default Extension node => astNode;

    shared actual ClassModel? declaration => asserted<ClassModel?>(super.declaration);
}

shared
class ConstructionInfo(Construction astNode)
        extends ExtensionOrConstructionInfo(astNode) {

    shared actual Construction node => astNode;

    shared actual ConstructorModel declaration
        =>  asserted<ConstructorModel>(super.declaration);

    shared actual List<TypeModel> signature
        =>  assertExists(super.signature);

    shared actual TypeModel typeModel
        =>  assertExists(super.typeModel);
}

shared
class OuterInfo(Outer astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Outer node => astNode;

    value tcNode = assertedTcNode<Tree.Outer>(astNode);
    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class SuperInfo(Super astNode)
        extends ExpressionInfo(astNode) {

    shared actual default Super node => astNode;

    value tcNode = assertedTcNode<Tree.Super>(astNode);
    shared default TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class ThisInfo(This astNode)
        extends ExpressionInfo(astNode) {

    shared actual default This node => astNode;

    value tcNode = assertedTcNode<Tree.This>(astNode);
    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

shared
class TypeNameWithTypeArgumentsInfo(TypeNameWithTypeArguments astNode)
        extends NodeInfo(astNode) {

    shared actual default TypeNameWithTypeArguments node => astNode;

    value tcNode = assertedTcNode<
            Tree.SimpleType | Tree.BaseTypeExpression | Tree.QualifiedTypeExpression>
            (astNode);

    shared default TypeDeclarationModel declarationModel
        =>  switch (tcNode)
            case (is Tree.SimpleType)
                tcNode.declarationModel
            case (is Tree.BaseTypeExpression)
                asserted<TypeDeclarationModel>(tcNode.declaration)
            case (is Tree.QualifiedTypeExpression)
                asserted<TypeDeclarationModel>(tcNode.declaration);
}

TcNodeType assertedTcNode<TcNodeType>(Node astNode)
        given TcNodeType satisfies TcNode {
    assert (is TcNodeType tcNode = astNode.get(keys.tcNode));
    return tcNode;
}