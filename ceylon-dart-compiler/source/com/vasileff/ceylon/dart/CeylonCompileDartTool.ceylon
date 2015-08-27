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
import ceylon.file {
    Directory,
    File,
    lines,
    parsePath
}
import ceylon.interop.java {
    CeylonIterable,
    createJavaByteArray,
    javaClass,
    JavaIterable,
    javaString
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
    argument=argument__SETTER,
    AnnotatedToolModel,
    ToolFactory
}
import com.redhat.ceylon.common.tools {
    CeylonTool,
    SourceArgumentsResolver,
    CeylonToolLoader
}
import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.model.typechecker.model {
    ModuleModel=Module
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
import com.vasileff.ceylon.dart.compiler {
    augmentNode,
    CompilationContext,
    CompilerBug,
    CaptureVisitor
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
            value ctx = CompilationContext(phasedUnit);

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

                unit.visit(CaptureVisitor(ctx));

                ctx.topLevelVisitor.transformCompilationUnit(unit);
                declarations.addAll(ctx.compilationUnitMembers.sequence());
            }
        }

        for (m -> ds in moduleMembers) {

            value languageModule = m.nameAsString == "ceylon.language";

            ds.add(mainFunctionHack);
            value dcu = DartCompilationUnit {
                {DartImportDirective {
                    DartSimpleStringLiteral("dart:core");
                    DartSimpleIdentifier("$dart$core");
                },
                DartImportDirective {
                    DartSimpleStringLiteral("dart:io");
                    DartSimpleIdentifier("$dart$io");
                },
                DartImportDirective {
                    DartSimpleStringLiteral("dart:math");
                    DartSimpleIdentifier("$dart$math");
                },
                DartImportDirective {
                    DartSimpleStringLiteral("dart:mirrors");
                    DartSimpleIdentifier("$dart$mirrors");
                },
                !languageModule then
                DartImportDirective {
                    DartSimpleStringLiteral("package:ceylon/language/language.dart");
                    DartSimpleIdentifier("$ceylon$language");
                }}.coalesced.sequence();
                ds.sequence();
            };

            assert (is Directory directory = parsePath(m.unit.fullPath).parent.resource);
            value native = nativeCode(directory);
            value bais = ByteArrayInputStream(
                    createJavaByteArray(utf8.encode(
                            dcu.string + native)));

            outputRepositoryManager.putArtifact(
                ArtifactContext(m.nameAsString, m.version, ".dart"),
                bais);
        }
    }

    String nativeCode(Directory directory) {
        // Concatinate *.dart files. Filter import and library directives. Return.
        value sb = StringBuilder();

        for (file in directory
                .children("*.dart")
                .narrow<File>() // TODO support Links
                .filter(File.readable)) {

            sb.append("\n");
            sb.append("/".repeat(70) + "\n");
            sb.append("//\n");
            sb.append("// Stitched file: ``file.name``\n");
            sb.append("//\n");
            sb.append("/".repeat(70) + "\n");

            lines(file)
                .filter((line)
                    => !line.startsWith("import") && !line.startsWith("library"))
                .interpose("\n")
                .each(sb.append);
        }
        return sb.string;
    }
}

"Run the CeylonCompileDartTool, using arguments from [[process.arguments]]."
shared
void runCompileDartTool() {
    value args = JavaIterable(process.arguments.map(javaString));
    value tool = CeylonCompileDartTool();
    value toolLoader = CeylonToolLoader();
    value toolFactory = ToolFactory();
    value toolModel = AnnotatedToolModel<CeylonCompileDartTool>("compile-dart");
    toolModel.toolLoader = toolLoader;
    toolModel.toolClass = javaClass<CeylonCompileDartTool>();
    toolFactory.bindArguments(toolModel, tool, CeylonTool(), args);
    tool.run();
}
