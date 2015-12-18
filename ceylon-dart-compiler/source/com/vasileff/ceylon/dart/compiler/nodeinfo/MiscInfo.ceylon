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
    RequiredParameter,
    VariadicParameter,
    DefaultedParameter
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
    ParameterModel=Parameter
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

shared abstract
class ParameterInfo()
        of RequiredParameterInfo | DefaultedParameterInfo | VariadicParameterInfo
        extends NodeInfo() {

    shared actual formal Tree.Parameter tcNode;

    shared ParameterModel parameterModel => tcNode.parameterModel;
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
class RequiredParameterInfo(shared actual RequiredParameter node)
        extends ParameterInfo() {

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
