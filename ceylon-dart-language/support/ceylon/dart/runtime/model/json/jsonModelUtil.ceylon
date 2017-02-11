import ceylon.dart.runtime.model {
    Scope,
    Type,
    Functional,
    FunctionOrValue,
    Constructor,
    CallableConstructor,
    ValueConstructor,
    Declaration,
    TypeParameter,
    Variance,
    TypeDeclaration,
    covariant,
    contravariant,
    ClassWithInitializer,
    ClassWithConstructors,
    Annotation,
    Function,
    Package,
    invariant,
    InterfaceDefinition,
    Class,
    ClassAlias,
    Interface,
    InterfaceAlias,
    Parameter,
    ParameterList,
    Value,
    Setter,
    TypeAlias,
    unionDeduped,
    intersectionDedupedCanonical
}
import ceylon.dart.runtime.model.internal {
    assertedTypeDeclaration,
    eq
}

shared
object jsonModelUtil {

    function getModuleName(JsonObject json)
        =>  if (is String m = json[keyModule])
            then if (m == "$")
                 then "ceylon.language"
                 else m
            else null;

    function getPackageName(Scope scope, JsonObject json)
        =>  if (is String m = json[keyPackage])
            then if (m == "$") then
                    "ceylon.language"
                 else if (m == ".") then
                    // TODO building a name just to tear it down, and then
                    //      rebuild it...
                    ".".join(scope.pkg.name)
                 else m
            else null;

    TypeDeclaration declarationFromType(Scope scope, JsonObject json) {
        value packageName = getPackageName(scope, json);
        if (!exists packageName) {
            "The type is a type parameter in scope"
            assert (is TypeParameter result
                =   scope.getBase(getString(json, keyName)));
            return result;
        }
        else {
            "The found declaration will be a type or a value for an anonymous class"
            assert (is Value | TypeDeclaration declaration
                =   scope.findDeclaration {
                        declarationName = getString(json, keyName).split('.'.equals);
                        packageName;
                        moduleName = getModuleName(json);
                    });
            if (is Value declaration) {
                "If the found declaration is a value, the value's type's declaration
                 must be an anonymous class"
                assert (is Class result = declaration.type.declaration,
                        result.isAnonymous);
                return result;
            }
            return declaration;
        }
    }

    "The input map be:

     - A [[JsonArray]], with each element being a [[JsonObject]] representing a type
       argument, in order of the type's type parameters, or

     - a [[JsonObject]], mapping qualified type parameter names to types.

     - or [[null]], in which case `null` will be returned."
    [Map<TypeParameter, Type>, Map<TypeParameter, Variance>]
    typeArgumentMaps(TypeDeclaration declaration, Scope scope, JsonArray | JsonObject | Null json) {
        function useSiteOverrideEntry(
                TypeParameter typeParameter, JsonObject typeArgumentJson) {

            switch (override = typeArgumentJson.get(keyUsVariance))
                case (is Null) {
                    return null;
                }
                case (0) {
                    return typeParameter -> covariant;
                }
                case (1) {
                    return typeParameter -> contravariant;
                }
                else {
                    throw Exception(
                        "Invalid use site variance value ``override``");
            }
        }

        switch (json)
        case (is Null) {
            return [emptyMap, emptyMap];
        }
        case (is JsonArray) {
            // TODO does JsonArray still occur? Probably for dart interop models
            value typeArgs
                =   map(mapPairs((TypeParameter typeParameter, Anything jsonType) {
                        assert (is JsonObject jsonType);
                        return typeParameter -> parseType(scope, jsonType);
                    }, declaration.typeParameters, json));

            value overrides
                =   map(mapPairs((TypeParameter typeParameter, Anything jsonTypeArgument) {
                        assert (is JsonObject jsonTypeArgument);
                        return useSiteOverrideEntry(typeParameter, jsonTypeArgument);
                    }, declaration.typeParameters, json).coalesced);

            return [typeArgs, overrides];
        }
        else { // is JsonObject
            value typeParametersToJson
                =   json.map((name -> jsonType) {
                        value typeParameter
                            =   declaration.findDeclaration(name.split('.'.equals));

                        if (!is TypeParameter typeParameter) {
                            throw Exception(
                                "cannot find type parameter for name ``name``");
                        }
                        return typeParameter -> jsonType;
                    });

            value typeArgs
                =   map(typeParametersToJson.map((typeParameter -> jsonType) {
                        assert (is JsonObject jsonType);
                        return typeParameter -> parseType(scope, jsonType);
                    }));

            value overrides
                =   map(typeParametersToJson.map((typeParameter -> jsonTypeArgument) {
                        assert (is JsonObject jsonTypeArgument);
                        return useSiteOverrideEntry(typeParameter, jsonTypeArgument);
                    }).coalesced);

            return [typeArgs, overrides];
        }
    }

    shared
    [String+] parseModuleName(JsonObject json) {
        assert (nonempty result
            =   getString(json, keyModuleName).split('.'.equals).sequence());
        return result;
    }

    shared
    String? parseModuleVersion(JsonObject json)
        =>  getStringOrNull(json, keyModuleVersion);

    function toAnnotations(JsonObject json)
        // TODO once https://github.com/ceylon/ceylon/issues/6783 is fixed, the input
        //      will be an array. Actually... need fully qualified name.
        //      Should the name be for the annotation constructor or the annotation
        //      class? The constructor is less useful, since we wouldn't be able to do
        //      things like annotations.contains("ceylon.language::Shared").
        =>  json.collect((name->args) {
                assert (is JsonArray args);
                return Annotation {
                    name;
                    args.collect((arg) {
                        assert (is String arg);
                        return arg;
                    });
                };
            });

    shared
    [Annotation*] parseModuleAnnotations(JsonObject json)
        =>  toAnnotations(getObjectOrEmpty(json, keyModuleAnnotations));

    shared
    [Annotation*] parsePackageAnnotations(JsonObject json)
        =>  toAnnotations(getObjectOrEmpty(json, keyPackageAnnotations));

    shared
    Boolean parsePackageSharedAnnotation(JsonObject json)
        =>  getIntegerOrNull(json, keyPackedAnnotations)?.get(sharedBit) else false;

    shared
    Type parseType(Scope scope, JsonObject json) {
        if (exists compositeType = getStringOrNull(json, keyCompositeType)) {
            switch (compositeType)
            case ("u") {
                return unionDeduped {
                    getArrayOrEmpty(json, keyTypes).collect((j) {
                        assert (is JsonObject j);
                        return parseType(scope, j);
                    });
                    scope.unit;
                };
            }
            case ("i") {
                return intersectionDedupedCanonical {
                    getArrayOrEmpty(json, keyTypes).collect((j) {
                        assert (is JsonObject j);
                        return parseType(scope, j);
                    });
                    scope.unit;
                };
            }
            else {
                throw AssertionError("Unexpected composite type ``compositeType``");
            }
        }

        return if (getString(json, keyName) == "$U")
            then scope.unit.unknownType
            else
                let (declaration
                        = declarationFromType(scope, json),
                    [typeArguments, overrides]
                        =   typeArgumentMaps {
                                declaration;
                                scope;
                                getObjectOrArrayOrNull(json, keyTypeArgs)
                                else getObjectOrArrayOrNull(json, keyTypeParams);
                            })
                declaration.type.substitute(typeArguments, overrides);
    }

    Variance parseDsVariance(JsonObject json) {
        if (is String dv = json[keyDsVariance]) {
            switch (dv)
            case ("out") {
                return covariant;
            }
            case ("in") {
                return contravariant;
            }
            else {
                throw Exception("invalid variance ``dv``");
            }
        }
        return invariant;
    }

    {Declaration*} parseMembers(Scope scope, JsonObject json, String? selfTypeName)
        =>  expand {
                // TypeParameters
                if (is Declaration scope)
                    then parseTypeParameters {
                        scope;
                        getArrayOrEmpty(json, keyTypeParams);
                        selfTypeName;
                    }
                    else [],
                // Classes
                getObjectOrEmpty(json, keyClasses).items.map((classJson) {
                    assert (is JsonObject classJson);
                    return parseClass(scope, classJson);
                }),
                // Constructors
                if (is Class scope)
                    then getObjectOrEmpty(json, keyConstructors)
                        .map((_ -> constructorJson) {
                            assert (is JsonObject constructorJson);
                            return parseConstructor(scope, constructorJson);
                        })
                    else [],
                // Interfaces
                getObjectOrEmpty(json, keyInterfaces).items.map((interfaceJson) {
                    assert (is JsonObject interfaceJson);
                    return parseInterface(scope, interfaceJson);
                }),
                // Functions
                getObjectOrEmpty(json, keyMethods).items.map((methodJson) {
                    assert (is JsonObject methodJson);
                    return parseFunction(scope, methodJson);
                }),
                // Values and Setters
                getObjectOrEmpty(json, keyAttributes).items
                    .map((valueJson) {
                        assert (is JsonObject valueJson);
                        return valueJson;
                    })
                    .filter((valueJson) => !eq(metatypeAlias, valueJson[keyMetatype]))
                    .flatMap((valueJson) => parseValue(scope, valueJson)),
                // TypeAlias, which happen to be keyAttributes!
                getObjectOrEmpty(json, keyAttributes).items
                    .map((valueJson) {
                        assert (is JsonObject valueJson);
                        return valueJson;
                    })
                    .filter((valueJson) => eq(metatypeAlias, valueJson[keyMetatype]))
                    .map((valueJson) => parseTypeAlias(scope, valueJson)),
                // Objects
                getObjectOrEmpty(json, keyObjects).items.flatMap((classJson) {
                    assert (is JsonObject classJson);
                    return parseObject(scope, classJson);
                })
            };

    shared
    TypeParameter parseTypeParameter
            (Declaration scope, JsonObject json, TypeDeclaration? selfTypeDeclaration)
        =>  TypeParameter {
                container = scope;
                name = getString(json, keyName);
                variance = parseDsVariance(json);
                isTypeConstructor = false; // TODO
                selfTypeDeclaration = selfTypeDeclaration;
                defaultTypeArgumentLG
                    =   if (exists da = getObjectOrNull(json, keyDefault))
                        then typeFromJsonLG(da)
                        else null;

                caseTypesLG
                    =   getArrayOrEmpty(json, keyCases).map((s) {
                            assert (is JsonObject s);
                            return typeFromJsonLG(s);
                        });

                satisfiedTypesLG
                    =   getArrayOrEmpty(json, keySatisfies).map((s) {
                            assert (is JsonObject s);
                            return typeFromJsonLG(s);
                        });
            };

    {TypeParameter*} parseTypeParameters(
            Declaration scope,
            JsonArray typeParametersJson,
            String? selfTypeName) {

        "The TypeDeclaration to use if this type parameter is a self type. Scope will not
         be a TypeDeclaration for Functions."
        value typeDeclaration
            =   if (is TypeDeclaration scope)
                then scope else null;

        return typeParametersJson.map((tpJson) {
            assert (is JsonObject tpJson);
            value name = getString(tpJson, keyName);
            return parseTypeParameter {
                scope = scope;
                json = tpJson;
                selfTypeDeclaration
                    =   if (eq(selfTypeName, name))
                        then typeDeclaration
                        else null;
            };
        });
    }

    shared
    TypeAlias parseTypeAlias(Scope scope, JsonObject json) {
        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value declaration
            =   TypeAlias {
                    container = scope;
                    name = getString(json, keyName);
                    extendedTypeLG = typeFromJsonLG(getObject(json, keyAlias));
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    isShared = packedAnnotations.get(sharedBit);
                    isStatic = packedAnnotations.get(staticBit);
                };

        // For type parameters
        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = null;
            };
        };

        return declaration;
    }

    shared
    Function parseFunction(Scope scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value flags
            =   getIntegerOrNull(json, keyFlags) else 0;

        value declaration
            =   Function {
                    container = scope;
                    name = getString(json, keyName);
                    typeLG = typeFromJsonLG(getObject(json, keyType));
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    // what is "md.setDeferred((flags & 2) > 0);" in JsonPackage???
                    isDeclaredVoid = !flags.and(1).zero;
                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isAnnotation = packedAnnotations.get(annotationBit);
                    isStatic = packedAnnotations.get(staticBit);
                    isDynamic = json[keyDynamic] exists;
                };

        // value ParameterLists
        if (nonempty parameterListsJson
                =   getArrayOrNull(json, keyParams)?.sequence()) {

            assert (nonempty parameterLists
                =   parameterListsJson.indexed.collect((i->parameterListJson) {
                        assert (is JsonArray parameterListJson);
                        return parseParameterList {
                            declaration;
                            parameterListJson;
                            i == 0;
                        };
                    }));

            // Hackish: see note in parseParameterList: add the models as members
            //          for functions and constructors
            declaration.addMembers {
                for (pl in parameterLists) for (p in pl.parameters) p.model
            };

            declaration.parameterLists = parameterLists;
        }

        // remaining members

        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = null;
            };
        };

        return declaration;
    }

    ParameterList parseParameterList(
            Declaration & Functional scope, JsonArray json, Boolean first)

        // Hackish: For classes, Function and Value models will already be available
        // in the scope. For functions, methods, and constructors, we must create our
        // own values, and the caller will add them to the scope.
        //
        // Better would be to have the JSON for *all* functional types to include models
        // for functions and values as members, and for the parameter lists, avoid
        // duplication by only having the name and isVariadic (or whatever is needed).
        =>  ParameterList {
            json.collect((jsonParameter) {
                assert (is JsonObject jsonParameter);
                Function | Value model;
                if (exists m = scope.getDirectMember(getString(jsonParameter, keyName))) {
                    "Parameters are functions or values"
                    assert (is Function | Value m);
                    model = m;
                }
                else {
                    switch (type = getStringOrNull(jsonParameter, "$pt"))
                    case ("f") {
                        model = parseFunction(scope, jsonParameter);
                    }
                    case (null | "v") {
                        model = parseValue(scope, jsonParameter)[0];
                    }
                    else {
                        throw AssertionError("Unexpected parameter type '``type``'");
                    }
                }

                return Parameter {
                    model = model;
                    isDefaulted = jsonParameter[keyDefault] exists;
                    isSequenced = jsonParameter[keySequenced] exists;
                };
            });
        };

    shared
    [Value] | [Value, Setter] parseValue(Scope scope, JsonObject json) {
        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value declaration
            =   Value {
                    container = scope;
                    name = getString(json, keyName);
                    typeLG = typeFromJsonLG(getObject(json, keyType));
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isStatic = packedAnnotations.get(staticBit);
                    isLate = packedAnnotations.get(lateBit);
                    isVariable = packedAnnotations.get(variableBit);
                    isDynamic = json[keyDynamic] exists;
                    isTransient = getString(json, keyMetatype) == metatypeGetter;
                    // isDeprecated
                };

        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = null;
            };
        };

        if (exists setterJson = json[keySetter]) {
            assert (is JsonObject setterJson);

            value setter
                =   Setter {
                        declaration;
                        // TODO are these supposed to be independent of the getter? If
                        //      not, remove them from Setter's parameter list.
                        isActual = declaration.isActual;
                        isDeprecated = declaration.isDeprecated;
                        annotations
                            =   toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    };

            setter.addMembers {
                parseMembers {
                    scope = setter;
                    json = setterJson;
                    selfTypeName = null;
                };
            };

            return [declaration, setter];
        }
        else {
            return [declaration];
        }
    }

    shared
    Interface parseInterface(Scope scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value declaration
            =   if (exists aliasJson = getObjectOrNull(json, keyAlias))
                then InterfaceAlias {
                    container = scope;
                    unit = scope.pkg.defaultUnit;
                    name = getString(json, keyName);
                    extendedTypeLG = typeFromJsonLG(getObject(json, keyExtendedType));
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    isShared = packedAnnotations.get(sharedBit);
                    isSealed = packedAnnotations.get(sealedBit);
                }
                else InterfaceDefinition {
                    container = scope;
                    unit = scope.pkg.defaultUnit;
                    name = getString(json, keyName);
                    caseTypesLG
                        =   getArrayOrEmpty(json, keyCases).map((s) {
                                assert (is JsonObject s);
                                return typeFromJsonLG(s);
                            });
                    satisfiedTypesLG
                        =   getArrayOrEmpty(json, keySatisfies).map((s) {
                                assert (is JsonObject s);
                                return typeFromJsonLG(s);
                            });
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isSealed = packedAnnotations.get(sealedBit);
                    isFinal = packedAnnotations.get(finalBit);
                    isAnnotation = packedAnnotations.get(annotationBit);
                    isStatic = packedAnnotations.get(staticBit);
                    isDynamic = json[keyDynamic] exists;
                };

        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = getStringOrNull(json, keySelfType);
            };
        };

        return declaration;
    }

    shared
    Constructor parseConstructor(Class scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value parameters
            =   getArrayOrNull(json, keyParams)?.sequence();

        value declaration
            =   if (parameters exists) then
                    CallableConstructor {
                        container = scope;
                        unit = scope.pkg.defaultUnit;
                        name = getStringOrNull(json, keyName) else "";
                        annotations = toAnnotations {
                            getObjectOrEmpty(json, keyAnnotations);
                        };
                        isShared = packedAnnotations.get(sharedBit);
                        isSealed = packedAnnotations.get(sealedBit);
                        isAbstract = packedAnnotations.get(abstractBit);
                        isDynamic = json[keyDynamic] exists;
                    }
                else
                    ValueConstructor {
                        container = scope;
                        unit = scope.pkg.defaultUnit;
                        name = getString(json, keyName);
                        annotations = toAnnotations {
                            getObjectOrEmpty(json, keyAnnotations);
                        };
                        isShared = packedAnnotations.get(sharedBit);
                        isSealed = packedAnnotations.get(sealedBit);
                        isDynamic = json[keyDynamic] exists;
                    };

        // value ParameterLists
        if (nonempty parameters) {
            assert (is CallableConstructor declaration);
            value parameterList = parseParameterList(declaration, parameters, true);

            // Hackish: see note in parseParameterList: add the models as members
            //          for functions and constructors
            declaration.addMembers(parameterList.parameters.map((Parameter.model)));
            declaration.parameterList = parameterList;
        }

        // remaining members

        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = getStringOrNull(json, keySelfType);
            };
        };

        return declaration;
    }

    shared
    [Value, Class] parseObject(Scope scope, JsonObject json) {
        // Note: only the value gets annotations, but the class should be marked
        // shared, etc. as necessary based on the value's annotations. Note that when
        // compiling code, the typechecker does apply annotations to both the class and
        // the value, but this is probably due to the workings of the typechecker rather
        // than an intentional behavior. In fact, the annonymous class, per the
        // typechecker, even gets annotations that are constrained to Values.
        //
        // Note2: the class gets added to the container, despite JS only adding it to the
        // unit in JsonPackage. On the JVM, `package`.members<...> lists both
        // "class simple::obj, value simple::obj" and the typechecker adds them both
        // as members: "[class obj, value obj => obj]"

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value c
            =   parseClass(scope, json);

        value v
            =   Value {
                    container = scope;
                    name = c.name;
                    typeLG = (scope) => c.type;
                    annotations = toAnnotations(getObjectOrEmpty(json, keyAnnotations));
                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isStatic = packedAnnotations.get(staticBit);
                    isLate = packedAnnotations.get(lateBit);
                    isVariable = packedAnnotations.get(variableBit);
                    isDynamic = c.isDynamic;
                    isTransient = false;
                    // isDeprecated
                };

        return [v, c];
    }

    shared
    Class parseClass(Scope scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value isAlias
            =   getIntegerOrNull(json, keyAlias) exists;

        value constructors
            =   getObjectOrNull(json, keyConstructors);

        value declaration
            =   if (isAlias) then
                    ClassAlias {
                        container = scope;
                        name = getString(json, keyName);
                        unit = scope.pkg.defaultUnit;
                        extendedTypeLG
                            =   typeFromJsonLG {
                                    getObject(json, keyExtendedType);
                                };
                        annotations
                            =   toAnnotations {
                                    getObjectOrEmpty(json, keyAnnotations);
                                };
                        isShared = packedAnnotations.get(sharedBit);
                        isActual = packedAnnotations.get(actualBit);
                        isFormal = packedAnnotations.get(formalBit);
                        isDefault = packedAnnotations.get(defaultBit);
                        isSealed = packedAnnotations.get(sealedBit);
                        isAbstract = packedAnnotations.get(abstractBit);
                        isStatic = packedAnnotations.get(staticBit);
                        isDynamic = json[keyDynamic] exists;
                    }
                else if (!constructors exists) then
                    ClassWithInitializer {
                        container = scope;
                        name = getString(json, keyName);
                        unit = scope.pkg.defaultUnit;
                        satisfiedTypesLG
                            =   getArrayOrEmpty(json, keySatisfies).map((s) {
                                    assert (is JsonObject s);
                                    return typeFromJsonLG(s);
                                });
                        caseTypesLG
                            =   getArrayOrEmpty(json, keyCases).map((s) {
                                    assert (is JsonObject s);
                                    return typeFromJsonLG(s);
                                });
                        extendedTypeLG
                            =   if (is JsonObject et = json[keyExtendedType])
                                then typeFromJsonLG(et)
                                else null;
                        annotations
                            =   toAnnotations {
                                    getObjectOrEmpty(json, keyAnnotations);
                                };
                        isShared = packedAnnotations.get(sharedBit);
                        isActual = packedAnnotations.get(actualBit);
                        isFormal = packedAnnotations.get(formalBit);
                        isDefault = packedAnnotations.get(defaultBit);
                        isSealed = packedAnnotations.get(sealedBit);
                        isFinal = packedAnnotations.get(finalBit);
                        isAnnotation = packedAnnotations.get(annotationBit);
                        isAbstract = packedAnnotations.get(abstractBit);
                        isStatic = packedAnnotations.get(staticBit);
                        isDynamic = json[keyDynamic] exists;
                        isAnonymous = getString(json, keyMetatype) == metatypeObject;
                    }
                else
                    ClassWithConstructors {
                        container = scope;
                        name = getString(json, keyName);
                        unit = scope.pkg.defaultUnit;
                        satisfiedTypesLG
                            =   getArrayOrEmpty(json, keySatisfies).map((s) {
                                    assert (is JsonObject s);
                                    return typeFromJsonLG(s);
                                });
                        caseTypesLG
                            =   getArrayOrEmpty(json, keyCases).map((s) {
                                    assert (is JsonObject s);
                                    return typeFromJsonLG(s);
                                });
                        extendedTypeLG
                            =   if (is JsonObject et = json[keyExtendedType])
                                then typeFromJsonLG(et)
                                else null;
                        annotations
                            =   toAnnotations {
                                    getObjectOrEmpty(json, keyAnnotations);
                                };
                        isShared = packedAnnotations.get(sharedBit);
                        isActual = packedAnnotations.get(actualBit);
                        isFormal = packedAnnotations.get(formalBit);
                        isDefault = packedAnnotations.get(defaultBit);
                        isSealed = packedAnnotations.get(sealedBit);
                        isFinal = packedAnnotations.get(finalBit);
                        isAnnotation = packedAnnotations.get(annotationBit);
                        isAbstract = packedAnnotations.get(abstractBit);
                        isStatic = packedAnnotations.get(staticBit);
                        isDynamic = json[keyDynamic] exists;
                    };

        declaration.addMembers {
            parseMembers {
                scope = declaration;
                json = json;
                selfTypeName = getStringOrNull(json, keySelfType);
            };
        };

        if (!constructors exists,
            nonempty parameters
                =   getArrayOrNull(json, keyParams)?.sequence()) {
            // TODO even when constructors exist, the JSON has parameters ("ps"). Does
            //      the typechecker's model copy the default constructor's parameters
            //      to the class?
            assert (is ClassWithInitializer declaration);
            declaration.parameterList
                =   parseParameterList(declaration, parameters, true);
        }

        return declaration;
    }

    shared
    [Declaration] | [Value, Setter] | [Value, Class] parseToplevelDeclaration
            (Package pkg, JsonObject item) {

        value metaType = getString(item, keyMetatype);

        if (metaType == metatypeClass) {
            return [parseClass(pkg, item)];
        }
        else if (metaType == metatypeInterface) {
            return [parseInterface(pkg, item)];
        }
        else if (metaType == metatypeMethod) {
            return [parseFunction(pkg, item)];
        }
        else if (metaType == metatypeAlias) {
            return [parseTypeAlias(pkg, item)];
        }
        else if (metaType == metatypeGetter) {
            // transient value with or without a setter
            return parseValue(pkg, item);
        }
        else if (metaType == metatypeAttribute) {
            // possibly variable reference value
            return parseValue(pkg, item);
        }
        else if (metaType == metatypeObject) {
            return parseObject(pkg, item);
        }

        throw AssertionError("Unsupported toplevel meta type '``metaType``'");
    }

    shared
    {Declaration*} parseToplevelDeclarations(Package pkg, JsonObject json)
        =>  json.filter((key->item) => !key.startsWith("$pkg-")).flatMap((key->item) {
                assert (is JsonObject item);
                return parseToplevelDeclaration(pkg, item);
            });

    "Returns the declaration(s), or [] if the toplevel declaration cannot be found."
    shared
    [Declaration*] parseToplevelDeclarationWithName(
            Package pkg, String name, JsonObject packageJson) {
        if (name.startsWith("$pkg-")) {
            return [];
        }

        value item = getObjectOrNull(packageJson, name);

        if (!exists item) {
            return [];
        }

        return parseToplevelDeclaration(pkg, item);
    }
}
