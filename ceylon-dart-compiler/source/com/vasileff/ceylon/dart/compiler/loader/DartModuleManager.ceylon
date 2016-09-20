import ceylon.interop.java {
    javaString,
    JavaCollection
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
import com.vasileff.ceylon.dart.compiler {
    dartBackend,
    javaList
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

class DartModuleManager(Map<String, Module> moduleCache = emptyMap)
        extends ModuleManager() {

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
        // This method is similar same as super(), but using a different, slightly less
        // hard coded language module version, and preloading modules from moduleCache.

        // Use *our* version as the language module version!
        value languageModuleVersion = `module`.version;

        // preload modules from the cache, if any
        initialModules.listOfModules.addAll(JavaCollection(moduleCache.items));

        // start with the cache + the passed in set of modules (which should be empty???)
        setModules(initialModules);

        if (!modules.languageModule exists) {
            //build empty package
            Package emptyPackage = createPackage("", null);

            // create language module and add it as a dependency of defaultModule
            // since packages outside a module cannot declare dependencies
            Module languageModule;
            if (exists m = moduleCache["ceylon.language/``languageModuleVersion``"]) {
                // we just added it to initialModules, so just wrap up the config
                languageModule = m;
                modules.languageModule = m;
            }
            else {
                value languageName = Arrays.asList(
                        javaString("ceylon"), javaString("language"));
                languageModule = createModule(languageName, languageModuleVersion);
                languageModule.languageModule = languageModule;
                languageModule.available = false;
                modules.languageModule = languageModule;
                modules.listOfModules.add(languageModule);
            }

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
        // create a new one
        JsonModule m = JsonModule();
        m.name = moduleName;
        m.version = version;

        // Add an implicit import for the language module
        if (!m.nameAsString == Module.\iLANGUAGE_MODULE_NAME) {
            value languageModule
                =   findLoadedModule(Module.\iLANGUAGE_MODULE_NAME, null)
                    else modules.languageModule;

            value moduleImport
                =   ModuleImport(null, languageModule, false, true);

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
            if (exists p = m.getDirectPackage(packageName)) {
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
