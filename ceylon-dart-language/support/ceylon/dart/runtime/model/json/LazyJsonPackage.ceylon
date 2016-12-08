import ceylon.dart.runtime.model {
    Package,
    Unit,
    Module,
    Declaration,
    Annotation
}
import ceylon.dart.runtime.structures {
    ListMultimap
}

shared
class LazyJsonPackage(
        [String+] name,
        Module mod,
        JsonObject json,
        Boolean isShared = jsonModelUtil.parsePackageSharedAnnotation(json),
        [Annotation*] annotations = jsonModelUtil.parsePackageAnnotations(json),
        Unit(Package)? unitLG = null)
        extends Package(name, mod, isShared, annotations, unitLG) {

    variable Boolean allLoaded = false;

    shared actual
    ListMultimap<String,Declaration> members {
        value membersAtStart = super.members;
        if (!allLoaded) {
            for (name -> memberJson in json) {
                if (!membersAtStart.contains(name)) {
                    jsonModelUtil.loadToplevelDeclaration(this, name, json);
                }
            }
            allLoaded = true;
        }
        return super.members;
    }

    shared actual
    Declaration? getDirectMember(String name) {
        // TODO During warmup, accessing super.members (and calling
        //      super.getDirectMember()) is going to be expensive, since the members
        //      multimap will be rebuilt every time a member is added. Is this ok?
        //      We may want units to register declarations with packages rather than
        //      invalidating the cache on declarations.add().

        if (!allLoaded && !super.members.contains(name)) {
            jsonModelUtil.loadToplevelDeclaration(this, name, json);
        }
        return super.getDirectMember(name);
    }
}
