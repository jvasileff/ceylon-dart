import ceylon.ast.core {
    Statement,
    LazySpecification,
    Specification,
    ValueSpecification,
    BaseExpression,
    QualifiedExpression,
    ForFail,
    DynamicBlock,
    While
}
import ceylon.ast.redhat {
    primaryToCeylon
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TcNode=Node,
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    ValueModel=Value,
    FunctionModel=Function,
    TypedDeclarationModel=TypedDeclaration
}
import com.vasileff.ceylon.dart.compiler.core {
    augmentNode
}

shared abstract
class StatementInfo()
        of ControlStructureInfo | SpecificationInfo | DefaultStatementInfo
        extends NodeInfo() {

    shared actual formal Statement node;
}

shared abstract
class ControlStructureInfo()
        of DynamicBlockInfo | WhileInfo | ForFailInfo
        extends StatementInfo() {}

shared final
class DynamicBlockInfo(shared actual DynamicBlock node)
        extends ControlStructureInfo() {
    shared actual TcNode tcNode = getTcNode(node);
}

shared
class ForFailInfo(shared actual ForFail node)
        extends ControlStructureInfo() {

    shared alias TcNodeType => Tree.ForStatement;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared Boolean exits => tcNode.exits;
}

shared final
class WhileInfo(shared actual While node)
        extends ControlStructureInfo() {
    shared actual TcNode tcNode = getTcNode(node);
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
