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
    File,
    forEachLine
}
import ceylon.interop.java {
    CeylonIterable,
    javaClass,
    JavaIterable
}

import com.redhat.ceylon.cmr.api {
    RepositoryManager,
    ArtifactContext
}
import com.redhat.ceylon.cmr.ceylon {
    CeylonUtils
}
import com.redhat.ceylon.cmr.impl {
    ShaSigner
}
import com.redhat.ceylon.common {
    FileUtil
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
    ModuleModel=Module,
    ModuleImport
}
import com.vasileff.ceylon.dart.compiler.borrowed {
    ErrorCollectingVisitor
}
import com.vasileff.ceylon.dart.compiler.core {
    CompilationContext,
    augmentNode,
    computeCaptures,
    computeClassCaptures,
    isForDartBackend,
    moduleImportPrefix
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
    DartArgumentList,
    CodeWriter
}
import com.vasileff.jl4c.guava.collect {
    javaList,
    LinkedListMultimap
}

import java.io {
    JFile=File,
    JPrintWriter=PrintWriter
}
import java.lang {
    System,
    Runnable
}
import java.nio.file {
    JFiles=Files
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
    builder.moduleManagerFactory(DartModuleManagerFactory());

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

    value moduleMembers
        =   HashMap<ModuleModel, LinkedList<DartCompilationUnitMember>>();

    value moduleSources
        =   LinkedListMultimap<ModuleModel, JFile>();

    t3 = system.nanoseconds;

    for (phasedUnit in phasedUnits) {
        value path => phasedUnit.pathRelativeToSrcDir else "<null>";

        // FIXME virtual files? skip if not saving src?
        moduleSources.put(phasedUnit.\ipackage.\imodule, JFile(phasedUnit.unit.fullPath));

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

        function dartPackageLocationForModule(ModuleModel m)
            =>  "package:" + CeylonIterable(m.name)
                    .map(Object.string)
                    .interpose("/")
                    .fold("")(plus)
                    .plus("/")
                    .plus(m.name.get(m.name.size() - 1).string)
                    .plus(".dart");

        // TODO decide if the language module should be excluded.
        value importedModules
            =   CeylonIterable(m.imports)
                .filter(isForDartBackend)
                .map(ModuleImport.\imodule)
                .map((m) =>
                    DartImportDirective {
                        DartSimpleStringLiteral {
                            dartPackageLocationForModule(m);
                        };
                        DartSimpleIdentifier {
                            moduleImportPrefix(m);
                        };
                    }
                );

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
                    //!languageModule then
                    //DartImportDirective {
                    //    DartSimpleStringLiteral("package:ceylon/language/language.dart");
                    //    DartSimpleIdentifier("$ceylon$language");
                    //},
                    *importedModules}.coalesced.sequence();
                    ds.sequence();
                };

        dartCompilationUnits.add(dcu);

        // TODO use the *virtual* filesystem. See JsCompiler.findFile()
        value native
            =   if (exists unit = m.unit,
                    is Directory directory = parsePath(unit.fullPath).parent.resource)
                then nativeCode(directory)
                else "";

        // don't bother serializing if we don't have to
        if (outputRepositoryManager exists || verboseCode) {

            // use a tempfile rather than a StringBuffer, since ShaSigner needs a file
            try (dFile = TemporaryFile("ceylon-dart-dart-", ".dart", true),
                 mFile = TemporaryFile("ceylon-dart-model-", ".json", true)) {

                value dartFile = dFile.file;
                value modelFile = mFile.file;

                // write to the temp file
                try (appender = dartFile.Appender("utf-8")) {
                    dcu.write(CodeWriter(appender.write));
                    appender.write(native);
                }

                // persist to output repository
                if (exists outputRepositoryManager) {
                    // the code
                    value artifact = ArtifactContext(m.nameAsString, m.version,
                            ArtifactContext.\iDART);

                    artifact.forceOperation = true; // what does this do?

                    outputRepositoryManager.putArtifact(artifact, javaFile(dartFile));

                    ShaSigner.signArtifact(outputRepositoryManager, artifact,
                            javaFile(dartFile), null);

                    // the model
                    value modelArtifact = ArtifactContext(m.nameAsString, m.version,
                            ArtifactContext.\iDART_MODEL);

                    modelArtifact.forceOperation = true; // what does this do?

                    // write to the model file
                    try (appender = modelFile.Appender("utf-8")) {
                        appender.write("\n".join(CeylonIterable(m.imports)
                            .filter(isForDartBackend)
                            .map(ModuleImport.\imodule)
                            .map((m) => m.nameAsString + " " + m.version)));
                    }

                    // persist
                    outputRepositoryManager.putArtifact(
                            modelArtifact, javaFile(modelFile));

                    // and hash
                    ShaSigner.signArtifact(outputRepositoryManager, modelArtifact,
                            javaFile(modelFile), null);

                    // the source artifact (*must* have this for language module)
                    value sac = CeylonUtils.makeSourceArtifactCreator(
                            outputRepositoryManager,
                            JavaIterable(sourceDirectories),
                            m.nameAsString, m.version,
                            // TODO verboseCMR and logging
                            false, null);

                    sac.copy(FileUtil.filesToPathList(javaList(moduleSources.get(m))));
                }

                // write code to console
                if (verboseCode) {
                    forEachLine(dartFile, process.writeErrorLine);
                }
            }
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

JFile javaFile(File file)
    =>  JFile(file.path.string);

class TemporaryFile(
        String? prefix = null, String? suffix = null,
        Boolean deleteOnExit = false)
        satisfies Destroyable {

    value path = JFiles.createTempFile(prefix, suffix);
    if (deleteOnExit) {
        path.toFile().deleteOnExit();
    }
    assert (is File f = parsePath(path.string).resource);

    shared File file = f;

    shared actual void destroy(Throwable? error) {
        try {
            f.delete();
        }
        finally {
            if (exists error) {
                throw error;
            }
        }
    }
}
