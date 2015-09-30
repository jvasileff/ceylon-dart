import ceylon.ast.core {
    Node
}
import ceylon.collection {
    HashMap
}
import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.model.loader {
    JvmBackendUtil
}
import com.redhat.ceylon.model.typechecker.model {
    DeclarationModel=Declaration,
    TypedDeclarationModel=TypedDeclaration,
    FunctionModel=Function,
    ClassModel=Class,
    InterfaceModel=Interface,
    ValueModel=Value,
    ElementModel=Element,
    UnitModel=Unit,
    ModuleModel=Module,
    ScopeModel=Scope,
    SetterModel=Setter,
    ParameterModel=Parameter,
    TypeModel=Type,
    PackageModel=Package,
    ClassOrInterfaceModel=ClassOrInterface,
    FunctionOrValueModel=FunctionOrValue,
    ControlBlockModel=ControlBlock,
    ConstructorModel=Constructor,
    SpecificationModel=Specification,
    NamedArgumentListModel=NamedArgumentList
}
import com.vasileff.ceylon.dart.ast {
    DartConstructorName,
    DartPrefixedIdentifier,
    DartTypeName,
    DartSimpleIdentifier,
    DartIdentifier,
    DartExpression,
    DartPropertyAccess,
    createDartPropertyAccess
}
import com.vasileff.ceylon.dart.model {
    DartTypeModel
}
import com.vasileff.jl4c.guava.collect {
    ImmutableMap
}

shared
class DartTypes(CeylonTypes ceylonTypes, CompilationContext ctx) {

    variable value counter = 0;

    value nameCache = HashMap<TypedDeclarationModel, String>();

    [String, Boolean]?(DeclarationModel) mappedFunctionOrValue = (() {
        return ImmutableMap {
            ceylonTypes.objectDeclaration.getMember("string", null, false)
                -> ["toString", true],
            ceylonTypes.objectDeclaration.getMember("hash", null, false)
                -> ["hashCode", false]
        }.get;
    })();

    String getUnprefixedName(DeclarationModel|ParameterModel declaration) {
        String classOrObjectShortName(ClassModel declaration)
            =>  if (declaration.anonymous) then
                    // *all* objects are anonymous classes, not just expressions that
                    // get the "anonymous#" names. Non-expression objects are named
                    // the same as their values.
                    declaration.name.replace("anonymous#", "$anonymous$") + "_"
                else
                    declaration.name;

        if (is SetterModel declaration) {
            return getUnprefixedName(declaration.getter);
        }

        if (is TypedDeclarationModel declaration) {
            // search for replacement name
            variable value model = declaration;
            while (true) {
                if (exists name = nameCache[declaration]) {
                    return name;
                }
                if (exists parent = model.originalDeclaration) {
                    model = parent;
                    continue;
                }
                break;
            }
        }

        switch (declaration)
        case (is ValueModel) {
            // TODO generalize this Dart reserved word hack
            return switch (n = declaration.name)
                case ("true") "$true"
                case ("false") "$false"
                else n;
        }
        case (is FunctionModel) {
            return declaration.name;
        }
        case (is ClassModel) {
            return classOrObjectShortName(declaration);
        }
        case (is ConstructorModel) {
            return declaration.name;
        }
        case (is InterfaceModel) {
            return declaration.name;
        }
        case (is ParameterModel) {
            return declaration.name;
        }
        else {
            throw Exception("declaration type not yet supported \
                             for ``className(declaration)``");
        }
    }

    shared
    String getName(DeclarationModel|ParameterModel declaration) {
        // TODO it might make sense to make this private, and have callers
        //      use `dartIdentifierForX()` methods that can also handle
        //      function <-> value mappings.

        String classOrInterfacePrefix(DeclarationModel member)
            // for member classes/interfaces, prepend with outer type names
            =>  if (exists container = getContainingDeclaration(member.container))
                then classOrInterfacePrefix(container)
                        + getUnprefixedName(container) + "$"
                else "";

        switch (declaration)
        case (is SetterModel | ValueModel | FunctionModel
                | ConstructorModel | ParameterModel) {
            return getUnprefixedName(declaration);
        }
        case (is ClassModel | InterfaceModel) {
            return classOrInterfacePrefix(declaration)
                    + getUnprefixedName(declaration);
        }
        else {
            throw Exception("declaration type not yet supported \
                             for ``className(declaration)``");
        }
    }

    "The name of the static method used for the implementation of
     non-formal interface methods."
    shared
    String getStaticInterfaceMethodName(
            FunctionModel|ValueModel|SetterModel declaration,
            Boolean isSetter = declaration is SetterModel)
        =>  if (declaration is FunctionModel) then
                "$" + getName(declaration)
            else if (isSetter) then
                "$set$" + getName(declaration)
            else
                "$get$" + getName(declaration);

    shared
    DartSimpleIdentifier getStaticInterfaceMethodIdentifier(
            FunctionModel|ValueModel|SetterModel declaration,
            Boolean isSetter = declaration is SetterModel)
        =>  DartSimpleIdentifier(getStaticInterfaceMethodName(declaration, isSetter));

    shared
    String getOrCreateReplacementName(ValueModel declaration);

    getOrCreateReplacementName = memoize((ValueModel declaration) {
        // Note: This *must* be memoized, to ensure idempotence!!!
        value replacement
            =   declaration.name + "$" + (counter++).string;

        nameCache.put(declaration, replacement);
        return replacement;
    });

    shared
    String createTempName(TypedDeclarationModel declaration) {
        return declaration.name + "$" + (counter++).string;
    }

    shared
    String createTempNameCustom(String prefix="tmp") {
        return prefix + "$" + (counter++).string;
    }

    "The Dart library prefix for the Ceylon module."
    shared
    String moduleImportPrefix
            (Node|ElementModel|UnitModel|ModuleModel|ScopeModel declaration);

    moduleImportPrefix
        =   memoize((Node|ElementModel|UnitModel|ModuleModel|ScopeModel declaration)
            =>  CeylonIterable(getModule(declaration).name)
                    .map(Object.string)
                    .interpose("$")
                    .fold("$")(plus));

    "The prefix to use for identifiers to simulate Ceylon packages
     in Dart. This is the part of the Ceylon package name that is not
     part of the containing module's base package, with `.` replaced
     by `$`, and a trailing `$` if nonempty."
    shared
    String identifierPackagePrefix(ElementModel|UnitModel declaration);

    identifierPackagePrefix
        =   memoize((ElementModel|UnitModel declaration)
            =>  CeylonIterable(getPackage(declaration).name)
                    .skip(getModule(declaration).name.size())
                    .map(Object.string)
                    .interpose("$")
                    .reduce(plus)
                    ?.plus("$") else "");

    shared
    DartTypeName dartObject
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("Object");
                };
            };

    shared
    DartTypeName dartBool
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("bool");
                };
            };

    shared
    DartTypeName dartInt
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("int");
                };
            };

    shared
    DartTypeName dartDouble
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("double");
                };
            };

    shared
    DartTypeName dartFunction
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("Function");
                };
            };

    shared
    DartTypeName dartString
        =   DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$dart$core");
                    DartSimpleIdentifier("String");
                };
            };

    shared
    DartIdentifier dartDefault(Node scope)
        =>  if (getModule(scope).nameAsString == "ceylon.language") then
                DartSimpleIdentifier("$package$dart$default")
            else
                DartPrefixedIdentifier {
                    DartSimpleIdentifier("$ceylon$language");
                    DartSimpleIdentifier("dart$default");
                };

    shared
    DartTypeModel dartLazyIterable
        =>  DartTypeModel("$ceylon$language", "LazyIterable");

    shared
    DartTypeModel dartFunctionIterableFactory
        =>  DartTypeModel("$ceylon$language", "functionIterable");

    shared
    DartTypeModel dartObjectModel
        =   DartTypeModel("$dart$core", "Object");

    shared
    DartTypeModel dartBoolModel
        =   DartTypeModel("$dart$core", "bool");

// FIXME shouldn't have hardcoded package!
    shared
    DartTypeModel dartCallableModel
        =>  DartTypeModel("$ceylon$language", "dart$Callable");

    shared
    DartTypeModel dartIntModel
        =   DartTypeModel("$dart$core", "int");

    shared
    DartTypeModel dartDoubleModel
        =   DartTypeModel("$dart$core", "double");

    shared
    DartTypeModel dartFunctionModel
        =   DartTypeModel("$dart$core", "Function");

    shared
    DartTypeModel dartStringModel
        =   DartTypeModel("$dart$core", "String");

    shared
    DartConstructorName dartConstructorName(
            Node|ElementModel|ScopeModel scope,
            ClassModel|ConstructorModel declaration) {
        switch (declaration)
        case (is ClassModel) {
            //"Only toplevel classes supported for now"
            //assert(withinPackage(declaration));
            // TODO above assertion uncommented; was there a reason for the restriction?

            return DartConstructorName {
                dartTypeName(scope, declaration.type, false, false);
                null;
            };
        }
        case (is ConstructorModel) {
            assert (is ClassModel container = declaration.container);
            "Only toplevel classes supported for now"
            assert(withinPackage(container));

            return DartConstructorName {
                dartTypeName(scope, container.type, false, false);
                DartSimpleIdentifier(getName(declaration));
            };
        }
    }

    shared
    DartTypeName dartTypeName(
            Node|ElementModel|ScopeModel scope,
            TypeOrNoType type,
            Boolean eraseToNative,
            Boolean eraseToObject = false)
        =>  if (eraseToObject) then
                dartTypeNameForDartModel(scope, dartObjectModel)
            else if (is NoType type) then
                dartTypeNameForDartModel(scope, dartObjectModel)
            else
                dartTypeNameForDartModel(scope, dartTypeModel(type, eraseToNative));

    shared
    DartTypeName dartTypeNameForDartModel(
            Node|ElementModel|ScopeModel scope,
            DartTypeModel dartModel)
        =>  DartTypeName(dartIdentifierForDartModel(scope, dartModel));

    shared
    DartIdentifier dartIdentifierForDartModel(
            Node|ElementModel|ScopeModel scope,
            DartTypeModel dartModel) {

        value fromDartPrefix = moduleImportPrefix(scope);

        if (dartModel.dartModule == fromDartPrefix) {
            return
            DartSimpleIdentifier(dartModel.name);
        }
        else {
            return
            DartPrefixedIdentifier {
                DartSimpleIdentifier(dartModel.dartModule);
                DartSimpleIdentifier(dartModel.name);
            };
        }
    }

    "For the `Value`, or a `Callable` if the declaration is a `Function`."
    shared
    DartTypeName dartTypeNameForDeclaration(
            Node|ElementModel|ScopeModel scope,
            FunctionOrValueModel declaration) {

        value dartModel =
            switch (declaration)
            case (is FunctionModel)
                // code path for Callable parameters, other?
                dartTypeModel {
                    declaration.typedReference.fullType;
                    false; false;
                }
            else //case (is ValueModel | SetterModel)
                dartTypeModelForDeclaration(declaration);
        value fromDartPrefix = moduleImportPrefix(scope);
        if (dartModel.dartModule == fromDartPrefix) {
            return
            DartTypeName {
                DartSimpleIdentifier(dartModel.name);
            };
        }
        else {
            return
            DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier(dartModel.dartModule);
                    DartSimpleIdentifier(dartModel.name);
                };
            };
        }
    }

    "For the Value, or the return type of the Function"
    shared
    DartTypeName dartReturnTypeNameForDeclaration(
            Node|ElementModel|ScopeModel scope,
            FunctionModel|ValueModel declaration) {

        value dartModel = dartTypeModel {
            declaration.type;
            erasedToNative(declaration);
            erasedToObject(declaration);
        };
        value fromDartPrefix = moduleImportPrefix(scope);
        if (dartModel.dartModule == fromDartPrefix) {
            return
            DartTypeName {
                DartSimpleIdentifier(dartModel.name);
            };
        }
        else {
            return
            DartTypeName {
                DartPrefixedIdentifier {
                    DartSimpleIdentifier(dartModel.dartModule);
                    DartSimpleIdentifier(dartModel.name);
                };
            };
        }
    }

    function refinedParameter(FunctionOrValueModel declaration) {
        // FIXME This is a bit sloppy and trusting, and needs review
        //       Before, we were using the parameter name as a key. But... parameter
        //       names may change on refinement.

        "Only use this for parmaeters!!!"
        assert(declaration.parameter);
        assert (is FunctionOrValueModel result = JvmBackendUtil
                .getTopmostRefinedDeclaration(declaration));
        return result;
    }

    "Determine the *formal* type, which indicates Dart erasure/boxing"
    shared
    TypeModel formalType(FunctionOrValueModel declaration)
        =>  if (declaration.parameter,
                    is FunctionModel c = declaration.container,
                    is FunctionModel r = c.refinedDeclaration) then
                // for parameters of method refinements, use the type of the parameter
                // of the refined method
                refinedParameter(declaration).type
            else if (declaration.parameter,
                // same, for shortcut refinements
                    is SpecificationModel s = declaration.container,
                    is FunctionModel c = s.declaration,
                    is FunctionModel r = c.refinedDeclaration) then
                refinedParameter(declaration).type
            else if (is FunctionOrValueModel r = declaration.refinedDeclaration) then
                r.type
            else
                declaration.type;

    shared
    DartTypeModel dartTypeModelForDeclaration(
            FunctionOrValueModel declaration)
        =>  dartTypeModel {
                declaration.type;
                erasedToNative(declaration);
                erasedToObject(declaration);
            };

    "Obtain the [[DartTypeModel]] that will be used for the given [[TypeModel]]."
    shared
    DartTypeModel dartTypeModel(
            TypeModel type,
            "Don't erase `Boolean`, `Integer`, `Float`,
             and `String` to native types."
            Boolean eraseToNative,
            "Treat all generic types as `core.Object`.

             NOTE: callers should set eraseToObject to true for defaulted parameters."
            Boolean eraseToObject = type.typeParameter) {

        if (eraseToObject) {
            return dartObjectModel;
        }

        value definiteType = ceylonTypes.definiteType(type);

        // Tricky: Element|Absent is not caught in the first type.typeParameter test
        if (definiteType.typeParameter) {
            return dartObjectModel;
        }

        // handle well known types first, before giving up
        // on unions and intersections

        // these types are erased when statically known
        if (eraseToNative) {
            if (ceylonTypes.isCeylonBoolean(definiteType)) {
                return dartBoolModel;
            }
            if (ceylonTypes.isCeylonInteger(definiteType)) {
                return dartIntModel;
            }
            if (ceylonTypes.isCeylonFloat(definiteType)) {
                return dartDoubleModel;
            }
            if (ceylonTypes.isCeylonString(definiteType)) {
                return dartStringModel;
            }
        }

        // types like Anything and Object are _always_ erased
        if (ceylonTypes.isCeylonAnything(definiteType)) {
            return dartObjectModel;
        }
        if (ceylonTypes.isCeylonNothing(definiteType)) {
            // this handles the `Null` case too,
            // since Null & Object = Nothing
            return dartObjectModel;
        }
        if (ceylonTypes.isCeylonObject(definiteType)) {
            return dartObjectModel;
        }
        if (ceylonTypes.isCeylonBasic(definiteType)) {
            return dartObjectModel;
        }

        // at this point, settle for Object for other
        // unions and intersections
        if (definiteType.union || definiteType.intersection) {
            return dartObjectModel;
        }

        // not erased
        return
        DartTypeModel(moduleImportPrefix(definiteType.declaration),
                identifierPackagePrefix(definiteType.declaration) +
                    getName(definiteType.declaration));
    }

    "True if [[type]] is denotable in Dart (not Nothing, a type parameter, union type, or
     intersection type.) Note: generic types such as `List<String>` and `List<T>` are
     considered denotable by this method, whereas type parameters, like `T`, are not."
    shared
    Boolean denotable(TypeModel type)
        =>  !type.typeParameter
                && !ceylonTypes.isCeylonNothing(type)
                && (let (definiteType = ceylonTypes.definiteType(type))
                   // union types that are booleans are denotable, as bool/Boolean
                   (ceylonTypes.isCeylonBoolean(definiteType)
                        || (!definiteType.union
                                && !definiteType.intersection
                                && !definiteType.typeParameter)));

    "True if [[type]] is not a type parameter and has a corresponding Dart native type
     such as `dart.core.int`."
    shared
    Boolean native(TypeModel type)
        =>  !type.typeParameter
            && (let (definiteType = ceylonTypes.definiteType(type))
                ceylonTypes.isCeylonBoolean(definiteType)
                || ceylonTypes.isCeylonInteger(definiteType)
                || ceylonTypes.isCeylonFloat(definiteType)
                || ceylonTypes.isCeylonString(definiteType));


    String outerFieldName(ClassOrInterfaceModel declaration)
        =>  "$outer"
                + moduleImportPrefix(declaration) + "$"
                + getName(declaration);

    shared
    DartSimpleIdentifier identifierForOuter(ClassOrInterfaceModel declaration)
        =>  DartSimpleIdentifier(outerFieldName(declaration));

    "Outer declarations for the given [[declaration]] and all supertype (extended and
     satisfied) declarations."
    shared
    {ClassOrInterfaceModel*} outerDeclarationsForClass
            (ClassOrInterfaceModel declaration)
        =>  supertypeDeclarations(declaration)
                .map((d) => getContainingClassOrInterface(d.container))
                .coalesced
                .distinct;

    "Declarations for captures required by the given [[declaration]] and all supertype
     (extended and satisfied) declarations."
    shared
    {FunctionOrValueModel*} captureDeclarationsForClass
        (ClassOrInterfaceModel declaration)
        =>  supertypeDeclarations(declaration)
                .flatMap(ctx.captures.get)
                .distinct;

    shared
    DartIdentifier dartIdentifierForClassOrInterface(
            Node|ElementModel|ScopeModel scope,
            ClassOrInterfaceModel declaration)
        =>  let (identifier =
                    dartIdentifierForClassOrInterfaceDeclaration(declaration))
            if (sameModule(scope, declaration)) then
                identifier
            else
                DartPrefixedIdentifier {
                    DartSimpleIdentifier(moduleImportPrefix(declaration));
                    identifier;
                };

    shared
    DartSimpleIdentifier dartIdentifierForClassOrInterfaceDeclaration
            (ClassOrInterfaceModel declaration)
        =>  DartSimpleIdentifier {
                identifierPackagePrefix(declaration) + getName(declaration);
            };

    shared
    DartSimpleIdentifier expressionForThis(ClassOrInterfaceModel scope)
        =>  switch (container = getContainingClassOrInterface(scope))
            case (is ClassModel)
                DartSimpleIdentifier("this")
            else
                DartSimpleIdentifier("$this");

    "A stream containing the given [[declaration]] followed by declarations for all
     of [[declaration]]'s ancestor Classes and Interfaces."
    {ClassOrInterfaceModel+} ancestorChain
            (ClassOrInterfaceModel declaration)
        =>  loop<ClassOrInterfaceModel>(declaration)((c)
            =>  getContainingClassOrInterface(c.container) else finished);

    shared
    {ClassOrInterfaceModel+} ancestorChainToExactDeclaration(
            ClassModel|InterfaceModel scope,
            ClassOrInterfaceModel declaration)
        =>  // up to and including an exact match for `declaration`
            takeUntil(ancestorChain(scope))
                    (declaration.equals);

    shared
    {ClassOrInterfaceModel+} ancestorChainToInheritingDeclaration(
            ClassModel|InterfaceModel scope,
            ClassOrInterfaceModel inheritedDeclaration)
        =>  // up to and including a declarations that inherits inheritedDeclaration
            takeUntil(ancestorChain(scope))((c)
                =>  c.inherits(inheritedDeclaration));

    shared
    {ClassOrInterfaceModel+} ancestorChainToCapturerOfDeclaration(
            ClassModel|InterfaceModel scope,
            FunctionOrValueModel capturedDeclaration)
        =>  // up to and including a declarations that inherits inheritedDeclaration
            takeUntil(ancestorChain(scope))((c)
                =>  capturedBySelfOrSupertype(capturedDeclaration, c));

    """
       Chain of references to the member:
            $this ("." $outer$CI)* "." memberName

        The first identifier in the chain will be `this` or `$this`.
    """
    shared
    DartPropertyAccess | DartSimpleIdentifier expressionToThisOrOuter
            ({ClassOrInterfaceModel+} chain)
        =>  let (isInterface = chain.first is InterfaceModel)
            (if (isInterface) then ["$this"] else ["this"])
                .chain(chain.skip(1).map(outerFieldName))
                .map(DartSimpleIdentifier)
                .reduce<DartPropertyAccess|DartSimpleIdentifier> {
                    (expression, field) =>
                    DartPropertyAccess {
                        expression;
                        field;
                    };
                };

    """
       Chain of references to the member:
            $this ("." $outer$CI)* "." memberName

       If the first declaration in the chain is a class, the leading `this`
       will be suppressed.
    """
    shared
    DartPropertyAccess | DartSimpleIdentifier? expressionToThisOrOuterStripThis
            ({ClassOrInterfaceModel+} chain)
        =>  let (isInterface = chain.first is InterfaceModel)
            (if (isInterface) then ["$this"] else [])
                .chain(chain.skip(1).map(outerFieldName))
                .map(DartSimpleIdentifier)
                .reduce<DartPropertyAccess|DartSimpleIdentifier> {
                    (expression, field) =>
                    DartPropertyAccess {
                        expression;
                        field;
                    };
                };

    "Returns a tuple containing:

     - A Dart expression for the Ceylon FunctionOrValue
     - A boolean value that is true if the target is a dart function, or false if the
       target is a dart value. Note: this will be true for Ceylon values that must be
       mapped to Dart functions."
    shared
    [DartExpression, Boolean] expressionForBaseExpression(
            Node|ScopeModel scope,
            FunctionOrValueModel declaration,
            Boolean setter = false) {

        "By definition."
        assert (is FunctionModel|ValueModel|SetterModel declaration);

        value [identifier, isFunction] = dartIdentifierForFunctionOrValue {
            scope;
            declaration;
            setter;
        };

        if (exists container = getContainingClassOrInterface(scope)) {
            value declarationContainer = getRealContainingScope(declaration);

            "Arguments in named argument lists cannot be referenced."
            assert(!is NamedArgumentListModel declarationContainer);

            switch (declarationContainer)
            case (is ClassOrInterfaceModel) {

                "Identifiers for members will always be simple identifiers (not prefixed
                 as toplevels may be.)"
                assert (is DartSimpleIdentifier identifier);

                "An expression to the declaration including:
                 - `this`, `$this`, or a reference to an outer container that is also the
                   container of the declaration, and
                 - the identifier."
                value dartExpression
                    =   createDartPropertyAccess {
                            expressionToThisOrOuterStripThis {
                                ancestorChainToInheritingDeclaration {
                                    container;
                                    declarationContainer;
                                };
                            };
                            identifier;
                        };

                return [dartExpression, isFunction];
            }
            case (is ConstructorModel | ControlBlockModel
                    | FunctionOrValueModel | SpecificationModel) {

                value declarationsClassOrInterface
                    =   getContainingClassOrInterface(declaration);

                if (eq(container, declarationsClassOrInterface)) {
                    return [identifier, isFunction];
                }
                else {
                    // The declaration doesn't belong to a class or interface, and it
                    // does not share a containing class or interface, so it must be
                    // a capture.

                    // The capture must have been made by $this, a supertype of $this,
                    // some $outer, or a supertype of some $outer.

                    value dartExpression
                        =   createDartPropertyAccess {
                                expressionToThisOrOuterStripThis {
                                    ancestorChainToCapturerOfDeclaration {
                                        container;
                                        declaration;
                                    };
                                };
                                identifierForCapture(declaration);
                            };

                    return [dartExpression, isFunction];
                }
            }
            case (is PackageModel) {
                return [identifier, isFunction];
            }
        }
        else {
            return [identifier, isFunction];
        }
    }

    shared
    {ClassOrInterfaceModel+} classOrInterfaceContainers
            (ClassOrInterfaceModel declaration)
        =>  loop<ClassOrInterfaceModel>(declaration)((c)
                =>  getContainingClassOrInterface(c.container) else finished);

    "A non empty stream of containers, starting with [[inner]], and ending with the first
     of 1. a matching container per [[found]], or 2. the outermost class or interface."
    shared
    {ClassOrInterfaceModel+} classOrInterfaceContainerPath(
            ClassOrInterfaceModel inner,
            Boolean found(ClassOrInterfaceModel declaration))
        =>  takeUntil(classOrInterfaceContainers(inner))(found);

    shared
    DartSimpleIdentifier thisReference(ClassOrInterfaceModel scope)
        =>  if (scope is InterfaceModel)
            then DartSimpleIdentifier("$this")
            else DartSimpleIdentifier("this");

    """
       Returns a dart expression for [[outerDeclaration]] from [[scope]]. The expression
       will be of the form:

            $this ("." $outer$ref)*
    """
    shared
    DartExpression expressionToOuter(
            ClassOrInterfaceModel scope,
            ClassOrInterfaceModel outerDeclaration)
        =>  classOrInterfaceContainerPath(scope, outerDeclaration.equals)
                .skip(1) // don't include scope; will be $this instead
                .map(outerFieldName)
                .map(DartSimpleIdentifier)
                .follow(thisReference(scope))
                .reduce((DartExpression expression, field)
                    =>  DartPropertyAccess {
                            expression;
                            field;
                        });

    "Return true if [[target]] is captured by [[by]] or one of its supertypes."
    Boolean capturedBySelfOrSupertype
            (FunctionOrValueModel target, ClassOrInterfaceModel by)
        =>  supertypeDeclarations(by).any((d)
            =>  ctx.captures.contains(d->target));

    """
       Produces an identifier of the form "$capture$" followed by each declaration's name
       separated by '$' starting with the most distant ancestor of [[declaration]]—the
       one with the package as its immediate container.

       Control blocks are represented by the empty string, effectively being translated
       to "$". The idea is that to resolve ambiguities, control block depth is sufficient
       since declarations in sibling control blocks are not visible to each other.
    """
    shared
    DartSimpleIdentifier identifierForCapture(FunctionOrValueModel declaration) {
        value declarations
            =   loop<DeclarationModel|ControlBlockModel>(declaration)((d)
                =>  if (is DeclarationModel|ControlBlockModel result = d.container)
                    then result
                    else finished);

        return
        DartSimpleIdentifier {
            declarations
                .collect((d)
                    =>  if (is ControlBlockModel d)
                        then ""
                        else getName(d))
                .reversed
                .interpose("$")
                .fold("$capture$")(plus);
        };
    }

    "Returns a tuple containing:

     - The *unqualified* DartSimpleIdentifier for a Ceylon FunctionOrValue
     - A boolean value that is true if the target is a dart function, or false if the
       target is a dart value. This will be true for Ceylon values that must be mapped
       to Dart functions."
    shared
    see(`function dartIdentifierForFunctionOrValue`)
    [DartSimpleIdentifier, Boolean] dartIdentifierForFunctionOrValueDeclaration(
            Node|ScopeModel scope,
            FunctionOrValueModel declaration,
            Boolean setter = declaration is SetterModel) {

        // FIXME how should "string" setters be mapped, since the getters
        //       are mapped to "toString"? And, handle "hashCode" name translation.
        value mapped = mappedFunctionOrValue(declaration.refinedDeclaration);
        String name;
        Boolean isDartFunction;

        if (exists mapped) {
            name = mapped[0];
            isDartFunction = mapped[1];
        }
        else {
            name = getName(declaration);
            isDartFunction = declaration is FunctionModel;
        }

        switch (container = declaration.container)
        case (is PackageModel) {
            // qualify toplevel in same module with '$package.'
            return
            [DartSimpleIdentifier {
                "$package$"
                + identifierPackagePrefix(declaration)
                + name;
            }, isDartFunction];
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel
                    | SpecificationModel) {

            if (is ValueModel|SetterModel declaration,
                    useGetterSetterMethods(declaration)) {
                // identifier for the getter or setter method
                return
                [DartSimpleIdentifier {
                    name + (if (setter) then "$set" else "$get");
                },true];
            }
            else {
                // identifier for the value or function
                return
                [DartSimpleIdentifier {
                    name;
                }, isDartFunction];
            }
        }
        else {
            // TODO should be a compiler bug, but we don't have a Node
            throw Exception(
                "Unexpected container for base expression: \
                 declaration type '``className(declaration)``' \
                 container type '``className(container)``'");
        }
    }

    "Returns a tuple containing:

     - The Dart identifier for a Ceylon FunctionOrValue
     - A boolean value that is true if the target is a dart function, or false if the
       target is a dart value. This will be true for Ceylon values that must be mapped
       to Dart functions.

     **Note** this function should not be used for base expressions since they may
     reference captured values. Use [[expressionForBaseExpression]] instead."
    shared
    see(`function dartIdentifierForFunctionOrValueDeclaration`)
    see(`function expressionForBaseExpression`)
    [DartIdentifier, Boolean] dartIdentifierForFunctionOrValue(
            Node|ScopeModel scope,
            FunctionOrValueModel declaration,
            Boolean setter = false)
        =>  let ([identifier, isDartFunction]
                    = dartIdentifierForFunctionOrValueDeclaration(
                            scope, declaration, setter))
            if (declaration.container is PackageModel
                && !sameModule(scope, declaration)) then
                [
                    DartPrefixedIdentifier {
                        DartSimpleIdentifier {
                            moduleImportPrefix(declaration);
                        };
                        DartSimpleIdentifier {
                            // trim leading "$package."
                            identifier.identifier[9...];
                        };
                    },
                    isDartFunction
                ]
            else
                [identifier, isDartFunction];

    shared
    BoxingConversion? boxingConversionFor(
            "The lhs expression type"
            TypeModel lhsType,
            "True if the lhs is native"
            Boolean lhsEraseToNative,
            "The rhs expression type"
            TypeModel rhsType,
            "True if the rhs is native"
            Boolean rhsEraseToNative) {

        // The provided lhsType and rhsType should be subtypes of the formal types
        // used to calculate erasue to native
        //assert(!lhsEraseToNative || native(lhsType));
        //assert(!rhsEraseToNative || native(rhsType));

        if (lhsEraseToNative == rhsEraseToNative) {
            // if erased, they must be the same type (we don't coerce)
            // if neither should be erased, no conversion necessary
            return null;
        }

        if (lhsEraseToNative) {
            value definiteLhs = ceylonTypes.definiteType(lhsType);
            if (ceylonTypes.isCeylonBoolean(definiteLhs)) {
                return ceylonBooleanToNative;
            }
            else if (ceylonTypes.isCeylonFloat(definiteLhs)) {
                return ceylonFloatToNative;
            }
            else if (ceylonTypes.isCeylonInteger(definiteLhs)) {
                return ceylonIntegerToNative;
            }
            else if (ceylonTypes.isCeylonString(definiteLhs)) {
                return ceylonStringToNative;
            }
            else {
                throw Exception(
                        "Cannot find native type for lhs type \
                         '``definiteLhs.asQualifiedString()``'");
            }
        } else {
            value definiteRhs = ceylonTypes.definiteType(rhsType);
            if (ceylonTypes.isCeylonBoolean(definiteRhs)) {
                return nativeToCeylonBoolean;
            }
            else if (ceylonTypes.isCeylonFloat(definiteRhs)) {
                return nativeToCeylonFloat;
            }
            else if (ceylonTypes.isCeylonInteger(definiteRhs)) {
                return nativeToCeylonInteger;
            }
            else if (ceylonTypes.isCeylonString(definiteRhs)) {
                return nativeToCeylonString;
            }
            else {
                throw Exception(
                        "Cannot find native type for rhs type \
                         '``definiteRhs.asQualifiedString()``'");
            }
        }
    }

    "For the Value, or the return type of the Function, *unless* it's a Function that is
     a callable parameter, in which case the result will be false.

     Regarding callable parameters:

     - When invoked, non-native values are returned
     - They may also appear as the lhs type, in which case they are treated as
       `Callable` values, which of course are not erased. (Although, the lhs case should
       be handled by `withLhs`, preempting a call to this function.)
     - They may also appear as the rhs type (when taking a reference to a Function), in
       which case they are treated as `Callable` values, which of course are not erased."
    shared
    Boolean erasedToNative(FunctionOrValueModel declaration)
        =>  !ctx.disableErasureToNative.contains(declaration)
            && !isCallableParameterOrParamOf(declaration)
            && !isAnonymousFunctionOrParamOf(declaration)
            && !isParameterInNonFirstParamList(declaration)
            && native(formalType(declaration));

    "For the Value, or the return type of the Function.

     Regarding callable parameters:

     - This function cannot be used when callable parameters are used as the rhs
       expression, since this would be ambiguous with the normal case where we are
       concerned with the *return* type. (The return is always erased to `Object` for
       callable parameters, but the `Callable` value itself is usually not erased.)"
    shared
    Boolean erasedToObject(FunctionOrValueModel declaration)
        // Ignore "defaulted" for FunctionModel parameters, which are Callable
        // parameters that may be defaulted, where the erasure of the parameter
        // itself has no bearing on the erasure of the actual function return type
        // TODO shouldn't we always return `true` for FunctionModels that are parameters?
        =>  ((!declaration is FunctionModel)
                && (declaration.initializerParameter?.defaulted else false))
            || !denotable(declaration.type);
}
