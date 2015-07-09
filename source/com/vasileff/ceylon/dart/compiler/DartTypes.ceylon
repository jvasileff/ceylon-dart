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
            return declaration.name;
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

    // FIXME DartTypeName values should be removed; they assume we aren't
    //       compiling the language module...
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

    see(`function CeylonTypes.boxingConversionFor`) // erasureFor?
    shared deprecated
    DartTypeName dartTypeName(
            Node|ElementModel|ScopeModel scope,
            TypeModel|DartTypeModel type,
            // FIXME remove default; callers should use dartTypeNameForDeclaration
            Boolean disableErasure = false) {

        // TODO add tests for non-boxed types

        // TODO document/explore erasure for generics
        //      and also for covariant returns. Can the
        //      caller always just use the `formal`,
        //      non-refined type? Is it readily available?

        // TODO we erase Object & Basic here, but need to
        //      address boxing/erasure issues elsewhere, like
        //      method invocations

        value dartModel =
                if (is DartTypeModel type)
                then type
                else dartTypeModel(type, disableErasure);

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

    "Determine the *actual* type, which indicates the Dart static type"
    shared
    TypeModel actualTypeForDeclaration(FunctionOrValueModel declaration)
        =>  let (defaulted = declaration.initializerParameter?.defaulted else false)
            if (defaulted)
            // lie and use `Anything`, since we use `core.Object` in Dart for
            // defaulted parameters.
            then ceylonTypes.anythingType
            else declaration.type;

    "Determine the *formal* type, which indicates Dart erasure/boxing"
    shared
    TypeModel formalTypeForDeclaration(FunctionOrValueModel declaration)
        // FIXME likely incorrect for Parameters, which may not point to the refined dec.
        =>  if (is FunctionOrValueModel refined = declaration.refinedDeclaration)
            then refined.type
            else declaration.type;

    shared
    DartTypeModel dartTypeModelForDeclaration(FunctionOrValueModel declaration)
        =>  dartTypeModel {
                type = actualTypeForDeclaration(declaration);
                // confusing: erased to Object means not erased to a native type!
                disableErasure = erasedToObject(formalTypeForDeclaration(declaration));
            };

    "Obtain the [[DartTypeModel]] that will be used for
     the given [[TypeModel]]."
    see(`function CeylonTypes.boxingConversionFor`)
    shared
    DartTypeModel dartTypeModel(
            TypeModel type,
            // FIXME remove default value; callers should use dartTypeModelForDeclaration instead
            "Don't erase `Boolean`, `Integer`, `Float`,
             and `String` to native types."
            Boolean disableErasure = false) {

        // TODO consider using `dynamic` instead of `core.Object`
        //      for unions, intersections, Nothing,
        //      and generic type parameters

        // TODO type.typeAlias

        if (type.typeParameter) {
            // treat all generic types as `core.Object`
            return dartObjectModel;
        }

        value definiteType = ceylonTypes.definiteType(type);

        // handle well known types first, before giving up
        // on unions and intersections

        // these types are erased when statically known
        if (!disableErasure) {
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

    "True if `type` is a type parameter or a union or intersection
     that cannot be represented in Dart. This is an ugly violation
     of DRY re [[dartTypeModel]], and a better way to express various
     erasure and boxing notions may be needed."
    shared
    Boolean erasedToObject(TypeModel type)
        =>  type.involvesTypeParameters() || (
                let (definiteType = ceylonTypes.definiteType(type))
                (!ceylonTypes.isCeylonBoolean(definiteType) &&
                    (definiteType.union || definiteType.intersection)));

    shared
    Boolean equalErasure(TypeModel first, TypeModel second)
        =>  dartTypeModel(first) == dartTypeModel(second);

    shared
    DartIdentifier qualifyIdentifier(
            ElementModel|UnitModel scope,
            DeclarationModel declaration,
            String simpleName) {

        switch (container = containerOfDeclaration(declaration))
        case (is PackageModel) {
            if (sameModule(scope, declaration)) {
                // qualify toplevel in same module with '$package.'
                return DartSimpleIdentifier(
                    "$package$" +
                    identifierPackagePrefix(declaration) +
                    simpleName);
            }
            else {
                // qualify toplevel with Dart import prefix
                return DartPrefixedIdentifier {
                    prefix = DartSimpleIdentifier(
                        moduleImportPrefix(declaration));
                    identifier = DartSimpleIdentifier(
                        identifierPackagePrefix(declaration) +
                        simpleName);
                };
            }
        }
        case (is ClassOrInterfaceModel
                    | FunctionOrValueModel
                    | ControlBlockModel
                    | ConstructorModel) {
            // TODO should be in scope? consider capture, etc.
            return DartSimpleIdentifier(simpleName);
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