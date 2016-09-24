import ceylon.dart.runtime.nativecollection {
    MutableSet,
    HashSet
}
import ceylon.dart.runtime.model.internal {
    eq
}

shared abstract
class TypeDeclaration()
        of ClassOrInterface | Constructor | IntersectionType | NothingDeclaration
            | TypeAlias | TypeParameter | UnionType | UnknownType
        extends Declaration()
        satisfies Generic {

    "The class or constructor extended by a class, the
     type aliased by a class or interface alias, or the
     class Anything for any other type."
    shared formal Type? extendedType;

    shared formal [Type*] satisfiedTypes;
    shared formal [Type*] caseTypes;
    shared formal [Value*] caseValues;
    shared formal Boolean isSealed;
    shared formal Boolean isFinal;
    shared formal Boolean inherits(ClassOrInterface | TypeParameter that);

    shared default
    Boolean isSelfType => false;

    shared default
    Boolean isAlias => false;

    shared actual default
    {TypeParameter*} typeParameters
        =>  { for (member in members.items)
                if (is TypeParameter member)
                  member };

     "The type of the declaration as seen from within the body of the declaration itself.

      Note that for certain special types which we happen to know don't have type
      arguments, we use this as a convenience method to quickly get a produced type for
      use outside the body of the declaration, but this is not really correct!"
    shared default
    Type type {
        // avoid => to workaround https://github.com/ceylon/ceylon/issues/6221
        return createType {
            declaration = this;
            qualifyingType = memberContainerType;
            typeArguments = typeParametersAsArguments;
        };
    }

    shared
    Type appliedType(
            Type? qualifyingType,
            {Type?*} typeArguments,
            Map<TypeParameter, Variance> varianceOverrides = emptyMap)
        =>  createType {
                declaration = this;
                qualifyingType = qualifyingType;
                typeArguments = aggregateTypeArguments {
                    qualifyingType;
                    this;
                    typeArguments;
                };
                varianceOverrides = varianceOverrides;
            };

    shared
    {ClassOrInterface*} supertypeDeclarations
        =>  collectSupertypeDeclarations {
                HashSet<ClassOrInterface> { unit.anythingDeclaration };
            };

    MutableSet<ClassOrInterface> collectSupertypeDeclarations
            (results = HashSet<ClassOrInterface>()) {

        MutableSet<ClassOrInterface> results;
        switch (self = this)
        case (is ClassDefinition | InterfaceDefinition) {
            if (!results.contains(self)) {
                results.add(self);
                extendedType?.declaration?.collectSupertypeDeclarations(results);
                satisfiedTypes.map(Type.declaration).each((d)
                    =>  d.collectSupertypeDeclarations(results));
            }
        }
        case (is TypeParameter | IntersectionType) {
            satisfiedTypes.map(Type.declaration).each((d)
                =>  d.collectSupertypeDeclarations(results));
        }
        case (is UnionType) {
            // Copied note: actually the loop is unnecessary, we only need to consider
            // the first case
            if (exists first = caseTypes.first) {
                value candidates
                    =   first.declaration.collectSupertypeDeclarations(results);
                results.addAll(candidates.filter(not(results.contains)).filter(inherits));
            }
        }
        case (is Constructor | ClassAlias | InterfaceAlias | TypeAlias) {
            extendedType?.declaration?.collectSupertypeDeclarations(results);
        }
        case (is NothingDeclaration) {
            throw AssertionError("supertypeDeclarations not supported for Nothing type");
        }
        case (is UnknownType) {
            // ignore
        }
        return results;
    }

    shared actual default
    Declaration? getMember(String name, Unit? unit) {
        // TODO resolve import aliases for members of supertypes
        //      (ceylon-model doesn't do this yet either)

        // Search unit for import aliases
        if (exists member = unit?.getImportedMember(this, name)) {
            return member;
        }

        // Search shared and unshared direct members
        value directMember = getDirectMember(name);
        if (exists directMember, directMember.isShared) {
            // It's shared, so we can return it (don't return unshared members yet, to
            // avoid masking inherited shared members.)
            return directMember;
        }

        if (exists supertypeMember = getSupertypeDeclaration(name)) {
            return supertypeMember;
        }

        // Return the non-shared member, if found, to allow the caller to provide a good
        // error message.
        return directMember;
    }

    Declaration? getSupertypeDeclaration(String name) {
        object exactCriteria satisfies Criteria {
            shared actual
            Boolean memberLookup => true;

            shared actual
            Boolean satisfiesType(ClassOrInterface | TypeParameter type) {
                // do not detect members of this scope
                if (type == outer) {
                    return false;
                }

                value member = type.getDirectMember(name);
                if (exists member, member.isShared) {
                    return true;
                }

                return false;
            }
        }

        value superType = type.getSupertype(exactCriteria);

        if (!exists superType) {
            // not found
            return null;
        }
        else if (superType.isUnknown) {
            // we're dealing with an ambiguous member of an intersection type
            // todo: this is pretty fragile - it depends upon the fact that
            //       getSupertype() just happens to return an UnknownType instead of
            //       null in this case
            return null;
        }
        else {
            // we got exactly one uniquely-defined member
            assert (exists result = superType.declaration.getDirectMember(name));
            return result;
        }
    }

    shared
    {Type*} extendedAndSatisfiedTypes
        =>  if (exists et = extendedType)
            then satisfiedTypes.follow(et)
            else satisfiedTypes;

    shared default
    {TypeDeclaration*} extendedAndSatisfiedDeclarations
        =>  extendedAndSatisfiedTypes.map(Type.declaration);

    shared default
    Type? selfType
        =>  if (hasSelfType)
            then caseTypes.first
            else null;

    shared
    Boolean hasSelfType
        =>  caseTypes.first?.isTypeParameter else false;

    "Is this a class, interface, or type parameter with enumerated types or enumerated
     type constraints?"
    shared
    Boolean hasEnumeratedTypes
        =>  this is ClassOrInterface | TypeParameter
            && !hasSelfType
            && !caseTypes.empty;

    "If [[hasEnumeratedTypes]], then [[caseTypes]]. Otherwise, `[]`."
    shared
    [Type*] enumeratedTypes
        =>  if (hasEnumeratedTypes)
            then caseTypes
            else [];

    ///////////////////////////////////
    //
    // Utilities
    //
    ///////////////////////////////////

    shared
    Boolean isAnything
        =>  eq(qualifiedName, "ceylon.language::Anything");

    shared
    Boolean isEntry
        =>  eq(qualifiedName, "ceylon.language::Entry");

    shared
    Boolean isNothing
        =>  eq(qualifiedName, "ceylon.language::Nothing");

    shared
    Boolean isNull
        =>  eq(qualifiedName, "ceylon.language::Null");

    shared
    Boolean isNullValue
        =>  eq(qualifiedName, "ceylon.language::null");

    shared
    Boolean isObject
        =>  eq(qualifiedName, "ceylon.language::Object");

    // TODO Look at model's isTupleType and isTuple, and all refinements.
    //      Make sure we're using the right methods everywhere.
    shared
    Boolean isTuple
        =>  eq(qualifiedName, "ceylon.language::Tuple");
}
