import ceylon.ast.core {
    ValueGetterDefinition,
    ValueSetterDefinition,
    ValueDefinition,
    AnyValue,
    ValueDeclaration,
    ConstructorDefinition,
    TypeDeclaration,
    AnyClass,
    TypeAliasDefinition,
    ClassOrInterface,
    AnyInterface,
    FunctionDeclaration,
    FunctionDefinition,
    AnyFunction,
    FunctionShortcutDefinition,
    ObjectDefinition,
    CallableConstructorDefinition,
    ValueConstructorDefinition,
    ClassAliasDefinition,
    ClassDefinition,
    AnyInterfaceDefinition,
    InterfaceAliasDefinition,
    DynamicInterfaceDefinition,
    InterfaceDefinition
}

import com.redhat.ceylon.compiler.typechecker.tree {
    Tree
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    TypedDeclarationModel=TypedDeclaration,
    ValueModel=Value,
    SetterModel=Setter,
    FunctionModel=Function,
    ConstructorModel=Constructor,
    TypeDeclarationModel=TypeDeclaration,
    ClassModel=Class,
    InterfaceModel=Interface,
    ClassOrInterfaceModel=ClassOrInterface
}

shared abstract
class DeclarationInfo()
        of TypeDeclarationInfo
            | TypedDeclarationInfo
            | ObjectDefinitionInfo
            | ValueSetterDefinitionInfo
            | ConstructorDefinitionInfo
        extends NodeInfo() {

    shared actual formal Tree.Declaration tcNode;

    shared default DeclarationModel declarationModel => tcNode.declarationModel;
}

abstract shared
class TypedDeclarationInfo()
        of AnyValueInfo | AnyFunctionInfo
        extends DeclarationInfo() {

    shared actual default
    TypedDeclarationModel declarationModel {
        assert (is TypedDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared abstract
class AnyValueInfo()
        of ValueDeclarationInfo
            | ValueDefinitionInfo
            | ValueGetterDefinitionInfo
        extends TypedDeclarationInfo() {

    shared actual formal AnyValue node;

    shared actual formal Tree.TypedDeclaration tcNode;

    shared actual default
    ValueModel declarationModel {
        assert (is ValueModel result = tcNode.declarationModel);
        return result;
    }
}

shared final
class ValueDefinitionInfo(shared actual ValueDefinition node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeDeclaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueDeclarationInfo(shared actual ValueDeclaration node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeDeclaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueGetterDefinitionInfo(shared actual ValueGetterDefinition node)
        extends AnyValueInfo() {

    shared alias TcNodeType => Tree.AttributeGetterDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ValueModel declarationModel => tcNode.declarationModel;
}

shared final
class ValueSetterDefinitionInfo(shared actual ValueSetterDefinition node)
        extends DeclarationInfo() {

    shared alias TcNodeType => Tree.AttributeSetterDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    SetterModel declarationModel => tcNode.declarationModel;
}

shared abstract
class ConstructorDefinitionInfo()
        of CallableConstructorDefinitionInfo | ValueConstructorDefinitionInfo
        extends DeclarationInfo() {

    shared actual formal ConstructorDefinition node;

    shared actual formal Tree.Constructor | Tree.Enumerated tcNode;

    shared actual formal FunctionModel | ValueModel declarationModel;

    shared formal ConstructorModel constructorModel;
}

shared final
class CallableConstructorDefinitionInfo
        (shared actual CallableConstructorDefinition node)
        extends ConstructorDefinitionInfo() {

    shared alias TcNodeType => Tree.Constructor;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual FunctionModel declarationModel => tcNode.declarationModel;

    shared actual ConstructorModel constructorModel => tcNode.constructor;
}

shared final
class ValueConstructorDefinitionInfo(shared actual ValueConstructorDefinition node)
        extends ConstructorDefinitionInfo() {

    shared alias TcNodeType => Tree.Enumerated;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ValueModel declarationModel => tcNode.declarationModel;

    shared actual ConstructorModel constructorModel => tcNode.enumerated;
}

shared abstract
class TypeDeclarationInfo()
        of ClassOrInterfaceInfo | TypeAliasDefinitionInfo
        extends DeclarationInfo() {

    shared actual formal TypeDeclaration node;

    shared actual default
    TypeDeclarationModel declarationModel {
        assert (is TypeDeclarationModel result = super.declarationModel);
        return result;
    }
}

shared final
class TypeAliasDefinitionInfo(shared actual TypeAliasDefinition node)
        extends TypeDeclarationInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class ClassOrInterfaceInfo()
        of AnyClassInfo | AnyInterfaceInfo
        extends TypeDeclarationInfo() {

    shared actual formal ClassOrInterface node;

    shared actual default
    ClassOrInterfaceModel declarationModel {
        assert (is ClassOrInterfaceModel result = super.declarationModel);
        return result;
    }
}

shared abstract
class AnyInterfaceInfo(AnyInterface astNode)
        of AnyInterfaceDefinitionInfo | InterfaceAliasDefinitionInfo
        extends ClassOrInterfaceInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(astNode));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    InterfaceModel declarationModel {
        assert (is InterfaceModel result = super.declarationModel);
        return result;
    }

    shared actual formal AnyInterface node;
}

shared final
class InterfaceAliasDefinitionInfo(shared actual InterfaceAliasDefinition node)
        extends AnyInterfaceInfo(node) {
}

shared abstract
class AnyInterfaceDefinitionInfo(AnyInterfaceDefinition node)
        of DynamicInterfaceDefinitionInfo | InterfaceDefinitionInfo
        extends AnyInterfaceInfo(node) {
}

shared final
class DynamicInterfaceDefinitionInfo(shared actual DynamicInterfaceDefinition node)
        extends AnyInterfaceDefinitionInfo(node) {
}

shared final
class InterfaceDefinitionInfo(shared actual InterfaceDefinition node)
        extends AnyInterfaceDefinitionInfo(node) {
}

shared abstract
class AnyClassInfo(AnyClass astNode)
        of ClassAliasDefinitionInfo | ClassDefinitionInfo
        extends ClassOrInterfaceInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(astNode));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ClassModel declarationModel {
        assert (is ClassModel result = super.declarationModel);
        return result;
    }

    shared actual formal AnyClass node;
}

shared final
class ClassAliasDefinitionInfo(shared actual ClassAliasDefinition node)
        extends AnyClassInfo(node) {
}

shared final
class ClassDefinitionInfo(shared actual ClassDefinition node)
        extends AnyClassInfo(node) {
}

shared abstract
class AnyFunctionInfo()
        of FunctionDeclarationInfo
            | FunctionDefinitionInfo
            | FunctionShortcutDefinitionInfo
        extends TypedDeclarationInfo() {

    shared actual formal AnyFunction node;

    shared actual formal Tree.AnyMethod tcNode;

    shared actual FunctionModel declarationModel => tcNode.declarationModel;
}

shared final
class FunctionDeclarationInfo(shared actual FunctionDeclaration node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class FunctionDefinitionInfo(shared actual FunctionDefinition node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class FunctionShortcutDefinitionInfo(shared actual FunctionShortcutDefinition node)
        extends AnyFunctionInfo() {

    shared alias TcNodeType => Tree.AnyMethod;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared final
class ObjectDefinitionInfo(shared actual ObjectDefinition node)
        extends DeclarationInfo() {

    shared alias TcNodeType => Tree.ObjectDefinition;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual ValueModel declarationModel => tcNode.declarationModel;
    shared ClassModel anonymousClass => tcNode.anonymousClass;
}
