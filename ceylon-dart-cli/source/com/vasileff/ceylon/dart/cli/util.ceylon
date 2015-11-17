import com.redhat.ceylon.cmr.api {
    ArtifactContext,
    RepositoryManager
}
import java.io {
    JFile=File
}
import ceylon.file {
    File,
    Path,
    Directory,
    parsePath
}
import com.vasileff.ceylon.dart.compiler {
    ceylonFile,
    parseJson,
    ReportableException,
    JsonObject,
    JsonArray,
    javaPath
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import ceylon.collection {
    MutableMap,
    HashMap
}
import java.nio.file {
    FileAlreadyExistsException,
    JPath=Path,
    JFiles=Files
}

void verifyLanguageModuleAvailability(RepositoryManager repositoryManager) {
    value version = `module`.version;

    value languageModuleFile = repositoryManager.getArtifact(
        ArtifactContext("ceylon.language", version, ArtifactContext.\iDART))
        else null;

    if (!exists languageModuleFile) {
        throw ReportableException(
              "The Ceylon/Dart language module version ``version``
               was not found. Try installing with:

                   ceylon install-dart --out ~/.ceylon/repo");
    }
}

JsonObject? parseJsonModel(JFile | File file) {
    value jsonObject = parseJson(ceylonFile(file));
    if (is JsonObject jsonObject) {
        return jsonObject;
    }
    return null;
}

File moduleFile(
        RepositoryManager repositoryManager,
        String moduleName, String? moduleVersion) {
    if (exists file = ceylonFile(repositoryManager.getArtifact(ArtifactContext(
                    moduleName, moduleVersion, ArtifactContext.\iDART)))) {
        return file;
    }
    throw ReportableException("Cannot find module \
             ``ModuleUtil.makeModuleName(moduleName, moduleVersion)``");
}

File moduleModelFile(
        RepositoryManager repositoryManager,
        String moduleName, String? moduleVersion) {
    if (exists file = ceylonFile(repositoryManager.getArtifact(ArtifactContext(
                    moduleName, moduleVersion, ArtifactContext.\iDART_MODEL)))) {
        return file;
    }
    throw ReportableException("Cannot find model metadata for module \
             ``ModuleUtil.makeModuleName(moduleName, moduleVersion)``");
}

JsonObject moduleModel(
        RepositoryManager repositoryManager,
        String moduleName, String? moduleVersion) {
    value modelFile = moduleModelFile(repositoryManager, moduleName, moduleVersion);

    value parsedJson = parseJsonModel(modelFile);

    if (!exists parsedJson) {
        throw ReportableException(
                "Unable to parse json model metadata for module \
                 ``ModuleUtil.makeModuleName(moduleName, moduleVersion)``");
    }
    return parsedJson;
}

[String*] dependencyNamesFromJson(JsonObject model) {
    assert (is JsonArray? dependencies
        =   model.get("$mod-deps"));

    "We'll always have dependencies; at least the language module."
    assert (exists dependencies);

    return
    dependencies.collect((dependency) {
        assert (is String | JsonObject dependency);

        switch (dependency)
        case (is String) {
            return dependency.string;
        }
        case (is JsonObject) {
            assert (is String path = dependency.get("path"));
            return path.string;
        }
    });
}

MutableMap<String,String> gatherDependencies(
        RepositoryManager repositoryManager,
        String moduleName,
        String moduleVersion,
        MutableMap<String,String> dependencies
            =   HashMap<String, String>()) {

    value previousVersion = dependencies[moduleName];
    if (exists previousVersion) {
        if (moduleVersion != previousVersion) {
            throw ReportableException(
                "Two versions of the same module cannot be imported. Module \
                 ``ModuleUtil.makeModuleName(moduleName, moduleVersion)`` conflicts \
                 with ``ModuleUtil.makeModuleName(moduleName, previousVersion)``");
        }
        return dependencies;
    }

    dependencies.put(moduleName, moduleVersion);

    value parsedJson = moduleModel(repositoryManager, moduleName, moduleVersion);

    dependencyNamesFromJson(parsedJson).each((dep)
        =>  gatherDependencies {
                repositoryManager;
                ModuleUtil.moduleName(dep);
                ModuleUtil.moduleVersion(dep) else "";
                dependencies;
            });

    return dependencies;
}

[JPath, Map<String, JPath>] createTemporaryPackageRoot({<String->File>*} modules) {
    value moduleToLinkMap = HashMap<String, JPath>();

    // create temporary Dart package root directory
    value packageRootPath = JFiles.createTempDirectory("ceylon-run-dart");
    packageRootPath.toFile().deleteOnExit();

    // populate with modules
    for (name->file in modules) {
        variable JPath symLinkPath = packageRootPath;

        value nameParts = name.split('.'.equals);
        for (part in nameParts) {
            symLinkPath = symLinkPath.resolve(part);
            try {
                // this throws if "recreating" common dirs, like /com, since packages
                // may share leading path segments.
                JFiles.createDirectory(symLinkPath);
                symLinkPath.toFile().deleteOnExit();
            } catch (FileAlreadyExistsException e) {}
        }
        symLinkPath = symLinkPath.resolve(nameParts.last + ".dart");
        JFiles.createSymbolicLink(symLinkPath, javaPath(file));
        symLinkPath.toFile().deleteOnExit();
        moduleToLinkMap.put(name, symLinkPath);
    }
    return [packageRootPath, moduleToLinkMap];
}

File? findDartInPath(String? path) {
    assert (exists sep = operatingSystem.pathSeparator.first);

    // TODO handle Links, support windows (dart.exe?)
    return path?.split(sep.equals)
            ?.map(parsePath)
            ?.map(Path.resource)
            ?.narrow<Directory>()
            ?.flatMap((d) => d.files("dart"))
            ?.filter(File.executable)
            ?.first;
}
