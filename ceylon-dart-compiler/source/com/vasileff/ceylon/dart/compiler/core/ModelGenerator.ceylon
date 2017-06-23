import ceylon.interop.java {
    CeylonIterable
}
import ceylon.language.meta {
    type
}

import com.redhat.ceylon.model.typechecker.model {
    ModuleModel=Module,
    ModuleImport,
    ClassModel=Class,
    FunctionModel=Function,
    ParameterModel=Parameter,
    PackageModel=Package
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnitMember,
    DartNullLiteral,
    DartBlock,
    DartVariableDeclarationList,
    DartInstanceCreationExpression,
    DartFunctionDeclaration,
    DartArgumentList,
    DartPrefixedIdentifier,
    DartTopLevelVariableDeclaration,
    DartIfStatement,
    DartSimpleIdentifier,
    DartBlockFunctionBody,
    DartAssignmentOperator,
    DartConstructorName,
    DartTypeName,
    DartReturnStatement,
    DartVariableDeclaration,
    DartBinaryExpression,
    DartFunctionExpression,
    DartSimpleStringLiteral,
    DartListLiteral,
    DartMapLiteralEntry,
    DartMapLiteral,
    createAssignmentStatement,
    createMethodInvocationStatement,
    DartExpression,
    DartFormalParameterList,
    DartSwitchStatement,
    DartSwitchCase,
    DartSimpleFormalParameter,
    DartExpressionStatement,
    DartMethodInvocation,
    DartIntegerLiteral,
    DartDoubleLiteral
}
import com.vasileff.ceylon.dart.compiler.loader {
    JsonModule
}

shared
object modelGenerator extends BaseGenerator() {

    // FIXME use $package prefix for toplevel $module value

    function runnableFunction(FunctionModel d)
        =>  d.shared
            && !d.nativeImplementation
            && d.typeParameters.empty
            && d.parameterLists.size() == 1
            && CeylonIterable(d.firstParameterList.parameters)
                    .every(ParameterModel.defaulted);

    function runnableClass(ClassModel d) {
        if (!d.shared
                || d.abstract
                || d.nativeImplementation
                || !d.typeParameters.empty) {
            return false;
        }

        value parameterList
            =   if (d.hasConstructors() || d.hasEnumerated())
                then d.defaultConstructor?.parameterList
                else d.parameterList;

        if (!exists parameterList) {
            return false;
        }

        return CeylonIterable(parameterList.parameters)
            .every(ParameterModel.defaulted);
    }

    function generateToplevelRunner(ModuleModel mod, PackageModel pkg) {
        function shortName(FunctionModel | ClassModel declaration) {
            value modulePartSize
                =   if (mod.defaultModule) then 0
                    else let (s = mod.nameAsString.size)
                         if (s == 0) then 0 else s + 1;

            value packagePart
                =   getPackage(declaration).nameAsString[modulePartSize...];

            value dot
                =   packagePart.empty then "" else ".";

            return packagePart + dot + declaration.name;
        }

        function runnables(PackageModel pkg)
            =>  {
                    for (declaration in pkg.members)
                    if (is FunctionModel declaration, runnableFunction(declaration))
                    declaration
                }.chain {
                    for (declaration in pkg.members)
                    if (is ClassModel declaration, runnableClass(declaration))
                    declaration
                };

        value scope
            =   errorThrowingDScope(pkg);

        value allRunnables
            =   CeylonIterable(mod.packages).flatMap(runnables).sequence();

        value toplevelIdentifier
            =   DartSimpleIdentifier("toplevel");

        value runToplevelIdentifier
            =   DartSimpleIdentifier("_$runToplevel");

        value runnerFunctionExpression = DartFunctionExpression {
            DartFormalParameterList {
                false; false;
                [DartSimpleFormalParameter {
                    false; false;
                    // use boxed type...
                    dartTypes.dartTypeName {
                        scope;
                        ceylonTypes.stringType;
                        false;
                        false;
                    };
                    toplevelIdentifier;
                }];
            };
            DartBlockFunctionBody {
                null; false;
                DartBlock {
                    {
                        if (nonempty allRunnables)
                        then DartSwitchStatement {
                            // It's a Ceylon string, unbox with toString()
                            DartMethodInvocation {
                                toplevelIdentifier;
                                DartSimpleIdentifier("toString");
                                DartArgumentList();
                            };
                            [for (runnable in allRunnables)
                                DartSwitchCase {
                                    [];
                                    DartSimpleStringLiteral {
                                        shortName(runnable);
                                    };
                                    [DartExpressionStatement {
                                        withLhsNoType {
                                            () => ctx.dartTypes
                                                    .invocableForBaseExpression {
                                                scope;
                                                runnable;
                                            }.expressionForInvocation {
                                                [];
                                                false;
                                            };
                                        };
                                    },
                                    DartReturnStatement {
                                        // boxed true
                                        dartTypes.identifierForToplevel {
                                            scope;
                                            ceylonTypes.trueValueDeclaration;
                                        };
                                    }];
                                }
                            ];
                        } else null,
                        DartReturnStatement {
                            // boxed false
                            dartTypes.identifierForToplevel {
                                scope;
                                ceylonTypes.falseValueDeclaration;
                            };
                        }
                    }.coalesced.sequence();
                };
            };
        };

        // declare _$runToplevel Callable - Boolean(String)
        return DartTopLevelVariableDeclaration {
            DartVariableDeclarationList {
                null;
                dartTypes.dartTypeNameForDartModel {
                    scope;
                    dartTypes.dartCallableModel;
                };
                [DartVariableDeclaration {
                    runToplevelIdentifier;
                    DartInstanceCreationExpression {
                        false;
                        DartConstructorName {
                            dartTypes.dartTypeNameForDartModel {
                                scope;
                                dartTypes.dartCallableModel;
                            };
                            null;
                        };
                        DartArgumentList {
                            [generateTypeDescriptor(scope, ceylonTypes.booleanType),
                            generateTypeDescriptor(scope,
                                ceylonTypes.getTupleType([ceylonTypes.stringType])),
                            runnerFunctionExpression];
                        };
                    };
                }];
            };
        };
    }

    shared
    [DartCompilationUnitMember*] generateRuntimeModel(ModuleModel mod, PackageModel pkg)
        =>  let (scope = errorThrowingDScope(pkg))
            [generateToplevelRunner(mod, pkg),
            DartTopLevelVariableDeclaration {
                DartVariableDeclarationList {
                    "const";
                    null;
                    [DartVariableDeclaration {
                        name = DartSimpleIdentifier("_$jsonModel");
                        generateJsonLiteral(encodeModule(mod), true);
                    }];
                };
            },
            DartTopLevelVariableDeclaration {
                DartVariableDeclarationList {
                    "var";
                    null;
                    [DartVariableDeclaration {
                        DartSimpleIdentifier("_$module");
                        DartNullLiteral();
                    }];
                };
            },
            // Important: the assignment to $module must not involve the metamodel in
            // order to avoid circular dependecy problems between modules
            // ceylon.dart.runtime.model and ceylon.language.
            DartFunctionDeclaration {
                false;
                null;
                "get";
                DartSimpleIdentifier("$module");
                DartFunctionExpression {
                    null;
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            // may return a partially initialized if there is a circular
                            // dependency, which is ok.
                            [DartIfStatement {
                                condition
                                    =   DartBinaryExpression {
                                            DartSimpleIdentifier("_$module");
                                            "==";
                                            DartNullLiteral();
                                        };
                                thenStatement = DartBlock {
                                    // create the model, assign to _$module
                                    [createAssignmentStatement {
                                        DartSimpleIdentifier("_$module");
                                        DartAssignmentOperator.equal;
                                        DartInstanceCreationExpression {
                                            false;
                                            // TODO ugly; use model for this
                                            DartConstructorName {
                                                DartTypeName {
                                                    DartPrefixedIdentifier {
                                                        DartSimpleIdentifier {
                                                            "$ceylon$dart$runtime$model";
                                                        };
                                                        DartSimpleIdentifier {
                                                            "json$LazyJsonModule";
                                                        };
                                                    };
                                                };
                                                null;
                                            };
                                            DartArgumentList {
                                                [dartTypes.invocableForBaseExpression {
                                                    scope;
                                                    // ceylon.interop.dart::JsonObject()
                                                    ceylonTypes.jsonObjectDeclaration;
                                                }.expressionForInvocation {
                                                    [DartSimpleIdentifier("_$jsonModel")];
                                                }];
                                            };
                                        };
                                    },
                                    // initialize imports
                                    createMethodInvocationStatement {
                                        DartSimpleIdentifier("_$module");
                                        DartSimpleIdentifier("initializeImports");
                                        DartArgumentList {
                [withLhs {
                    // [Module*]
                    ctx.unit.getSequentialType(ceylonTypes.moduleDeclaration.type);
                    null;
                    () => generateSequentialFromElements {
                        scope;
                        elementType
                            =   ceylonTypes.moduleDeclaration.type;

                        elements
                            =   [for (imp in mod.imports)
                                // TODO remove filter once dart interop
                                //      modules include runtime model info
                                if (!dartNative(imp))
                                if (isForDartBackend(imp))
                                ()=>DartPrefixedIdentifier {
                                    DartSimpleIdentifier {
                                        moduleImportPrefix(imp.\imodule);
                                    };
                                    DartSimpleIdentifier("$module");
                                }];
                    };
                }];
                                        };
                                    },

                                    // setup run function
                                    createAssignmentStatement {
                                        DartPrefixedIdentifier {
                                            DartSimpleIdentifier("_$module");
                                            DartSimpleIdentifier("runToplevel");
                                        };
                                        DartAssignmentOperator.equal;
                                        DartSimpleIdentifier("_$runToplevel");
                                    }];
                                };
                            },
                            DartReturnStatement {
                                DartSimpleIdentifier("_$module");
                            }];
                        };
                    };
                };
            }];

    Boolean dartNative(ModuleImport mi)
        =>  if (is JsonModule m = mi.\imodule)
            then m.dartNative
            else false;

    DartExpression generateJsonLiteral(Object json, Boolean const) {
        if (is String json) {
            return DartSimpleStringLiteral(json);
        }
        else if (is Integer json) {
            return DartIntegerLiteral(json);
        }
        else if (is Float json) {
            return DartDoubleLiteral(json);
        }
        else if (is Map<String, Object> json) {
            return generateMapLiteral(json, const);
        }
        else if (is List<Object> json) {
            return generateListLiteral(json, const);
        }
        else {
            throw Exception("unrecognized object type ``type(json)``");
        }
    }

    DartMapLiteral generateMapLiteral(Map<String, Object> jsonObject, Boolean const)
        =>  DartMapLiteral {
                const = const;
                entries = jsonObject.collect((entry)
                    =>  DartMapLiteralEntry {
                            DartSimpleStringLiteral(entry.key);
                            generateJsonLiteral(entry.item, const);
                        });
            };

    DartListLiteral generateListLiteral(List<Object> jsonArray, Boolean const)
        =>  DartListLiteral {
                const = const;
                elements = jsonArray.collect((element)
                    => generateJsonLiteral(element, const));
            };
}
