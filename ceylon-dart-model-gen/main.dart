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
const keyDynamic       = "dyn";
const keyStatic       = "sta";

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

main() {
  //var dcMirror = currentMirrorSystem().findLibrary(#dart.io);
  //var dcMirror = currentMirrorSystem().findLibrary(new Symbol("dart.io"));
  var dcMirror = currentMirrorSystem().findLibrary(#dart.async);

  var jsonMap = new Map<String, Object>();
  jsonMap["\$mod-bin"] = "9.0";
  jsonMap["\$mod-deps"] = ["ceylon.language/1.2.1-DP2-SNAPSHOT"];
  jsonMap["\$mod-name"] = moduleName(dcMirror);
  jsonMap["\$mod-version"] = "1.2.1";

  var declarationMap = new Map<String, Object>();
  declarationMap["\$pkg-pa"] = 1; // TODO shared, for now
  dcMirror.declarations.forEach((Symbol k, DeclarationMirror m) {
    if (m.isPrivate) {
      return;
    }
    if (k != #Future
        && k != #Stream
        // && k != #StreamView
        && k != #StreamSubscription) {
      return;
    }
    if (m is MethodMirror && m.isRegularMethod) {
      // TODO toplevel functions
      //print("Method: " + MirrorSystem.getName(m.simpleName).toString());
    }
    else if (m is ClassMirror) {
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
  map[keyMetatype] = metatypeInterface;
  map[keyName] = MirrorSystem.getName(cm.simpleName);

  // TODO better annotations?
  map[keyPackedAnns] = 1;

  var typeParameters = typeParameterList(cm.declarations.values, from);
  if (!typeParameters.isEmpty) {
    map[keyTypeParams] = typeParameters;
  }

  List<ClassMirror> interfaces = [cm.superclass];
  interfaces.addAll(cm.superinterfaces);
  map[keySatisfies] = interfaces
    .where((t) {
      return t != reflectClass(Object);
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
  map[keyMetatype] = metatypeClass;
  map[keyName] = "C_" + MirrorSystem.getName(cm.simpleName);

  // TODO better annotations. 'abstract', other?
  map[keyPackedAnns] = 1;

  var typeParameters = typeParameterList(cm.declarations.values, from);
  if (!typeParameters.isEmpty) {
    map[keyTypeParams] = typeParameters;
  }

  if (cm.superclass != reflectClass(Object)) {
    map["super"] = typeToMap(cm.superclass, from, true);
  }

  // satisfy the corresponding Ceylon interface
  List<ClassMirror> interfaces = [cm];
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
    if (d is MethodMirror && d.isConstructor
        && d.constructorName != #delayed
        && d.constructorName != #error
        && d.simpleName != #Stream.eventTransformed
        && d.simpleName != #Stream.fromIterable
        && d.simpleName != #Stream.periodic
        && d.simpleName != #Stream.fromFutures) {
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

Map<String, Map<String, Object>> methodsToMap(
    Iterable<DeclarationMirror> declarations, TypeMirror from) {
  var map = new Map<String, Map<String, Object>>();
  for (var d in declarations) {
    if (d.simpleName != #then
        && d.simpleName != #whenComplete
        && d.simpleName != #listen
        && d.simpleName != #doWhile) {
      continue;
    }
    if (d is MethodMirror) {
      map[MirrorSystem.getName(d.simpleName)] = methodToMap(d, from);
    }
  }
  return map;
}

Map<String, Object> methodToMap(MethodMirror mm, TypeMirror from) {
  var map = new Map();
  map[keyType] = typeToMap(mm.returnType, from); // TODO what about void?
  map[keyMetatype] = metatypeMethod;
  map[keyName] = MirrorSystem.getName(mm.simpleName);
  map[keyPackedAnns] = 5; // TODO 'shared formal' for now
  map[keyParams] = [parametersToList(mm.parameters, from)];
  if (mm.isStatic) {
    map[keyStatic] = true;
  }
  return map;
}

List<Map<String, Object>> parametersToList(List<ParameterMirror> parameters,
    TypeMirror from) {
  return parameters
  .where((p) =>
        p.simpleName != #onError
        && p.simpleName != #onDone
        && p.simpleName != #cancelOnError)
  .map((pm) {
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
    }

    // TODO defaulted, named

    return map;
  }).toList();
}

List<Map<String, Object>> typeArgumentMap(List<TypeMirror> typeArguments,
    TypeMirror from) {
  return typeArguments.map((tm) {
    var map = typeToMap(tm, from); // keyModule, keyName
    map[keyMetatype] = metatypeTypeParameter;
    return map;
  }).toList();
}

Map<String, Object> typeToMap(
    TypeMirror tm, TypeMirror from, [bool isClass = false]) {
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
