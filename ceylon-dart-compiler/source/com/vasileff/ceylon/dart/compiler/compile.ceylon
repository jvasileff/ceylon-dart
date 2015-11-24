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
    JavaIterable,
    javaString
}
import ceylon.json {
    JsonObject=Object,
    Array,
    ObjectValue
}
import ceylon.language.meta {
    type
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
    FileUtil,
    ModuleUtil
}
import com.redhat.ceylon.compiler.js.loader {
    MetamodelVisitor
}
import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    Warning,
    ModuleSourceMapper
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
    DartFunctionExpression,
    DartFunctionDeclaration,
    DartArgumentList,
    CodeWriter,
    DartFormalParameterList,
    DartSimpleFormalParameter,
    DartBlockFunctionBody,
    DartBlock,
    DartExpressionStatement,
    DartPropertyAccess,
    DartFunctionExpressionInvocation
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
    Runnable,
    JString=String,
    JBoolean=Boolean,
    JFloat=Float,
    JDouble=Double,
    JInteger=Integer,
    JLong=Long
}
import java.util {
    EnumSet,
    JMap=Map,
    JList=List
}

// TODO produce error on import of modules with conflicting versions, even if non-shared.

shared
[[DartCompilationUnit*], CompilationStatus] compileDart(
        virtualFiles = [],
        sourceDirectories = [],
        sourceFiles = [],
        moduleFilters = [],
        repositoryManager = null,
        outputRepositoryManager = null,
        standardOutWriter = JPrintWriter(System.\iout),
        standardErrorWriter = JPrintWriter(System.\ierr),
        generateSourceArtifact = false,
        suppressWarning = [],
        doWithoutCaching = false,
        suppressMainFunction = false,
        verboseAst = false,
        verboseRhAst = false,
        verboseCode = false,
        verboseProfile = false,
        verboseFiles = false,
        quiet = true) {

    {VirtualFile*} virtualFiles;
    {JFile*} sourceFiles; // for typechecker
    {JFile*} sourceDirectories; // for typechecker

    "A list of modules to compile, or the empty list to compile all modules."
    {String*} moduleFilters;

    RepositoryManager? repositoryManager;
    RepositoryManager? outputRepositoryManager;

    JPrintWriter standardOutWriter;
    JPrintWriter standardErrorWriter;

    Boolean generateSourceArtifact;

    {Warning*} suppressWarning;

    Boolean doWithoutCaching;

    Boolean suppressMainFunction;

    Boolean verboseAst;
    Boolean verboseRhAst;
    Boolean verboseCode;
    Boolean verboseProfile;
    Boolean verboseFiles;
    Boolean quiet;

    suppressWarnings("unusedDeclaration")
    void logOut(Object message = "") {
        standardOutWriter.println(message);
        standardOutWriter.flush();
    }

    void logError(Object message = "") {
        standardErrorWriter.println(message);
        standardErrorWriter.flush();
    }

    void logInfo(String message) {
        if (!quiet) {
            logError(message);
        }
    }

    value mainFunctionHack
        =   DartFunctionDeclaration {
                false;
                DartTypeName {
                    DartSimpleIdentifier("void");
                };
                null;
                DartSimpleIdentifier("main");
                DartFunctionExpression {
                    DartFormalParameterList {
                        false; false;
                        [DartSimpleFormalParameter {
                            false;
                            true;
                            null;
                            DartSimpleIdentifier("arguments");
                        }];
                    };
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            [DartExpressionStatement {
                                DartFunctionExpressionInvocation {
                                    DartPropertyAccess {
                                        DartSimpleIdentifier("$ceylon$language");
                                        DartSimpleIdentifier("initializeProcess");
                                    };
                                    DartArgumentList {
                                        [DartSimpleIdentifier("arguments")];
                                    };
                                };
                            },
                            DartExpressionStatement {
                                DartMethodInvocation {
                                    null;
                                    DartSimpleIdentifier("run");
                                    DartArgumentList([]);
                                };
                            }];
                        };
                    };
                };
            };

    value mainFunctionHackNoRun
        =   DartFunctionDeclaration {
                false;
                DartTypeName {
                    DartSimpleIdentifier("void");
                };
                null;
                DartSimpleIdentifier("main");
                DartFunctionExpression {
                    DartFormalParameterList {
                        false; false;
                        [DartSimpleFormalParameter {
                            false;
                            true;
                            null;
                            DartSimpleIdentifier("arguments");
                        }];
                    };
                    DartBlockFunctionBody {
                        null; false;
                        DartBlock {
                            [DartExpressionStatement {
                                DartFunctionExpressionInvocation {
                                    DartPropertyAccess {
                                        DartSimpleIdentifier("$dart$core");
                                        DartSimpleIdentifier("print");
                                    };
                                    DartArgumentList {
                                        [DartSimpleStringLiteral {
                                            "A shared toplevel run() function \
                                             was not found.";
                                        }];
                                    };
                                };
                            }];
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
    if (!moduleFilters.empty) {
        builder.setModuleFilters(javaList(moduleFilters.map(javaString)));
    }
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
    value errorVisitor = ErrorCollectingVisitor2();
    phasedUnits.map(PhasedUnit.compilationUnit).each((cu) => cu.visit(errorVisitor));
    if (errorVisitor.errorCount > 0) {
        // if there are dependency errors, report only them
        value dependencyErrors
            =   errorVisitor.positionedMessages
                .filter((pm)
                    => pm.message is ModuleSourceMapper.ModuleDependencyAnalysisError)
                .sequence();
        if (dependencyErrors nonempty) {
            printErrors {
                (String s) => standardErrorWriter.print(s);
                true; true;
                dependencyErrors;
                typeChecker;
            };
            standardErrorWriter.flush();
        }
        else {
            // otherwise, print all the errors
            printErrors {
                (String s) => standardErrorWriter.print(s);
                true; true;
                errorVisitor.positionedMessages;
                typeChecker;
            };
            standardErrorWriter.flush();
        }
        return [[], CompilationStatus.errorTypeChecker];
    }
    errorVisitor.clear();

    value moduleMembers
        =   HashMap<ModuleModel, LinkedList<DartCompilationUnitMember>>();

    value moduleSources
        =   LinkedListMultimap<ModuleModel, JFile>();

    value metamodelVisitors
        =   HashMap<ModuleModel, MetamodelVisitor>();

    t3 = system.nanoseconds;

    for (phasedUnit in phasedUnits) {
        phasedUnit.compilationUnit.visit(typeConstructorVisitor);

        value path => phasedUnit.pathRelativeToSrcDir else "<null>";

        // FIXME virtual files? skip if not saving src?
        moduleSources.put(phasedUnit.\ipackage.\imodule, JFile(phasedUnit.unit.fullPath));

        if (verboseFiles) {
            logError("-- begin " + path);
        }

        if (verboseRhAst) {
            logError("-- Redhat AST " + path);
            logError(phasedUnit.compilationUnit);
        }

        Integer start = system.nanoseconds;

        try {
            value ctx = CompilationContext(phasedUnit);

            value unit = anyCompilationUnitToCeylon {
                phasedUnit.compilationUnit;
                augmentNode;
            };

            if (verboseAst) {
                logError("-- Ceylon AST " + path);
                logError(unit);
            }

            if (is CompilationUnit unit) {
                // ignore packages and modules for now

                value m = phasedUnit.\ipackage.\imodule;

                LinkedList<DartCompilationUnitMember> declarations;
                if (exists d = moduleMembers.get(m)) {
                    declarations = d;
                }
                else {
                    declarations = LinkedList<DartCompilationUnitMember>();
                    moduleMembers.put(m, declarations);
                }

                MetamodelVisitor metamodelVisitor;
                if (exists v = metamodelVisitors.get(m)) {
                    metamodelVisitor = v;
                }
                else {
                    metamodelVisitor = MetamodelVisitor(m);
                    metamodelVisitors.put(m, metamodelVisitor);
                }
                phasedUnit.compilationUnit.visit(metamodelVisitor);

                computeCaptures(unit, ctx);
                computeClassCaptures(unit, ctx);
                ctx.topLevelVisitor.transformCompilationUnit(unit);
                declarations.addAll(ctx.compilationUnitMembers.sequence());
            }
        }
        catch (Throwable t) {
            logError(
               "------------------------------------------------------------
                                    ** Compiler bug! **
                ------------------------------------------------------------
                ``t.message``\n
                was encountered while compiling the file:

                    ``phasedUnit.unit.fullPath``
                ------------------------------------------------------------");
            throw t;
        }

        // collect warnings and errors
        phasedUnit.compilationUnit.visit(errorVisitor);

        // verboseFiles output
        if (verboseFiles) {
            Integer end = system.nanoseconds;
            logError("-- end   " + path
                + " (``((end-start)/10^6).string``ms)");
        }
    }

    value dartCompilationUnits = LinkedList<DartCompilationUnit>();

    // we'll print errors at the end, but determine count now
    value errorCount = errorVisitor.errorCount;

    for (m -> ds in moduleMembers) {
        value languageModule = m.nameAsString == "ceylon.language";

        if (!suppressMainFunction) {
            if (hasRunFunction(m)) {
                ds.add(mainFunctionHack);
            }
            else {
                ds.add(mainFunctionHackNoRun);
            }
        }

        function dartPackageLocationForModule(ModuleModel m)
            =>  "package:" + CeylonIterable(m.name)
                    .map(Object.string)
                    .interpose("/")
                    .fold("")(plus)
                    .plus("/")
                    .plus(m.name.get(m.name.size() - 1).string)
                    .plus(".dart");

        value importedModules
            =   CeylonIterable(m.imports)
                .filter(isForDartBackend)
                .map(ModuleImport.\imodule)
                .map((m) =>
                    if (m.name.size() == 1
                            && m.name.get(0).string.startsWith("dart:")) then
                        let (name = m.name.get(0).string)
                        DartImportDirective {
                            DartSimpleStringLiteral(name);
                            DartSimpleIdentifier {
                                "$" + name.replace(":", "$");
                            };
                        }
                    else
                        DartImportDirective {
                            DartSimpleStringLiteral {
                                dartPackageLocationForModule(m);
                            };
                            DartSimpleIdentifier {
                                moduleImportPrefix(m);
                            };
                        });

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

        // don't bother serializing if we don't have to, or if errors exist
        if (!errorCount.positive && (outputRepositoryManager exists || verboseCode)) {

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

                    // persist the json model
                    try (appender = modelFile.Appender("utf-8")) {
                        assert (exists metamodelVisitor = metamodelVisitors.get(m));
                        encodeModel(metamodelVisitor.model, appender);
                    }

                    // persist
                    outputRepositoryManager.putArtifact(
                            modelArtifact, javaFile(modelFile));

                    // and hash
                    ShaSigner.signArtifact(outputRepositoryManager, modelArtifact,
                            javaFile(modelFile), null);

                    if (generateSourceArtifact) {
                        // the source artifact (*must* have this for language module)
                        value sac = CeylonUtils.makeSourceArtifactCreator(
                                outputRepositoryManager,
                                JavaIterable(sourceDirectories),
                                m.nameAsString, m.version,
                                // TODO verboseCMR and logging
                                false, null);

                        sac.copy(FileUtil.filesToPathList(
                            javaList(moduleSources.get(m))));
                    }
                }

                // write code to console
                if (verboseCode) {
                    forEachLine(dartFile, process.writeErrorLine);
                }
            }
            logInfo("Note: Created module \
                     ``ModuleUtil.makeModuleName(m.nameAsString, m.version)``");
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

    // print errors last, to make them easy to find
    printErrors {
        (String s) => standardErrorWriter.print(s);
        true; true;
        errorVisitor.positionedMessages;
        typeChecker;
    };

    standardOutWriter.flush();
    standardErrorWriter.flush();

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

void encodeModel(JMap<JString, Object> model, File.Appender appender) {
    ObjectValue? javaToJson(Anything javaObject) {
        switch (javaObject)
        case (is JString) {
            return javaObject.string;
        }
        case (is JBoolean) {
            return javaObject.booleanValue();
        }
        case (is JLong) {
            return javaObject.longValue();
        }
        case (is JDouble) {
            return javaObject.doubleValue();
        }
        case (is JInteger) {
            return javaObject.longValue();
        }
        case (is JFloat) {
            return javaObject.doubleValue();
        }
        case (is Null) {
            return javaObject;
        }
        else if (is JMap<out Anything, out Anything> javaObject) {
            return JsonObject {
                CeylonIterable {
                    javaObject.entrySet();
                }.collect((entry)
                    =>  (entry.key?.string else "<null>") -> javaToJson(entry.\ivalue));
            };
        }
        else if (is JList<out Anything> javaObject) {
            return Array {
                CeylonIterable(javaObject).collect(javaToJson);
            };
        }
        throw AssertionError("Unsupported type for json: ``type(javaObject)``");
    }

    if (exists s = javaToJson(model)?.string) {
        appender.write(s);
    }
}
