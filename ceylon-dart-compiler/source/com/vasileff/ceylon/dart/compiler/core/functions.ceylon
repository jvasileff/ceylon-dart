import ceylon.ast.core {
    Node,
    Declaration,
    This,
    BaseExpression,
    Expression,
    Outer
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
    CeylonList,
    CeylonIterable
}
import ceylon.math.whole {
    parseWhole,
    wholeNumber
}

import com.redhat.ceylon.common {
    Backends
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TCNode=Node
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    NamedArgumentListModel=NamedArgumentList,
    ConditionScopeModel=ConditionScope,
    UnitModel=Unit,
    PackageModel=Package,
    ElementModel=Element,
    ModuleModel=Module,
    ClassModel=Class,
    ConstructorModel=Constructor,
    InterfaceModel=Interface,
    ClassOrInterfaceModel=ClassOrInterface,
    ScopeModel=Scope,
    SetterModel=Setter,
    ValueModel=Value,
    FunctionModel=Function,
    FunctionOrValueModel=FunctionOrValue,
    TypeDeclarationModel=TypeDeclaration,
    TypeModel=Type,
    ModuleImportModel=ModuleImport
}
import com.vasileff.ceylon.dart.compiler {
    dartBackend,
    DScope,
    Warning
}
import com.vasileff.ceylon.dart.compiler.nodeinfo {
    NodeInfo,
    DeclarationInfo,
    keys,
    BaseExpressionInfo
}
import java.lang {
    JDouble=Double { jparseDouble=parseDouble }
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartPrefixExpression,
    DartIntegerLiteral
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
        (DScope|Node|ScopeModel|ElementModel|ModuleModel|UnitModel declaration)
    // Test for Node first; see https://github.com/ceylon/ceylon-spec/issues/1394
    =>  if (is Node declaration) then
            getModule(NodeInfo(declaration).scope)
        else if (is PackageModel declaration) then
            declaration.\imodule
        else if (is ModuleModel declaration) then
            declaration
        else if (is DScope declaration) then
            getModule(declaration.scope)
        else
            getPackage(declaration).\imodule;

Boolean sameModule(
        DScope|Node|ScopeModel|ElementModel|ModuleModel|UnitModel first,
        DScope|Node|ScopeModel|ElementModel|ModuleModel|UnitModel second)
    =>  getModule(first) == getModule(second);

shared
String moduleImportPrefix(ModuleModel m)
    =>  CeylonIterable(m.name)
            .map(Object.string)
            .interpose("$")
            .fold("$")(plus);

"Shortcut for `(scope of ScopeModel).container`,"
ScopeModel? containerOfScope(ScopeModel scope)
    =>  scope.container;

"Returns the `ScopeModel` for the argument, extracting from the `Node` or casting
 `ElementModel` to `ScopeModel` as necessary."
ScopeModel toScopeModel(DScope|Node|NodeInfo|ScopeModel|ElementModel scope) {
    // Test for Node first; see https://github.com/ceylon/ceylon-spec/issues/1394
    if (is Node scope) {
        return NodeInfo(scope).scope;
    }
    else if (is NodeInfo scope) {
        return scope.scope;
    }
    else if (is ScopeModel scope) {
        return scope;
    }
    else if (is DScope scope) {
        return scope.scope;
    }
    else {
        "Shouldn't happen; aren't all concrete `Element`s `Scope`s?"
        assert (false);
    }
}

ClassModel|InterfaceModel? getContainingClassOrInterface
        (DScope|Node|ScopeModel|ElementModel scope) {
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

ClassModel getClassModelForConstructor(ClassModel | ConstructorModel model) {
    switch (model)
    case (is ClassModel) {
        return model;
    }
    case (is ConstructorModel) {
        assert (is ClassModel result = model.container);
        return result;
    }
}

ConstructorModel? getConstructor(FunctionModel model)
    =>  if (is ConstructorModel c = model.type.declaration)
        then c
        else null;

ConstructorModel|Declaration replaceFunctionWithConstructor<Declaration>
        (Declaration model)
    =>  if (is FunctionModel model,
            is ConstructorModel c = (model of FunctionModel).type.declaration)
        then c
        else model;

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
        else if (declaration.parameter,
                 is FunctionModel f = declaration.container,
                 f.anonymous) then
            true
        else
            false;

Boolean isFunctionArgumentOrParamOf(FunctionOrValueModel declaration)
    =>  if (declaration is FunctionModel
                && declaration.container is NamedArgumentListModel) then
            true
        else if (declaration.parameter,
                 is FunctionModel f = declaration.container,
                 f.container is NamedArgumentListModel) then
            true
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

"Does the expression represent a constant. That is, `outer`, `this`, or a base expression
 to a non-transient, non-variable, non-formal & non-default value."
Boolean isConstant(Expression e) {
    if (is BaseExpression be = e,
        is ValueModel vm = BaseExpressionInfo(be).declaration) {
        return !vm.transient && !vm.variable && !vm.formal && !vm.default;
    }
    return e is Outer|This;
}

"Returns the [[Backends]] object for the declaration."
Backends getNativeBackends(Declaration | DeclarationInfo | DeclarationModel
            | ModuleModel | ModuleImportModel that)
    =>  switch (that)
        case (is Declaration)
            DeclarationInfo(that).declarationModel.nativeBackends
        case (is DeclarationInfo)
            that.declarationModel.nativeBackends
        case (is DeclarationModel)
            that.nativeBackends
        case (is ModuleModel)
            that.nativeBackends
        case (is ModuleImportModel)
            that.nativeBackends;

"Returns true if the declaration is not marked `native`, or if it is marked `native`
 with a Ceylon implementation for the Dart backend."
shared
Boolean isForDartBackend(Declaration | DeclarationInfo | DeclarationModel
            | ModuleModel | ModuleImportModel that)
    =>  let (backends = getNativeBackends(that))
        backends.none() || backends.supports(dartBackend);

shared
SetterModel|FunctionModel|ValueModel? mostRefined
        (ClassOrInterfaceModel bottom, FunctionOrValueModel declaration) {
    if (!declaration.name exists) {
        // Nameless constructors appear (as annoying?) class members of the
        // form: `function C.() => C.null`

        "Functions models for nameless constructors are Function models"
        assert (is FunctionModel declaration);
        return declaration;
    }

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
DScope dScope(
        "The AST node or node info for error reporting."
        Node|NodeInfo node,
        "The scope, which may be different from the [[node]]'s scope. The one known use
         for this is creating values for `object` definitions, where the value's
         scope must be used (which is the container of the `object` anonymous class
         scope.)"
        ScopeModel scope = toScopeModel(node))
    =>  let (passedScope = scope, passedNode = node)
        object satisfies DScope {
            shared actual Node node
                =   if (is Node passedNode)
                    then passedNode
                    else passedNode.node;

            shared actual NodeInfo nodeInfo
                =   if (is NodeInfo passedNode)
                    then passedNode
                    else NodeInfo(passedNode);

            shared actual ScopeModel scope => passedScope;
        };

shared
ScopeModel container(DeclarationModel declaration)
    // workaround interop issue with FunctionModel|ValueModel|SetterModel
    =>  declaration.container;

shared
DeclarationModel refinedDeclaration(DeclarationModel declaration) {
    // workaround https://github.com/ceylon/ceylon-spec/issues/1435
    variable value refined = declaration.refinedDeclaration;
    while (refined != refined.refinedDeclaration) {
        refined = refined.refinedDeclaration;
    }
    return refined;
}

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
Item(Key) unsafeMap<Key, Item>({<Key->Item>*} entries)
        given Key satisfies Object {

    value m = map(entries);
    function unsafeGet(Key key) {
        assert (exists item = m.get(key));
        return item;
    }
    return unsafeGet;
}

shared
void addWarning(Node|NodeInfo|DScope node, Warning warning, String message) {
    value info
        =   switch (node)
            case (is Node) NodeInfo(node)
            case (is NodeInfo) node
            else node.nodeInfo;
    info.addWarning(warning, message);
}

shared
void addError(Node|NodeInfo|DScope node, String message) {
    value info
        =   switch (node)
            case (is Node) NodeInfo(node)
            case (is NodeInfo) node
            else node.nodeInfo;
    info.addUnexpectedError(message);
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

shared
Return? omap<Return, Argument>(Return(Argument) collecting)(Argument? item)
    =>  if (exists item)
        then collecting(item)
        else null;

Integer?(Character) suffixExponent
    =   map {
            'k' -> 3,
            'M' -> 6,
            'G' -> 9,
            'T' -> 12,
            'P' -> 15,
            'm' -> -3,
            'u' -> -6,
            'n' -> -9,
            'p' -> -12,
            'f' -> -15
        }.get;

shared
DartIntegerLiteral | DartPrefixExpression parseCeylonInteger(String text) {
    "Text must not be empty."
    assert (exists first = text.first);

    "Text must not be empty."
    assert (exists last = text.last);

    "The first character must be a number, `$`, or `#`."
    assert (first in ['$', '#', *('0'..'9')]);

    Integer radix
        =   switch (first)
            case ('$') 2
            case ('#') 16
            else 10;

    value exponent = if(radix == 10) then suffixExponent(last) else null;

    value start = if (radix == 10) then 0 else 1;

    value length = text.size - start - (if (exponent exists) then 1 else 0);

    "The text must be parsable as an integer."
    assert (exists result = parseWhole(text[start:length].replace("_", ""), radix));

    if (exists exponent) {
        if (exponent.positive) {
            return DartIntegerLiteral(result.timesInteger(10 ^ exponent).string);
        }
        else {
            return DartIntegerLiteral(
                result.divided(wholeNumber(10 ^ exponent.magnitude)).string);
        }
    }

    if (radix == 10) {
        return DartIntegerLiteral(result.string);
    }

    value string64 = result.integer.string;
    if (string64.startsWith("-")) {
        return DartPrefixExpression("-", DartIntegerLiteral(string64[1...]));
    }
    return DartIntegerLiteral(string64);
}

shared
String parseCeylonFloat(String text) {
    // TODO string manipulation instead; we lose precision on the roundtrip
    //      for now, use Java's parseDouble for better results than parseFloat

    "Text must not be empty."
    assert (exists last = text.last);

    value exponent = suffixExponent(last);

    value length = text.size - (if (exponent exists) then 1 else 0);

    value result = jparseDouble(text[0:length].replace("_", ""));

    if (exists exponent) {
        return (result * 10.0 ^ exponent).string;
    }
    return result.string;
}
