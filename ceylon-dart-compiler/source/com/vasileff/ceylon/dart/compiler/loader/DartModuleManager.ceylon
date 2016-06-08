import ceylon.interop.java {
    javaString
}

import com.redhat.ceylon.common {
    Backends
}
import com.redhat.ceylon.model.typechecker.model {
    Modules,
    Package,
    Module,
    ModuleImport
}
import com.redhat.ceylon.model.typechecker.util {
    ModuleManager
}

import java.lang {
    JString=String,
    Iterable
}
import java.util {
    Collections,
    Arrays,
    JList=List
}

import com.vasileff.ceylon.dart.compiler {
    dartBackend,
    javaList
}

class DartModuleManager() extends ModuleManager() {

    shared actual
    Iterable<JString> searchedArtifactExtensions
        // This is crazy. We should be using ArtifactContext.\iDART_MODEL, but
        // ModuleValidator processes the elements with `getArtifactSuffixes()`, which
        // prepends a '.'. So we can't search for our model file; its prefix doesn't
        // begin with a dot. Further hackery for this in
        // DartModuleSourceMapper.resolveModule().
        =   javaList { javaString("dart") };

    shared actual
    void initCoreModules(variable Modules initialModules) {
        // This method is the same as super(), but using a different, slighly less
        // hard coded language module version.

        // Use *our* version as the language module version!
        value languageModuleVersion = `module`.version;

        setModules(initialModules);

        if (!modules.languageModule exists) {
            //build empty package
            Package emptyPackage = createPackage("", null);

            // create language module and add it as a dependency of defaultModule
            // since packages outside a module cannot declare dependencies
            value languageName = Arrays.asList(
                    javaString("ceylon"), javaString("language"));
            value languageModule = createModule(languageName, languageModuleVersion);
            languageModule.languageModule = languageModule;
            languageModule.available = false;
            modules.languageModule = languageModule;
            modules.listOfModules.add(languageModule);

            // build default module (module in which packages belong to when not
            // explicitly under a module)
            value defaultModuleName = Collections.singletonList(
                    javaString(Module.\iDEFAULT_MODULE_NAME));
            value defaultModule = createModule(defaultModuleName, "unversioned");
            defaultModule.available = true;
            bindPackageToModule(emptyPackage, defaultModule);
            modules.defaultModule = defaultModule;
            modules.listOfModules.add(defaultModule);
        }
    }

    shared actual
    JsonModule createModule(JList<JString> moduleName, String version) {
        JsonModule m = JsonModule();
        m.name = moduleName;
        m.version = version;

        // Add an implicit import for the language module
        if (!m.nameAsString == Module.\iLANGUAGE_MODULE_NAME) {
            value languageModule
                =   findLoadedModule(Module.\iLANGUAGE_MODULE_NAME, null)
                    else modules.languageModule;

            value moduleImport
                =   ModuleImport(null, languageModule, false, false);

            m.addImport(moduleImport);
            m.languageModule = languageModule;
        }

        // Mark native dart:* sdk modules available now to keep aether from trying to
        // find a pom (somehow aether jumps in the module name has a ':').
        if (moduleName.size() == 1 && moduleName.get(0).string.startsWith("dart:")) {
            m.available = true;
        }

        return m;
    }

    shared actual
    JsonPackage createPackage(String packageName, Module? m) {
        if (exists m) {
            if (exists p = m.getPackage(packageName)) {
                "The package should be a JsonPackage, right?"
                assert (is JsonPackage p);
                return p;
            }
        }

        value p = JsonPackage(packageName);

        if (exists m) {
            m.packages.add(p);
            p.\imodule = m;
        }

        return p;
    }

    shared actual
    Backends supportedBackends
        =>  dartBackend.asSet();
}
