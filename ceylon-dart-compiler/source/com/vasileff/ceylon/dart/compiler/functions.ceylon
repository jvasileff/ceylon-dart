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
import com.vasileff.ceylon.dart.nodeinfo {
    NodeInfo,
    DeclarationInfo,
    keys
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
        (Node|ScopeModel|ElementModel|ModuleModel|UnitModel declaration)
    // Test for Node first; see https://github.com/ceylon/ceylon-spec/issues/1394
    =>  if (is Node declaration)
            then getUnit(toScopeModel(declaration))
        else if (is UnitModel declaration)
            then declaration
        else if (is ModuleModel declaration)
            then declaration.unit
        else if (is ElementModel declaration)
            then declaration.unit
        else
            getUnit(declaration.container);

PackageModel getPackage
        (Node|ScopeModel|ElementModel|ModuleModel|UnitModel declaration)
    =>  getUnit(declaration).\ipackage;

ModuleModel getModule
        (Node|ScopeModel|ElementModel|ModuleModel|UnitModel declaration)
    // Test for Node first; see https://github.com/ceylon/ceylon-spec/issues/1394
    =>  if (is Node declaration) then
            getModule(NodeInfo(declaration).scope)
        else if (is PackageModel declaration) then
            declaration.\imodule
        else if (is ModuleModel declaration) then
            declaration
        else
            getPackage(declaration).\imodule;

Boolean sameModule(
        Node|ScopeModel|ElementModel|ModuleModel|UnitModel first,
        Node|ScopeModel|ElementModel|ModuleModel|UnitModel second)
    =>  getModule(first) == getModule(second);

"Shortcut for `(scope of ScopeModel).container`,"
ScopeModel? containerOfScope(ScopeModel scope)
    =>  scope.container;

"Returns the `ScopeModel` for the argument, extracting from the `Node` or casting
 `ElementModel` to `ScopeModel` as necessary."
ScopeModel toScopeModel(Node|ScopeModel|ElementModel scope) {
    // Test for Node first; see https://github.com/ceylon/ceylon-spec/issues/1394
    if (is Node scope) {
        return NodeInfo(scope).scope;
    }
    else if (is ScopeModel scope) {
        return scope;
    }
    else {
        "Shouldn't happen; aren't all concrete `Element`s `Scope`s?"
        assert (false);
    }
}

ClassOrInterfaceModel? getContainingClassOrInterface
        (Node|ScopeModel|ElementModel scope) {
    variable ScopeModel scopeModel = toScopeModel(scope);
    while (!is PackageModel s = scopeModel) {
        if (is ClassOrInterfaceModel s) {
            return s;
        }
        else {
            scopeModel = s.container;
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
        // workaround https://github.com/ceylon/ceylon-compiler/issues/2244
        if (exists result=model.nativeBackend)
        then result
        else null;

"Returns true if the declaration is not marked `native`, or if it is marked `native`
 with a Ceylon implementation for the Dart backend."
Boolean isForDartBackend(Declaration|DeclarationInfo|DeclarationModel that)
    =>  if (exists native=getNative(that))
        then native.equals("dart")
        else true;

Boolean withinClassOrInterface(Node|ScopeModel|ElementModel scope)
    =>  toScopeModel(scope).container is ClassOrInterfaceModel;

Boolean withinClass(Node|ScopeModel|ElementModel scope)
    =>  toScopeModel(scope).container is ClassModel;

Boolean withinInterface(Node|ScopeModel|ElementModel scope)
    =>  toScopeModel(scope).container is InterfaceModel;

Boolean withinPackage(Node|ScopeModel|ElementModel scope)
    =>  toScopeModel(scope).container is PackageModel;

"""Use getter and setter methods instead of regular
   Dart variables for non-toplevel or class attributes
   that require programatic getter or setters, due to:
   > "Getters cannot be defined within methods or functions"
"""
Boolean useGetterSetterMethods(ValueModel | SetterModel declaration)
    =>  if (!(declaration of DeclarationModel).container is
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

shared
{Element+} loopFinished<Element>(
        "The first element of the resulting stream."
        Element first)(
        "The function that produces the next element of the
         stream, given the current element."
        Element|Finished next(Element element))
    => let (start = first)
    object satisfies {Element+} {
        first => start;
        empty => false;
        shared actual Nothing size {
            "stream is infinite"
            assert(false);
        }
        function nextElement(Element element)
                => next(element);
        iterator()
                => object satisfies Iterator<Element> {
            variable Element|Finished current = start;
            shared actual Element|Finished next() {
                if (is Element result = current) {
                    current = nextElement(result);
                    return result;
                }
                else {
                    return finished;
                }
            }
        };
    };
