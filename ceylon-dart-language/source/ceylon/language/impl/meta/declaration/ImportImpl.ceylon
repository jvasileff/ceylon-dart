import ceylon.dart.runtime.model {
    ModelModuleImport = ModuleImport
}
import ceylon.language {
    AnnotationType = Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Import
}

class ImportImpl(container, modelImport) satisfies Import {
    shared actual Module container;
    ModelModuleImport modelImport;

    name => modelImport.mod.nameAsString;
    version => modelImport.mod.version else "";
    shared => modelImport.isShared;
    optional => modelImport.isOptional;

    shared actual suppressWarnings("unusedDeclaration")
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType
        =>  nothing;

    string => "import of ``name``/``version`` by ``container``";

}
