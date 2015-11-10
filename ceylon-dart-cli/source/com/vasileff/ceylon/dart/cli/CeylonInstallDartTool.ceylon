import ceylon.interop.java {
    javaClass,
    javaString
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext
}
import com.redhat.ceylon.cmr.ceylon {
    OutputRepoUsingTool,
    ModuleCopycat
}
import com.redhat.ceylon.common.tools {
    CeylonTool
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
class CeylonInstallDartTool() extends OutputRepoUsingTool(null) {

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

        // configure the artifact context for the language module
        value languageModuleAC
            =   ArtifactContext("ceylon.language", "1.2.0", ArtifactContext.\iDART);

        languageModuleAC.ignoreDependencies = true;

        // perform the module copy
        value copier = ModuleCopycat(repositoryManager, outputRepositoryManager);
        copier.copyModule(languageModuleAC);
    }
}
