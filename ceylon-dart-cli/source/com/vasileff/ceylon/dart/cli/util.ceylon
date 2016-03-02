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
    parsePath,
    Link,
    Nil,
    createFileIfNil
}
import com.vasileff.ceylon.dart.compiler {
    ceylonFile,
    parseJson,
    ReportableException,
    JsonObject,
    JsonArray,
    javaPath,
    javaFile
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
              "The Ceylon/Dart module \
               ``ModuleUtil.makeModuleName("ceylon.language", version)``
               was not found. Please complete the installation with:

                   ceylon install-dart --out ~/.ceylon/repo\n ");
    }
}

void checkCeylonVersion() {
    if (!language.version in ["1.2.1", "1.2.2"]) {
        throw ReportableException(
            "Sorry, the Dart backend is not compatible
             with Ceylon ``language.version``. Please try again with Ceylon \
             version 1.2.1.");
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
        variable String moduleName,
        String moduleVersion,
        "The variation of ceylon.dart.runtime to use ('standard' or 'web')"
        String runtime = "standard",
        MutableMap<String,String> dependencies
            =   HashMap<String, String>()) {

    // Never actually use ceylon.dart.runtime.core. The actual implementations
    // are ceylon.dart.runtime.standard and ceylon.dart.runtime.web.
    if (moduleName == "ceylon.dart.runtime.core") {
        moduleName = "ceylon.dart.runtime.``runtime``";
    }

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
                runtime;
                dependencies;
            });

    return dependencies;
}

{<String->File>*} mapToDependencyFiles(
        Map<String,String> dependencies, RepositoryManager repositoryManager)
    =>  dependencies.map((pair)
        =>  let (name -> version = pair)
            (if (name.startsWith("ceylon.dart.runtime."))
                // Let ceylon.dart.runtime.web and
                // ceylon.dart.runtime.standard masquerade as
                // ceylon.dart.runtime.core. The name assigned here will be used
                // to generate the directory and file name for the dependency
                // when it is copied to the directory used for the runtime
                // environment.
                then "ceylon.dart.runtime.core"
                else name)
            -> moduleFile(repositoryManager, name, version));

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

File? findExecutableInPath(String fileName) {
    assert (exists sep = operatingSystem.pathSeparator.first);

    // TODO handle Links, support windows (dart.exe?)
    return process.environmentVariableValue("PATH")
            ?.split(sep.equals)
            ?.map(parsePath)
            ?.map(Path.resource)
            ?.narrow<Directory>()
            ?.flatMap((d) => d.files(fileName))
            ?.filter(File.executable)
            ?.first;
}

Directory createDirectoryIfAbsent(Path path) {
    value target = path.resource;
    switch (target)
    case (is Directory) {
        return target;
    }
    case (is Nil) {
        return target.createDirectory(true);
    }
    case (is File | Link) {
        throw ReportableException(
            "Cannot overwrite file or symbolic link resource \
             ``target.path.string``");
    }
}

File overwriteFile(Path path, String contents) {
    value target = path.resource;
    if (is Directory | Link target) {
        throw ReportableException(
            "Cannot overwrite directory or symbolic link resource \
             ``target.path.string``");
    }

    value file = createFileIfNil(target);

    try (writer = file.Overwriter("utf-8")) {
        writer.write(contents);
    }

    return file;
}

void setExecutable(File file) {
    javaFile(file).setExecutable(true);
}
