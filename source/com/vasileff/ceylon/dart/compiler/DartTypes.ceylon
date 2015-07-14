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

class DartTypes(CeylonTypes ceylonTypes) {

    variable value counter = 0;

    value nameCache = HashMap<TypedDeclarationModel, String>();

    shared
    String getName(DeclarationModel|ParameterModel declaration) {
        if (is SetterModel declaration) {
            getName(declaration.getter);
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
    DartTypeModel dartObjectModel
        =   DartTypeModel("$dart$core", "Object");

    shared
    DartTypeModel dartBoolModel
        =   DartTypeModel("$dart$core", "bool");

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
    DartTypeName dartTypeName(
            Node|ElementModel|ScopeModel scope,
            TypeModel type,
            Boolean eraseToNative)
        =>  dartTypeNameForDartModel(scope, dartTypeModel(type, eraseToNative));

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

    shared
    DartTypeName dartTypeNameForFormalActual(
            Node|ElementModel|ScopeModel scope,
            FormalActualOrNoType formalActualType)
        =>  dartTypeNameForDartModel(scope, dartTypeModelFormalActual(formalActualType));

    "Determine the *actual* type, which indicates the Dart static type"
    shared
    TypeModel actualType(FunctionOrValueModel declaration)
        =>  let (defaulted = declaration.initializerParameter?.defaulted else false)
            if (defaulted)
            // lie and use `Anything`, since we use `core.Object` in Dart for
            // defaulted parameters.
            then ceylonTypes.anythingType
            else declaration.type;

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
    DartTypeModel dartTypeModelFormalActual(FormalActualOrNoType formalActualType)
        =>  switch (formalActualType)
            case (is NoType) dartObjectModel
            else dartTypeModel {
                formalActualType[1];
                // only erase to native if the formal type is a denotable native
                // type (ruling out generics, unions, intersections, and covariant
                // refinements)
                eraseToNative = native(formalActualType[0]);
            };

    shared
    DartTypeModel dartTypeModelForDeclaration(FunctionOrValueModel declaration)
        =>  dartTypeModelFormalActual([formalType(declaration), actualType(declaration)]);

    "Obtain the [[DartTypeModel]] that will be used for the given [[TypeModel]]."
    see(`function CeylonTypes.boxingConversionFor`)
    shared
    DartTypeModel dartTypeModel(
            TypeModel type,
            "Don't erase `Boolean`, `Integer`, `Float`,
             and `String` to native types."
            Boolean eraseToNative) {

        if (type.typeParameter) {
            // treat all generic types as `core.Object`
            return dartObjectModel;
        }

        value definiteType = ceylonTypes.definiteType(type);

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

    "True if [[type]] is denotable in Dart (not a type parameter, union type, or
     intersection type.) Note: generic types such as `List<String>` and `List<T>` are
     considered denotable by this method, whereas type parameters, like `T`, are not."
    shared
    Boolean denotable(TypeModel type)
        =>  !type.typeParameter && (
                let (definiteType = ceylonTypes.definiteType(type))
                // union types that are booleans are denotable, as bool/Boolean
                (ceylonTypes.isCeylonBoolean(definiteType) ||
                    (!definiteType.union && !definiteType.intersection)));

    "True if [[type]] has a corresponding Dart native type such as `dart.core.int`."
    shared
    Boolean native(TypeModel type)
        =>  let (definiteType = ceylonTypes.definiteType(type))
            ceylonTypes.isCeylonBoolean(definiteType)
            || ceylonTypes.isCeylonInteger(definiteType)
            || ceylonTypes.isCeylonFloat(definiteType)
            || ceylonTypes.isCeylonString(definiteType);

    shared
    Boolean equalErasure(TypeModel first, TypeModel second)
        =>  dartTypeModel(first, true) == dartTypeModel(second, true);

    shared
    DartIdentifier qualifyIdentifier(
            Node|ElementModel|UnitModel|ScopeModel scope,
            DeclarationModel declaration) {

        switch (container = containerOfDeclaration(declaration))
        case (is PackageModel) {
            if (sameModule(scope, declaration)) {
                // qualify toplevel in same module with '$package.'
                return DartSimpleIdentifier(
                    "$package$" +
                    identifierPackagePrefix(declaration) +
                    getName(declaration));
            }
            else {
                // qualify toplevel with Dart import prefix
                return DartPrefixedIdentifier {
                    prefix = DartSimpleIdentifier(
                        moduleImportPrefix(declaration));
                    identifier = DartSimpleIdentifier(
                        identifierPackagePrefix(declaration) +
                        getName(declaration));
                };
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            // TODO should be in scope? consider capture, etc.
            return DartSimpleIdentifier(getName(declaration));
        }
        else {
            // FIXME this needs to be a CompilerBug exception
            throw Exception(
                "Unexpected container for base expression: \
                 declaration type '``className(declaration)``' \
                 container type '``className(container)``'");
        }
    }
}