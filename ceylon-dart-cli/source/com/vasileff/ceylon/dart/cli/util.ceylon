import ceylon.collection {
    MutableMap,
    HashMap
}
import ceylon.file {
    File,
    Path,
    Resource,
    Directory,
    parsePath,
    Link,
    Nil,
    createFileIfNil,
    temporaryDirectory
}

import com.redhat.ceylon.cmr.api {
    ArtifactContext,
    RepositoryManager
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.vasileff.ceylon.dart.compiler {
    ceylonFile,
    parseJson,
    ReportableException,
    JsonObject,
    JsonArray,
    javaFile,
    createSymbolicLink
}

import java.io {
    JFile=File
}

void verifyLanguageModuleAvailability(RepositoryManager repositoryManager) {
    value version = `module`.version;

    value languageModuleFile = repositoryManager.getArtifact(
        ArtifactContext(null, "ceylon.language", version, ArtifactContext.\iDART))
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
    if (language.version != "1.2.3") {
        throw ReportableException(
            "Sorry, the Dart backend is not compatible
             with Ceylon ``language.version``. Please try again with Ceylon \
             version 1.2.3, or disable this check with --disable-compatibility-check.");
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
                    null, moduleName, moduleVersion, ArtifactContext.\iDART)))) {
        return file;
    }
    throw ReportableException("Cannot find module \
             ``ModuleUtil.makeModuleName(moduleName, moduleVersion)``");
}

File moduleModelFile(
        RepositoryManager repositoryManager,
        String moduleName, String? moduleVersion) {
    if (exists file = ceylonFile(repositoryManager.getArtifact(ArtifactContext(
                    null, moduleName, moduleVersion, ArtifactContext.\iDART_MODEL)))) {
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

Map<String,String> gatherDependencies(
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

[Path, Map<String, Path>] createTemporaryPackageRoot({<String->File>*} modules) {
    value moduleToLinkMap = HashMap<String, Path>();

    // create temporary Dart package root directory
    value packageRootPath = temporaryDirectory.TemporaryDirectory("ceylon-run-dart");
    packageRootPath.deleteOnExit();

    // populate with modules
    for (name->file in modules) {
        variable Path symLinkPath = packageRootPath.path;

        value nameParts = name.split('.'.equals);
        for (part in nameParts) {
            symLinkPath = symLinkPath.childPath(part);
            value symLinkDir = createDirectoryIfAbsent(symLinkPath);
            symLinkDir.deleteOnExit();
        }
        symLinkPath = symLinkPath.childPath(nameParts.last + ".dart");
        assert (is Nil nilLink = symLinkPath.resource);
        value link = createSymbolicLink(nilLink, file.path);
        link.deleteOnExit();
        moduleToLinkMap.put(name, parsePath(symLinkPath.string));
    }
    return [packageRootPath.path, moduleToLinkMap];
}

File? findExecutableInPath(String fileName) {
    assert (exists sep = operatingSystem.pathSeparator.first);

    return process.environmentVariableValue("PATH")
            ?.split(sep.equals)
            ?.map(parsePath)
            ?.map(Path.resource)
            ?.map(Resource.linkedResource)
            ?.narrow<Directory>()
            ?.flatMap((d) => d.children(fileName))
            ?.map(Resource.linkedResource)
            ?.narrow<File>()
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
