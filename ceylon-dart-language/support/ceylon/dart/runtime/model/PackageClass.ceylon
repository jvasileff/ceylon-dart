import ceylon.dart.runtime.nativecollection {
    HashSet,
    MutableSet
}

import ceylon.dart.runtime.structures {
    LinkedListMultimap,
    ListMultimap
}

shared
class Package(name, mod, isShared = false, annotations = [], Unit(Package)? unitLG = null)
        satisfies Scope & Annotated {

    shared
    [String+] name;

    shared actual
    Module mod;

    shared
    Boolean isShared;

    shared actual
    [Annotation*] annotations;

    "A cached map of all members. A [[ListMultimap]] is used since [[Declaration]]s may
     not be unique, to support headers and multiple `native` declarations."
    variable
    LinkedListMultimap<String, Declaration>? memberMap = null;

    variable
    Unit? unitMemo = null;

    variable
    Unit? defaultUnitMemo = null;

    shared actual
    String qualifiedName = ".".join(name);

    shared actual
    Null container => null;

    shared actual
    Null scope => null;

    "An internal function that should not be called outside this package. This function
     marks the member cache dirty if the passed in value is `true`, and returns the
     passed in value. "
    shared
    Boolean markMemberCacheDirty(Boolean dirty = true) {
        if (dirty) {
            memberMap = null;
        }
        return dirty;
    }

    shared
    object units satisfies MutableSet<Unit> {
        value delegate = HashSet<Unit>();

        shared actual
        Boolean add(Unit element) {
            value result = delegate.add(element);
            markMemberCacheDirty();
            return result;
        }

        shared actual
        void clear() {
            delegate.clear();
            markMemberCacheDirty();
        }

        shared actual
        Boolean remove(Unit element)
            =>  markMemberCacheDirty(delegate.remove(element));

        shared actual HashSet<Unit> clone() => delegate.clone();
        shared actual Iterator<Unit> iterator() => delegate.iterator();
        shared actual Integer hash => delegate.hash;
        shared actual Boolean equals(Object that) => delegate.equals(that);
    }

    shared
    Unit defaultUnit {
        if (exists u = defaultUnitMemo) {
            return u;
        }
        value u = defaultUnitMemo = Unit(this);
        units.add(u);
        return u;
    }

    shared actual
    Unit unit {
        if (exists u = unitMemo) {
            return u;
        }
        value u = unitMemo
            =   if (exists unitLG)
                then unitLG(this)
                else defaultUnit;
        units.add(u);
        return u;
    }

    shared actual default
    ListMultimap<String, Declaration> members
        =>  memberMap else (memberMap
            =   LinkedListMultimap {
                    for (unit in units)
                      for (declaration in unit.declarations)
                        declaration.name -> declaration
                });

    shared actual
    Declaration? getBase(String name, Unit? unit) {
        // this implements the rule that imports hide toplevel members of a package
        if (exists unit, exists declaration = unit.getImportedDeclaration(name)) {
            return declaration;
        }

        if (exists declaration = getDirectMember(name)) {
            return declaration;
        }

        // finally, try the implicitly imported language module
        return this.unit.ceylonLanguagePackage.getDirectMember(name);
    }

    shared actual
    String string
        =>  "package ``qualifiedName``";

    shared actual
    Boolean equals(Object that)
        // FIXME also check module == ?
        =>  if (!is Package that)
            then false
            else this === that
                || qualifiedName == that.qualifiedName;

    shared actual
    Integer hash
        =>  qualifiedName.hash;
}
