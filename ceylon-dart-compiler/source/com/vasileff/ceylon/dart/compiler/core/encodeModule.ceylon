import ceylon.collection {
    HashMap
}
import ceylon.interop.java {
    CeylonIterable
}

import com.redhat.ceylon.model.typechecker.model {
    ClassModel=Class,
    TypeModel=Type,
    DeclarationModel=Declaration,
    ModuleModel=Module,
    PackageModel=Package,
    InterfaceModel=Interface,
    ModelUtil
}

shared String keyClasses       = "$c";
shared String keyInterfaces    = "$i";
shared String keyObjects       = "$o";
shared String keyMethods       = "$m";
shared String keyCompositeType = "comp";
shared String keyAttributes    = "$at";
shared String keyAnnotations   = "an";
shared String keyPackedAnnotations = "pa";
shared String keyType          = "$t";
shared String keyReturnType    = "$rt";
shared String keyTypes         = "l";
shared String keyTypeArgs      = "ta";
shared String keyTypeParams    = "tp";
shared String keyMetatype      = "mt";
shared String keyModule        = "md";
shared String keyModuleName    = "$mod-name";
shared String keyModuleVersion = "$mod-version";
shared String keyName          = "nm";
shared String keyPackage       = "pk";
shared String keyParams        = "ps";
shared String keySelfType      = "st";
shared String keySatisfies     = "sts";
shared String keyExtendedType  = "super";
shared String keyDsVariance    = "dv"; //declaration-site variance
shared String keyUsVariance    = "uv"; //use-site variance
shared String keyCases         = "of";
shared String keyConstructors  = "$cn";
shared String keyFlags         = "$ff";

shared String keyDefault       = "def";
shared String keyNamed         = "nam";
shared String keyDynamic       = "dyn";
shared String keyStatic        = "sta";

shared String keyNativeDart     = "$mod-native-dart";

shared String typeUnion         = "u";
shared String typeIntersection  = "i";
shared String typeUnknown       = "$U";

shared String metatypeClass           = "c";
shared String metatypeInterface       = "i";
shared String metatypeAlias           = "als";
shared String metatypeObject          = "o";
shared String metatypeMethod          = "m";
shared String metatypeAttribute       = "a";
shared String metatypeGetter          = "g";
shared String metatypeSetter          = "s";
shared String metatypeTypeParameter   = "tp";
shared String metatypeParameter       = "prm";

shared Integer sharedBit = 0;
shared Integer actualBit = 1;
shared Integer formalBit = 2;
shared Integer defaultBit = 3;
shared Integer sealedBit = 4;
shared Integer finalBit = 5;
shared Integer nativeBit = 6;
shared Integer lateBit = 7;
shared Integer abstractBit = 8;
shared Integer annotationBit = 9;
shared Integer variableBit = 10;
shared Integer serializableBit = 11;

shared
Map<String, Object> encodeModule(ModuleModel mod) {
    value m = HashMap<String, Object>();
    m.put(keyModuleName, mod.nameAsString);
    m.put(keyModuleVersion, mod.version);
    // TODO $mod-bin: binary version
    // TODO $mod-nat: backends for native modules
    // TODO annotations
    // TODO imports

    // packages
    for (pkg in mod.packages) {
        m.put(pkg.nameAsString, encodePackage(pkg));
    }
    return m;
}

Map<String, Object> encodePackage(PackageModel pkg) {
    value m = HashMap<String, Object>();
    // TODO annotations

    for (member in pkg.members) {
        if (is ClassModel member) {
            value memberMap = encodeClass(member);
            assert (is String name = memberMap[keyName]);
            m.put(name, memberMap);
        }
        else if (is InterfaceModel member) {
            value memberMap = encodeInterface(member);
            assert (is String name = memberMap[keyName]);
            m.put(name, memberMap);
        }
        // TODO other types
    }
    return m;
}

"Encode a class, as seen from within its container (name is not qualified)."
Map<String, Object> encodeClass(ClassModel declaration) {
    // TODO JS model adds a hash to non-toplevel non-shared classes
    //      JS changes "anonymous#" prefix to "anon$"

    value m = HashMap<String, Object>();
    m.put(keyMetatype, metatypeClass);
    m.put(keyName, declaration.name);

    // type parameters
    // self type

    // extended type
    if (exists extendedType = declaration.extendedType) {
        m.put {
            keyExtendedType;
            encodeType(extendedType, declaration);
        };
    }

    // satisfied types
    m.put {
        keySatisfies;
        CeylonIterable(declaration.satisfiedTypes).collect((st)
            =>  encodeType(st, declaration));
    };

    // initializer parameters (skipping)
    // case types
    // annotations (only packed annotations)

    // members
    m.putAll(encodeMembers(CeylonIterable(declaration.members)));

    return m;
}

{<String -> Map<String, Object>>*} encodeMembers({DeclarationModel*} members) {
    value classes
        =   members.narrow<ClassModel>().map(encodeClass).collect((m) {
                assert (is String name = m[keyName]);
                return name -> m;
            });

    value interfaces
        =   members.narrow<InterfaceModel>().map(encodeInterface).collect((m) {
                assert (is String name = m[keyName]);
                return name -> m;
            });

    return {
        if (nonempty classes)
            then keyClasses -> map(classes)
            else null,
        if (nonempty interfaces)
            then keyInterfaces -> map(interfaces)
            else null
    }.coalesced;
}

"Encode an interface, as seen from within its container (name is not qualified)."
Map<String, Object> encodeInterface(InterfaceModel declaration) {
    // TODO JS model adds a hash to non-toplevel non-shared declarations

    value m = HashMap<String, Object>();
    m.put(keyMetatype, metatypeInterface);
    m.put(keyName, declaration.name);

    // type parameters
    // self type

    // satisfied types
    m.put {
        keySatisfies;
        CeylonIterable(declaration.satisfiedTypes).collect((st)
            =>  encodeType(st, declaration));
    };

    // case types
    // annotations (only packed annotations)

    // members
    m.putAll(encodeMembers(CeylonIterable(declaration.members)));

    return m;
}


HashMap<String, Object> encodeType(TypeModel type, DeclarationModel scope) {
    if (ModelUtil.isTypeUnknown(type)) {
        return HashMap<String, Object> { keyName -> typeUnknown };
    }

    if (type.union || type.intersection) {
        value m = HashMap<String, Object>();

        m.put {
            keyCompositeType;
            if (type.union)
                then typeUnion
                else typeIntersection;
        };

        m.put {
            keyTypes;
            CeylonIterable {
                if (type.union)
                then type.caseTypes
                else type.satisfiedTypes;
            }.collect((t) => encodeType(t, scope));
        };

        return m;
    }
    //else if (type.tuple && !type.involvesTypeParameters()) {
    //    // TODO
    //    //throw Exception("tuple types not yet supported: ``type``");
    //}

    value m = HashMap<String, Object>();
    value declaration = type.declaration;

    if (declaration.toplevel || type.typeParameter) {
        m.put(keyName, declaration.name);
    }
    else {
        // TODO use qualifiedNameString w/o package part and mangled for locals
        m.put(keyName, declaration.name);
    }

    if (!type.typeParameter) {
        // for non-type parameters, add module and/or package info
        value pkg = declaration.unit.\ipackage else null;
        if (!exists pkg) {
            m.put(keyPackage, ".");
        }
        else if (pkg == scope.unit.\ipackage) {
            m.put(keyPackage, ".");
        }
        else if (pkg.nameAsString == "ceylon.language") {
            m.put(keyPackage, "$");
            m.put(keyModule, "$");
        }
        else {
            m.put(keyPackage, pkg.nameAsString);
            if (pkg.\imodule != scope.unit.\ipackage.\imodule) {
                if (pkg.\imodule.nameAsString == "ceylon.language") {
                    m.put(keyModule, "$");
                }
                else {
                    m.put(keyModule, pkg.\imodule.nameAsString);
                }
            }
        }
    }

    if (exists typeArguments = encodeTypeArguments(type, scope)) {
        m.put(keyTypeArgs, typeArguments);
    }

    return m;
}

Map<String, Map<String, Object>>? encodeTypeArguments
        (TypeModel type, DeclarationModel scope) {

    value types
        =   loop(type)((TypeModel t)
            =>  t.qualifyingType else finished);

    "Entries from partially qualified type parameter names to type arguments,
     which are maps."
    value entries
        =   types.flatMap((type) {
                value args = type.typeArguments;
                value overrides = type.varianceOverrides else null;
                return CeylonIterable(type.declaration.typeParameters).map((param) {
                    assert (exists arg = args.get(param));
                    value map = encodeType(arg, param);
                    if (exists override = overrides?.get(param)) {
                        map.put(keyUsVariance, override.ordinal());
                    }
                    return partiallyQualifiedName(param) -> map;
                });
            }).sequence();

    if (entries.empty) {
        return null;
    }
    return map(entries);
}

String partiallyQualifiedName(DeclarationModel d)
    =>  if (exists index = d.qualifiedNameString.firstInclusion("::"))
        then d.qualifiedNameString[index+2...]
        else d.qualifiedNameString;
