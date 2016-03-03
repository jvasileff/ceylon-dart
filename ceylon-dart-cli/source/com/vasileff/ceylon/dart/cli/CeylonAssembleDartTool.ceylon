import ceylon.collection {
    HashMap
}
import ceylon.file {
    File,
    parsePath,
    Directory,
    Link,
    Path,
    createFileIfNil,
    readAndAppendLines
}
import ceylon.process {
    currentOutput,
    currentError,
    currentInput,
    createProcess
}

import com.redhat.ceylon.cmr.api {
    ModuleQuery
}
import com.redhat.ceylon.cmr.ceylon {
    RepoUsingTool
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.redhat.ceylon.common.tool {
    argument=argument__SETTER,
    ToolError,
    option=option__SETTER,
    optionArgument=optionArgument__SETTER,
    description=description__SETTER
}
import com.redhat.ceylon.common.tools {
    CeylonTool
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException,
    TemporaryFile
}

import java.lang {
    JString=String,
    JBoolean=Boolean
}

shared
class CeylonAssembleDartTool() extends RepoUsingTool(repoUsingToolresourceBundle) {

    shared variable
    argument {
        argumentName = "module";
        multiplicity = "1";
        order=1;
    }
    String moduleString = "";

    shared variable
    optionArgument { shortName = 'o'; argumentName="url"; }
    description {
        "Output directory for the Dart Application Assembly.
         The default is 'moduleName-assembly'.";
    }
    JString? \iout = null;

    shared variable
    optionArgument
    description {
        "The output mode. May be 'dart' or 'js' to generate a single file, or 'expanded'
         to create a Dart project directory.";
    }
    AssembleMode mode = AssembleMode.dart;

    shared variable
    optionArgument
    description {
        "Link against the web compatible runtime. Defaults to 'true' if mode is 'js', or
         false otherwise.";
    }
    JBoolean? web = null;

    shared variable option
    optionArgument {
        argumentName = "flags";
    }
    description {
        "Determines if and how compilation should be handled. \
         Allowed flags include: `never`, `once`, `force`, `check`."; }
    String compile = "never";

    shared variable option
    description {
        "Suppress output of successfull actions. \
         Errors and warnings will still be logged.";
    }
    Boolean quiet = false;

    shared variable option { shortName = 'm'; }
    description {
        "In non-expanded mode, instruct dart2js to minify the output. Using this option
         may result in buggy output.";
    }
    Boolean minify = false;

    shared actual
    void initialize(CeylonTool? ceylonTool) {
        // noop
    }

    shared actual
    suppressWarnings("expressionTypeNothing")
    void run() {
        try {
            value exitCode = doRun();
            process.exit(exitCode);
        }
        catch (ReportableException e) {
            throw object extends ToolError(e.message, e.cause) {};
        }
    }

    Integer doRun() {
        checkCeylonVersion();
        // Make sure the language module has been installed
        // Although, the program may actually import some other version...
        verifyLanguageModuleAvailability(repositoryManager);

        // TODO support default modules
        if (ModuleUtil.isDefaultModule(moduleString)) {
            throw ReportableException(
                    "Default modules not yet supported: ``moduleString``");
        }

        value cwdPath
            =   parsePath(validCwd().absolutePath);

        value moduleName
            =   ModuleUtil.moduleName(moduleString);

        value moduleShortName
            =   if (exists lastDot = moduleName.lastOccurrence('.'))
                then moduleName[(lastDot + 1)...]
                else moduleName;

        value moduleVersion
            =   checkModuleVersionsOrShowSuggestions(
                    repositoryManager,
                    moduleName,
                    ModuleUtil.moduleVersion(moduleString),
                    ModuleQuery.Type.\iDART,
                    null, null, null, null,
                    if (compile.empty) then "once" else compile) else "";

        value runtime
            =   if (web?.booleanValue() else mode == AssembleMode.js)
                then "web" else "standard";

        value dependencies
            =   gatherDependencies(repositoryManager, moduleName, moduleVersion, runtime);

        value dependencyFiles
            =   mapToDependencyFiles(dependencies, repositoryManager);

        if (mode == AssembleMode.expanded) {
            value assemblyRootPath
                =   cwdPath.childPath(\iout?.string else "``moduleShortName``-assembly");

            value assemblyBinPath
                =   assemblyRootPath.childPath("bin");

            value packageRootPath
                =   assemblyRootPath.childPath("packages");

            createDirectoryIfAbsent(assemblyRootPath);
            createDirectoryIfAbsent(assemblyBinPath);
            createDirectoryIfAbsent(packageRootPath);

            value moduleMap
                =   createPackageRoot(dependencyFiles, packageRootPath);

            assert (exists programModuleFile
                =   moduleMap[moduleName]);

            value runFilePath
                =   assemblyBinPath.childPath(moduleShortName);

            value runScript
                =   runScriptTemplate.replace {
                        "MODULE_FILE_RELATIVE_PATH";
                        programModuleFile.relativePath(assemblyBinPath).string;
                    }.replace {
                        "PACKAGES_RELATIVE_PATH";
                        packageRootPath.relativePath(assemblyBinPath).string;
                    };

            value runFile
                =   overwriteFile(runFilePath, runScript);

            setExecutable(runFile);

            value readmeFilePath
                =   assemblyRootPath.childPath("README");

            value readmeText
                =   readmeTemplate.replace {
                        "MODULE_FILE_RELATIVE_PATH";
                        programModuleFile.relativePath(assemblyRootPath).string;
                    }.replace {
                        "PACKAGES_RELATIVE_PATH";
                        packageRootPath.relativePath(assemblyRootPath).string;
                    }.replace {
                        "RUN_FILE_NAME";
                        moduleShortName;
                    };

            overwriteFile(readmeFilePath, readmeText);

            logInfo("Created expanded assembly directory \
                     ``\iout else assemblyRootPath.relativePath(cwdPath)``");

            return 0;
        }
        else {
            // create an executable dart script

            value [packageRootPath, moduleMap]
                =   createTemporaryPackageRoot(dependencyFiles);

            assert (exists programModuleFile
                =   moduleMap[moduleName]);

            value dart2jsPath = findExecutableInPath("dart2js");
            if (!exists dart2jsPath) {
                throw ReportableException("Cannot find dart2js executable in path.");
            }

            try (tempScriptFile = TemporaryFile()) {
                value p
                    =   createProcess {
                            command = dart2jsPath.string;
                            arguments = [
                                "--enable-experimental-mirrors",
                                !runtime == "web" then "--categories=Server",
                                mode == AssembleMode.dart then "--output-type=dart",
                                "--package-root=" + packageRootPath.string,
                                minify then "-m", // minify
                                "-o", tempScriptFile.file.path.string,
                                // TODO add verbose option to enable dart2js messages
                                "--suppress-warnings",
                                "--suppress-hints",
                                programModuleFile.string
                            ].coalesced;
                            path = parsePath(validCwd().absolutePath);
                            input = currentInput;
                            output = currentOutput;
                            error = currentError;
                        };

                p.waitForExit();
                if (exists code = p.exitCode, code != 0) {
                    throw ReportableException("dart2js reported an error.");
                }

                value extension
                    =   if (mode == AssembleMode.js)
                        then "js"
                        else "dart";

                value scriptFilePath
                    =   parsePath(validCwd().absolutePath).childPath(
                            \iout?.string else "``moduleShortName``.``extension``");

                value resource
                    =   scriptFilePath.resource;

                if (is Directory | Link resource) {
                    throw ReportableException(
                        "Cannot overwrite directory or symbolic link resource \
                         ``resource.path.string``");
                }
                value scriptFile = createFileIfNil(resource);
                try (writer = scriptFile.Overwriter("utf-8")) {
                    if (mode == AssembleMode.dart) {
                        writer.writeLine("#!/usr/bin/env dart");
                    }
                }
                readAndAppendLines(tempScriptFile.file, scriptFile);
                if (mode == AssembleMode.dart) {
                    setExecutable(scriptFile);
                }
                value minified = if (minify) then "minified " else "";
                logInfo("Created ``minified``executable Dart script \
                         ``\iout else scriptFilePath.relativePath(cwdPath)``");

                return 0;
            }
        }
    }

    void logInfo(String message) {
        if (!quiet) {
            process.writeErrorLine(message);
        }
    }
}

Map<String, Path> createPackageRoot(
        {<String->File>*} modules, Path packageRootPath) {

    value moduleToLinkMap = HashMap<String, Path>();

    // populate with modules
    for (name->file in modules) {
        variable Path dartPackagePath = packageRootPath;

        value nameParts = name.split('.'.equals);
        for (part in nameParts) {
            dartPackagePath = dartPackagePath.childPath(part);
            createDirectoryIfAbsent(dartPackagePath);
        }
        dartPackagePath = dartPackagePath.childPath(nameParts.last + ".dart");
        value target = parsePath(dartPackagePath.string).resource;

        if (is Directory | Link target) {
            throw ReportableException(
                "Cannot overwrite directory or symbolic link resource \
                 ``target.path.string``");
        }

        file.copyOverwriting(target);
        moduleToLinkMap.put(name, dartPackagePath);
    }
    return moduleToLinkMap;
}

String runScriptTemplate
    =    """#!/bin/sh

            ARG0="$0"
            while [ -h "$ARG0" ]; do
              ls=`ls -ld "$ARG0"`
              link=`expr "$ls" : '.*-> \(.*\)$'`
              if expr "$link" : '/.*' > /dev/null; then
                ARG0="$link"
              else
                ARG0="`dirname $ARG0`/$link"
              fi
            done
            DIRNAME="`dirname $ARG0`"
            PROGRAM="`basename $ARG0`"

            dart --package-root=$DIRNAME/PACKAGES_RELATIVE_PATH $DIRNAME/MODULE_FILE_RELATIVE_PATH "$@"
         """;

String readmeTemplate
    =    """Run with:

                $ASSEMBLY_HOME/bin/RUN_FILE_NAME [arguments]

            or

                dart --package-root=$ASSEMBLY_HOME/PACKAGES_RELATIVE_PATH $ASSEMBLY_HOME/MODULE_FILE_RELATIVE_PATH [arguments]
         """;
