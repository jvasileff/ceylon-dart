import ceylon.ast.core {
    CompilationUnit,
    AnyCompilationUnit,
    Node,
    WideningTransformer,
    Visitor
}
import ceylon.ast.redhat {
    anyCompilationUnitToCeylon
}
import ceylon.collection {
    HashMap,
    LinkedList,
    linked,
    MutableMap
}
import ceylon.file {
    Directory,
    parsePath,
    lines,
    File,
    forEachLine,
    temporaryDirectory
}
import ceylon.interop.java {
    CeylonIterable,
    javaClass,
    JavaIterable,
    javaString,
    CeylonList
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
import com.redhat.ceylon.common.tool {
    ToolError
}
import com.redhat.ceylon.compiler.typechecker {
    TypeCheckerBuilder
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    ModuleSourceMapper
}
import com.redhat.ceylon.compiler.typechecker.context {
    PhasedUnit
}
import com.redhat.ceylon.compiler.typechecker.io {
    VirtualFile
}
import com.redhat.ceylon.compiler.typechecker.tree {
    TCVisitor=Visitor,
    TreeNode=Node,
    Tree,
    Message
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
import com.vasileff.ceylon.dart.compiler.core {
    CompilationContext,
    augmentNode,
    computeCaptures,
    computeClassCaptures,
    isForDartBackend,
    moduleImportPrefix,
    ModelGenerator,
    generateMain,
    errorThrowingDScope,
    identifyMemoizedValues
}
import com.vasileff.ceylon.dart.compiler.dartast {
    DartCompilationUnitMember,
    DartCompilationUnit,
    DartSimpleIdentifier,
    DartImportDirective,
    DartSimpleStringLiteral,
    CodeWriter
}
import com.vasileff.ceylon.dart.compiler.loader {
    MetamodelVisitor,
    DartModuleManagerFactory
}
import com.vasileff.ceylon.structures {
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
[[DartCompilationUnit*], CompilationStatus, [Message*]] compileDart(
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
        verboseAst = false,
        verboseRhAst = false,
        verboseCode = false,
        verboseProfile = false,
        verboseFiles = false,
        quiet = true,
        baselinePerfTest = false) {

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

    Boolean verboseAst;
    Boolean verboseRhAst;
    Boolean verboseCode;
    Boolean verboseProfile;
    Boolean verboseFiles;
    Boolean quiet;

    "Include 'count nodes' visitors to determine baseline performance."
    Boolean baselinePerfTest;
    void logOut(Object message) {
        standardOutWriter.print(message);
        standardOutWriter.flush();
    }

    void logError(Object message = "") {
        standardErrorWriter.print(message);
        standardErrorWriter.flush();
    }

    value [a,b,c,d,e] = compileDartSP {
        virtualFiles;
        sourceDirectories;
        sourceFiles;
        moduleFilters;
        repositoryManager;
        outputRepositoryManager;
        logOut;
        logError;
        generateSourceArtifact;
        suppressWarning;
        doWithoutCaching;
        verboseAst;
        verboseRhAst;
        verboseCode;
        verboseProfile;
        verboseFiles;
        quiet;
        baselinePerfTest;
    };

    return [a, b, c.collect(Entry.item)];
}

shared
[[DartCompilationUnit*], CompilationStatus, [<TreeNode->Message>*], [ModuleModel*],
 [PhasedUnit*]]
compileDartSP(
        virtualFiles = [],
        sourceDirectories = [],
        sourceFiles = [],
        moduleFilters = [],
        repositoryManager = null,
        outputRepositoryManager = null,
        logOut = noop,
        logError = noop,
        generateSourceArtifact = false,
        suppressWarning = [],
        doWithoutCaching = false,
        verboseAst = false,
        verboseRhAst = false,
        verboseCode = false,
        verboseProfile = false,
        verboseFiles = false,
        quiet = true,
        baselinePerfTest = false,
        moduleCache = emptyMap) {

    {VirtualFile*} virtualFiles;
    {JFile*} sourceFiles; // for typechecker
    {JFile*} sourceDirectories; // for typechecker

    "A list of modules to compile, or the empty list to compile all modules."
    {String*} moduleFilters;

    RepositoryManager? repositoryManager;
    RepositoryManager? outputRepositoryManager;

    Boolean generateSourceArtifact;

    {Warning*} suppressWarning;

    Boolean doWithoutCaching;

    Boolean verboseAst;
    Boolean verboseRhAst;
    Boolean verboseCode;
    Boolean verboseProfile;
    Boolean verboseFiles;
    Boolean quiet;

    "Include 'count nodes' visitors to determine baseline performance."
    Boolean baselinePerfTest;

    "The immutable module cache to be used for this compile.

        - The cached *must not* contain entries for modules to be compile.
        - If there is an entry for the default module, it will be ignored.

     Keys are of the form `module.name/version`.

     Note: all `Module`s must be `JsonModule`s!"
    Map<String, ModuleModel> moduleCache;

    void logOut(Object message);

    void logError(Object message);

    void logInfo(String message) {
        if (!quiet) {
            logError(message);
        }
    }

    void logErrorLine(Object message)
        =>  logError(message.string + "\n");

    void logInfoLine(Object message)
        =>  logInfo(message.string + "\n");

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

    // timers
    value timer = Timer();
    value timerStages = Timer();

    value swTypeCheckerCreation = timerStages.Measurement("Typechecker creation");

    value builder = TypeCheckerBuilder();

    // the typechecker output is mostly redundant with our measurements
    // (although it does also provide 'parse' time)
    //builder.statistics(verboseProfile);

    virtualFiles.each((f) => builder.addSrcDirectory(f));
    sourceDirectories.each((f) => builder.addSrcDirectory(f));
    builder.setSourceFiles(javaList(sourceFiles));
    if (!moduleFilters.empty) {
        builder.setModuleFilters(javaList(moduleFilters.map(javaString)));
    }
    builder.setRepositoryManager(repositoryManager);
    builder.moduleManagerFactory(DartModuleManagerFactory(moduleCache));

    // Typecheck, silently.
    value typeChecker = builder.typeChecker;

    swTypeCheckerCreation.destroy(null);

    try (timerStages.Measurement("TypeChecker processing"),
            timer.Measurement("typeChecker.process")) {
        if (doWithoutCaching) {
            TypeCache.doWithoutCaching(object satisfies Runnable {
                run() => typeChecker.process(true);
            });
        }
        else {
            try {
                typeChecker.process(true);
            }
            catch (Throwable t) {
                if (t is ReportableException | ToolError) {
                    throw t;
                }
                logErrorLine(
                   "------------------------------------------------------------
                                        ** Compiler bug! **
                    ------------------------------------------------------------
                    ``t.message``\n
                    was encountered while typechecking
                    ------------------------------------------------------------");
                throw t;
            }
        }
    }

    value swDartCompilerCreation = timerStages.Measurement("Dart compiler creation");

    value phasedUnits = CeylonIterable(typeChecker.phasedUnits.phasedUnits).sequence();

    // suppress warnings
    value suppressedWarnings = EnumSet.noneOf(javaClass<Warning>());
    suppressedWarnings.addAll(javaList(suppressWarning));
    value warningSuppressionVisitor = WarningSuppressionVisitor<Warning>(
                javaClass<Warning>(), suppressedWarnings);

    // exit early if errors exist
    value errorVisitor = ErrorCollectingVisitor();
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
                logError;
                true; true;
                dependencyErrors;
                typeChecker;
            };
        }
        else {
            // otherwise, print all the errors
            phasedUnits.map(PhasedUnit.compilationUnit).each((cu)
                =>  cu.visit(warningSuppressionVisitor));

            printErrors {
                logError;
                true; true;
                errorVisitor.positionedMessages;
                typeChecker;
            };
        }

        return [[],
            CompilationStatus.errorTypeChecker,
            errorVisitor.positionedMessages.collect((m) => m.node->m.message),
            CeylonIterable {
                typeChecker.phasedUnits.moduleManager.modules.listOfModules;
            }.sequence(),
            phasedUnits];
    }
    errorVisitor.clear();

    value moduleMembers
        =   HashMap<ModuleModel, LinkedList<DartCompilationUnitMember>>();

    value moduleSources
        =   LinkedListMultimap<ModuleModel, JFile>();

    value metamodelVisitors
        =   HashMap<ModuleModel, MetamodelVisitor>();

    swDartCompilerCreation.destroy(null);
    value swDartCompilation = timerStages.Measurement("Dart compilation");

    variable Integer nodeCountTransformer = 0;
    variable Integer nodeCountVisitor = 0;
    variable Integer nodeCountTcVisitor = 0;

    for (phasedUnit in phasedUnits) {
        phasedUnit.compilationUnit.visit(typeConstructorVisitor);

        value path => phasedUnit.pathRelativeToSrcDir else "<null>";

        // FIXME virtual files? skip if not saving src?
        moduleSources.put(phasedUnit.\ipackage.\imodule, JFile(phasedUnit.unit.fullPath));

        if (verboseFiles) {
            logErrorLine("-- begin " + path);
        }

        if (verboseRhAst) {
            logErrorLine("-- Redhat AST " + path);
            logErrorLine(phasedUnit.compilationUnit);
        }

        Integer start = system.nanoseconds;

        try {
            value ctx
                =   CompilationContext {
                        phasedUnit.unit;
                        CeylonList(phasedUnit.tokens);
                    };

            AnyCompilationUnit unit;
            try (timer.Measurement("anyCompilationUnitToCeylon")) {
                unit = anyCompilationUnitToCeylon {
                    phasedUnit.compilationUnit;
                    augmentNode;
                };
            }

            if (verboseAst) {
                logErrorLine("-- Ceylon AST " + path);
                logErrorLine(unit);
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

                try (timer.Measurement("metamodelVisitor")) {
                    phasedUnit.compilationUnit.visit(metamodelVisitor);
                }

                try (timer.Measurement("computeCaptures")) {
                    computeCaptures(unit, ctx);
                }

                try (timer.Measurement("computeClassCaptures")) {
                    computeClassCaptures(unit, ctx);
                }

                try (timer.Measurement("identifyMemoizedValues")) {
                    identifyMemoizedValues(unit, ctx);
                }

                try (timer.Measurement("transformCompilationUnit")) {
                    unit.visit(ctx.topLevelVisitor);
                }

                if (baselinePerfTest) {
                    try (timer.Measurement("countNodesTransformer")) {
                        nodeCountTransformer += countNodesTransformer(unit);
                    }

                    try (timer.Measurement("countNodesTransformerNull")) {
                        nodeCountTransformer += countNodesTransformerNull(unit);
                    }

                    try (timer.Measurement("countNodesVisitor")) {
                        nodeCountVisitor += countNodesVisitor(unit);
                    }

                    try (timer.Measurement("countNodesTcVisitor")) {
                        nodeCountTcVisitor += countNodesTcVisitor(
                                phasedUnit.compilationUnit);
                    }
                }

                declarations.addAll(ctx.compilationUnitMembers.sequence());
            }
        }
        catch (Throwable t) {
            logErrorLine(
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
        try (timer.Measurement("errorVisitor")) {
            phasedUnit.compilationUnit.visit(errorVisitor);
        }

        // verboseFiles output
        if (verboseFiles) {
            Integer end = system.nanoseconds;
            logErrorLine("-- end   " + path
                + " (``((end-start)/10^6).string``ms)");
        }
    }

    // add runtime model info & main function
    for (mod -> members in moduleMembers) {
        // jump through hoops to support default modules
        value unit
            =   if (mod.defaultModule)
                then mod.packages.get(0).units.iterator().next()
                else (mod.unit else null);

        if (!exists unit) {
            // this can occur with a module.ceylon file that is empty
            // or has nothing but whitespace
            continue;
        }

        value pkg
            =   if (mod.defaultModule)
                then mod.packages.get(0)
                else mod.unit.\ipackage;

        value ctx
            =   CompilationContext(unit, []);

        // add model info
        members.addAll(ModelGenerator(ctx).generateRuntimeModel(mod, pkg));

        // add main function
        members.add(generateMain(ctx, errorThrowingDScope(pkg)));
    }

    value dartCompilationUnits = LinkedList<DartCompilationUnit>();

    // we'll print errors at the end, but determine count now
    value errorCount = errorVisitor.errorCount;

    swDartCompilation.destroy(null);
    value swDartSerialization = timerStages.Measurement("Dart serialization");
    variable value createdModules = [] of {String*};

    for (m -> ds in moduleMembers) {
        function dartPackageLocationForModule(ModuleModel m)
            =>  "package:" + CeylonIterable(m.name)
                    .map(Object.string)
                    .interpose("/")
                    .fold("")(plus)
                    .plus("/")
                    .plus(m.name.get(m.name.size() - 1).string)
                    .plus(".dart");

        value importedModules
            =   gatherCompileDependencies(m).keys.rest
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
                    // Hack to have "dart.x" modules mean "dart:x" for interop
                    else if (m.name.size() == 2
                            && m.name.get(0).string == "dart") then
                        DartImportDirective {
                            DartSimpleStringLiteral("dart:" + m.name.get(1).string);
                            DartSimpleIdentifier {
                                moduleImportPrefix(m);
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
                    // Make dart.core, ceylon.interop.dart, and ceylon.dart.runtime.model
                    // available, even if not imported in module.ceylon.
                    {DartImportDirective {
                        DartSimpleStringLiteral("dart:core");
                        DartSimpleIdentifier("$dart$core");
                    },
                    DartImportDirective {
                        DartSimpleStringLiteral("package:ceylon/interop/dart/dart.dart");
                        DartSimpleIdentifier("$ceylon$interop$dart");
                    },
                    DartImportDirective {
                        DartSimpleStringLiteral(
                            "package:ceylon/dart/runtime/model/model.dart");
                        DartSimpleIdentifier("$ceylon$dart$runtime$model");
                    },
                    *importedModules}.coalesced.distinct.sequence();
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
            try (dFile = temporaryDirectory.TemporaryFile(
                            "ceylon-dart-dart-", ".dart"),
                 mFile = temporaryDirectory.TemporaryFile(
                            "ceylon-dart-model-", ".json")) {

                value dartFile = dFile;
                value modelFile = mFile;

                // write to the temp file
                try (appender = dartFile.Appender("utf-8")) {
                    dcu.write(CodeWriter(appender.write));
                    appender.write(native);
                }

                // persist to output repository
                if (exists outputRepositoryManager) {
                    // the code
                    value artifact = ArtifactContext(null, m.nameAsString, m.version,
                            ArtifactContext.\iDART);

                    artifact.forceOperation = true; // what does this do?

                    outputRepositoryManager.putArtifact(artifact, javaFile(dartFile));

                    ShaSigner.signArtifact(outputRepositoryManager, artifact,
                            javaFile(dartFile), null);

                    // the model
                    value modelArtifact = ArtifactContext(null, m.nameAsString, m.version,
                            ArtifactContext.\iDART_MODEL);

                    modelArtifact.forceOperation = true; // what does this do?

                    // persist the json model
                    try (appender = modelFile.Appender("utf-8")) {
                        assert (exists metamodelVisitor = metamodelVisitors.get(m));
                        if (m.nameAsString in
                                ["ceylon.dart.runtime.web",
                                 "ceylon.dart.runtime.standard"]) {
                            // ceylon.dart.runtime.standard and
                            // ceylon.dart.runtime.web masquerade as
                            // ceylon.dart.runtime.core. Only "core" is used at compile
                            // time, and only "standard" and "web" are used at runtime.
                            // Have the metadata for "standard" and "web" make them look
                            // like "core", since that is what will be expected at
                            // runtime.
                            metamodelVisitor.model.put(
                                javaString("$mod-name"),
                                javaString("ceylon.dart.runtime.core"));
                            metamodelVisitor.model.put(
                                javaString("ceylon.dart.runtime.core"),
                                metamodelVisitor.model.remove(
                                    javaString(m.nameAsString)));
                        }
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
            createdModules
                =   createdModules.follow {
                        ModuleUtil.makeModuleName(m.nameAsString, m.version);
                    };
        }
    }

    swDartSerialization.destroy(null);

    // suppress warnings *after* generating Dart code since Dart backend
    // may add warnings.
    try (timerStages.Measurement("Warning Suppression")) {
        try (timer.Measurement("warningSuppressionVisitor")) {
            phasedUnits.map(PhasedUnit.compilationUnit).each((cu)
                =>  cu.visit(warningSuppressionVisitor));
        }
    }

    if (verboseProfile) {
        void printTiming(String key, Integer nanos) {
            process.writeErrorLine(key.plus(":").padTrailing(30)
                + Float.format(nanos.float/1M, 2, 2).padLeading(10) + "ms");
        }

        process.writeErrorLine("");
        process.writeErrorLine("Profiling Information (Cross Sections)");
        process.writeErrorLine("------------------------------------------");
        for (sw in timer.totals) {
            printTiming(sw.key, sw.item);
        }
        printTiming("Total", timer.totalNanoseconds);

        process.writeErrorLine("");
        process.writeErrorLine("Profiling Information (Stages)");
        process.writeErrorLine("------------------------------------------");
        for (sw in timerStages.totals) {
            printTiming(sw.key, sw.item);
        }
        printTiming("Total", timerStages.totalNanoseconds);
    }

    // print errors last, to make them easy to find
    printErrors {
        logError;
        true; true;
        errorVisitor.positionedMessages;
        typeChecker;
    };

    createdModules.sequence().reversed.each {
        (moduleName) => logInfoLine("Note: Created module ``moduleName``");
    };

    return [
        dartCompilationUnits.sequence(),
        if (errorVisitor.errorCount > 0)
            then CompilationStatus.errorTypeChecker
            else CompilationStatus.success,
        errorVisitor.positionedMessages.collect((m) => m.node->m.message),
        CeylonIterable {
            typeChecker.phasedUnits.moduleManager.modules.listOfModules;
        }.sequence(),
        phasedUnits];
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

class Timer() {
    shared
    HashMap<String, Integer> totals = HashMap<String, Integer>(linked);

    shared
    class Measurement(String id) satisfies Destroyable {
        value startNanos = system.nanoseconds;

        shared actual
        void destroy(Throwable? error) {
            value elapsed = system.nanoseconds - startNanos;
            totals.put(id, elapsed + totals.getOrDefault(id, 0));
        }
    }

    shared
    T time<T>(String id, T run()) {
        value start = system.nanoseconds;
        value result = run();
        value stop = system.nanoseconds;
        totals.put(id, stop - start + totals.getOrDefault(id, 0));
        return result;
    }

    shared
    Integer totalNanoseconds
        =>  sum { 0, *totals.map(Entry.item) };
}

"Count nodes. Useful for determining baseline performance of WideningTransformers."
Integer countNodesTransformer(CompilationUnit unit) {
    object transformer satisfies WideningTransformer<Integer> {
        shared actual Integer transformNode(Node that)
            =>  sum { 1, *that.transformChildren(this) };
    }
    return unit.transform(transformer);
}

"Count nodes. Useful for determining baseline performance of WideningTransformers that
 are used like Visitors."
Integer countNodesTransformerNull(CompilationUnit unit) {
    variable Integer count = 0;
    object transformer satisfies WideningTransformer<Null> {
        shared actual Null transformNode(Node that) {
            count++;
            that.transformChildren(this);
            return null;
        }
    }
    unit.transform(transformer);
    return count;
}

"Count nodes. Useful for determining baseline performance of Visitors."
Integer countNodesVisitor(CompilationUnit unit) {
    variable Integer count = 0;
    object visitor satisfies Visitor {
        shared actual void visitNode(Node that) {
            count++;
            that.visitChildren(this);
        }
    }
    unit.visit(visitor);
    return count;
}

"Count nodes. Useful for determining baseline performance of TC Visitors."
Integer countNodesTcVisitor(Tree.CompilationUnit unit) {
    variable Integer count = 0;
    object visitor extends TCVisitor() {
        shared actual
        void visitAny(TreeNode that) {
            count++;
            that.visitChildren(this);
        }
    }
    unit.visit(visitor);
    return count;
}

"Gather all depencies of the given module, including exported transitive dependencies.
 The returned map will include the passed in module, unless the module is not for the
 Dart backend."
Map<ModuleModel, String> gatherCompileDependencies(
        ModuleModel moduleModel,
        Boolean excludeNonExported = false,
        MutableMap<ModuleModel, String> dependencies
            =   HashMap<ModuleModel, String> { stability = linked; }) {

    value previousVersion = dependencies[moduleModel];
    if (exists previousVersion) {
        if (moduleModel.version != previousVersion) {
            throw ReportableException(
                "Two versions of the same module cannot be imported. Module \
                 ``ModuleUtil.makeModuleName(
                        moduleModel.nameAsString, moduleModel.version)`` conflicts \
                 with ``ModuleUtil.makeModuleName(
                        moduleModel.nameAsString, previousVersion)``");
        }
        return dependencies;
    }

    if (!moduleModel.version exists) {
        // this can occur with a module.ceylon file that is empty
        // or has nothing but whitespace
        return dependencies;
    }

    dependencies.put(moduleModel, moduleModel.version);

    for (dependency in moduleModel.imports) {
        if (!isForDartBackend(dependency)) {
            continue;
        }
        // TODO we should search for version incompatibilites in non-exported
        //      versions too.
        if (!excludeNonExported || dependency.export) {
            gatherCompileDependencies(dependency.\imodule, true, dependencies);
        }
    }

    return dependencies;
}
