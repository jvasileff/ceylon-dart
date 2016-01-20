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
    ValueConstructorDefinition
}

shared abstract
class DeclarationInfo()
        of ConstructorDefinitionInfo
            | ObjectDefinitionInfo
            | TypeDeclarationInfo
            | TypedDeclarationInfo
            | ValueSetterDefinitionInfo
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

    shared actual formal Tree.Constructor tcNode;

    shared actual FunctionModel declarationModel => tcNode.declarationModel;

    shared ConstructorModel constructorModel => tcNode.constructor;
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
}

shared final
class ValueConstructorDefinitionInfo(shared actual ValueConstructorDefinition node)
        extends ConstructorDefinitionInfo() {

    shared alias TcNodeType => Tree.Constructor;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;
}

shared abstract
class TypeDeclarationInfo()
        of ClassOrInterfaceDefinitionInfo | TypeAliasDefinitionInfo
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
class ClassOrInterfaceDefinitionInfo()
        of AnyClassInfo | AnyInterfaceInfo
        extends TypeDeclarationInfo() {

    shared actual formal ClassOrInterface node;

    shared actual default
    ClassOrInterfaceModel declarationModel {
        assert (is ClassOrInterfaceModel result = super.declarationModel);
        return result;
    }
}

shared final
class AnyInterfaceInfo(shared actual AnyInterface node)
        extends ClassOrInterfaceDefinitionInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    InterfaceModel declarationModel {
        assert (is InterfaceModel result = super.declarationModel);
        return result;
    }
}

shared final
class AnyClassInfo(shared actual AnyClass node)
        extends ClassOrInterfaceDefinitionInfo() {

    shared alias TcNodeType => Tree.Declaration;
    value lazyTcNode {
        assert (is TcNodeType node = getTcNode(node));
        return node;
    }
    shared actual TcNodeType tcNode = lazyTcNode;

    shared actual
    ClassModel declarationModel {
        assert (is ClassModel result = super.declarationModel);
        return result;
    }
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
