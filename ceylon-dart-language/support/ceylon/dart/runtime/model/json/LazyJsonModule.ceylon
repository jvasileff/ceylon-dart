import ceylon.collection {
    MutableSet
}

import ceylon.dart.runtime.model {
    Module,
    Package,
    Unit,
    NothingDeclaration,
    ModuleImport
}

shared
class LazyJsonModule(
        JsonObject json,
        "Returns `false` if the toplevel was not found."
        shared Boolean runToplevel(String toplevelDeclaration),
        [String+] name = jsonModelUtil.parseModuleName(json),
        String? version = jsonModelUtil.parseModuleVersion(json),
        Unit(Package)? unitLG = null)
        extends Module(name, version, unitLG) {

    variable Boolean allLoaded = false;

    shared Boolean runApplication(String qualifiedToplevel) {
        String packageName;
        String toplevelName;
        if (exists idx = qualifiedToplevel.firstInclusion("::")) {
            packageName = qualifiedToplevel[0:idx];
            toplevelName = qualifiedToplevel[idx+2...];
        }
        else if (exists idx = qualifiedToplevel.lastOccurrence('.')) {
            packageName = qualifiedToplevel[0:idx];
            toplevelName = qualifiedToplevel[idx+1...];
        }
        else {
            packageName = "";
            toplevelName = qualifiedToplevel;
        }
        value pkg = findPackage(packageName);
        if (!exists pkg) {
            return false;
        }
        assert (is LazyJsonModule mod = pkg.mod);
        return mod.runToplevel(toplevelName);
    }

    shared actual
    MutableSet<Package> packages {
        if (!allLoaded) {
            // let findDirectPackage do all the work
            json.keys.filter((n) => !n.startsWith("$mod-")).each(findDirectPackage);
            allLoaded = true;
        }
        return super.packages;
    }

    shared actual
    Package? findDirectPackage(String qualifiedName) {
        if (exists existing
                =   super.packages.find((p) => p.qualifiedName == qualifiedName)) {
            return existing;
        }

        if (allLoaded) {
            return null;
        }

        if (exists packageJson = getObjectOrNull(json, qualifiedName)) {
            assert (nonempty nameParts = qualifiedName.split('.'.equals).sequence());
            value pkg = LazyJsonPackage(nameParts, this, packageJson);
            if (qualifiedName == "ceylon.language") {
                // manually add ceylon.language::Nothing, which shouldn't be in the
                // json object
                pkg.defaultUnit.addDeclaration {
                    NothingDeclaration(pkg.defaultUnit);
                };
            }
            super.packages.add(pkg);
            return pkg;
        }

        return null;
    }

    shared
    void initializeImports([Module*] importedModules) {
        // For now, just add them all as shared imports
        // TODO parse json for import information, add each import with correct
        //      annotations, etc., throw if 'importedModules' is missing imports.
        moduleImports.addAll {
            importedModules.map((mod)
                =>  ModuleImport(mod, true));
        };
    }
}
