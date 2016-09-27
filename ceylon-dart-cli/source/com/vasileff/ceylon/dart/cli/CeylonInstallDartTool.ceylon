import ceylon.interop.java {
    javaClass,
    javaString
}

import com.redhat.ceylon.cmr.ceylon {
    ModuleCopycat
}
import com.redhat.ceylon.cmr.api {
    ArtifactContext,
    ModuleQuery
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.redhat.ceylon.common.tool {
    ToolError,
    option=option__SETTER,
    description=description__SETTER
}
import com.redhat.ceylon.common.tools {
    CeylonTool,
    OutputRepoUsingTool
}
import com.redhat.ceylon.model.cmr {
    ArtifactResult
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException,
    javaList
}

import java.nio.file {
    JFiles=Files
}
import java.util.zip {
    ZipInputStream
}

shared
class CeylonInstallDartTool() extends OutputRepoUsingTool(installResourceBundle) {

    shared actual
    void initialize(CeylonTool? ceylonTool) {}

    shared variable option
    description {
        "Suppress output of successfull actions. \
         Errors and warnings will still be logged.";
    }
    Boolean quiet = false;

    shared variable option
    description("Disable Ceylon version compatibility check (default is false)")
    Boolean disableCompatibilityCheck = false;

    needsSystemRepo() => false;

    doNotReadFromOutputRepo() => true;

    shared actual
    suppressWarnings("expressionTypeNothing")
    void run() {
        try {
            doRun();
            process.exit(0);
        }
        catch (ReportableException e) {
            throw object extends ToolError(e.message, e.cause) {};
        }
    }

    void doRun() {
        if (!disableCompatibilityCheck) {
            checkCeylonVersion();
        }

        value unzipRootPath = JFiles.createTempDirectory("install-dart");
        unzipRootPath.toFile().deleteOnExit();

        void unzip(String resource) {
            // unzip our copy of the language module repository
            value zipIS = ZipInputStream(javaClass<CeylonInstallDartTool>()
                .getResourceAsStream(resource));

            while (exists entry = zipIS.nextEntry) {
                value entryPath = unzipRootPath.resolve(entry.name);
                entryPath.toFile().deleteOnExit();
                if (entry.directory) {
                    if (!entryPath.toFile().\iexists()) {
                        JFiles.createDirectory(entryPath);
                    }
                }
                else {
                    JFiles.copy(zipIS, entryPath);
                }
            }
            zipIS.close();
        }

        unzip("/com/vasileff/ceylon/dart/cli/ceylon-language.zip");
        unzip("/com/vasileff/ceylon/dart/cli/ceylon-sdk.zip");

        // configure this OutputRepoUsingTool with the temporary input repository
        repositoryAsStrings
            =   javaList { javaString(unzipRootPath.resolve("repository").string) };

        // auto-discover version
        String? moduleVersion(String moduleName)
            =>  checkModuleVersionsOrShowSuggestions(
                    repositoryManager,
                    moduleName,
                    null,
                    ModuleQuery.Type.\iDART,
                    null, null, null, null);

        function newArtifactContext(String name) {
            value version
                =   moduleVersion(name);

            value ac
                =   ArtifactContext(name, version,
                        ArtifactContext.\iDART_MODEL, ArtifactContext.\iDART);

            ac.forceOperation = true;
            ac.ignoreDependencies = true;
            return ac;
        }

        value artifactContexts
            =   javaList {
                    for (moduleName in {
                        "dart.async",
                        "dart.collection",
                        "dart.convert",
                        "dart.core",
                        "dart.developer",
                        "dart.html",
                        "dart.io",
                        "dart.isolate",
                        "dart.math",
                        "dart.mirrors",
                        "dart.typed_data",
                        "ceylon.dart.runtime.core",
                        "ceylon.dart.runtime.model",
                        "ceylon.dart.runtime.nativecollection",
                        "ceylon.dart.runtime.standard",
                        "ceylon.dart.runtime.structures",
                        "ceylon.dart.runtime.web",
                        "ceylon.interop.dart",
                        "ceylon.language",
                        "ceylon.buffer",
                        "ceylon.collection",
                        "ceylon.html",
                        "ceylon.json",
                        "ceylon.locale",
                        "ceylon.logging",
                        "ceylon.numeric",
                        "ceylon.promise",
                        "ceylon.random",
                        "ceylon.test",
                        "ceylon.time",
                        "ceylon.whole"})
                    newArtifactContext(moduleName)
                };

        // perform the module copy
        value logArtifacts
            =   verbose exists
                    && (verbose.contains("all")
                    || verbose.contains("files"));

        logInfo("Installing Dart modules to repository \
             ``\iout else "./modules"``");

        object feedback satisfies ModuleCopycat.CopycatFeedback {
            shared actual
            void afterCopyArtifact(ArtifactContext? artifactContext,
                    ArtifactResult? artifactResult, Integer int,
                    Integer int1, Boolean copied) {
                if (logArtifacts) {
                    append(" ").msg(if (copied) then "copying.ok" else "copying.skipped")
                            .newline().flush();
                }
            }

            shared actual
            void afterCopyModule(ArtifactContext artifactContext, Integer count,
                    Integer max, Boolean copied) {
                value name = ModuleUtil.makeModuleName(
                        artifactContext.name, artifactContext.version);
                logInfo("    ``name``");
            }

            shared actual
            Boolean beforeCopyArtifact(ArtifactContext? artifactContext,
                    ArtifactResult artifactResult, Integer count, Integer max) {
                if (logArtifacts) {
                    if (count == 0) {
                        append(" -- ");
                        append(artifactResult.repositoryDisplayString());
                        newline().flush();
                    }
                    append("    ").msg("copying.artifact",
                        artifactResult.artifact().name, count+1, max).flush();
                }
                return true;
            }

            shared actual
            Boolean beforeCopyModule(ArtifactContext artifactContext,
                    Integer count, Integer max) {
                if (logArtifacts) {
                    value mod = ModuleUtil.makeModuleName(
                            artifactContext.name, artifactContext.version);
                    msg("copying.module", mod, count+1, max).flush();
                }
                return true;
            }

            shared actual
            void notFound(ArtifactContext artifactContext) {
                value err = getModuleNotFoundErrorMessage(repositoryManager,
                    artifactContext.name, artifactContext.version);
                errorAppend(err);
                errorNewline();
            }
        }

        value copier = ModuleCopycat(repositoryManager, outputRepositoryManager,
                            logger, feedback);
        copier.copyModules(artifactContexts);
    }

    void logInfo(String message) {
        if (!quiet) {
            process.writeErrorLine(message);
        }
    }
}
