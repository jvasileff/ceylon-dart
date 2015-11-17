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
    ToolError
}
import com.redhat.ceylon.common.tools {
    CeylonTool
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException
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
        value dartPath = findDartInPath(process.environmentVariableValue("PATH"));
        if (!exists dartPath) {
            throw ReportableException("Cannot find dart executable in path.");
        }

        // Make sure the language module has been installed
        // Although, the program may actually import some other version...
        verifyLanguageModuleAvailability(repositoryManager);

        // TODO support default modules
        if (ModuleUtil.isDefaultModule(moduleString)) {
            throw ReportableException(
                    "Default modules not yet supported: ``moduleString``");
        }

        value moduleName
            =   ModuleUtil.moduleName(moduleString);

        value moduleVersion
            =   checkModuleVersionsOrShowSuggestions(
                    repositoryManager,
                    moduleName,
                    ModuleUtil.moduleVersion(moduleString),
                    ModuleQuery.Type.\iDART,
                    null, null) else "";

        value dependencies
            =   gatherDependencies(repositoryManager, moduleName, moduleVersion);

        value dependencyFiles
            =   dependencies.map((pair)
                =>  let (name -> version = pair)
                    name -> moduleFile(repositoryManager, name, version));

        value [packageRootPath, moduleMap]
            =   createTemporaryPackageRoot(dependencyFiles);

        assert (exists programModuleSymlink
            =   moduleMap[moduleName]?.string);

        value p
            =   createProcess {
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
        return p.exitCode else 0;
    }
}
