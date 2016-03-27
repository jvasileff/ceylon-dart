import ceylon.interop.java {
    CeylonList
}
import ceylon.process {
    createProcess,
    currentOutput,
    currentError,
    currentInput
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
    rest=rest__SETTER,
    option=option__SETTER,
    optionArgument=optionArgument__SETTER,
    description=description__SETTER
}
import com.redhat.ceylon.common.tools {
    CeylonTool
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException
}
import com.vasileff.jl4c.guava.collect {
    javaList
}

import java.lang {
    JString=String
}
import java.util {
    JList=List
}

shared
class CeylonRunDartTool() extends RepoUsingTool(repoUsingToolresourceBundle) {

    shared variable
    argument {
        argumentName="module";
        multiplicity="1";
        order=1;
    }
    String moduleString = "";

    shared variable rest
    JList<JString> args = javaList<JString> {};

    shared variable
    optionArgument
    description {
        "Link against the web compatible runtime. Defaults to 'false'.";
    }
    Boolean web = false;

    shared variable option
    description("Disable Ceylon version compatibility check (default is false)")
    Boolean disableCompatibilityCheck = false;

    shared variable option
    optionArgument {
        argumentName = "flags";
    }
    description {
        "Determines if and how compilation should be handled. \
         Allowed flags include: `never`, `once`, `force`, `check`."; }
    String compile = "never";

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
        if (!disableCompatibilityCheck) {
            checkCeylonVersion();
        }

        // Make sure the language module has been installed
        // Although, the program may actually import some other version...
        verifyLanguageModuleAvailability(repositoryManager);

        value dartPath = findExecutableInPath("dart");
        if (!exists dartPath) {
            throw ReportableException("Cannot find dart executable in path.");
        }

        value moduleName
            =   ModuleUtil.moduleName(moduleString);

        value moduleVersion
            =   checkModuleVersionsOrShowSuggestions(
                    repositoryManager,
                    moduleName,
                    ModuleUtil.moduleVersion(moduleString),
                    ModuleQuery.Type.\iDART,
                    null, null, null, null,
                    if (compile.empty) then "check" else compile) else "";

        value dependencies
            =   gatherDependencies(repositoryManager, moduleName, moduleVersion,
                    if (web) then "web" else "standard");

        value dependencyFiles
            =   mapToDependencyFiles(dependencies, repositoryManager);

        value [packageRootPath, moduleMap]
            =   createTemporaryPackageRoot(dependencyFiles);

        assert (exists programModuleSymlink
            =   moduleMap[moduleName]?.string);

        value p
            =   createProcess {
                    command = dartPath.name;
                    arguments = [
                        "--package-root=" + packageRootPath.string,
                        programModuleSymlink,
                        *CeylonList(args).map(Object.string)
                    ];
                    path = dartPath.directory.path;
                    input = currentInput;
                    output = currentOutput;
                    error = currentError;
                };

        p.waitForExit();
        return p.exitCode else 0;
    }
}
