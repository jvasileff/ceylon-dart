import ceylon.interop.java {
    javaClass,
    javaString,
    createJavaObjectArray,
    createJavaStringArray
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
import com.redhat.ceylon.common.tools {
    CeylonTool
}
import com.redhat.ceylon.model.cmr {
    ArtifactResult
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.lang {
    ObjectArray
}
import java.nio.file {
    JFiles=Files
}
import java.util {
    ListResourceBundle
}
import java.util.zip {
    ZipInputStream
}

shared
class CeylonInstallDartTool() extends OutputRepoUsingTool(installResourceBundle) {

    shared actual
    void initialize(CeylonTool? ceylonTool) {}

    shared actual
    void run() {
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
                    ArtifactContext.\iDART, ArtifactContext.\iSRC);

        languageModuleAC.ignoreDependencies = true;

        // perform the module copy
        value logArtifacts
            =   verbose exists
                    && (verbose.contains("all")
                    || verbose.contains("files"));

        // blindly copied from CeylonCopyTool
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
                    Integer max, Boolean copied) {
                if (!logArtifacts) {
                    append(") ").msg(if (copied) then "copying.ok" else "copying.skipped")
                            .newline().flush();
                }
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
                else {
                    if (count > 0) {
                        append(", ");
                    } else {
                        append(" (");
                    }
                    variable value name = ArtifactContext.getSuffixFromFilename(
                            artifactResult.artifact().name);
                    if (name.startsWith(".") || name.startsWith("-")) {
                        name = name.spanFrom(1);
                    } else if ("module-doc".equals(name)) {
                        name = "doc";
                    }
                    append(name);
                }
                return true;
            }

            shared actual
            Boolean beforeCopyModule(ArtifactContext artifactContext,
                    Integer count, Integer max) {
                value mod = ModuleUtil.makeModuleName(
                        artifactContext.name, artifactContext.version);
                msg("copying.module", mod, count+1, max).flush();
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

// TODO use resource file
object installResourceBundle extends ListResourceBundle() {
    shared actual ObjectArray<ObjectArray<Object>> contents
        // copied from tools/copy/resources/messages.properties
        =>  createJavaObjectArray([
                ["module.not.found", "Module {0} not found in the following repositories:"],
                ["missing.version.suggestion", "Not all repositories could be searched for matching modules/versions, try again using a specific version"],
                ["version.not.found", "Version {0} not found for module {1}"],
                ["missing.version", "Missing required module version number"],
                ["try.versions", "Try one of the following versions:"],
                ["unable.create.out.dir", "The ''out'' directory {0} does not exist and could not be created"],
                ["not.dir.out.dir", "The given ''out'' directory {0} exists, but is not a directory"],
                ["copying.module", "Module {0} [{1}/{2}]"],
                ["copying.artifact", "> {0} [{1}/{2}]"],
                ["copying.ok", "Ok"],
                ["copying.skipped", "Skipped"]
            ].map((e) => createJavaStringArray(e)));
}
