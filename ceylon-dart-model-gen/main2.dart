import "dart:mirrors";
import "dart:convert";
//import "dart:io";
//import "dart:typed_data";

// WEB ONLY
// import "dart:html";
// import "dart:indexed_db";
// import "dart:js";
// import "dart:svg";
// import "dart:web_audio";
//import "dart:web_gl";
//import "dart:web_sql";

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

Map<String, int> annotationBits = {
  "shared" : 1,
  "actual" : 1 << 1,
  "formal" : 1 << 2,
  "default" : 1 << 3,
  "sealed" : 1 << 4,
  "final" : 1 << 5,
  "native" : 1 << 6,
  "late" : 1 << 7,
  "abstract" : 1 << 8,
  "annotation" : 1 << 9,
  "variable" : 1 << 10,
  "serializable" : 1 << 11
};

Set<LibraryMirror> allowedLibraries;

/*
 *  FIXME include private declarations, since they are necessary for
 *        extends and satisfies
 */
main() {
//  // dart.async
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.async),
//    [currentMirrorSystem().findLibrary(#dart.core)]);
//
//  // dart.collection
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.collection),
//    [currentMirrorSystem().findLibrary(#dart.core)]);
//
//  // dart.convert
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.convert),
//    [currentMirrorSystem().findLibrary(#dart.core)]);
//
//  // dart.core
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.core), []);
//
//  // dart.developer
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.developer),
//    [currentMirrorSystem().findLibrary(#dart.core)]);
//
//  // dart.io
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.io),
//    [currentMirrorSystem().findLibrary(#dart.core),
//     currentMirrorSystem().findLibrary(#dart.async)]);
//
//  // dart.isolate
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.isolate),
//    [currentMirrorSystem().findLibrary(#dart.core),
//     currentMirrorSystem().findLibrary(#dart.async)]);
//
//  // dart.math
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.math),
//    [currentMirrorSystem().findLibrary(#dart.core)]);
//
//  // dart.mirrors
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.mirrors),
//    [currentMirrorSystem().findLibrary(#dart.core),
//     currentMirrorSystem().findLibrary(#dart.async)]);
//
//  // dart.typed_data
//  moduleToMap(
//    currentMirrorSystem().findLibrary(#dart.typed_data),
//    [currentMirrorSystem().findLibrary(#dart.core),
//     currentMirrorSystem().findLibrary(#dart.async)]);

  // dart.html
  moduleToMap(
    currentMirrorSystem().findLibrary(#dart.dom.html),
    [currentMirrorSystem().findLibrary(#dart.core),
     currentMirrorSystem().findLibrary(#dart.async),
     currentMirrorSystem().findLibrary(#dart.collection)]);

  // // dart.indexed_db
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.indexed_db),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);

  // // dart.js
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.js),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);

  // // dart.svg
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.svg),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);

  // // dart.web_audio
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.web_audio),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);

  // // dart.web_gl
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.web_gl),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);

  // // dart.web_sql
  // moduleToMap(
  //   currentMirrorSystem().findLibrary(#dart.web_sql),
  //   [currentMirrorSystem().findLibrary(#dart.core),
  //    currentMirrorSystem().findLibrary(#dart.async)]);
}

Map<String, Object> moduleToMap(LibraryMirror libraryMirror,
    Iterable<LibraryMirror> dependencies) {

  allowedLibraries = new Set<LibraryMirror>.from([libraryMirror])
      ..addAll(dependencies);

  var map = new Map<String, Object>();
  map["\$mod-bin"] = "9.0";

  map["\$mod-deps"] =
      [{"exp" : 1, "path" : "ceylon.language/1.3.0-DP3"}]..addAll(
      dependencies.map((d) => {"exp" : 1, "path" : moduleName(d) + "/1.3.0"}));

  map["\$mod-name"] = moduleName(libraryMirror);
  map["\$mod-version"] = "1.3.0";
  map[keyNativeDart] = true;

  var declarationMap = new Map<String, Object>();
  declarationMap["\$pkg-pa"] = 1; // TODO shared, for now
  libraryMirror.declarations.forEach((Symbol k, DeclarationMirror m) {
    if (m.isPrivate) {
      return;
    }
    if (m is VariableMirror) {
      // print("Variable: " + MirrorSystem.getName(m.simpleName).toString());
      declarationMap[MirrorSystem.getName(k)] = variableToMap(m, m, false);
    }
    if (m is MethodMirror && (m.isRegularMethod || m.isGetter)) {
      // print("Method: " + MirrorSystem.getName(m.simpleName).toString());
      declarationMap[MirrorSystem.getName(k)] = methodToMap(m, m, false);
    }
    else if (m is ClassMirror) {
      // print("-- Class: " + MirrorSystem.getName(k).toString() + " --");
      declarationMap[MirrorSystem.getName(k)] = classToInterfaceMap(m, m);
      declarationMap[MirrorSystem.getName(k) + "_C"] = classToClassMap(m, m);
    }
  });

  map[packageName(libraryMirror)] = declarationMap;

  // print("-- Module: " + moduleName(libraryMirror).toString() + " --");
  //print((new JsonEncoder.withIndent(" ")).convert(map));
  print(JSON.encode(map));

  //var file = new File("modules/" +  moduleName(libraryMirror) + "-1.3.0-dartmodel.json");
  //file.writeAsString(JSON.encode(map));

  return map;
}

Map<String, Object> classToInterfaceMap(ClassMirror cm, TypeMirror from) {
  // interface
  var map = new Map<String, Object>();

  var methods = methodsToMap(cm.declarations.values, from, true);
  if (!methods.isEmpty) {
    map[keyMethods] = methods;
  }

  var attributes = attributesToMap(cm.declarations.values, from, true);
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

  // FIXME using 'cm.superclass.mixin' instead of 'cm.superclass' is wrong.
  // It's used as a hack/workaround due to difficulties using the mirror api to
  // determine 1) the actual extended type (when mixins are present,
  // cm.superclass represents some sort of combined class), and 2) a
  // comprehensive list of mixins (cm.superclass.mixin seems to provide only
  // the last mixin, but we'll need all of them.)
  List<ClassMirror> interfaces =
    null != cm.superclass ? [cm.superclass.mixin] : [];

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
    // don't erase in typeToMap...
    .map((m) => typeToMap(m, from, false, false)).toList();

  // print("satisfies (i): " + map[keySatisfies].toString());

  // Also add the class as a static member class named ".Class"
  var classMap = classToClassMap(cm, from);
  classMap[keyName] = "Class";
  classMap[keyStatic] = true;
  map[keyClasses] = { "Class" : classMap };

  return map;
}

Map<String, Object> classToClassMap(ClassMirror cm, TypeMirror from) {
  // class
  var map = new Map<String, Object>();

  var methods = methodsToMap(cm.declarations.values, from, false);
  if (!methods.isEmpty) {
    map[keyMethods] = methods;
  }

  var attributes = attributesToMap(cm.declarations.values, from, false);
  if (!attributes.isEmpty) {
    map[keyAttributes] = attributes;
  }

  map[keyMetatype] = metatypeClass;
  map[keyName] = MirrorSystem.getName(cm.simpleName) + "_C";

  // TODO better annotations. 'abstract', other?
  map[keyPackedAnns] = 1;

  var typeParameters = typeParameterList(cm.declarations.values, from);
  if (!typeParameters.isEmpty) {
    map[keyTypeParams] = typeParameters;
  }

  // Ignoring the superclass. It shouldn't be necessary since the class's
  // corresponding interface should satisfy the superclass's corresponding
  // interface, and, if the superclass is a mixin, things get screwed up
  // with the Dart mirrors api.
  // if (cm.superclass != null
  //     && cm.superclass != reflectClass(Object)
  //     && !cm.superclass.isPrivate) {
  //   map["super"] = typeToMap(cm.superclass, from, true);
  // }

  map["super"] = {
      keyModule : "\$",
      keyPackage : "\$",
      keyName : "Basic"
  };

  // satisfy the corresponding Ceylon interface, using all type paramters as
  // type arguments. Do not erase.
  map[keySatisfies] = [typeToMap(cm, from, false, false)];
  var typeArgs = typeArgumentMap(
      cm.declarations.values.where((d) => d is TypeVariableMirror), from);
  if (!typeArgs.isEmpty) {
    map[keySatisfies][0][keyTypeParams] = typeArgs;
  }

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
      if (name != "internal_") { // Internal without this 'if'
        constructors[key] = constructorToMap(d, from);
      }
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
    Iterable<DeclarationMirror> declarations, TypeMirror from,
    bool forceAbstract) {

  var map = new Map<String, Map<String, Object>>();
  for (var d in declarations) {
    if (d is VariableMirror && !d.isPrivate) {
      // print("-- Variable: " + MirrorSystem.getName(d.simpleName).toString() + " --");
      map[MirrorSystem.getName(d.simpleName)] =
          variableToMap(d, from, forceAbstract);
    }
    else if (d is MethodMirror && d.isGetter) {
      // print("-- Method:   " + MirrorSystem.getName(d.simpleName).toString() + " --");
      map[MirrorSystem.getName(d.simpleName)] =
          methodToMap(d, from, forceAbstract);
    }
  }
  return map;
}

Map<String, String> methodNameMap = {
    // list access and assignment operators
    "[]" : "get_",
    "[]=" : "set_",
    // additive operators
    "+" : "plus_",
    "-" : "minus_",
    // multiplicative operators
    "*" : "times_",
    "/" : "divided_",
    "~/" : "dividedInt_",
    "%" : "remainder_",
    // relational operators
    ">" : "largerThan_",
    "<" : "smallerThan_",
    ">=" : "notSmallerThan_",
    "<=" : "notLargerThan_",
    // bitwise operators
    "|" : "or_",
    "^" : "xor_",
    "&" : "and_",
    // shift operator
    "<<" : "shiftLeft_",
    ">>" : "shiftRight_"
};

Map<String, Map<String, Object>> methodsToMap(
    Iterable<DeclarationMirror> declarations, TypeMirror from,
    bool forceAbstract) {

  var map = new Map<String, Map<String, Object>>();
  for (var d in declarations) {
    if (d is MethodMirror && d.isRegularMethod) {
      // print("-- Method: " + MirrorSystem.getName(d.simpleName).toString() + " --");

      var dartName = MirrorSystem.getName(d.simpleName);
      var ceylonName = methodNameMap[dartName];
      map[null != ceylonName ? ceylonName : dartName] =
          methodToMap(d, from, forceAbstract);
    }
  }
  return map;
}

Map<String, Object> variableToMap(VariableMirror mm, DeclarationMirror from,
    bool forceAbstract) {
  var map = new Map();
  map[keyType] = typeToMap(mm.type, from); // TODO what about void?

  if (!mm.isFinal && !mm.isConst) {
    map["\$set"] = { keyMetatype : metatypeSetter };
  }
  map[keyMetatype] = metatypeGetter;
  map[keyName] = MirrorSystem.getName(mm.simpleName);

  map[keyPackedAnns] = annotationBits["shared"];
  if (forceAbstract) {
    // FIXME for now, making all members "default" since we're not getting
    // reliable info for implemented members for classes like IterableBase
    //map[keyPackedAnns] |= annotationBits["formal"];
    map[keyPackedAnns] |= annotationBits["default"];
  }
  else {
    map[keyPackedAnns] |= annotationBits["default"];
  }

  if (mm.isStatic) {
    map[keyStatic] = true;
  }
  return map;
}

Map<String, Object> methodToMap(MethodMirror mm, DeclarationMirror from,
    bool forceAbstract) {

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

  map[keyPackedAnns] = annotationBits["shared"];
  if (forceAbstract || mm.isAbstract) {
    // FIXME for now, making all members "default" since we're not getting
    // reliable info for implemented members for classes like IterableBase
    //map[keyPackedAnns] |= annotationBits["formal"];
    map[keyPackedAnns] |= annotationBits["default"];
  }
  else {
    map[keyPackedAnns] |= annotationBits["default"];
  }

  if (!mm.isGetter) {
    map[keyParams] = [parametersToList(mm.parameters, from)];
  }

  if (mm.isStatic) {
    map[keyStatic] = true;
  }
  return map;
}

List<Map<String, Object>> parametersToList(List<ParameterMirror> parameters,
    DeclarationMirror from) {
  return parameters.map((pm) {
    var map = new Map();
    var pt = pm.type;
    if (pt is FunctionTypeMirror) {
      map["\$pt"] = "f";
      // Don't erase! Callable's are generic, so there is no automatic
      // type erasure.
      map[keyType] = typeToMap(pt.returnType, from, false, false);
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

List<Map<String, Object>> typeArgumentMap(
    Iterable<DeclarationMirror> typeArguments, DeclarationMirror from) {
  return typeArguments.where((tm) => tm is TypeMirror).map((tm) {
    var map = typeToMap(tm, from, false, false); // keyModule, keyName
    map[keyMetatype] = metatypeTypeParameter;
    return map;
  }).toList();
}

Map<String, Object> typeToMap(
    TypeMirror tm, DeclarationMirror from, [bool isClass = false, bool erase = true]) {

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
      map[keyName] = MirrorSystem.getName(tm.simpleName) + "_C";
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

String moduleName(DeclarationMirror tm) {
  if (tm is LibraryMirror) {
    return MirrorSystem.getName(tm.simpleName);
  }
  if (null != tm) {
    return moduleName(tm.owner);
  }
  return "**UNKNOWN_MODULE_NAME**";
}

String packageName(DeclarationMirror tm) {
  if (tm is LibraryMirror) {
    return MirrorSystem.getName(tm.simpleName);
  }
  if (null != tm) {
    return packageName(tm.owner);
  }
  return "**UNKNOWN_PACKAGE_NAME**";
}
