shared
class ModuleImport(mod, isShared, isOptional = false, annotations = [])
        satisfies Annotated {
    shared Module mod;
    shared Boolean isShared;
    shared Boolean isOptional;
    shared actual [Annotation*] annotations;
}
