import ceylon.interop.java {
    javaString
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
    JString=String
}
import java.util {
    Collections,
    Arrays,
    JList=List
}

class DartModuleManager() extends ModuleManager() {

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

            // build default module (module in which packages belong to when not
            // explicitly under a module)
            JList<JString> defaultModuleName =
                    Collections.singletonList(javaString(Module.\iDEFAULT_MODULE_NAME));
            Module defaultModule = createModule(defaultModuleName, "unversioned");
            defaultModule.default = true;
            defaultModule.available = true;
            bindPackageToModule(emptyPackage, defaultModule);
            modules.listOfModules.add(defaultModule);
            modules.defaultModule = defaultModule;

            // create language module and add it as a dependency of defaultModule
            // since packages outside a module cannot declare dependencies
            JList<JString> languageName =
                    Arrays.asList(javaString("ceylon"), javaString("language"));
            variable Module languageModule =
                    createModule(languageName, languageModuleVersion);
            languageModule.languageModule = languageModule;
            languageModule.available = false;
            modules.languageModule = languageModule;
            modules.listOfModules.add(languageModule);
            defaultModule.addImport(ModuleImport(languageModule, false, false));
            defaultModule.languageModule = languageModule;
        }
    }
}
