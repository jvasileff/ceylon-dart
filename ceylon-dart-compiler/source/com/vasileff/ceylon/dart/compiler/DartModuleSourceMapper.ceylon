import com.redhat.ceylon.compiler.typechecker.analyzer {
    ModuleSourceMapper
}
import com.redhat.ceylon.compiler.typechecker.context {
    Context
}
import com.redhat.ceylon.model.typechecker.util {
    ModuleManager
}

shared
class DartModuleSourceMapper(Context context, ModuleManager moduleManager)
        extends ModuleSourceMapper(context, moduleManager) {}
