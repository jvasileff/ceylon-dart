import ceylon.ast.core {
    Node,
    Declaration
}
import ceylon.ast.redhat {
    RedHatTransformer,
    SimpleTokenFactory
}
import ceylon.collection {
    HashMap
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
    ScopeModel=Scope,
    SetterModel=Setter,
    ValueModel=Value
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

Boolean hasError(Node that)
    =>  that.transform(hasErrorTransformer);

UnitModel getUnit
        (ElementModel|UnitModel|ScopeModel declaration)
    =>  if (is UnitModel declaration)
            then declaration
        else if (is ElementModel declaration)
            then declaration.unit
        else
            getUnit(declaration.container);

PackageModel getPackage
        (ElementModel|UnitModel|ScopeModel declaration)
    =>  getUnit(declaration).\ipackage;

ModuleModel getModule
        (Node|ElementModel|UnitModel|ModuleModel|ScopeModel declaration)
    =>  if (is PackageModel declaration) then
            declaration.\imodule
        else if (is Node declaration) then
            getModule(NodeInfo(declaration).scope)
        else if (!is ModuleModel declaration) then
            getUnit(declaration).\ipackage.\imodule
        else
            declaration;

Boolean sameModule(
        Node|ElementModel|UnitModel|ScopeModel first,
        Node|ElementModel|UnitModel|ScopeModel second)
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

"Returns the name of the backend for declarations marked `native` with a Ceylon
 implementation for a specific backend, the empty String (\"\") for declarations marked
 native without specifying a backend, or null for non-`native` declarations."
String? getNative(Declaration|DeclarationInfo|DeclarationModel that)
    =>  let (model =
                switch (that)
                case (is Declaration) DeclarationInfo(that)
                        .declarationModel
                case (is DeclarationInfo) that
                        .declarationModel
                case (is DeclarationModel) that)

        model.nativeBackend;

"Returns true if the declaration is not marked `native`, or if it is marked `native`
 with a Ceylon implementation for the Dart backend."
Boolean isForDartBackend(Declaration|DeclarationInfo|DeclarationModel that)
    =>  if (exists native=getNative(that))
        then native.equals("dart")
        else true;

Boolean withinClassOrInterface
        (ElementModel declaration)
    =>  declaration.container is ClassOrInterfaceModel;

Boolean withinClass
        (ElementModel declaration)
    =>  declaration.container is ClassModel;

Boolean withinInterface
        (ElementModel declaration)
    =>  declaration.container is InterfaceModel;

Boolean withinPackage
        (ElementModel declaration)
    =>  declaration.container is PackageModel;

"""Use getter and setter methods instead of regular
   Dart variables for non-toplevel or class attributes
   that require programatic getter or setters, due to:
   > "Getters cannot be defined within methods or functions"
"""
Boolean useGetterSetterMethods
        (ValueModel | SetterModel declaration)
    =>  if (!containerOfDeclaration(declaration) is
                PackageModel | ClassOrInterfaceModel)
        then (
            switch(declaration)
            case (is ValueModel) declaration.transient
            case (is SetterModel) declaration.getter.transient)
        else
            false;

Result memoize<Result, Argument>
        (Result compute(Argument argument),
         HashMap<Argument, Result> cache =
                HashMap<Argument, Result>())
        (Argument argument)
        given Argument satisfies Object
        given Result satisfies Object {
    if (exists result = cache.get(argument)) {
        return result;
    }
    else {
        value result = compute(argument);
        cache.put(argument, result);
        return result;
    }
}
