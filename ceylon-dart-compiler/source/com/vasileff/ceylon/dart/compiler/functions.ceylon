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
import ceylon.interop.java {
    CeylonList
}

import com.redhat.ceylon.compiler.typechecker.tree {
    TCNode=Node
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    ConditionScopeModel=ConditionScope,
    UnitModel=Unit,
    PackageModel=Package,
    ElementModel=Element,
    ModuleModel=Module,
    ClassModel=Class,
    InterfaceModel=Interface,
    ClassOrInterfaceModel=ClassOrInterface,
    ScopeModel=Scope,
    SetterModel=Setter,
    ValueModel=Value,
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue,
    TypeDeclarationModel=TypeDeclaration,
    TypeModel=Type
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

ClassModel|InterfaceModel? getContainingClassOrInterface
        (Node|ScopeModel|ElementModel scope) {
    variable ScopeModel scopeModel = toScopeModel(scope);
    while (!is PackageModel s = scopeModel) {
        if (is ClassModel|InterfaceModel s) {
            return s;
        }
        else {
            scopeModel = s.container;
        }
    }
    return null;
}

DeclarationModelType? getContainingDeclaration
        (Node|ScopeModel|ElementModel scope) {
    variable ScopeModel scopeModel = toScopeModel(scope);
    while (!is PackageModel s = scopeModel) {
        if (is DeclarationModelType s) {
            return s;
        }
        else {
            scopeModel = s.container;
        }
    }
    return null;
}

"The scope or nearest containing scope that is not a [[ConditionScopeModel]]."
ClassOrInterfaceModel | PackageModel | LocalNonInitializerScope
getRealScope(ElementModel scope) {
    variable ScopeModel scopeModel = toScopeModel(scope);
    while (scopeModel is ConditionScopeModel) {
        scopeModel = scopeModel.container;
    }
    assert (is ClassOrInterfaceModel | PackageModel | LocalNonInitializerScope
            result = scopeModel);

    return result;
}

"The nearest containing scope that is not a [[ConditionScopeModel]]. This differs from
 [[ScopeModel.container]] in that the latter does not exclude [[ConditionScopeModel]]s
 that are necessary in order to disambiguate replacement declarations."
ClassOrInterfaceModel | PackageModel | LocalNonInitializerScope
getRealContainingScope(ElementModel scope) {
    variable ScopeModel scopeModel = toScopeModel(scope).container;
    while (scopeModel is ConditionScopeModel) {
        scopeModel = scopeModel.container;
    }
    assert (is ClassOrInterfaceModel | PackageModel | LocalNonInitializerScope
            result = scopeModel);

    return result;
}

"A stream including the given [[declaration]], the declarations of its extended and
 satisfied types, and all of their extended and satisfied types, recursively.

 Note: The values in the returned stream are not necessarily distinct!"
shared
{ClassOrInterfaceModel+} supertypeDeclarations(ClassOrInterfaceModel declaration) {
    {TypeDeclarationModel+} collectx(TypeDeclarationModel declaration)
        =>  {
                declaration,
                *CeylonList(declaration.satisfiedTypes)
                    .follow(declaration.extendedType of TypeModel?)
                    .coalesced
                    .map(TypeModel.declaration)
                    .flatMap(collectx)
            };

    return collectx(declaration).map {
        function(d) {
            "Extended and satisfied types are classes and interfaces."
            assert (is ClassOrInterfaceModel d);
            return d;
        };
    };
}

"True if the non-ConditionScope container is a class or interface.

 Note: this method does not distinguish between captured and non-captured declarations
 in class initializers. All declarations are considered captured, for now."
Boolean isClassOrInterfaceMember(DeclarationModel scope)
    =>  scope.container is ClassModel | InterfaceModel;

Boolean isToplevel(DeclarationModel scope)
    =>  scope.container is PackageModel;

"Is the declaration an anonymous function, or a parameter of an anonymous function?"
Boolean isAnonymousFunctionOrParamOf(FunctionOrValueModel declaration)
    =>  if (is FunctionModel declaration, declaration.anonymous) then
            true
        else if (declaration.parameter, is FunctionModel f = declaration.container) then
            f.anonymous
        else
            false;

"Is the declaration a parameter, and is it in a parameter list that is *not* the first
 parameter list?"
Boolean isParameterInNonFirstParamList(FunctionOrValueModel declaration)
    =>  if (exists parameter = declaration.initializerParameter,
                // could be a constructor or class
                is FunctionModel f = declaration.container) then
            !f.firstParameterList.parameters.contains(parameter)
        else
            false;

"Is the declaration a Function that is a parameter? Callable parameters are implemented
 as values, but are presented as Functions by the model."
Boolean isCallableParameterOrParamOf(FunctionOrValueModel declaration)
    =>  if (declaration.parameter && declaration is FunctionModel) then
            true
        else if (declaration.parameter,
                 is FunctionModel f = declaration.container,
                 f.parameter) then
            true
        else
            false;

"Returns the name of the backend for declarations marked `native` with a Ceylon
 implementation for a specific backend, the empty String (\"\") for declarations marked
 native without specifying a backend, or null for non-`native` declarations."
String? getNative(Declaration|DeclarationInfo|DeclarationModel that)
    =>  switch (that)
        case (is Declaration)
            DeclarationInfo(that).declarationModel.nativeBackend
        case (is DeclarationInfo)
            that.declarationModel.nativeBackend
        case (is DeclarationModel)
            that.nativeBackend;

"Returns true if the declaration is not marked `native`, or if it is marked `native`
 with a Ceylon implementation for the Dart backend."
Boolean isForDartBackend(Declaration|DeclarationInfo|DeclarationModel that)
    =>  if (exists native=getNative(that))
        then native.equals("dart")
        else true;


shared
SetterModel|FunctionModel|ValueModel? mostRefined
        (ClassOrInterfaceModel bottom, FunctionOrValueModel declaration) {
    // getMember by name turns setters into getters!
    value setter = declaration is SetterModel;
    DeclarationModel? result = bottom.getMember(declaration.name, null, false);
    if (setter) {
        assert (is ValueModel result);
        return result.setter;
    }
    else {
        assert (is FunctionModel | ValueModel | Null result);
        return result;
    }
}

shared
ScopeModel container(DeclarationModel declaration)
    // workaround interop issue with FunctionModel|ValueModel|SetterModel
    =>  declaration.container;

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
[Element*] concatenate<Element>({{Element*}*} iterables)
    =>  [ for (it in iterables) for (val in it) val ];

shared
Type asserted<Type>(Anything item, String? message = null) {
    try {
        assert(is Type item);
        return item;
    }
    catch (AssertionError e) {
        if (exists message) {
            throw AssertionError(message);
        }
        else {
            throw e;
        }
    }
}

shared
T&Object assertExists<T>(T item, String? message = null) {
    try {
        assert(exists item);
        return item;
    }
    catch (AssertionError e) {
        if (exists message) {
            throw AssertionError(message);
        }
        else {
            throw e;
        }
    }
}

shared
Boolean eq(Anything first, Anything second)
    =>  if (exists first, exists second)
        then first == second
        else (!first exists) && (!second exists);

"Like Iterable.takeWhile, but include the terminating element."
shared
Iterable<Element, Absent> takeUntil<Element, Absent=Null>
        (Iterable<Element, Absent> elements)
        (Boolean terminating(Element element))
        given Absent satisfies Null => object
        satisfies Iterable<Element, Absent> {
    iterator()
        =>  let (iter = elements.iterator())
            object satisfies Iterator<Element> {
                variable Boolean alive = true;
                actual shared Element|Finished next() {
                    if (alive,
                        !is Finished next = iter.next()) {
                        if (!terminating(next)) {
                            return next;
                        }
                        else {
                            alive = false;
                            return next;
                        }
                    }
                    return finished;
                }
                string => outer.string + ".iterator()";
            };
};
