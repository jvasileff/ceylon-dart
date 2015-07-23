import ceylon.ast.core {
    CompilationUnit
}
import ceylon.ast.redhat {
    anyCompilationUnitToCeylon
}
import ceylon.collection {
    HashMap,
    LinkedList
}
import ceylon.interop.java {
    CeylonIterable,
    CeylonList,
    createJavaByteArray
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext
}
import com.redhat.ceylon.cmr.ceylon {
    OutputRepoUsingTool
}
import com.redhat.ceylon.common {
    Backend
}
import com.redhat.ceylon.common.config {
    DefaultToolOptions
}
import com.redhat.ceylon.common.tool {
    argument=argument__SETTER
}
import com.redhat.ceylon.common.tools {
    CeylonTool,
    SourceArgumentsResolver
}
import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.model.typechecker.model {
    ModuleModel=Module
}
import com.vasileff.ceylon.dart.compiler {
    augmentNode,
    CompilationContext,
    CompilerBug
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.io {
    ByteArrayInputStream
}
import java.lang {
    JString=String,
    System
}
import java.util {
    JList=List
}
import com.vasileff.ceylon.dart.ast {
    DartArgumentList,
    DartImportDirective,
    dartFormalParameterListEmpty,
    DartFunctionExpression,
    DartExpressionFunctionBody,
    DartCompilationUnitMember,
    DartTypeName,
    DartSimpleIdentifier,
    DartMethodInvocation,
    DartCompilationUnit,
    DartFunctionDeclaration,
    DartSimpleStringLiteral
}

shared
class CeylonCompileDartTool() extends OutputRepoUsingTool(null) {

    DartFunctionDeclaration mainFunctionHack =
        DartFunctionDeclaration {
            false;
            DartTypeName {
                DartSimpleIdentifier("void");
            };
            null;
            DartSimpleIdentifier("main");
            DartFunctionExpression {
                dartFormalParameterListEmpty;
                DartExpressionFunctionBody {
                    false;
                    DartMethodInvocation {
                        null;
                        DartSimpleIdentifier("run");
                        DartArgumentList([]);
                    };
                };
            };
        };

    shared variable
    argument {
        argumentName = "moduleOrFile";
        multiplicity = "*";
    }
    JList<JString> moduleOrFile = javaList<JString>([]);

    shared actual
    void initialize(CeylonTool? ceylonTool) {}

    shared actual
    void run() {
        try {
            doRun();
        }
        catch (CompilerBug e) {
            process.writeErrorLine("Compiler Bug: " + e.message);
            System.exit(1);
        }
    }

    void doRun() {
        value roots = DefaultToolOptions.compilerSourceDirs;
        value resources = DefaultToolOptions.compilerResourceDirs;
        value resolver = SourceArgumentsResolver(roots, resources, ".ceylon");

        resolver.cwd(cwd).expandAndParse(moduleOrFile, Backend.\iNone);

        value builder = TypeCheckerBuilder();

        for (root in CeylonIterable(roots)) {
            builder.addSrcDirectory(root);
        }
        builder.setSourceFiles(resolver.sourceFiles);
        builder.setRepositoryManager(repositoryManager);

        value typeChecker = builder.typeChecker;
        typeChecker.process();

        value phasedUnits = CeylonIterable(typeChecker.phasedUnits.phasedUnits);

        value moduleMembers =
                HashMap<ModuleModel, LinkedList<DartCompilationUnitMember>>();

        for (phasedUnit in phasedUnits) {
            value ctx = CompilationContext {
                phasedUnit.unit;
                CeylonList {
                    phasedUnit.tokens;
                };
            };

            value unit = anyCompilationUnitToCeylon {
                phasedUnit.compilationUnit;
                augmentNode;
            };

            if (is CompilationUnit unit) {
                // ignore packages and modules for now
                LinkedList<DartCompilationUnitMember> declarations;
                if (exists d = moduleMembers.get(phasedUnit.\ipackage.\imodule)) {
                    declarations = d;
                }
                else {
                    declarations = LinkedList<DartCompilationUnitMember>();
                    moduleMembers.put(phasedUnit.\ipackage.\imodule, declarations);
                }
                declarations.addAll(ctx.miscTransformer.transformCompilationUnit(unit));
            }
        }

        for (m -> ds in moduleMembers) {
            ds.add(mainFunctionHack);
            value dcu = DartCompilationUnit {
                [DartImportDirective {
                    DartSimpleStringLiteral(
                        "dart:core");
                    DartSimpleIdentifier(
                        "$dart$core");
                },
                DartImportDirective {
                    DartSimpleStringLiteral(
                        "package:ceylon/language/language.dart");
                    DartSimpleIdentifier(
                        "$ceylon$language");
                }];
                ds.sequence();
            };

            value bais = ByteArrayInputStream(
                    createJavaByteArray(utf8.encode(dcu.string)));

            outputRepositoryManager.putArtifact(
                ArtifactContext(m.nameAsString, m.version, ".dart"),
                bais);
        }
    }

    shared actual
    void setOut(String? string)
        =>  super.setOut(string);
}