import ceylon.dart.runtime.model {
    ModuleModel=Module
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.declaration {
    Module,
    Package,
    Import
}
import ceylon.language.meta.model {
    ClassOrInterface
}

shared
class ModuleImpl(ModuleModel delegate) satisfies Module {

    shared actual
    Boolean annotated<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Annotation[] annotations<Annotation>()
            given Annotation satisfies AnnotationType => nothing;

    shared actual
    Import[] dependencies
        =>  nothing;

    shared actual
    Package? findImportedPackage(String name)
        =>  if (exists p = delegate.findPackage(name))
            then PackageImpl(p)
            else null;

    shared actual
    Package? findPackage(String name)
        =>  if (exists p = delegate.findDirectPackage(name))
            then PackageImpl(p)
            else null;

    shared actual
    [Package*] members
        =>  delegate.packages.collect(PackageImpl);

    shared actual
    String name
        =>  delegate.nameAsString;

    shared actual
    String qualifiedName
        =>  delegate.nameAsString;

    shared actual
    Resource? resourceByPath(String path)
        =>  nothing;

    shared actual
    String version
        =>  delegate.version else "unknownVersion";

    shared actual
    String string
        =>  "module ``name``/``version``";

    shared actual
    {Service*} findServiceProviders<Service>(ClassOrInterface<Service> service)
        =>  [];
}
