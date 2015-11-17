import ceylon.interop.java {
    javaClass,
    javaString
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext,
    ModuleQuery
}
import com.redhat.ceylon.cmr.ceylon {
    OutputRepoUsingTool,
    ModuleCopycat
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.redhat.ceylon.common.tool {
    ToolError
}
import com.redhat.ceylon.common.tools {
    CeylonTool
}
import com.redhat.ceylon.model.cmr {
    ArtifactResult
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException
}
import com.vasileff.jl4c.guava.collect {
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
        value unzipRootPath = JFiles.createTempDirectory("install-dart");
        unzipRootPath.toFile().deleteOnExit();

        // unzip our copy of the language module repository
        value zipIS = ZipInputStream(javaClass<CeylonInstallDartTool>()
            .getResourceAsStream("/com/vasileff/ceylon/dart/cli/ceylon-language.zip"));

        while (exists entry = zipIS.nextEntry) {
            value entryPath = unzipRootPath.resolve(entry.name);
            entryPath.toFile().deleteOnExit();
            if (entry.directory) {
                JFiles.createDirectory(entryPath);
            }
            else {
                JFiles.copy(zipIS, entryPath);
            }
        }
        zipIS.close();

        // configure this OutputRepoUsingTool with the temporary input repository
        repositoryAsStrings
            =   javaList { javaString(unzipRootPath.resolve("repository").string) };

        // auto-discover version
        String? moduleVersion
            =   checkModuleVersionsOrShowSuggestions(
                    repositoryManager,
                    "ceylon.language",
                    null,
                    ModuleQuery.Type.\iDART,
                    null, null);

        // configure the artifact context for the language module including source
        value languageModuleAC
            =   ArtifactContext("ceylon.language", moduleVersion,
                    ArtifactContext.\iDART_MODEL, ArtifactContext.\iDART,
                    ArtifactContext.\iSRC);

        languageModuleAC.forceOperation = true;

        languageModuleAC.ignoreDependencies = true;

        // perform the module copy
        value logArtifacts
            =   verbose exists
                    && (verbose.contains("all")
                    || verbose.contains("files"));

        // adapted from CeylonCopyTool
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
            void afterCopyModule(ArtifactContext? artifactContext, Integer count,
                    Integer max, Boolean copied) {}

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
                            log, feedback);
        copier.copyModule(languageModuleAC);
    }
}
