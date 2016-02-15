import "dart:mirrors";
import "dart:convert";
import "dart:io";

const keyClasses       = "\$c";
const keyInterfaces    = "\$i";
const keyObjects       = "\$o";
const keyMethods       = "\$m";
const keyAttributes    = "\$at";
const keyAnnotations   = "an";
const keyPackedAnns    = "pa";
const keyType          = "\$t";
const keyReturnType    = "\$rt";
const keyTypes         = "l";
const keyTypeParams    = "tp";
const keyMetatype      = "mt";
const keyModule        = "md";
const keyName          = "nm";
const keyPackage       = "pk";
const keyParams        = "ps";
const keySelfType      = "st";
const keySatisfies     = "sts";
const keyDsVariance    = "dv"; //declaration-site variance
const keyUsVariance    = "uv"; //use-site variance
const keyConstructors  = "\$cn";
const keyFlags         = "\$ff";

const keyDefault       = "def";
const keyNamed         = "nam";
const keyDynamic       = "dyn";
const keyStatic        = "sta";

const keyNativeDart   = "\$mod-native-dart";

const metatypeClass           = "c";
const metatypeInterface       = "i";
const metatypeAlias           = "als";
const metatypeObject          = "o";
const metatypeMethod          = "m";
const metatypeAttribute       = "a";
const metatypeGetter          = "g";
const metatypeSetter          = "s";
const metatypeTypeParameter   = "tp";
const metatypeParameter       = "prm";


Set<LibraryMirror> allowedLibraries;

/*
 *  FIXME
 *    - include private declarations, since they are necessary for
 *      extends and satisfies
 *
 *    - for Ceylon classes, include type arguments when satisfying the
 *      corresponding Ceylon interface
 */
main() {
  var jsonMap = new Map<String, Object>();
  jsonMap["\$mod-bin"] = "9.0";

  // // for CORE
  // var dcMirror = currentMirrorSystem().findLibrary(#dart.core);
  // jsonMap["\$mod-deps"] = ["ceylon.language/1.2.1-DP2-SNAPSHOT"];
  // allowedLibraries = new Set<LibraryMirror>.from([dcMirror]);
  // // jsonMap["\$mod-deps"] = [
  // //   "ceylon.language/1.2.1-DP2-SNAPSHOT",
  // //   {"exp" : 1, "path" : "interop.dart.math/1.2.1"},
  // // ];

  // // for MATH
  // var dcMirror = currentMirrorSystem().findLibrary(#dart.math);
  // jsonMap["\$mod-deps"] = [
  //   "ceylon.language/1.2.1-DP2-SNAPSHOT",
  //   {"exp" : 1, "path" : "interop.dart.core/1.2.1"},
  // ];
  // allowedLibraries = new Set<LibraryMirror>.from([
  //   dcMirror, currentMirrorSystem().findLibrary(#dart.core)
  // ]);

  // // for IO
  // var dcMirror = currentMirrorSystem().findLibrary(#dart.io);
  // jsonMap["\$mod-deps"] = [
  //   "ceylon.language/1.2.1-DP2-SNAPSHOT",
  //   {"exp" : 1, "path" : "interop.dart.core/1.2.1"},
  //   {"exp" : 1, "path" : "interop.dart.async/1.2.1"}
  // ];
  // allowedLibraries = new Set<LibraryMirror>.from([dcMirror,
  //   currentMirrorSystem().findLibrary(#dart.core),
  //   currentMirrorSystem().findLibrary(#dart.async)
  // ]);

  // for ASYNC
  var dcMirror = currentMirrorSystem().findLibrary(#dart.async);
  jsonMap["\$mod-deps"] = [
    "ceylon.language/1.2.1-DP2-SNAPSHOT",
   {"exp" : 1, "path" : "interop.dart.core/1.2.1"}
  ];
  allowedLibraries = new Set<LibraryMirror>.from([dcMirror,
    currentMirrorSystem().findLibrary(#dart.core),
  ]);

  jsonMap["\$mod-name"] = moduleName(dcMirror);
  jsonMap["\$mod-version"] = "1.2.1";
  jsonMap[keyNativeDart] = true;

  var declarationMap = new Map<String, Object>();
  declarationMap["\$pkg-pa"] = 1; // TODO shared, for now
  dcMirror.declarations.forEach((Symbol k, DeclarationMirror m) {
    if (m.isPrivate) {
      return;
    }
    if (m is MethodMirror && m.isRegularMethod) {
      // TODO toplevel functions
      //print("Method: " + MirrorSystem.getName(m.simpleName).toString());
    }
    else if (m is ClassMirror) {
      print("-- Class: " + MirrorSystem.getName(k).toString() + " --");
      declarationMap[MirrorSystem.getName(k)] = classToInterfaceMap(m, m);
      declarationMap["C_" + MirrorSystem.getName(k)] = classToClassMap(m, m);
    }
  });

  jsonMap[packageName(dcMirror)] = declarationMap;
  print("-- Module: " + moduleName(dcMirror).toString() + " --");
  print(JSON.encode(jsonMap));
}

Map<String, Object> classToInterfaceMap(ClassMirror cm, TypeMirror from) {
  // interface
  var map = new Map<String, Object>();

  var methods = methodsToMap(cm.declarations.values, from);
  if (!methods.isEmpty) {
    map[keyMethods] = methods;
  }

  var attributes = attributesToMap(cm.declarations.values, from);
  if (!attributes.isEmpty) {
    map[keyAttributes] = attributes;
  }

  map[keyMetatype] = metatypeInterface;
  map[keyName] = MirrorSystem.getName(cm.simpleName);

  // TODO better annotations?
  map[keyPackedAnns] = 1;

  var typeParameters = typeParameterList(cm.declarations.values, from);
  if (!typeParameters.isEmpty) {
    map[keyTypeParams] = typeParameters;
  }

  // FIXME always satisfy Identifiable

  List<ClassMirror> interfaces = [cm.superclass];
  interfaces.addAll(cm.superinterfaces);
  map[keySatisfies] = interfaces
    .where((t) {
      return t != null
        && !t.isPrivate
        && t.owner != null
        && t != reflectClass(Object)
        // TODO make this configurable
        // exclude dart._internal.EfficientLength and others?
        && MirrorSystem.getName(t.owner.qualifiedName) != "dart._internal";
    })
    .map((m) => typeToMap(m, from)).toList();

  // print("satisfies (i): " + map[keySatisfies].toString());

  return map;
}

Map<String, Object> classToClassMap(ClassMirror cm, TypeMirror from) {
  // class
  var map = new Map<String, Object>();

  var methods = methodsToMap(cm.declarations.values, from);
  if (!methods.isEmpty) {
    map[keyMethods] = methods;
  }

  var attributes = attributesToMap(cm.declarations.values, from);
  if (!attributes.isEmpty) {
    map[keyAttributes] = attributes;
  }

  map[keyMetatype] = metatypeClass;
  map[keyName] = "C_" + MirrorSystem.getName(cm.simpleName);

  // TODO better annotations. 'abstract', other?
  map[keyPackedAnns] = 1;

  var typeParameters = typeParameterList(cm.declarations.values, from);
  if (!typeParameters.isEmpty) {
    map[keyTypeParams] = typeParameters;
  }

  if (cm.superclass != null
      && cm.superclass != reflectClass(Object)
      && !cm.superclass.isPrivate) {
    map["super"] = typeToMap(cm.superclass, from, true);
  }
  else {
    map["super"] = {
        keyModule : "\$",
        keyPackage : "\$",
        keyName : "Basic"
    };
  }

  // satisfy the corresponding Ceylon interface
  map[keySatisfies] = [typeToMap(cm, from)];

  // print("satisfies (c): " + map[keySatisfies].toString());
  // print("extends   (c): " + map["super"].toString());

  // FIXME Present static constructors as static methods? But... they need
  //       `new`, and, some don't have names. Somehow, we need to disallow
  //       extension for d.isFactoryConstructor

  var constructors = new Map();
  for (var d in cm.declarations.values) {
    // if (d is MethodMirror
    //  && (d.isGenerativeConstructor || d.isRedirectingConstructor)) {
    if (d is MethodMirror && d.isConstructor) {
      var name = MirrorSystem.getName(d.constructorName);
      var key = name.isNotEmpty ? name : "\$def";
      constructors[key] = constructorToMap(d, from);
    }
  }
  map[keyConstructors] =  constructors;
  return map;
}

Map<String, Object> constructorToMap(MethodMirror mm, TypeMirror from) {
  var map = new Map();
  var name = MirrorSystem.getName(mm.constructorName);
  // var key = name.isNotEmpty ? name : "\$def";
  if (name.isNotEmpty) {
    map[keyName] = name;
  }
  map[keyPackedAnns] = 1; // TODO shared for now
  map[keyParams] = parametersToList(mm.parameters, from);
  return map;
}

// TODO take Iterable<TypeVariableMirror>, but, how can the caller provide the
//      right generic Iterable type?
List<Map<String, Object>> typeParameterList(
    Iterable<DeclarationMirror> typeVariables, TypeMirror from) {
  return typeVariables
    .where((d) => d is TypeVariableMirror)
    .map((tp) => {
      keyDsVariance : "out", // Always covariant. For now at least...
      keyName : MirrorSystem.getName(tp.simpleName)
    })
    .toList();
}

Map<String, Map<String, Object>> attributesToMap(
    Iterable<DeclarationMirror> declarations, TypeMirror from) {
  var map = new Map<String, Map<String, Object>>();
  for (var d in declarations) {
    if (d is VariableMirror && !d.isPrivate) {
      print("-- Variable: " + MirrorSystem.getName(d.simpleName).toString() + " --");
      map[MirrorSystem.getName(d.simpleName)] = variableToMap(d, from);
    }
    else if (d is MethodMirror && d.isGetter) {
      print("-- Method:   " + MirrorSystem.getName(d.simpleName).toString() + " --");
      map[MirrorSystem.getName(d.simpleName)] = methodToMap(d, from);
    }
  }
  return map;
}

Map<String, Map<String, Object>> methodsToMap(
    Iterable<DeclarationMirror> declarations, TypeMirror from) {
  var map = new Map<String, Map<String, Object>>();
  for (var d in declarations) {
    if (d is MethodMirror && d.isRegularMethod) {
      print("-- Method: " + MirrorSystem.getName(d.simpleName).toString() + " --");
      map[MirrorSystem.getName(d.simpleName)] = methodToMap(d, from);
    }
  }
  return map;
}

Map<String, Object> variableToMap(VariableMirror mm, TypeMirror from) {
  var map = new Map();
  map[keyType] = typeToMap(mm.type, from); // TODO what about void?

  if (!mm.isFinal && !mm.isConst) {
    map["\$set"] = { keyMetatype : metatypeSetter };
  }
  map[keyMetatype] = metatypeGetter;
  map[keyName] = MirrorSystem.getName(mm.simpleName);
  map[keyPackedAnns] = 5; // TODO 'shared formal' for now

  if (mm.isStatic) {
    map[keyStatic] = true;
  }
  return map;
}

Map<String, Object> methodToMap(MethodMirror mm, TypeMirror from) {
  var map = new Map();
  map[keyType] = typeToMap(mm.returnType, from); // TODO what about void?

  if (mm.isGetter) {
    // FIXME Find a way to determine if a setter exists. We could search
    //       the owner for a declaration named 'theAttribute=', but then,
    //       it may actually be the owner's supertype that declares the
    //       setter.
    //
    //       For now, just add a setter for all getters.
    //       See also https://github.com/dart-lang/sdk/issues/10975
    map["\$set"] = { keyMetatype : metatypeSetter };
    map[keyMetatype] = metatypeGetter;
  }
  else {
    map[keyMetatype] = metatypeMethod;
  }
  map[keyName] = MirrorSystem.getName(mm.simpleName);
  map[keyPackedAnns] = 5; // TODO 'shared formal' for now
  if (!mm.isGetter) {
    map[keyParams] = [parametersToList(mm.parameters, from)];
  }

  if (mm.isStatic) {
    map[keyStatic] = true;
  }
  return map;
}

List<Map<String, Object>> parametersToList(List<ParameterMirror> parameters,
    TypeMirror from) {
  return parameters.map((pm) {
    var map = new Map();
    var pt = pm.type;
    if (pt is FunctionTypeMirror) {
      map["\$pt"] = "f";
      map[keyType] = typeToMap(pt.returnType, from);
      map[keyMetatype] = metatypeParameter;
      map[keyName] = MirrorSystem.getName(pm.simpleName);
      List plist = parametersToList(pt.parameters, from);
      if (plist.isNotEmpty) {
        map[keyParams] = [plist];
      }
    }
    else {
      map[keyType] = typeToMap(pm.type, from);
      map[keyMetatype] = metatypeParameter;
      map[keyName] = MirrorSystem.getName(pm.simpleName);
      if (pm.isNamed) {
        map[keyNamed] = true;
      }
    }
    if (pm.isOptional) {
      map[keyDefault] = true;
    }

    // TODO defaulted, named

    return map;
  }).toList();
}

List<Map<String, Object>> typeArgumentMap(List<TypeMirror> typeArguments,
    TypeMirror from) {
  return typeArguments.map((tm) {
    var map = typeToMap(tm, from, false, false); // keyModule, keyName
    map[keyMetatype] = metatypeTypeParameter;
    return map;
  }).toList();
}

Map<String, Object> typeToMap(
    TypeMirror tm, TypeMirror from, [bool isClass = false, bool erase = true]) {

  // FIXME tm is null sometimes

  if (tm == reflectClass(Object)
      // For now, use Anything for modules we can't import until cyclic
      // dependencies work
      || (tm is ClassMirror && !allowedLibraries.contains(tm.owner))
      || (null != tm && tm.isPrivate)) {
    return {
        keyModule : "\$",
        keyPackage : "\$",
        keyName : "Anything"
    };
  }
  if (erase) {
    if (tm == reflectClass(String)) {
      return {
          keyModule : "\$",
          keyPackage : "\$",
          keyName : "String"
      };
    }
    if (tm == reflectClass(int)) {
      return {
          keyModule : "\$",
          keyPackage : "\$",
          keyName : "Integer"
      };
    }
    if (tm == reflectClass(double)) {
      return {
          keyModule : "\$",
          keyPackage : "\$",
          keyName : "Float"
      };
    }
    if (tm == reflectClass(bool)) {
      return {
          keyModule : "\$",
          keyPackage : "\$",
          keyName : "Boolean"
      };
    }
  }

  var fromModuleName = moduleName(from);
  var fromPackageName = packageName(from);
  var tmModuleName = moduleName(tm);
  var tmPackageName = packageName(tm);

  // TODO map to ceylon types for non-generic String, int, float, bool
  var map = new Map();
  if (tm is FunctionTypeMirror) {
    map[keyModule] = "\$";
    map[keyPackage] = "\$";
    map[keyName] = "Callable";
    // TODO return type & tuple for argument types, or just
    //      Callable<Anything, Nothing> or Callable<Nothing, Anything[]> for
    //      for params and returns?
  }
  else if (tm is ClassMirror) {
    if (isClass) {
      map[keyName] = "C_" + MirrorSystem.getName(tm.simpleName);
    }
    else {
      map[keyName] = MirrorSystem.getName(tm.simpleName);
    }

    // TODO use "$" for ceylon.language
    if (tmPackageName != fromPackageName) {
      map[keyPackage] = tmPackageName;
    }
    else {
      // use "." for same package as from's package
      map[keyPackage] = ".";
    }

    // TODO use "$" for ceylon.language
    if (tmModuleName != fromModuleName) {
      map[keyModule] = tmModuleName;
    }

    var tam = typeArgumentMap(tm.typeArguments, from);
    if (tam.isNotEmpty) {
      map[keyTypeParams] = tam;
    }
  }
  else if (tm is TypeVariableMirror) {
    // TODO make sure this works (type is type parameter)
    map[keyName] = MirrorSystem.getName(tm.simpleName);
  }
  else {
    // it must be dynamic
    map[keyModule] = "\$";
    map[keyName] = "Anything";
    map[keyPackage] = "\$";
  }
  return map;
}

String moduleName(Object tm) {
  if (tm is LibraryMirror) {
    return "interop." + MirrorSystem.getName(tm.simpleName);
  }
  else if (tm is ClassMirror) {
    return moduleName(tm.owner);
  }
  return "**UNKNOWN_MODULE_NAME**";
}

String packageName(Object tm) {
  if (tm is LibraryMirror) {
    return "interop." + MirrorSystem.getName(tm.simpleName);
  }
  else if (tm is ClassMirror) {
    return packageName(tm.owner);
  }
  return "**UNKNOWN_PACKAGE_NAME**";
}
