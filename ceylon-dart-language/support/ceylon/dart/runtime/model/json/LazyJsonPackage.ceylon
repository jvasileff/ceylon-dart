import ceylon.dart.runtime.model {
    Package,
    Unit,
    Module,
    Declaration
}
import ceylon.dart.runtime.structures {
    ListMultimap
}

shared
class LazyJsonPackage(name, mod, json, Unit(Package)? unitLG = null)
        extends Package(name, mod, unitLG) {

    [String+] name;
    Module mod;
    JsonObject json;

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
