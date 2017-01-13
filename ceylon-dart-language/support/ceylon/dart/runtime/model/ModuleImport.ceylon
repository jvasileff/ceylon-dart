shared
class ModuleImport(mod, isShared, annotations = []) satisfies Annotated {
    shared Module mod;
    shared Boolean isShared;
    shared actual [Annotation*] annotations;
}
