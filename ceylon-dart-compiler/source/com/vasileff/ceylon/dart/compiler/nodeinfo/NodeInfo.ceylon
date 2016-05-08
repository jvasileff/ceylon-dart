import ceylon.ast.core {
    Node,
    Annotations,
    Annotation,
    Resource,
    TypeParameter,
    TypeParameters,
    CaseTypes,
    SatisfiedTypes,
    TypeConstraint,
    PackageDescriptor,
    ModuleImport,
    ModuleBody,
    ModuleDescriptor,
    ImportAlias,
    ImportWildcard,
    ImportElement,
    ImportElements,
    Import,
    Conditions,
    ExtendedType,
    ClassSpecifier,
    TypeSpecifier,
    FailClause,
    Resources,
    SwitchCases,
    SwitchClause,
    Identifier,
    FullPackageName,
    Arguments,
    AnySpecifier,
    Bound,
    Modifier,
    Body,
    Subscript,
    DecQualifier,
    AnyMemberOperator,
    Pattern,
    SpecifiedPattern,
    PatternList,
    CaseExpression,
    Block,
    ClassBody,
    InterfaceBody,
    OpenBound,
    ClosedBound,
    ImportFunctionValueAlias,
    ImportTypeAlias,
    NamedArguments,
    PositionalArguments,
    LIdentifier,
    UIdentifier,
    ImportTypeElement,
    ImportFunctionValueElement,
    TypeModifier,
    DynamicModifier,
    LocalModifier,
    FunctionModifier,
    ValueModifier,
    VoidModifier,
    Variance,
    InModifier,
    OutModifier,
    EntryPattern,
    TuplePattern,
    VariablePattern,
    KeySubscript,
    RangeSubscript,
    MeasureSubscript,
    SpanFromSubscript,
    SpanSubscript,
    SpanToSubscript,
    LazySpecifier,
    Specifier,
    MemberOperator,
    SafeMemberOperator,
    SpreadMemberOperator
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Message
}
import com.redhat.ceylon.model.typechecker.model {
    ScopeModel=Scope,
    Unit
}
import com.vasileff.ceylon.dart.compiler {
    DScope,
    dartBackend,
    Warning
}

import org.antlr.runtime {
    Token
}

shared
class DefaultNodeInfo(shared actual Node node)
        //of AnnotationInfo | AnnotationsInfo | TypeParameterInfo | TypeParametersInfo
        //| CaseTypesInfo | SatisfiedTypesInfo | TypeConstraintInfo | PackageDescriptorInfo
        //| ModuleImportInfo | ModuleBodyInfo | ModuleDescriptorInfo | ImportAliasInfo
        //| ImportWildcardInfo | ImportElementInfo | ImportElementsInfo | ImportInfo
        //| ConditionsInfo | ExtendedTypeInfo
        //| ClassSpecifierInfo | TypeSpecifierInfo | FailClauseInfo
        //| ResourceInfo | ResourcesInfo
        //| SwitchCasesInfo | SwitchClauseInfo | IdentifierInfo
        //| FullPackageNameInfo | ArgumentsInfo | AnySpecifierInfo | BoundInfo | ModifierInfo
        //| BodyInfo | SubscriptInfo | DecQualifierInfo | AnyMemberOperatorInfo | PatternInfo
        //| SpecifiedPatternInfo | PatternListInfo | CaseExpressionInfo |
        extends NodeInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared class AnnotationInfo(Annotation that) => DefaultNodeInfo(that);
shared class AnnotationsInfo(Annotations that) => DefaultNodeInfo(that);
shared class TypeParameterInfo(TypeParameter that) => DefaultNodeInfo(that);
shared class TypeParametersInfo(TypeParameters that) => DefaultNodeInfo(that);
shared class CaseTypesInfo(CaseTypes that) => DefaultNodeInfo(that);
shared class SatisfiedTypesInfo(SatisfiedTypes that) => DefaultNodeInfo(that);
shared class TypeConstraintInfo(TypeConstraint that) => DefaultNodeInfo(that);
shared class PackageDescriptorInfo(PackageDescriptor that) => DefaultNodeInfo(that);
shared class ModuleImportInfo(ModuleImport that) => DefaultNodeInfo(that);
shared class ModuleBodyInfo(ModuleBody that) => DefaultNodeInfo(that);
shared class ModuleDescriptorInfo(ModuleDescriptor that) => DefaultNodeInfo(that);

shared class ImportAliasInfo(ImportAlias that) => DefaultNodeInfo(that);
shared class ImportFunctionValueAliasInfo(ImportFunctionValueAlias that) => ImportAliasInfo(that);
shared class ImportTypeAliasInfo(ImportTypeAlias that) => ImportAliasInfo(that);

shared class ImportWildcardInfo(ImportWildcard that) => DefaultNodeInfo(that);

shared class ImportElementInfo(ImportElement that) => DefaultNodeInfo(that);
shared class ImportTypeElementInfo(ImportTypeElement that) => ImportElementInfo(that);
shared class ImportFunctionValueElementInfo(ImportFunctionValueElement that) => ImportElementInfo(that);

shared class ImportElementsInfo(ImportElements that) => DefaultNodeInfo(that);
shared class ImportInfo(Import that) => DefaultNodeInfo(that);
shared class ConditionsInfo(Conditions that) => DefaultNodeInfo(that);
shared class ExtendedTypeInfo(ExtendedType that) => DefaultNodeInfo(that);
shared class ClassSpecifierInfo(ClassSpecifier that) => DefaultNodeInfo(that);
shared class TypeSpecifierInfo(TypeSpecifier that) => DefaultNodeInfo(that);
shared class FailClauseInfo(FailClause that) => DefaultNodeInfo(that);
shared class ResourceInfo(Resource that) => DefaultNodeInfo(that);
shared class ResourcesInfo(Resources that) => DefaultNodeInfo(that);
shared class SwitchCasesInfo(SwitchCases that) => DefaultNodeInfo(that);
shared class SwitchClauseInfo(SwitchClause that) => DefaultNodeInfo(that);

shared class IdentifierInfo(Identifier that) => DefaultNodeInfo(that);
shared class LIdentifierInfo(LIdentifier that) => IdentifierInfo(that);
shared class UIdentifierInfo(UIdentifier that) => IdentifierInfo(that);

shared class FullPackageNameInfo(FullPackageName that) => DefaultNodeInfo(that);

shared class ArgumentsInfo(Arguments that) => DefaultNodeInfo(that);
shared class NamedArgumentsInfo(NamedArguments that) => ArgumentsInfo(that);
shared class PositionalArgumentsInfo(PositionalArguments that) => ArgumentsInfo(that);

shared class AnySpecifierInfo(AnySpecifier that) => DefaultNodeInfo(that);
shared class LazySpecifierInfo(LazySpecifier that) => AnySpecifierInfo(that);
shared class SpecifierInfo(Specifier that) => AnySpecifierInfo(that);

shared class BoundInfo(Bound that) => DefaultNodeInfo(that);
shared class OpenBoundInfo(OpenBound that) => BoundInfo(that);
shared class ClosedBoundInfo(ClosedBound that) => BoundInfo(that);

shared class ModifierInfo(Modifier that) => DefaultNodeInfo(that);
shared class TypeModifierInfo(TypeModifier that) => ModifierInfo(that);
shared class DynamicModifierInfo(DynamicModifier that) => TypeModifierInfo(that);
shared class LocalModifierInfo(LocalModifier that) => TypeModifierInfo(that);
shared class FunctionModifierInfo(FunctionModifier that) => LocalModifierInfo(that);
shared class ValueModifierInfo(ValueModifier that) => LocalModifierInfo(that);
shared class VoidModifierInfo(VoidModifier that) => TypeModifierInfo(that);
shared class VarianceInfo(Variance that) => ModifierInfo(that);
shared class InModifierInfo(InModifier that) => VarianceInfo(that);
shared class OutModifierInfo(OutModifier that) => VarianceInfo(that);

shared class BodyInfo(Body that) => DefaultNodeInfo(that);
shared class BlockInfo(Block that) => BodyInfo(that);
shared class ClassBodyInfo(ClassBody that) => BodyInfo(that);
shared class InterfaceBodyInfo(InterfaceBody that) => BodyInfo(that);

shared class SubscriptInfo(Subscript that) => DefaultNodeInfo(that);
shared class KeySubscriptInfo(KeySubscript that) => SubscriptInfo(that);
shared class RangeSubscriptInfo(RangeSubscript that) => SubscriptInfo(that);
shared class MeasureSubscriptInfo(MeasureSubscript that) => RangeSubscriptInfo(that);
shared class SpanFromSubscriptInfo(SpanFromSubscript that) => RangeSubscriptInfo(that);
shared class SpanSubscriptInfo(SpanSubscript that) => RangeSubscriptInfo(that);
shared class SpanToSubscriptInfo(SpanToSubscript that) => RangeSubscriptInfo(that);

shared class DecQualifierInfo(DecQualifier that) => DefaultNodeInfo(that);

shared class AnyMemberOperatorInfo(AnyMemberOperator that) => DefaultNodeInfo(that);
shared class MemberOperatorInfo(MemberOperator that) => AnyMemberOperatorInfo(that);
shared class SafeMemberOperatorInfo(SafeMemberOperator that) => AnyMemberOperatorInfo(that);
shared class SpreadMemberOperatorInfo(SpreadMemberOperator that) => AnyMemberOperatorInfo(that);

shared class PatternInfo(Pattern that) => DefaultNodeInfo(that);
shared class EntryPatternInfo(EntryPattern that) => PatternInfo(that);
shared class TuplePatternInfo(TuplePattern that) => PatternInfo(that);
shared class VariablePatternInfo(VariablePattern that) => PatternInfo(that);

shared class SpecifiedPatternInfo(SpecifiedPattern that) => DefaultNodeInfo(that);
shared class PatternListInfo(PatternList that) => DefaultNodeInfo(that);
shared class CaseExpressionInfo(CaseExpression that) => DefaultNodeInfo(that);

shared abstract
class NodeInfo()
        of ExpressionInfo | StatementInfo | DeclarationInfo | ParameterInfo
            | AnyCompilationUnitInfo | ConditionInfo | ElseClauseInfo | VariableInfo
            | ForIteratorInfo | ForClauseInfo | ComprehensionClauseInfo | ArgumentListInfo
            | CaseItemInfo | SpreadArgumentInfo | NamedArgumentInfo | ParametersInfo
            | ComprehensionInfo | TypeIshInfo | ExtensionOrConstructionInfo
            | DefaultNodeInfo | CaseClauseInfo | CatchClauseInfo | FinallyClauseInfo
            | IfClauseInfo | TryClauseInfo
        satisfies DScope {

    shared formal Node node;

    shared formal TcNode tcNode;

    shared String text => tcNode.text;

    // TODO hide ANTLR dependency
    shared Token token => tcNode.token;
    shared Token endToken => tcNode.endToken;

    shared Unit unit => tcNode.unit;

    // FIXME location and filename doesn't work for ArgumentListInfo
    // https://github.com/ceylon/ceylon-spec/issues/1385
    shared String location => tcNode.location;
    shared String filename => tcNode.unit?.filename else "unknown file";

    shared actual ScopeModel scope => tcNode.scope;

    shared default NodeInfo nodeInfo => this;

    shared {Message*} errors => CeylonList(tcNode.errors);

    shared actual void addError(String string)
        =>  tcNode.addError(string, dartBackend);

    shared actual void addUnsupportedError(String string)
        =>  tcNode.addUnsupportedError(string, dartBackend);

    shared actual void addUnexpectedError(String string)
        =>  tcNode.addUnexpectedError(string, dartBackend);

    shared actual void addWarning(Warning warning, String message)
        =>  tcNode.addUsageWarning(warning, message, dartBackend);
}
