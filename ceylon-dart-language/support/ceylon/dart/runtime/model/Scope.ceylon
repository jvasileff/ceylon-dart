import ceylon.dart.runtime.structures {
    ListMultimap
}
import ceylon.language.meta.declaration {
    ConstructorDeclaration
}

shared
interface Scope of Package | Element {

    shared formal
    String qualifiedName;

    "The 'real' scope of the element, ignoring that conditions (in an assert, if, or
     while) each have their own 'fake' scope."
    shared formal
    Scope? container;

    "The scope of the element, taking into account that conditions (in an assert, if, or
     while) each have their own 'fake' scope.

     Since `ConditionScope`s are not yet supported, [[scope]] is an alias for
     [[container]]."
    shared formal
    Scope? scope;

    shared formal
    Unit unit;

    shared default
    Package pkg => unit.pkg;

    shared default
    Module mod => pkg.mod;

    shared formal
    ListMultimap<String, Declaration> members;

    "Search for a resolvable declaration with the given [[name]].

     Shared and unshared members will be searched, but not inherited members, members of
     ancestor scopes, or imports.

     Import aliases will not be resolved.

     Note that if there are multiple declarations with the same name (as may be the case
     with native headers and implementations), the first one that is found will be
     returned."
    shared default see(`value Declaration.isResolvable`)
    Declaration? getDirectMember(String name)
        =>  members.get(name).find(Declaration.isResolvable);

    "Search for a resolvable declaration with the given [[name]].

     The following will be searched:

        - shared and unshared direct members
        - inherited members

     The following will not be searched:

        - members of ancestor scopes
        - imports

     Import aliases for members will be resolved if [[unit]] is provided.

     Note that if there are multiple declarations with the same name (as may be the case
     with native headers and implementations), the first one that is found will be
     returned."
    shared default see(`value Declaration.isResolvable`)
    Declaration? getMember(String name, Unit? unit = null)
        // Note: TypeDeclaration.getMember considers import aliases and inherited
        //       members, which are not applicable to non-TypeDeclarations.
        =>  getDirectMember(name);

    "Search for a resolvable declaration with the given [[name]].

     The following will be searched:

        - shared and unshared direct members
        - inherited members
        - members of ancestor scopes, including inherited
        - imports

     Import aliases for members will not be resolved.

     Note that if there are multiple declarations with the same name (as may be the case
     with native headers and implementations), the first one that is found will be
     returned."
    shared default see(`value Declaration.isResolvable`)
    Declaration? getBase(String name, Unit? unit = null) {
        // shared and unshared direct members
        if (exists member = getDirectMember(name)) {
            return member;
        }

        // inherited members (would be redundant for non-TypeDeclarations)
        if (this is TypeDeclaration && !this is ConstructorDeclaration,
                exists member = getMember(name, null)) {
            return member;
        }

        // shared and unshared direct members & inherited members of ancestors
        return scope?.getBase(name, unit);
    }

    "Find a declaration by name.

     The package in which to search will be determined as follows:

        - If [[packageName]] is null, use the current package.

        - If [[packageName]] is not null and [[moduleName]] is null, search for
          [[packageName]] within the current module.

        - If [[moduleName]] is not null, search for [[packageName]] within a visible
          module with the name [[moduleName]], if any.

        - *Unless* [[packageName]] is null and [[moduleName]] is not null, in which
          case null will be returned."
    shared
    Declaration? findDeclaration(
            "The name parts of the declaration to find."
            {String+} declarationName,
            "The name of the package to search, or `null` for this Scope's package."
            String? packageName = null,
            "The name of the module to search, or `null` for this Scope's module."
            String? moduleName = null) {

        // TODO declarationName won't be enough if we start relying on `qualifier` to
        //      distinguish declarations that have the same name and nearest ancestor
        //      declaration.

        if (!packageName exists && moduleName exists) {
            return null;
        }

        "The package to search."
        value pkg
            =   if (exists packageName)
                then (if (exists moduleName)
                      then mod.findModule(moduleName)
                      else mod)
                     ?.findDirectPackage(packageName)
                else this.pkg;

        if (!exists pkg) {
            return null;
        }

        return declarationName.rest.fold
            (pkg.getDirectMember(declarationName.first)) // start with declarationName[0]
            ((d, name) => d?.getDirectMember(name));     // resolve subsequent parts
    }

    shared actual formal
    String string;
}
