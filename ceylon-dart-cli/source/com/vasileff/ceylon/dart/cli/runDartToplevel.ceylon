import ceylon.process {
    createProcess,
    currentOutput,
    currentError,
    currentInput
}

import com.redhat.ceylon.cmr.api {
    RepositoryManager
}
import com.redhat.ceylon.common {
    ModuleUtil
}
import com.vasileff.ceylon.dart.compiler {
    ReportableException
}

/* TODO
    - move to dart.compiler module, for use with tests?
    - options:
        --disableCompatibilityCheck
        --disableDefaultRepos
        --compile (likely not possible)
*/

shared throws(`class ReportableException`)
Integer runDartToplevel(
        moduleAndVersion, arguments=[], toplevel=null, web=false,
        disableCompatibilityCheck=false,
        repositoryManager=package.repositoryManager()) {

    String moduleAndVersion;
    {String*} arguments;
    "Specifies the fully qualified name of a toplevel method or class to run.
     The indicated declaration must be shared by the <module> and have no
     parameters. The format is: `qualified.package.name::classOrMethodName` with
     `::` acting as separator between the package name and the toplevel class or
     method name. (default: `<module>::run`)"
    String? toplevel;
    RepositoryManager repositoryManager;
    "Disable Ceylon version compatibility and language module availability
     checks (default is false)"
    Boolean disableCompatibilityCheck;
    "Link against the web compatible runtime. Defaults to 'false'."
    Boolean web;

    if (!disableCompatibilityCheck) {
        checkCeylonVersion();
        // Make sure the language module has been installed
        // Although, the program may actually import some other version...
        verifyLanguageModuleAvailability(repositoryManager);
    }

    value dartPath = findExecutableInPath("dart");
    if (!exists dartPath) {
        throw ReportableException("Cannot find dart executable in path.");
    }

    value moduleName
        =   ModuleUtil.moduleName(moduleAndVersion);

    value moduleVersion
        =   ModuleUtil.moduleVersion(moduleAndVersion) else null;

    if (!exists moduleVersion) {
        // TODO can we do something like checkModuleVersionsOrShowSuggestions() instead?
        throw ReportableException("Module version must be provided.");
    }

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
                arguments = {
                    "--package-root=" + packageRootPath.string,
                    programModuleSymlink,
                    if (exists rd = toplevel)
                        then "$ceylon$run=``rd``"
                        else null,
                    *arguments
                }.coalesced;
                path = dartPath.directory.path;
                input = currentInput;
                output = currentOutput;
                error = currentError;
            };

    p.waitForExit();
    return p.exitCode else 0;
}
