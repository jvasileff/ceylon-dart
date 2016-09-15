import com.redhat.ceylon.model.typechecker.util {
    ModuleManager
}
import com.redhat.ceylon.compiler.typechecker.context {
    Context
}
import com.redhat.ceylon.compiler.typechecker.util {
    ModuleManagerFactory
}
import com.redhat.ceylon.compiler.typechecker.analyzer {
    ModuleSourceMapper
}
import com.redhat.ceylon.model.typechecker.model {
    Module
}

shared
class DartModuleManagerFactory(
        "The immutable module cache to be used for all `ModuleSourceMapper`s created
         by this factory.

            - The cached *must not* contain entries for modules to be compile.
            - If there is an entry for the default module, it will be ignored.

         Keys are of the form `module.name/version`."
        Map<String, Module> moduleCache = emptyMap)
        satisfies ModuleManagerFactory {

    shared actual
    ModuleManager createModuleManager(Context? context)
        =>  DartModuleManager(moduleCache);

    shared actual
    ModuleSourceMapper createModuleManagerUtil
            (Context context, ModuleManager moduleManager)
        =>  DartModuleSourceMapper(context, moduleManager);
}
