import ceylon.collection {
    HashMap
}
import ceylon.interop.java {
    CeylonIterable
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
    ConstructorModel=Constructor
}

import com.vasileff.ceylon.dart.model {
    DartTypeModel
}
import ceylon.ast.core {
    Node
}
import com.vasileff.ceylon.dart.ast {
    DartConstructorName,
    DartPrefixedIdentifier,
    DartTypeName,
    DartSimpleIdentifier,
    DartIdentifier
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

    shared
    String getName(DeclarationModel|ParameterModel declaration) {
        // TODO it might make sense to make this private, and have callers
        //      use `dartIdentifierForX()` methods that can also handle
        //      function <-> value mappings.

        if (is SetterModel declaration) {
            return getName(declaration.getter);
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
            return declaration.name;
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
    String createReplacementName(TypedDeclarationModel declaration) {
        if (is SetterModel declaration) {
            return createReplacementName(declaration.getter);
        }

        String replacement;
        switch (declaration)
        case (is ValueModel) {
            replacement = declaration.name + "$" + (counter++).string;
        }
        else {
            throw Exception("declaration type not yet supported \
                             for ``className(declaration)``");
        }
        nameCache.put(declaration, replacement);
        return replacement;
    }

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
    String identifierPackagePrefix
            (ElementModel|UnitModel declaration);

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
        // TODO should take type arguments too



        switch (declaration)
        case (is ClassModel) {
            "Only toplevel classes supported for now"
            assert(withinPackage(declaration));

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
            DartTypeModel dartModel) {

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
    DartTypeName dartTypeNameForDeclaration(
            Node|ElementModel|ScopeModel scope,
            FunctionOrValueModel declaration) {

        value dartModel = dartTypeModelForDeclaration(declaration);
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

    "Determine the *formal* type, which indicates Dart erasure/boxing"
    shared
    TypeModel formalType(FunctionOrValueModel declaration)
        =>  if (declaration.parameter,
                    is FunctionModel c = declaration.container,
                    is FunctionModel r = c.refinedDeclaration) then
                // for parameters of method refinements, use the type of the parameter
                // of the refined method
                r.getParameter(declaration.name).type
            else if (is FunctionOrValueModel r =
                    declaration.refinedDeclaration) then
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

    shared
    DartIdentifier dartIdentifierForClassOrInterface(
            Node|ElementModel|ScopeModel scope,
            ClassOrInterfaceModel declaration) {

        switch (container = containerOfDeclaration(declaration))
        case (is PackageModel) {
            if (sameModule(scope, declaration)) {
                // don't qualify with module
                return DartSimpleIdentifier(
                    identifierPackagePrefix(declaration) +
                    getName(declaration));
            }
            else {
                // qualify toplevel with Dart import prefix
                return DartPrefixedIdentifier {
                    DartSimpleIdentifier(moduleImportPrefix(declaration));
                    DartSimpleIdentifier(
                        identifierPackagePrefix(declaration)
                        + getName(declaration));
                };
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            // FIXME this needs to be a CompilerBug exception
            throw Exception(
                "Unsupported container for base expression: \
                 declaration type '``className(declaration)``' \
                 container type '``className(container)``'");
        }
        else {
            // FIXME this needs to be a CompilerBug exception
            throw Exception(
                "Unexpected container for base expression: \
                 declaration type '``className(declaration)``' \
                 container type '``className(container)``'");
        }
    }

    "Returns a tuple containing:

     - The Dart identifier for a Ceylon FunctionOrValue
     - A boolean value that is true if the target is a dart function, or false if the
       target is a dart value. Note: this will be true for Ceylon values that must be
       mapped to Dart functions."
    shared
    [DartIdentifier, Boolean] dartIdentifierForFunctionOrValue(
            Node|ElementModel|ScopeModel scope,
            FunctionOrValueModel declaration,
            Boolean setter = false) {

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

        switch (container = containerOfDeclaration(declaration))
        case (is PackageModel) {
            if (sameModule(scope, declaration)) {
                // qualify toplevel in same module with '$package.'
                return
                [DartSimpleIdentifier {
                    "$package$"
                    + identifierPackagePrefix(declaration)
                    + name;
                }, isDartFunction];
            }
            else {
                // qualify toplevel with Dart import prefix
                return
                [DartPrefixedIdentifier {
                    DartSimpleIdentifier {
                        moduleImportPrefix(declaration);
                    };
                    DartSimpleIdentifier {
                        identifierPackagePrefix(declaration)
                        + name;
                    };
                }, isDartFunction];
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {

            if (is ValueModel|SetterModel declaration,
                    useGetterSetterMethods(declaration)) {
                // identifier for the getter or setter method
                return
                [DartSimpleIdentifier {
                    name
                    + (if (setter) then "$set" else "$get");
                 }, true];
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

    "For the Value, or the return type of the Function"
    shared
    Boolean erasedToNative(FunctionOrValueModel declaration)
        =>  !ctx.disableErasureToNative.contains(declaration)
            && native(formalType(declaration));

    "For the Value, or the return type of the Function"
    shared
    Boolean erasedToObject(FunctionOrValueModel declaration)
        =>  (declaration.initializerParameter?.defaulted else false)
                || !denotable(declaration.type);
}
