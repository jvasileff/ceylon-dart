import ceylon.dart.runtime.model {
    Scope,
    Type,
    Declaration,
    TypeParameter,
    Variance,
    TypeDeclaration,
    covariant,
    contravariant,
    ClassDefinition,
    Package,
    invariant,
    InterfaceDefinition,
    Class,
    Interface,
    unionDeduped,
    intersectionDedupedCanonical
}
import ceylon.dart.runtime.model.internal {
    assertedTypeDeclaration
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

    Declaration? declarationFromType(Scope scope, JsonObject json) {
        value packageName = getPackageName(scope, json);
        if (!exists packageName) {
            // it's a type parameter in scope
            return scope.getBase(getString(json, keyName));
        }
        else {
            return scope.findDeclaration {
                declarationName = getString(json, keyName).split('.'.equals);
                packageName;
                moduleName = getModuleName(json);
            };
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

    shared
    Type parseType(Scope scope, JsonObject json) {
        if (exists compositeType = getStringOrNull(json, keyComposite)) {
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
            else let (declaration
                    =   assertedTypeDeclaration {
                            declarationFromType(scope, json);
                        })
                let ([typeArguments, overrides]
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

    shared
    TypeParameter parseTypeParameter
            (Scope scope, JsonObject json, TypeDeclaration? selfTypeDeclaration)
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

    shared
    Interface parseInterface(Scope scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value declaration
            =   InterfaceDefinition {
                    container = scope;
                    unit = scope.pkg.defaultUnit;
                    name = getString(json, keyName);

                    satisfiedTypesLG
                        =   getArrayOrEmpty(json, keySatisfies).map((s) {
                                assert (is JsonObject s);
                                return typeFromJsonLG(s);
                            });

                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isSealed = packedAnnotations.get(sealedBit);
                    isFinal = packedAnnotations.get(finalBit);
                    isAnnotation = packedAnnotations.get(annotationBit);
                };

        value selfType
            =   getStringOrNull(json, keySelfType);

        for (tpJson in getArrayOrEmpty(json, keyTypeParams)) {
            assert (is JsonObject tpJson);
            value name = getString(json, keyName);
            declaration.addMember(parseTypeParameter {
                scope = declaration;
                json = tpJson;
                selfTypeDeclaration
                    =   (selfType?.equals(name) else false) then declaration;
            });
        }

        for (classJson in getObjectOrEmpty(json, keyClasses).items) {
            assert (is JsonObject classJson);
            declaration.addMember(parseClass(declaration, classJson));
        }

        for (interfaceJson in getObjectOrEmpty(json, keyClasses).items) {
            assert (is JsonObject interfaceJson);
            declaration.addMember(parseInterface(declaration, interfaceJson));
        }

        return declaration;
    }

    shared
    Class parseClass(Scope scope, JsonObject json) {

        value packedAnnotations
            =   getIntegerOrNull(json, keyPackedAnnotations) else 0;

        value declaration
            =   ClassDefinition {
                    container = scope;
                    name = getString(json, keyName);
                    unit = scope.pkg.defaultUnit;

                    satisfiedTypesLG
                        =   getArrayOrEmpty(json, keySatisfies).map((s) {
                                assert (is JsonObject s);
                                return typeFromJsonLG(s);
                            });

                    extendedTypeLG
                        =   if (is JsonObject et = json[keyExtendedType])
                            then typeFromJsonLG(et)
                            else null;

                    isShared = packedAnnotations.get(sharedBit);
                    isActual = packedAnnotations.get(actualBit);
                    isFormal = packedAnnotations.get(formalBit);
                    isDefault = packedAnnotations.get(defaultBit);
                    isSealed = packedAnnotations.get(sealedBit);
                    isFinal = packedAnnotations.get(finalBit);
                    isAnnotation = packedAnnotations.get(annotationBit);
                    isAbstract = packedAnnotations.get(abstractBit);
                };

        value selfType
            =   getStringOrNull(json, keySelfType);

        for (tpJson in getArrayOrEmpty(json, keyTypeParams)) {
            assert (is JsonObject tpJson);
            value name = getString(json, keyName);
            declaration.addMember(parseTypeParameter {
                scope = declaration;
                json = tpJson;
                selfTypeDeclaration
                    =   (selfType?.equals(name) else false) then declaration;
            });
        }

        for (classJson in getObjectOrEmpty(json, keyClasses).items) {
            assert (is JsonObject classJson);
            declaration.addMember(parseClass(declaration, classJson));
        }

        for (interfaceJson in getObjectOrEmpty(json, keyClasses).items) {
            assert (is JsonObject interfaceJson);
            declaration.addMember(parseInterface(declaration, interfaceJson));
        }

        return declaration;
    }

    void loadToplevel(Package pkg, JsonObject item) {
        assert (exists metaType = getStringOrNull(item, keyMetatype));

        if (metaType == metatypeClass) {
            pkg.defaultUnit.addDeclaration(parseClass(pkg, item));
        }
        else if (metaType == metatypeInterface) {
            pkg.defaultUnit.addDeclaration(parseInterface(pkg, item));
        }

        // attribute
        // getter
        // method
        // object
        // alias
    }

    shared
    void loadToplevelDeclarations(Package pkg, JsonObject json) {
        for (key -> item in json) {
            if (key.startsWith("$pkg-")) {
                continue;
            }

            assert (is JsonObject item);
            loadToplevel(pkg, item);
        }
    }

    "Returns `true` if the toplevel declaration was found.

     Note: this method is not idempotent! Multiple calls to this method with the same
     arguments will result in the package having redundant declarations."
    shared
    Boolean loadToplevelDeclaration(Package pkg, String name, JsonObject packageJson) {
        if (name.startsWith("$pkg-")) {
            return false;
        }

        value item = getObjectOrNull(packageJson, name);

        if (!exists item) {
            return false;
        }

        loadToplevel(pkg, item);
        return true;
    }
}
