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
    SetterModel=Setter,
    ParameterModel=Parameter,
    TypeModel=Type
}
import com.vasileff.ceylon.dart.model {
    DartTypeModel
}

class Naming(TypeFactory typeFactory) {

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
            return (declaration of DeclarationModel).name;
        }
        case (is ClassModel) {
            return (declaration of DeclarationModel).name;
        }
        case (is InterfaceModel) {
            return (declaration of DeclarationModel).name;
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
            (ElementModel|UnitModel|ModuleModel declaration);

    moduleImportPrefix
        =   memoize((ElementModel|UnitModel|ModuleModel declaration)
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

    see(`function TypeFactory.boxingConversionFor`) // erasureFor?
    shared
    DartTypeName dartTypeName(
            ElementModel inRelationTo,
            TypeModel|DartTypeModel type,
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

        value fromDartPrefix = moduleImportPrefix(inRelationTo);

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

    "Obtain the [[DartTypeModel]] that will be used for
     the given [[TypeModel]]."
    see(`function TypeFactory.boxingConversionFor`)
    shared
    DartTypeModel dartTypeModel(
            TypeModel type,
            Boolean disableErasure = false) {

        // TODO consider using `dynamic` instead of `core.Object`
        //      for unions, intersections, Nothing,
        //      and generic type parameters

        // TODO type.typeAlias

        if (type.typeParameter) {
            // treat all generic types as `core.Object`
            return dartObjectModel;
        }

        value definiteType = typeFactory.definiteType(type);

        // handle well known types first, before giving up
        // on unions and intersections

        // these types are erased when statically known
        if (!disableErasure) {
            if (typeFactory.isCeylonBoolean(definiteType)) {
                return dartBoolModel;
            }
            if (typeFactory.isCeylonInteger(definiteType)) {
                return dartIntModel;
            }
            if (typeFactory.isCeylonFloat(definiteType)) {
                return dartDoubleModel;
            }
            if (typeFactory.isCeylonString(definiteType)) {
                return dartStringModel;
            }
        }

        // types like Anything and Object are _always_ erased
        if (typeFactory.isCeylonAnything(definiteType)) {
            return dartObjectModel;
        }
        if (typeFactory.isCeylonNothing(definiteType)) {
            // this handles the `Null` case too,
            // since Null & Object = Nothing
            return dartObjectModel;
        }
        if (typeFactory.isCeylonObject(definiteType)) {
            return dartObjectModel;
        }
        if (typeFactory.isCeylonBasic(definiteType)) {
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

    shared
    Boolean equalErasure(TypeModel first, TypeModel second)
        =>  dartTypeModel(first) == dartTypeModel(second);
}
