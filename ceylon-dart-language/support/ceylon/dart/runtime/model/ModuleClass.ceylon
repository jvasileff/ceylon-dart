import ceylon.dart.runtime.nativecollection {
    HashSet,
    MutableSet,
    MutableList,
    ArrayList
}

import ceylon.dart.runtime.model.internal {
    assertedPackage
}

shared
class Module(name, version, unitLG = null) {

    shared
    [String+] name;

    shared
    String? version;

    Unit(Package)? unitLG;

    variable
    Unit? unitMemo = null;

    shared
    String nameAsString
        =   ".".join(name);

    shared
    String signature
        =   if (nameAsString == "default")
            then nameAsString
            else "``nameAsString``/``version else ""``";

    shared
    MutableList<ModuleImport> moduleImports
        // Due to versions and shared/non-shared, there's no good way to use a HashSet
        // here. But we could wrap the ArrayList to ensure unique module names. Or,
        // use a TreeSet.
        =   ArrayList<ModuleImport>();

    // TODO make this a private map; add shared addPackage method
    shared default
    MutableSet<Package> packages
        =   HashSet<Package>();

    shared
    Unit unit {
        if (exists u = unitMemo) {
            return u;
        }

        "A module must contain a package of the same name."
        assert (exists namesakePackage = findDirectPackage(nameAsString));

        return unitMemo
            =   if (exists unitLG)
                then unitLG(namesakePackage)
                else Unit(namesakePackage);
    }

    shared default
    Package? findDirectPackage(String qualifiedName)
        =>  packages.find((p) => p.qualifiedName == qualifiedName);

    "All modules that are visible from this module. A module is visible from this
     module if it is:

     - `this` module
     - a direct import of `this` module
     - a `shared` direct import of an import of a visible module"
    {Module+} visibleModules
        =>  let (visited = HashSet<Module> { this })
            {
                this,
                *moduleImports
                    .map(ModuleImport.mod)
                    .flatMap((m) => m.exportedDependencies(visited))
                    .follow(this)
            };

    {Module*} exportedDependencies(HashSet<Module> visited) {
        visited.add(this);
        return {
            this,
            *moduleImports
                .filter(ModuleImport.isShared)
                .map(ModuleImport.mod)
                .filter(not(visited.contains))
                .flatMap((m) => m.exportedDependencies(visited))
        };
    }

    shared
    Module? findModule(String qualifiedName)
        =>  visibleModules.find((m)
            =>  m.nameAsString == qualifiedName);

    shared
    Package? findPackage(String qualifiedName)
        =>  visibleModules.map((m)
            =>  m.findDirectPackage(qualifiedName)).coalesced.first;

    shared actual
    String string
        =>  "module ``signature``";

    shared actual
    Boolean equals(Object other)
        =>  if (!is Module other)
            then false
            else this === other
                || signature == other.signature;

    shared actual
    Integer hash
        =>  signature.hash;

    ///////////////////////////////////
    //
    // Utilities
    //
    ///////////////////////////////////

    Package getLanguageModulePackage(String qualifiedName)
        =>  assertedPackage(languageModule.findDirectPackage(qualifiedName));

    shared
    Module languageModule {
        assert (exists m = findModule("ceylon.language"));
        return m;
    }

    shared
    Package ceylonLanguagePackage
        =>  getLanguageModulePackage("ceylon.language");

    shared
    Package ceylonLanguageMetaPackage
        =>  getLanguageModulePackage("ceylon.language.meta");

    shared
    Package ceylonLanguageMetaDeclarationPackage
        =>  getLanguageModulePackage("ceylon.language.meta.declaration");

    shared
    Package ceylonLanguageMetaModelPackage
        =>  getLanguageModulePackage("ceylon.language.meta.model");

    shared
    Package ceylonLanguageSerializationPackage
        =>  getLanguageModulePackage("ceylon.language.serialization");
}
