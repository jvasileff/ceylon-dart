import ceylon.ast.core {
    ForClause,
    IsCase,
    Construction,
    Type,
    Comprehension,
    TryClause,
    ArgumentList,
    FinallyClause,
    ExtensionOrConstruction,
    SpreadArgument,
    ElseClause,
    TypeNameWithTypeArguments,
    Extension,
    CaseClause,
    ComprehensionClause,
    IfClause,
    CatchClause,
    ForIterator,
    CompilationUnit,
    VariadicParameter,
    DefaultedParameter,
    Parameters,
    ValueParameter,
    CallableParameter,
    ParameterReference,
    ModuleCompilationUnit,
    PackageCompilationUnit,
    MatchCase,
    Node,
    MemberNameWithTypeArguments,
    VariadicType,
    DefaultedType,
    TypeList,
    SpreadType,
    TypeArgument,
    TypeArguments,
    PackageQualifier,
    EntryType,
    MainType,
    UnionType,
    UnionableType,
    IntersectionType,
    PrimaryType,
    CallableType,
    GroupedType,
    IterableType,
    OptionalType,
    SequentialType,
    SimpleType,
    BaseType,
    QualifiedType,
    TupleType,
    DefaultedValueParameter,
    DefaultedCallableParameter,
    DefaultedParameterReference,
    InitialComprehensionClause,
    ExpressionComprehensionClause,
    ForComprehensionClause,
    IfComprehensionClause
}
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    TypeDeclarationModel=TypeDeclaration,
    TypeModel=Type,
    TypedReferenceModel=TypedReference,
    ValueModel=Value,
    ClassModel=Class,
    ConstructorModel=Constructor,
    ControlBlockModel=ControlBlock,
    ParameterModel=Parameter,
    ParameterListModel=ParameterList,
    FunctionModel=Function
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
class AnyCompilationUnitInfo()
        of CompilationUnitInfo | ModuleCompilationUnitInfo | PackageCompilationUnitInfo
        extends NodeInfo() {}

shared
class CompilationUnitInfo(shared actual CompilationUnit node)
        extends AnyCompilationUnitInfo() {

    shared alias TcNodeType => Tree.CompilationUnit;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class ModuleCompilationUnitInfo(shared actual ModuleCompilationUnit node)
        extends AnyCompilationUnitInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared
class PackageCompilationUnitInfo(shared actual PackageCompilationUnit node)
        extends AnyCompilationUnitInfo() {
    shared actual TcNode tcNode = getTcNode(node);
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
class InitialComprehensionClauseInfo(InitialComprehensionClause that)
    =>  ComprehensionClauseInfo(that);

shared
class ExpressionComprehensionClauseInfo(ExpressionComprehensionClause that)
    =>  ComprehensionClauseInfo(that);

shared
class ForComprehensionClauseInfo(ForComprehensionClause that)
    =>  InitialComprehensionClauseInfo(that);

shared
class IfComprehensionClauseInfo(IfComprehensionClause that)
    =>  InitialComprehensionClauseInfo(that);

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
alias ControlClauseNodeType
    =>  CaseClause | CatchClause | FinallyClause | IfClause | TryClause;

shared
interface ControlClauseInfo {
    shared formal ControlBlockModel controlBlock;
}

shared
class CaseClauseInfo(shared actual CaseClause node)
        extends NodeInfo()
        satisfies ControlClauseInfo {

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class CatchClauseInfo(shared actual CatchClause node)
        extends NodeInfo()
        satisfies ControlClauseInfo {

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class FinallyClauseInfo(shared actual FinallyClause node)
        extends NodeInfo()
        satisfies ControlClauseInfo {

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class IfClauseInfo(shared actual IfClause node)
        extends NodeInfo()
        satisfies ControlClauseInfo {

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ControlBlockModel controlBlock => tcNode.controlBlock;
}

shared
class TryClauseInfo(shared actual TryClause node)
        extends NodeInfo()
        satisfies ControlClauseInfo {

    shared alias TcNodeType => Tree.ControlClause;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ControlBlockModel controlBlock => tcNode.controlBlock;
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

shared abstract
class CaseItemInfo()
        of MatchCaseInfo | IsCaseInfo
        extends NodeInfo() {}

shared
class IsCaseInfo(shared actual IsCase node)
        extends CaseItemInfo() {

    shared alias TcNodeType => Tree.IsCase;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ValueModel? variableDeclarationModel => tcNode.variable?.declarationModel;
}

shared
class MatchCaseInfo(shared actual MatchCase node)
        extends CaseItemInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared abstract
class ParameterInfo()
        of RequiredParameterInfo | DefaultedParameterInfo | VariadicParameterInfo
        extends NodeInfo() {

    shared actual formal Tree.Parameter tcNode;

    shared ParameterModel parameterModel => tcNode.parameterModel;
}

shared
class ParametersInfo(shared actual Parameters node)
        extends NodeInfo() {

    shared alias TcNodeType => Tree.ParameterList;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared ParameterListModel model => tcNode.model;
}

shared
class DefaultedParameterInfo(shared actual DefaultedParameter node)
        extends ParameterInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class DefaultedValueParameterInfo(DefaultedValueParameter that)
    =>  DefaultedParameterInfo(that);

shared
class DefaultedCallableParameterInfo(DefaultedCallableParameter that)
    =>  DefaultedParameterInfo(that);

shared
class DefaultedParameterReferenceInfo(DefaultedParameterReference that)
    =>  DefaultedParameterInfo(that);

shared abstract
class RequiredParameterInfo()
        of ValueParameterInfo | CallableParameterInfo | ParameterReferenceInfo
        extends ParameterInfo() {

    shared actual formal Tree.Parameter tcNode;
}

shared
class ValueParameterInfo(shared actual ValueParameter node)
        extends RequiredParameterInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class CallableParameterInfo(shared actual CallableParameter node)
        extends RequiredParameterInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    "The same as `parameterModel.model`, but narrowed."
    shared FunctionModel functionModel {
        assert (is FunctionModel m = tcNode.parameterModel.model);
        return m;
    }
}

shared
class ParameterReferenceInfo(shared actual ParameterReference node)
        extends RequiredParameterInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared
class VariadicParameterInfo(shared actual VariadicParameter node)
        extends ParameterInfo() {

    shared alias TcNodeType => Tree.Parameter;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
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

shared abstract
class TypeIshInfo()
        of NameWithTypeArgumentsInfo | TypeArgumentInfo | TypeInfo | DefaultTypeIshInfo
        extends NodeInfo() {}

shared
class DefaultTypeIshInfo(shared actual Node node)
        // of VariadicType | DefaultedType | TypeList | SpreadType | TypeArgument
        //    | TypeArguments | PackageQualifier
        extends TypeIshInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared class VariadicTypeInfo(VariadicType that) => DefaultTypeIshInfo(that);
shared class DefaultedTypeInfo(DefaultedType that) => DefaultTypeIshInfo(that);
shared class TypeListInfo(TypeList that) => DefaultTypeIshInfo(that);
shared class SpreadTypeInfo(SpreadType that) => DefaultTypeIshInfo(that);
shared class TypeArgumentsInfo(TypeArguments that) => DefaultTypeIshInfo(that);
shared class PackageQualifierInfo(PackageQualifier that) => DefaultTypeIshInfo(that);

"This info object is largely worthless for us, since TypeArgument nodes are only
 available for type arguments that are not inferred.

 So, instead of using this, get the type parameters from the parent BaseExpression or
 QualifiedExpression's `declaration`, and the type arguments from the expression's
 `target`, which for invocations, will be a TypedReference.

 The corresponding typechecker node for this node is the same as that of the Type
 child node."
shared
class TypeArgumentInfo(shared actual TypeArgument node)
        extends TypeIshInfo() {

    shared alias TcNodeType => Tree.Type;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared TypeModel typeModel => tcNode.typeModel;
}

shared abstract
class TypeInfo()
        of DefaultTypeInfo | BaseTypeInfo
        extends TypeIshInfo() {

    shared formal TypeModel typeModel;
}

shared
class DefaultTypeInfo(shared actual Type node)
        extends TypeInfo() {

    shared alias TcNodeType => Tree.Type;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual TypeModel typeModel => tcNode.typeModel;
}

//shared class BaseTypeInfo(BaseType that) => SimpleTypeInfo(that);

shared
class BaseTypeInfo(shared actual BaseType node)
        extends TypeInfo() {

    shared alias TcNodeType => Tree.BaseType;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual TypeModel typeModel => tcNode.typeModel;

    shared TypeDeclarationModel declarationModel => tcNode.declarationModel;
}

shared class EntryTypeInfo(EntryType that) => DefaultTypeInfo(that);
shared class MainTypeInfo(MainType that) => DefaultTypeInfo(that);
shared class UnionTypeInfo(UnionType that) => MainTypeInfo(that);
shared class UnionableTypeInfo(UnionableType that) => MainTypeInfo(that);
shared class IntersectionTypeInfo(IntersectionType that) => UnionableTypeInfo(that);
shared class PrimaryTypeInfo(PrimaryType that) => UnionableTypeInfo(that);
shared class CallableTypeInfo(CallableType that) => PrimaryTypeInfo(that);
shared class GroupedTypeInfo(GroupedType that) => PrimaryTypeInfo(that);
shared class IterableTypeInfo(IterableType that) => PrimaryTypeInfo(that);
shared class OptionalTypeInfo(OptionalType that) => PrimaryTypeInfo(that);
shared class SequentialTypeInfo(SequentialType that) => PrimaryTypeInfo(that);
shared class SimpleTypeInfo(SimpleType that) => PrimaryTypeInfo(that);
shared class QualifiedTypeInfo(QualifiedType that) => SimpleTypeInfo(that);
shared class TupleTypeInfo(TupleType that) => PrimaryTypeInfo(that);

shared abstract
class NameWithTypeArgumentsInfo()
        of TypeNameWithTypeArgumentsInfo | MemberNameWithTypeArgumentsInfo
        extends TypeIshInfo() {}

shared
class MemberNameWithTypeArgumentsInfo(shared actual MemberNameWithTypeArguments node)
        extends NameWithTypeArgumentsInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared
class TypeNameWithTypeArgumentsInfo(shared actual TypeNameWithTypeArguments node)
        extends NameWithTypeArgumentsInfo() {

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
