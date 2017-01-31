import ceylon.dart.runtime.nativecollection {
    MutableMap,
    HashMap
}

import ceylon.dart.runtime.model {
    Module,
    Type
}
import ceylon.dart.runtime.model.parser {
    parseType
}

// TODO elminiate this global. One option would be to have TypeDescriptor's first param
//      be [module, moduleTypeCache], which would be a toplevel in the module.
MutableMap<[Module, String, [TypeDescriptor*]], Type> typeCache
    =   HashMap<[Module, String, [TypeDescriptor*]], Type>();

shared
class TypeDescriptor(mod, typeString, arguments = []) {
    Module mod;
    String typeString;
    [TypeDescriptor*] arguments;

    variable Type? typeMemo = null;
    variable Integer? hashMemo = null;

    shared Type type {
        // TODO if all arguments are for the same module as mod, substitution by string
        //      manipulation is possible, which could lead to a cache hit

        if (exists t = typeMemo) {
            return t;
        }
        if (exists t = typeCache[[mod, typeString, arguments]]) {
            return typeMemo = t;
        }

        // TODO consider deeply traversing arguments, loading types depth first
        //      to avoid deep call stacks in parseType? Same issue with hash though...
        value t = typeMemo = parseType(typeString, mod.unit.pkg, arguments*.type);
        typeCache.put([mod, typeString, arguments], t);
        return t;
    }

    shared actual
    String string
        =>  [mod, typeString, arguments].string;

    shared actual
    Integer hash {
        if (exists h = hashMemo) {
            return h;
        }
        variable value hash = 1;
        hash = 31 * hash + mod.hash;
        hash = 31 * hash + typeString.hash;
        hash = 31 * hash + arguments.hash;
        return hashMemo = hash;
    }

    shared actual
    Boolean equals(Object that)
        =>  if (is TypeDescriptor that)
            then mod == that.mod &&
                 typeString == that.typeString &&
                 arguments == that.arguments
            else false;
}
