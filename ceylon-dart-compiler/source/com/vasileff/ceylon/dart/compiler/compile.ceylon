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
    parsePath,
    lines,
    File
}
import ceylon.interop.java {
    CeylonIterable,
    javaClass,
    createJavaByteArray
}
import ceylon.io.charset {
    utf8
}

import com.redhat.ceylon.cmr.api {
    RepositoryManager,
    ArtifactContext
}
import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    Warning
}
import com.redhat.ceylon.compiler.typechecker.context {
    PhasedUnit
}
import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.redhat.ceylon.compiler.typechecker.util {
    WarningSuppressionVisitor
}
import com.redhat.ceylon.model.typechecker.context {
    TypeCache
}
import com.redhat.ceylon.model.typechecker.model {
    ModuleModel=Module
}
import com.vasileff.ceylon.dart.compiler.borrowed {
    ErrorCollectingVisitor
}
import com.vasileff.ceylon.dart.compiler.core {
    CompilationContext,
    augmentNode,
    computeCaptures,
    computeClassCaptures
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnitMember,
    DartCompilationUnit,
    DartSimpleIdentifier,
    DartImportDirective,
    DartSimpleStringLiteral,
    DartTypeName,
    DartMethodInvocation,
    dartFormalParameterListEmpty,
    DartExpressionFunctionBody,
    DartFunctionExpression,
    DartFunctionDeclaration,
    DartArgumentList
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.io {
    JFile=File,
    JPrintWriter=PrintWriter,
    ByteArrayInputStream
}
import java.lang {
    System,
    Runnable
}
import java.util {
    EnumSet
}

shared
[[DartCompilationUnit*], CompilationStatus] compileDart(
        virtualFiles = [],
        sourceDirectories = [],
        sourceFiles = [],
        repositoryManager = null,
        outputRepositoryManager = null,
        standardOutWriter = JPrintWriter(System.\iout),
        standardErrorWriter = JPrintWriter(System.\ierr),
        suppressWarning = [],
        doWithoutCaching = false,
        suppressMainFunction = false,
        verboseAst = false,
        verboseRhAst = false,
        verboseCode = false,
        verboseProfile = false,
        verboseFiles = false) {

    {VirtualFile*} virtualFiles;
    {JFile*} sourceFiles; // for typechecker
    {JFile*} sourceDirectories; // for typechecker

    RepositoryManager? repositoryManager;
    RepositoryManager? outputRepositoryManager;

    JPrintWriter standardOutWriter;
    JPrintWriter standardErrorWriter;

    {Warning*} suppressWarning;

    Boolean doWithoutCaching;

    Boolean suppressMainFunction;

    Boolean verboseAst;
    Boolean verboseRhAst;
    Boolean verboseCode;
    Boolean verboseProfile;
    Boolean verboseFiles;

    value mainFunctionHack
        =   DartFunctionDeclaration {
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

    function nativeCode(Directory directory) {
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

    // make sure Dart backend is registered
    noop(dartBackend);

    // times
    Integer t0;
    Integer t1;
    Integer t2;
    Integer t3;
    Integer t4;

    t0 = system.nanoseconds;

    value builder = TypeCheckerBuilder();

    builder.statistics(verboseProfile);
    virtualFiles.each((f) => builder.addSrcDirectory(f));
    sourceDirectories.each((f) => builder.addSrcDirectory(f));
    builder.setSourceFiles(javaList(sourceFiles));
    builder.setRepositoryManager(repositoryManager);

    // Typecheck, silently.
    value typeChecker = builder.typeChecker;

    t1 = system.nanoseconds;

    if (doWithoutCaching) {
        TypeCache.doWithoutCaching(object satisfies Runnable {
            run() => typeChecker.process(true);
        });
    }
    else {
        typeChecker.process(true);
    }

    t2 = system.nanoseconds;

    value phasedUnits = CeylonIterable(typeChecker.phasedUnits.phasedUnits);

    // suppress warnings
    value suppressedWarnings = EnumSet.noneOf(javaClass<Warning>());
    suppressedWarnings.addAll(javaList(suppressWarning));
    value warningSuppressionVisitor = WarningSuppressionVisitor<Warning>(
                javaClass<Warning>(), suppressedWarnings);
    phasedUnits.map(PhasedUnit.compilationUnit).each((cu)
        =>  cu.visit(warningSuppressionVisitor));

    // exit early if errors exist
    value errorVisitor = ErrorCollectingVisitor(typeChecker);
    phasedUnits.map(PhasedUnit.compilationUnit).each((cu) => cu.visit(errorVisitor));
    if (errorVisitor.errorCount > 0) {
        errorVisitor.printErrors(standardErrorWriter, null, true, true);
        return [[], CompilationStatus.errorTypeChecker];
    }
    errorVisitor.clear();

    value moduleMembers =
            HashMap<ModuleModel, LinkedList<DartCompilationUnitMember>>();

    t3 = system.nanoseconds;

    for (phasedUnit in phasedUnits) {
        value path => phasedUnit.pathRelativeToSrcDir else "<null>";

        if (verboseFiles) {
            standardErrorWriter.println("-- begin " + path);
        }

        if (verboseRhAst) {
            standardErrorWriter.println("-- Redhat AST " + path);
            standardErrorWriter.println(phasedUnit.compilationUnit.string);
        }

        Integer start = system.nanoseconds;

        value ctx = CompilationContext(phasedUnit);

        value unit = anyCompilationUnitToCeylon {
            phasedUnit.compilationUnit;
            augmentNode;
        };

        if (verboseAst) {
            standardErrorWriter.println("-- Ceylon AST " + path);
            standardErrorWriter.println(unit);
        }

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

            try {
                computeCaptures(unit, ctx);
                computeClassCaptures(unit, ctx);
                ctx.topLevelVisitor.transformCompilationUnit(unit);
                declarations.addAll(ctx.compilationUnitMembers.sequence());
            }
            catch (CompilerBug b) {
                standardErrorWriter.println();
                standardErrorWriter.println("Compiler bug: " + b.message);
                // return; // exit early on error?
            }
        }

        // collect warnings and errors
        phasedUnit.compilationUnit.visit(errorVisitor);

        // verboseFiles output
        if (verboseFiles) {
            Integer end = system.nanoseconds;
            standardErrorWriter.println("-- end   " + path
                + " (``((end-start)/10^6).string``ms)");
        }
    }

    value dartCompilationUnits = LinkedList<DartCompilationUnit>();

    for (m -> ds in moduleMembers) {
        value languageModule = m.nameAsString == "ceylon.language";

        if (!suppressMainFunction) {
            ds.add(mainFunctionHack);
        }

        value dcu
            =   DartCompilationUnit {
                    {DartImportDirective {
                        DartSimpleStringLiteral("dart:core");
                        DartSimpleIdentifier("$dart$core");
                    },
                    languageModule then
                    DartImportDirective {
                        DartSimpleStringLiteral("dart:io");
                        DartSimpleIdentifier("$dart$io");
                    },
                    languageModule then
                    DartImportDirective {
                        DartSimpleStringLiteral("dart:math");
                        DartSimpleIdentifier("$dart$math");
                    },
                    languageModule then
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

        dartCompilationUnits.add(dcu);

        // TODO use the *virtual* filesystem. See JsCompiler.findFile()
        value native
            =   if (exists unit = m.unit,
                    is Directory directory = parsePath(unit.fullPath).parent.resource)
                then nativeCode(directory)
                else "";

        value dartCode = dcu.string + native;

        // persist to output repository
        if (exists outputRepositoryManager) {
            value bais = ByteArrayInputStream(
                createJavaByteArray(utf8.encode(dartCode)));

            outputRepositoryManager.putArtifact(
                ArtifactContext(m.nameAsString, m.version, ".dart"),
                bais);
        }

        // write code to console
        if (verboseCode) {
            process.writeErrorLine(dartCode);
        }
    }

    t4 = system.nanoseconds;

    if (verboseProfile) {
        process.writeErrorLine("Profiling Information");
        process.writeErrorLine("---------------------");
        process.writeErrorLine("TypeChecker creation:   " + ((t1-t0)/10^6).string);
        process.writeErrorLine("TypeChecker processing: " + ((t2-t1)/10^6).string);
        process.writeErrorLine("Dart compiler creation: " + ((t3-t2)/10^6).string);
        process.writeErrorLine("Dart compilation:       " + ((t4-t3)/10^6).string);
    }

    // print warnings and errors
    errorVisitor.printErrors(standardErrorWriter, null, true, true);

    return [dartCompilationUnits.sequence(),
        if (errorVisitor.errorCount > 0)
        then CompilationStatus.errorTypeChecker
        else CompilationStatus.success];
}

shared
[Warning*] allWarnings
    =   CeylonIterable<Warning>(EnumSet.allOf(javaClass<Warning>())).sequence();

shared
class CompilationStatus
        of success | errorTypeChecker | errorDartBackend {
    shared new success {}
    shared new errorTypeChecker {}
    shared new errorDartBackend {}
}
