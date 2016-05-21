import ceylon.interop.java {
    CeylonIterable
}
import ceylon.language.meta {
    type
}

import com.redhat.ceylon.model.typechecker.model {
    ModuleModel=Module,
    Package,
    ModuleImport
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
    DartExpression
}
import com.vasileff.ceylon.dart.compiler.loader {
    JsonModule
}

shared
class ModelGenerator(CompilationContext ctx) extends BaseGenerator(ctx) {

    // FIXME use $package prefix for toplevel $module value

    shared
    [DartCompilationUnitMember*] generateRuntimeModel(ModuleModel mod, Package pkg)
        =>  let (scope = errorThrowingDScope(pkg))
            [DartTopLevelVariableDeclaration {
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
                                condition = DartBinaryExpression {
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
                    ceylonTypes.anythingType; // really, [Module*]
                    null;
                    () => generateInvocationSynthetic {
                        scope;

                        receiverType // TODO element type should be ceylon.model::Module
                            =   ctx.unit.getIterableType(ceylonTypes.anythingType);

                        generateReceiver()
                            =>  dartTypes.invocableForBaseExpression {
                                    scope;
                                    ceylonTypes.ceylonIterable;
                                }.expressionForInvocation {
                                    [DartListLiteral {
                                        false;
                                        CeylonIterable(mod.imports)
                                                // TODO remove filter once dart interop
                                                //      modules include runtime model info
                                                .filter(not(dartNative))
                                                .filter(isForDartBackend)
                                                .collect {
                                            // the.imported.module.$module
                                            (imp) => DartPrefixedIdentifier {
                                                DartSimpleIdentifier {
                                                    moduleImportPrefix(imp.\imodule);
                                                };
                                                DartSimpleIdentifier("$module");
                                            };
                                        };
                                    }];
                                };

                        memberName = "sequence";

                        arguments = [];
                    };
                }];
                                        };
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
