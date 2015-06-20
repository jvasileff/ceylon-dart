import ceylon.ast.core {
    TypedDeclaration,
    Node
}
import ceylon.ast.redhat {
    RedHatTransformer,
    SimpleTokenFactory
}
import ceylon.formatter {
    format
}
import ceylon.formatter.options {
    FormattingOptions
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TCNode=Node
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    UnitModel=Unit,
    PackageModel=Package,
    ElementModel=Element,
    ModuleModel=Module,
    ClassModel=Class,
    InterfaceModel=Interface,
    ClassOrInterfaceModel=ClassOrInterface,
    ScopeModel=Scope
}

String name(TypedDeclaration that) {
    if (exists name = that.get(keys.identifierName)) {
        return name;
    }

    variable
    String name = that.name.name;

    // TODO when does this happen?
    if (name.startsWith("anonymous#")) {
        name = "anon$" + name[10...];
    }

    // TODO sanitize, etc.

    that.put(keys.identifierName, name);
    return name;
}

void printNodeAsCode(Node node) {
    TCNode tcNode(Node node)
    =>  node.transform(
            RedHatTransformer(
                SimpleTokenFactory()));

    value fo = FormattingOptions {
        maxLineLength = 80;
    };
    print(format(tcNode(node), fo));
}

String location(Node that) {
    assert (exists location = that.get(keys.location));
    return location;
}

UnitModel getUnit
        (ElementModel|UnitModel declaration)
    =>  if (is UnitModel declaration)
        then declaration
        else declaration.unit;

PackageModel getPackage
        (ElementModel|UnitModel declaration)
    =>  getUnit(declaration).\ipackage;

ModuleModel getModule
        (ElementModel|UnitModel|ModuleModel declaration)
    =>  if (!is ModuleModel declaration)
        then getUnit(declaration).\ipackage.\imodule
        else declaration;

Boolean sameModule(
        ElementModel|UnitModel first,
        ElementModel|UnitModel second)
    =>  getModule(first) == getModule(second);

//not allowing `ScopeModel` arguments since they have `null` containers
ScopeModel containerOfDeclaration
        (DeclarationModel declaration)
    =>  declaration.container;

ScopeModel? containerOfScope
        (ScopeModel scope)
    =>  scope.container;

ClassOrInterfaceModel? getContainingClassOrInterface
        (variable ScopeModel scope) {
    while (!is PackageModel s = scope) {
        if (is ClassOrInterfaceModel s) {
            return s;
        }
        else {
            scope = s.container;
        }
    }
    return null;
}

Boolean withinClassOrInterface
        (ElementModel declaration)
    =>  declaration.container is ClassOrInterfaceModel;

Boolean withinClass
        (ElementModel declaration)
    =>  declaration.container is ClassModel;

Boolean withinInterface
        (ElementModel declaration)
    =>  declaration.container is InterfaceModel;
