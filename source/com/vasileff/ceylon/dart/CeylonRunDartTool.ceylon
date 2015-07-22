import ceylon.collection {
    HashMap
}
import ceylon.file {
    parsePath,
    Path,
    Directory,
    File
}
import ceylon.process {
    createProcess,
    currentOutput,
    currentError,
    currentInput
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext
}
import com.redhat.ceylon.cmr.ceylon {
    RepoUsingTool
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.redhat.ceylon.common.tool {
    argument=argument__SETTER
}
import com.redhat.ceylon.common.tools {
    CeylonTool
}

import java.io {
    JFile=File
}
import java.nio.file {
    JFiles=Files,
    JPath=Path
}

shared
class CeylonRunDartTool() extends RepoUsingTool(null) {

    shared variable
    argument {
        argumentName="module";
        multiplicity="1";
        order=1;
    }
    String moduleString = "";

    shared actual
    void initialize(CeylonTool? ceylonTool) {
        // noop
    }

    shared actual
    void run() {
        value dartPath = findDartInPath(process.environmentVariableValue("PATH"));
        if (!exists dartPath) {
            process.writeErrorLine("Error: cannot find dart executable in path.");
        }
        assert (exists dartPath);

        // TODO handle default modules
        // TODO handle version lookup
        value moduleIsDefault = ModuleUtil.isDefaultModule(moduleString);
        String moduleVersion = ModuleUtil.moduleVersion(moduleString);
        String moduleName = ModuleUtil.moduleName(moduleString);

        // collect required artifacts, generate temporary dart package root
        value programModuleFile = repositoryManager.getArtifact(
            ArtifactContext(moduleName, moduleVersion, ".dart"));

        value languageModuleFile = repositoryManager.getArtifact(
            ArtifactContext("ceylon.language", "0.0.1", ".dart"));

        value [packageRootPath, moduleMap] = createTemporaryPackageRoot(
            [moduleName -> programModuleFile,
             "ceylon.language" -> languageModuleFile]);

        assert (exists programModuleSymlink = moduleMap[moduleName]?.string);

        value p = createProcess {
            command = dartPath.name;
            arguments = [
                "--package-root=" + packageRootPath.string,
                programModuleSymlink];
            path = dartPath.directory.path;
            input = currentInput;
            output = currentOutput;
            error = currentError;
        };
        p.waitForExit();
    }
}

[JPath, Map<String, JPath>] createTemporaryPackageRoot({<String->JFile>*} modules) {
    value moduleToLinkMap = HashMap<String, JPath>();

    // create temporary Dart package root directory
    value packageRootPath = JFiles.createTempDirectory("ceylon-run-dart");
    packageRootPath.toFile().deleteOnExit();

    // populate with modules
    for (name->jFile in modules) {
        variable JPath symLinkPath = packageRootPath;

        value nameParts = name.split('.'.equals);
        for (part in nameParts) {
            symLinkPath = symLinkPath.resolve(part);
            JFiles.createDirectory(symLinkPath);
            symLinkPath.toFile().deleteOnExit();
        }
        symLinkPath = symLinkPath.resolve(nameParts.last + ".dart");
        JFiles.createSymbolicLink(symLinkPath, jFile.toPath());
        symLinkPath.toFile().deleteOnExit();
        moduleToLinkMap.put(name, symLinkPath);
    }
    return [packageRootPath, moduleToLinkMap];
}

File? findDartInPath(String? path) {
    // TODO don't assume single character separator, I guess.
    assert (exists sep = operatingSystem.pathSeparator.first);

    // TODO handle Links
    // TODO windows name (dart.exe?)
    return path?.split(sep.equals)
            ?.map(parsePath)
            ?.map(Path.resource)
            ?.narrow<Directory>()
            ?.flatMap((d) => d.files("dart"))
            ?.filter(File.executable)
            ?.first;
}
