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

shared
class DartModuleManagerFactory() satisfies ModuleManagerFactory {

    shared actual
    ModuleManager createModuleManager(Context? context)
        =>  DartModuleManager();

    shared actual
    ModuleSourceMapper createModuleManagerUtil
            (Context context, ModuleManager moduleManager)
        =>  DartModuleSourceMapper(context, moduleManager);
}
