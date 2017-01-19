import ceylon.dart.runtime.nativecollection {
    HashSet,
    ArrayList,
    HashMap
}

import ceylon.dart.runtime.model.internal {
    eq
}

shared abstract sealed
class Type() extends Reference() {

    variable Type? resolvedMemo = null;

    shared actual formal TypeDeclaration declaration;
    shared formal Map<TypeParameter, Variance> varianceOverrides;
    shared formal Boolean isTypeConstructor;

    shared formal TypeParameter? typeConstructorParameter;

    shared Boolean isAnything => declaration.isAnything;
    shared Boolean isEmpty => declaration.isEmpty;
    shared Boolean isEntry => declaration.isEntry;
    shared Boolean isIterable => declaration.isIterable;
    shared Boolean isNothing => declaration.isNothing;
    shared Boolean isNull => declaration.isNull;
    shared Boolean isObject => declaration.isObject;
    shared Boolean isSequence => declaration.isSequence;
    shared Boolean isSequential => declaration.isSequential;
    shared Boolean isTuple => declaration.isTuple;
    shared Boolean isUnknown => declaration is UnknownType;
    shared Boolean isClassOrInterface => declaration is ClassOrInterface;
    shared Boolean isClass => declaration is Class;
    shared Boolean isInterface => declaration is Interface;
    shared Boolean isUnion => declaration is UnionType;
    shared Boolean isIntersection => declaration is IntersectionType;
    shared Boolean isTypeParameter => declaration is TypeParameter;
    shared Boolean isTypeAlias => declaration is TypeAlias;

    shared Unit unit => declaration.unit;

    "Are all type arguments available?"
    shared Boolean isWellDefined {
        if (exists qt = qualifyingType, !qt.isWellDefined) {
            // what if the qualifyingType *should* exist, but is missing?
            return false;
        }

        for (typeParameter in declaration.typeParameters) {
            value typeArgument = typeArguments[typeParameter];
            if (exists typeArgument) {
                return typeArgument.isWellDefined;
            }
            return typeParameter.isDefaulted;
        }

        return true;
    }

    shared
    Boolean isExactlyNothing
        =>  isNothing || isEmptySequenceType || isEmptyTupleType;

    shared
    Boolean isEmptySequenceType {
        if (this.declaration.inherits(unit.sequenceDeclaration)) {
            value et = unit.getSequentialElementType(this);
            return et?.isExactlyNothing else false;
        }
        return false;
    }

    shared
    Boolean isEmptyTupleType
        =>  this.declaration.isTuple
            && typeArgumentList.coalesced.any(Type.isExactlyNothing);

    shared
    {Type*} caseTypes
        =>  if (typeArguments.empty)
            then declaration.caseTypes
            else declaration.caseTypes.map((ct) => ct.substituteFromType(this));

    shared
    {Type*} satisfiedTypes
        =>  if (typeArguments.empty)
            then declaration.satisfiedTypes
            else declaration.satisfiedTypes.map((ct)
                =>  ct.substituteFromType(this));

    {Type*} internalSatisfiedTypes
        =>  if (typeArguments.empty)
            then declaration.satisfiedTypes
            else declaration.satisfiedTypes.map((ct)
                =>  ct.substituteFromType { this; dedup = false; });

    shared
    {Type*} extendedAndSatisfiedTypes
        =>  if (exists et = extendedType)
            then satisfiedTypes.follow(et)
            else satisfiedTypes;

    shared
    {Type*} internalExtendedAndSatisfiedTypes
        =>  if (exists et = internalExtendedType)
            then internalSatisfiedTypes.follow(et)
            else internalSatisfiedTypes;

    shared
    {Type*} typeArgumentList
        =>  let (arguments = typeArguments) // typeArguments not yet memoized!
            declaration.typeParameters.map((tp)
                =>  arguments.get(tp) else unit.unknownType);

    shared
    {<TypeParameter -> Type>*} typeArgumentListEntries
        =>  zipEntries(declaration.typeParameters, typeArgumentList);

    shared
    Variance variance(TypeParameter typeParameter)
        =>  varianceOverrides[typeParameter] else typeParameter.variance;

    shared
    Boolean isCovariant(TypeParameter typeParameter)
        =>  variance(typeParameter) == covariant;

    shared
    Boolean isContravariant(TypeParameter typeParameter)
        =>  variance(typeParameter) == contravariant;

    shared Type resolvedAliases {
        function compute() {
            value declaration = this.declaration;
            if (declaration is ClassOrInterface
                    && !qualifyingType exists
                    && !declaration is Alias
                    && declaration.typeParameters.empty) {
                return this;
            }

            if (isTypeConstructor) {
                return this;
            }

            if (is UnionType declaration) {
                // verbose ref to Type.resolvedAliases due to ceylon/ceylon#6565
                return unionDeduped(caseTypes.map((t) => t.resolvedAliases), unit);
            }

            if (is IntersectionType declaration) {
                return intersectionDedupedCanonical(
                    satisfiedTypes.map((t) => t.resolvedAliases), unit);
            }

            value aliasedQualifyingType
                =   qualifyingType?.resolvedAliases;

            value aliasedTypeArguments
                =   typeArgumentList.collect((t) => t.resolvedAliases);

            if (is Alias declaration) {
                "extendedType is not optional for [[Alias]]es"
                assert (exists et = declaration.extendedType);
                return et.resolvedAliases.substitute {
                    aggregateTypeArguments {
                        receivingType = aliasedQualifyingType;
                        declaration = declaration;
                        typeArguments = aliasedTypeArguments;
                    };
                    varianceOverrides;
                };
            }

            return declaration.appliedType {
                aliasedQualifyingType;
                aliasedTypeArguments;
                varianceOverrides;
            };
        }

        if (exists existing = resolvedMemo) {
            return existing;
        }
        value result = compute();
        return resolvedMemo = result.resolvedMemo = result;
    }

    shared
    Boolean isExactly(Type that) {
        // FIXME resolve aliases for this and that
        if (isUnknown || that.isUnknown) {
            return this === that;
        }
        else if (isAnything) {
            return that.isAnything;
        }
        else if (isExactlyNothing) {
            return that.isExactlyNothing;
        }
        else if (isUnion) {
            value thisCases = this.caseTypes.sequence();
            if (that.isUnion) {
                value thatCases = that.caseTypes.sequence();
                if (thisCases.size != thatCases.size) {
                    return false;
                }
                else {
                    for (caseType in thisCases) {
                        if (thatCases.every(not(caseType.isExactly))) {
                            return false;
                        }
                    }
                    return true;
                }
            }
            else if (nonempty thisCases, thisCases.size == 1) {
                return thisCases.first.isExactly(that);
            }
            return false;
        }
        else if (isIntersection) {
            value thisTypes = satisfiedTypes.sequence();
            if (that.isIntersection) {
                value thatTypes = that.satisfiedTypes.sequence();
                if (thisTypes.size != thatTypes.size) {
                    return false;
                }
                else {
                    for (thisType in thisTypes) {
                        // TODO Review below

                        variable value found = false;
                        value thisTypeDeclaration = thisType.declaration;
                        for (thatType in thatTypes) {
                            value thatTypeDeclaration = thatType.declaration;
                            if (thisTypeDeclaration == thatTypeDeclaration) {
                                if (thisType.isExactly(thatType)) {
                                    found = true;
                                    break;
                                }
                                // given a covariant type Co, and interfaces
                                // A satisfies Co<B&Co<A>> and
                                // B satisfies Co<A&Co<B>>, then
                                // A&Co<B> is equivalent A&Co<B&Co<A>> as a
                                // consequence of principal instantiation
                                // inheritance
                                if (is ClassOrInterface | TypeParameter
                                        thisTypeDeclaration,
                                    is ClassOrInterface | TypeParameter
                                        thatTypeDeclaration) {

                                    assert (exists thisSupertype
                                        =   getSupertype(thisTypeDeclaration));
                                    assert (exists thatSupertype
                                        =   that.getSupertype(thatTypeDeclaration));
                                    if (thisSupertype.isExactly(thatSupertype)) {
                                        found = true;
                                        break;
                                    }
                                }
                            }
                        }
                        if (!found) {
                            return false;
                        }
                    }
                    return true;
                }
            }
            else if (nonempty thisTypes, thisTypes.size == 1) {
                return thisTypes.first.isExactly(that);
            }
            return false;
        }
        else if (that.isUnion) {
            value thatCases = that.caseTypes.sequence();
            if (nonempty thatCases, thatCases.size == 1) {
                return isExactly(thatCases.first);
            }
            return false;
        }
        else if (that.isIntersection) {
            value thatSatisfiedTypes = that.satisfiedTypes.sequence();
            if (nonempty thatSatisfiedTypes, thatSatisfiedTypes.size == 1) {
                return isExactly(thatSatisfiedTypes.first);
            }
            return false;
        }
        else if (isObject) {
            return that.isObject;
        }
        else if (that.isObject) {
            return false;
        }
        else if (isNull) {
            return that.isNull;
        }
        else if (that.isNull) {
            return false;
        }
        else if (isClass != that.isClass
                || isInterface != that.isInterface
                || isTypeParameter != that.isTypeParameter) {
            return false;
        }
        else if (isTypeConstructor && that.isTypeConstructor) {
            //return isExactlyTypeConstructor(that);
            return nothing;
        }
        else if (isTypeConstructor || that.isTypeConstructor) {
            return false;
        }
        else {
            if (!declaration.equals(that.declaration)) {
                return false;
            }
            if (isTuple) {
                return isExactlyTuple(that);
            }

            value thisQualifyingType = this.qualifyingType;
            value thatQualifyingType = that.qualifyingType;
            if (exists thisQualifyingType, exists thatQualifyingType) {
                if (thisQualifyingType.isUnknown || thisQualifyingType.isUnknown) {
                    return false;
                }

                value thisContainer = declaration.container;
                value thatContainer = that.declaration.container;

                if (is ClassOrInterface thisContainer,
                    is ClassOrInterface thatContainer) {

                    assert (exists thisQualifyingST
                        =   thisQualifyingType.getSupertype(thisContainer));

                    assert (exists thatQualifyingST
                        =   thatQualifyingType.getSupertype(thatContainer));

                    if (!thisQualifyingST.isExactly(thatQualifyingST)) {
                        return false;
                    }
                }
                else {
                    // one of the two must be a local type, they should both be
                    if (thisContainer is TypeDeclaration
                        || thatContainer is TypeDeclaration) {
                        return false;
                    }
                    // must be the same container
                    if (!thisContainer == thatContainer) {
                        return false;
                    }
                    // delegate
                    if (!thisQualifyingType.isExactly(thatQualifyingType)) {
                        return false;
                    }
                }
            }
            else if (qualifyingType exists || that.qualifyingType exists) {
                // only one has a qualifying type
                return false;
            }

            return isTypeArgumentListExactly(that);
        }
    }

    shared
    Boolean isExactlyTuple(Type that)
        =>  nothing;

    shared
    Boolean isTypeArgumentListExactly(Type that) {
        for (typeParameter in declaration.typeParameters) {
            value thisArgument = typeArguments[typeParameter];
            value thatArgument = that.typeArguments[typeParameter];

            if (!exists thisArgument) {
                return false;
            }

            if (!exists thatArgument) {
                return false;
            }

            value thisVariance = variance(typeParameter);
            value thatVariance = that.variance(typeParameter);

            if (thisVariance.isContravariant && thatVariance.isCovariant) {
                //Inv<in Nothing> == Inv<out Anything>
                if (!thisArgument.isNothing
                        || !intersectionOfSupertypes(typeParameter, unit)
                                .isSubtypeOf(thatArgument)) {
                    return false;
                }
            }
            else if (thisVariance.isCovariant && thatVariance.isContravariant) {
                //Inv<out Anything> == Inv<in Nothing>
                if (!thatArgument.isNothing
                        || !intersectionOfSupertypes(typeParameter, unit)
                            .isSubtypeOf(thisArgument)) {
                    return false;
                }
            }
            else if (thisVariance.isContravariant && thatVariance.isInvariant) {
                //Inv<in Anything> == Inv<Anything>
                if (!thisArgument.isAnything
                        || !thatArgument.isAnything) {
                    return false;
                }
            }
            else if (thisVariance.isCovariant && thatVariance.isInvariant
                    || thisVariance.isInvariant && thatVariance.isContravariant) {
                //Inv<out nothing> == Inv<Nothing>
                if (!thisArgument.isNothing
                        ||  !thatArgument.isNothing) {
                    return false;
                }
            }
            else {
                // same variance
                if (!thisArgument.isExactly(thatArgument)) {
                    return false;
                }
            }
        }
        return true;
    }

    shared
    Boolean isSupertypeOf(Type that)
        =>  that.isSubtypeOf(this);

    shared
    Boolean isSubtypeOf(Type that) {
        // FIXME use that.resolveAliases
        if (that.isAnything) {
            return true;
        }
        else if (isExactlyNothing) {
            return true;
        }
        else if (isUnknown || that.isUnknown) {
            return this === that;
        }
        else if (isAnything) {
            return false;
        }
        else if (that.isExactlyNothing) {
            return isExactlyNothing;
        }
        else if (isUnion) {
            return caseTypes.every((ct) => ct.isSubtypeOf(that));
        }
        else if (that.isUnion) {
            return that.caseTypes.any((ct) => isSubtypeOf(ct));
        }
        else if (isIntersection) {
            if (is ClassOrInterface | TypeParameter thatDeclaration
                    =   that.declaration) {
                if (exists superType = getSupertype(thatDeclaration),
                        superType.isSubtypeOf(that)) {
                    return true;
                }
            }
            return satisfiedTypes.any((st) => st.isSubtypeOf(that));
        }
        else if (that.isIntersection) {
            return that.satisfiedTypes.every(isSubtypeOf);
        }
        else if (isTypeConstructor && that.isTypeConstructor) {
            return  nothing; // isSubtypeOfTypeConstructor(that);
        }
        else if (isTypeConstructor) {
            return that.isAnything || that.isObject;
        }
        else if (that.isTypeConstructor) {
            return false;
        }
        else if (isObject) {
            return that.isObject;
        }
        else if (isNull) {
            return that.isNull;
        }
        else if (isInterface && that.isClass) {
            return that.isObject;
        }
        else if (isTuple && that.isTuple) {
            return isSubtypeOfTuple(that);
        }
        else {
            value thatDeclaration = that.declaration;
            assert (!is IntersectionType | UnionType | NothingDeclaration | UnknownType
                | Constructor | TypeAlias thatDeclaration);

            value supertype = getSupertype(thatDeclaration)?.resolvedAliases;
            if (!exists supertype) {
                return false;
            }

            value supertypeQT = supertype.qualifyingType;
            value thatQT = that.qualifyingType;

            if (exists supertypeQT, exists thatQT) {
                if (supertypeQT.isUnknown || thatQT.isUnknown) {
                    return false;
                }

                value thatContainer = that.declaration.container;

                if (!is ClassOrInterface thatContainer) {
                    // not a "member"

                    // TODO when does this happen? A qualifying type exists, yet the
                    //      container is not a class or interface?

                    // See Ceylon commit 8ae0b902643172cb3c85d4e105fb431e2b6763d6

                    // Must be https://github.com/ceylon/ceylon/issues/4429
                    // A fake interface at runtime to hold captured type arguments

                    // Copied note:
                    // local types with a qualifying typed
                    // declaration do not need to obtain the
                    // qualifying type's supertype
                    if (!supertypeQT.isSubtypeOf(thatQT)) {
                        return false;
                    }
                }
                else {
                    // note that the qualifying type of the
                    // given type may be an invariant subtype
                    // of the type that declares the member
                    // type, as long as it doesn't refine the
                    // member type
                    value thatQTSupertype
                        =   thatQT.getSupertype(thatContainer)?.resolvedAliases;

                    if (!exists thatQTSupertype) {
                        return false;
                    }
                    if (!supertypeQT.isSubtypeOf(thatQTSupertype)) {
                        return false;
                    }
                }
            }
            else if (supertypeQT exists || thatQT exists) {
                // Case only useful for incomplete model? assert(false) instead?
                return false;
            }

            return isTypeArgumentListAssignable(supertype, that);
        }
    }

    shared actual Boolean equals(Object that) {
        if (!is Type that) {
            return false;
        }
        if (this === that) {
            return true;
        }
        if (!eq(this.qualifyingType, that.qualifyingType)) {
            return false;
        }
        if (!this.declaration.equals(that.declaration)) {
            return false;
        }
        // The original code considers two null type arguments to be equal,
        // but at least for now, we don't have null type arguments.
        if (typeArguments != that.typeArguments) {
            return false;
        }
        // Precondition that you are not allowed to override a non-invariant
        // parameter!
        return varianceOverrides == that.varianceOverrides;
    }

    shared Boolean isSubtypeOfTuple(Type that) => nothing;

    shared
    Type? getSupertype(Criteria | ClassOrInterface | TypeParameter criteria) {
        "Search for the most-specialized supertype satisfying the given predicate."
        Type? getSupertypeForCriteria(Criteria criteria) {
            if (is ClassOrInterface | TypeParameter d = declaration,
                    criteria.satisfiesType(d)) {
                return qualifiedByDeclaringType;
            }
            // The ceylon-model note reads...:
            // now let's call the two most difficult methods
            // in the whole code base:
            value result
                =   getPrincipalInstantiationFromCases {
                        criteria;
                        getPrincipalInstantiation {
                            criteria;
                        };
                    };

            // Don't return Nothing as a result; we're not trying to show that two
            // instantiations are disjoint here.
            if (exists result, !result.isNothing) {
                return result;
            }
            return null;
        }

        Type? getSupertypeForDeclaration(variable ClassOrInterface | TypeParameter? td) {
            // Don't resolve aliases here because we want to try to propagate the aliased
            // specified in the code through to the returned supertype

            if (isNothing) {
                // From ceylon-model: this is what the backend expects, apparently
                return null;
            }

            while (td is ClassAlias | InterfaceAlias) {
                value et = td?.extendedType;
                if (!exists et) {
                    return null;
                }
                assert (is ClassOrInterface extendedDeclaration = et.declaration);
                td = extendedDeclaration;
            }

            value resolvedTD = td;
            if (!exists resolvedTD) {
                return null;
            }

            return
            if (is ClassOrInterface resolvedTD, isSimpleSupertypeLookup(resolvedTD)) then
                // fast. Won't have type parameters or qualifying type
                (declaration.inherits(resolvedTD) then resolvedTD.type)
            else // slow
                getSupertypeForCriteria(SupertypeCriteria(resolvedTD));
        }

        return switch(criteria)
               case (is Criteria) getSupertypeForCriteria(criteria)
               else getSupertypeForDeclaration(criteria);
    }

    Type? qualifiedByDeclaringType {
        value qualifyingType = this.qualifyingType;
        if (!exists qualifyingType) {
            return this;
        }
        value container = declaration.container;
        if (!is ClassOrInterface container) {
            // local types can't have qualifying types that differ
            return this;
        }

        // replace the qualifying type with the supertype of the qualifying
        // type that declares this nested type, substituting type arguments
        value declaringType = qualifyingType.getSupertype(container);

        return createType {
            declaration = declaration;
            qualifyingType = declaringType;
            typeArguments = aggregateTypeArguments {
                declaringType;
                declaration;
                typeArgumentList;
            };
            varianceOverrides =  varianceOverrides;
        };
    }

    Type? getPrincipalInstantiation(Criteria criteria) {
        // search for the most-specific supertype for the declaration that satisfies
        // the given Criteria

        variable [Type, Type]? resultAndLowerBound = null;

        "The various ways in which this Type satisfies the criteria."
        value candidates
            =>  internalExtendedAndSatisfiedTypes.map((st)
                =>  st.getSupertype(criteria)).coalesced;

        for (candidate in candidates) {
            value previous = resultAndLowerBound;

            if (!exists previous) {
                resultAndLowerBound = [candidate, candidate];
            }
            else if (previous[0].isSubtypeOf(candidate)) {
                // just ignore this candidate
            }
            else if (candidate.isSubtypeOf(previous[1])) {
                resultAndLowerBound = [candidate, candidate];
            }
            else {
                // try to find a supertype of both types and form a principal
                // instantiation
                if (previous[0].declaration == candidate.declaration) {
                    value pi = principalInstantiation {
                        previous[0].declaration;
                        candidate;
                        previous[0];
                        unit;
                    };
                    if (!exists pi) {
                        return null;
                    }
                    resultAndLowerBound
                        =   [pi,
                             if (!criteria.memberLookup)
                             then pi
                             // TODO make sure this is right. See Ceylon 6243
                             else intersection {
                                 [previous[1], candidate];
                                 unit;
                             }];
                }
                else {
                    // ambiguous! we can't decide between the two supertypes which
                    // both satisfy the criteria
                    if (criteria.memberLookup) {
                        // for the case of a member lookup, try to find a common
                        // supertype by forming the union of the two possible results
                        // (since A|B is always a supertype of A&B)
                        value newLowerBound
                            =   intersection([previous[1], candidate], unit);

                        value newResult
                            =   union(newLowerBound.satisfiedTypes, unit)
                                    .getSupertype(criteria);

                        if (!exists newResult) {
                            return unit.unknownType;
                        }

                        resultAndLowerBound = [newResult, newLowerBound];
                    }
                    else {
                        return unit.unknownType;
                    }
                }
            }
        }

        return resultAndLowerBound?.first;
    }

    Type | Absent getPrincipalInstantiationFromCases<Absent>
            (Criteria criteria, Type | Absent result)
            given Absent satisfies Null {

        Type? getCommonSupertype({Type*} caseTypes, ClassOrInterface declaration) {
            // now try to construct a common produced type that is a common supertype by
            // taking the type args and unioning them

            value args = ArrayList<Type>();
            value unit = declaration.unit;

            if (!declaration.typeParameters.empty) {
                value caseSupertypes
                    =   let (maybeResult
                                =   caseTypes
                                    .filter(not(Type.isNothing))
                                    .collect((ct) => ct.getSupertype(declaration)))
                        (maybeResult.every((st) => st exists)
                        then maybeResult.coalesced);

                if (!exists caseSupertypes) {
                    return null;
                }

                value varianceOverrides = HashMap<TypeParameter, Variance>();

                for (typeParameter in declaration.typeParameters) {
                    Type result;

                    switch (typeParameter.variance)
                    case (covariant) {
                        result = unionDeduped {
                            caseSupertypes
                                .map((st) => st.typeArguments[typeParameter])
                                .coalesced; // there shouldn't be any nulls
                            unit;
                        };
                    }
                    case (contravariant) {
                        result = intersectionDedupedCanonical {
                            caseSupertypes
                                .map((st) => st.typeArguments[typeParameter])
                                .coalesced; // there shouldn't be any nulls
                            unit;
                        };
                    }
                    case (invariant) {
                        // invariant is harder, need to account for use site variances!

                        value union = unionDeduped {
                            caseSupertypes
                                .filter((st) => !st.variance(typeParameter).isContravariant)
                                .map((st) => st.typeArguments[typeParameter])
                                .coalesced; // there shouldn't be any nulls
                            unit;
                        };

                        value intersection = intersectionDeduped {
                            caseSupertypes
                                .filter((st) => !st.variance(typeParameter).isCovariant)
                                .map((st) => st.typeArguments[typeParameter])
                                .coalesced; // there shouldn't be any nulls
                            unit;
                        };

                        value covarientExists
                            =   caseSupertypes.any((st)
                                =>  st.variance(typeParameter).isCovariant);

                        value contravarientExists
                            =   caseSupertypes.any((st)
                                =>  st.variance(typeParameter).isContravariant);

                        if (!covarientExists && !contravarientExists) {
                            if (union.isExactly(intersection)) {
                                result = union; //invariant
                            }
                            else {
                                //NOTE: big asymmetry here that
                                //      privileges covariance over
                                //      contravariance. More elegant
                                //      would be to have double
                                //      bounded wildcards like
                                //      "in ITT out UTT"
                                result = union;
                                varianceOverrides.put(typeParameter, covariant);
                            }
                        }
                        else if (covarientExists && !contravarientExists) {
                            result = union;
                            varianceOverrides.put(typeParameter, covariant);
                        }
                        else if (contravarientExists && !covarientExists) {
                            result = intersection;
                            varianceOverrides.put(typeParameter, contravariant);
                        }
                        else {
                            // we have mixed covariant and invariant
                            // instantiations - that's only OK if we
                            // have something of form
                            value upperBound
                                =   intersectionOfSupertypes(typeParameter, unit);
                            result = upperBound;
                            varianceOverrides.put(typeParameter, covariant);
                            // Note we could have used "in Nothing"
                            //      here instead
                        }
                    }

                    args.add {
                        if (!typeParameter.isTypeConstructor)
                        then result
                        else copyType { // TODO construct a type alias instead!
                            result;
                            isTypeConstructor = true;
                            typeConstructorParameter = typeParameter;
                        };
                    };
                }
            }

            // recurse to the qualifying type
            Type? outerType;
            if (is ClassOrInterface outerDeclaration = declaration.container,
                    !declaration.isStatic) {
                // it's a member
                value outerTypes = caseTypes.map((ct) {
                    value intersectedTypes
                        =   if (ct.isIntersection)
                            then ct.satisfiedTypes
                            else [ct];

                    for (intersectedType in intersectedTypes) {
                        if (intersectedType.declaration.container
                                is ClassOrInterface) {
                            assert (exists qualifyingTypeSupertype
                                =   intersectedType
                                        .qualifyingType
                                        ?.getSupertype(outerDeclaration));

                            return qualifyingTypeSupertype;
                        }
                    }
                    return null;
                }).coalesced;

                outerType = getCommonSupertype(outerTypes, outerDeclaration);
            }
            else {
                outerType = null;
            }

            // make the resulting type
            value candidate
                =   declaration.appliedType {
                        outerType;
                        args;
                        varianceOverrides;
                    };

            // check the the resulting type is *really* a subtype (take variance into
            // account)
            return caseTypes.every((ct) => ct.isSubtypeOf(candidate)) then candidate;
        }

        function findCommonSuperclass(Criteria c, {TypeDeclaration+} typeDeclarations) {
            variable ClassOrInterface? result = null;
            value first = typeDeclarations.first;

            for (candidate in first.supertypeDeclarations) {
                if (c.satisfiesType(candidate)) {
                    if (typeDeclarations.every((d) => d.inherits(candidate))) {
                        value previous = result;
                        if (!exists previous) {
                            result = candidate;
                        }
                        else if (candidate.inherits(previous)) {
                            result = candidate;
                        }
                        else if (!previous.inherits(candidate)) {
                            // JV: will this ever happen?
                            result = null;
                            break;
                        }
                    }
                }
            }

            return result;
        }

        if (isUnion, nonempty caseTypes = this.caseTypes.sequence()) {
            // first find a common superclass or superinterface
            // declaration that satisfies the criteria, ignoring
            // type arguments for now
            value superDeclaration
                =   findCommonSuperclass {
                        criteria;
                        caseTypes.collect(Type.declaration);
                    };

            if (exists superDeclaration) {
                // we found the declaration, now try to construct a
                // produced type that is a true common supertype
                if (exists candidate = getCommonSupertype(caseTypes, superDeclaration)) {
                    if (!exists result) {
                        return candidate;
                    }
                    else if (candidate.isSubtypeOf(result)) {
                        return candidate;
                    }
                }
            }

        }
        return result;
    }

    Boolean isSimpleSupertypeLookup(ClassOrInterface td)
        =>     !declaration is UnionType
            && !declaration is IntersectionType
            &&  td.typeParameters.empty
            && !td.container is ClassOrInterface
            // this is for the runtime which uses
            // qualifying types in a strange way
            // https://github.com/ceylon/ceylon/issues/4429
            && !qualifyingType exists;

    shared
    Type? extendedType
        =>  let (et = declaration.extendedType)
            if (exists et, !et.typeArguments.empty)
            then et.substituteFromType(this)
            else et;

    Type? internalExtendedType
        =>  let (et = declaration.extendedType)
            if (exists et, !et.typeArguments.empty)
            then et.substituteFromType { this; dedup = false; }
            else et;

    "Substitute the type arguments and use-site variances given in the given type into
     this type, which is usually a supertype of the given type."
    shared
    Type substituteFromType(
            "The source for the type arguments"
            Type source,
            "Variance overrides; default is to use overrides from the [[source]]"
            Map<TypeParameter, Variance> overrides = source.varianceOverrides,
            "Dedup union and intersection types?"
            Boolean dedup = true)
        =>  let (substitutions = source.typeArguments)
            // Is this optimization safe? It defeats the side effects of
            // union/intersection simplification and type argument aggregation.
            if (substitutions.empty)
            then this
            else package.substitute {
                if (!overrides.empty)
                    then applyVarianceOverrides(covariant, overrides)
                    else this;
                covariant;
                substitutions;
                overrides;
                dedup;
            };

    "Substitute the type arguments and use-site variances given in the qualifying type
     and type arguments of the given member reference into this type (which is always
     the type of the member reference)."
    shared
    Type substituteFromTypedReference(TypedReference source)
        =>  package.substitute {
                type = this;
                variance = source.variance;
                substitutions = source.typeArguments;
                varianceOverrides
                    =   source.qualifyingType?.collectedVarianceOverrides
                        else emptyMap;
            };

    Map<TypeParameter, Variance> collectedVarianceOverrides
        =>  let (qualifyingOverrides
                =   qualifyingType?.varianceOverrides else emptyMap)
            if (varianceOverrides.empty)
                then qualifyingOverrides
            else
                map {
                    expand {
                        varianceOverrides,
                        qualifyingOverrides
                    };
                };

    "Substitute the given types for the corresponding given type parameters wherever they
     appear in the type. Has the side-effect of performing disjoint type analysis,
     simplifying union/intersection types, even when there are no substitutions."
    // Note: "even when there are no substitutions" is not true in ceylon-model.
    shared
    Type substitute(
            Map<TypeParameter, Type> substitutions,
            Map<TypeParameter, Variance> varianceOverrides)
        =>  package.substitute {
                this; covariant; substitutions; varianceOverrides; true;
            };

    Type applyVarianceOverrides
            (Variance variance, Map<TypeParameter, Variance> overrides) {

        if (overrides.empty) {
            return this;
        }

        if (is TypeParameter declaration = this.declaration) {
            if (exists override = overrides.get(declaration)) {
                if (variance.isContravariant && override.isCovariant) {
                    // if a type parameter occurs in a contravariant position, and the
                    // specified use-site variance is "out", replace the type parameter
                    // with its lower bound Nothing, throwing away the use-site upper
                    // bound
                    return unit.nothingDeclaration.type;
                }
                else if (variance.isCovariant && override.isContravariant) {
                    // if a type parameter occurs in a covariant position, and the
                    // specified use-site variance is "in", replace the type parameter
                    // with its upper bounds, throwing away the use-site lower bound

                    value set = HashSet<Type>();
                    for (bound in declaration.satisfiedTypes) {
                        // ignore bounds in which the type parameter itself occurs
                        // covariantly because they would result in a stack overflow here
                        // TODO perhaps we should just
                        //      substitute Anything for the
                        //      type parameter in such bounds,
                        //      which would be a little more
                        //      precise
                        if (!bound.occursCovariantly(declaration)) {
                            value applied
                                =   bound.applyVarianceOverrides(variance, overrides);
                            addToIntersection(set, applied, unit);
                        }
                    }
                    return canonicalIntersection(set, unit);
                }
            }
            return this;
        }
        else if (isUnion) {
            return unionDeduped {
                caseTypes.map((ct)
                    =>  ct.applyVarianceOverrides(variance, overrides));
                unit;
            };
        }
        else if (isIntersection) {
            return intersectionDedupedCanonical {
                satisfiedTypes.map((st)
                    =>  st.applyVarianceOverrides(variance, overrides));
                unit;
            };
        }

        if (declaration.typeParameters.empty) {
            // we have variance overrides from a qualifying type
            // optimize, since no work to do
            return this;
        }

        value resultArgs = ArrayList<Type>();
        value varianceResults = HashMap<TypeParameter, Variance>();

        for (parameter -> argument in typeArgumentListEntries) {

            switch (this.variance(parameter))
            case (covariant) {
                resultArgs.add {
                    argument.applyVarianceOverrides  {
                        variance;
                        overrides;
                    };
                };
            }
            case (contravariant) {
                resultArgs.add {
                    argument.applyVarianceOverrides  {
                        variance.opposite;
                        overrides;
                    };
                };
            }
            case (invariant) {
                switch (variance)
                case (contravariant) {
                    if (argument.isTypeParameter
                            && overrides.defines(argument.declaration)) {
                        return unit.nothingDeclaration.type;
                    }
                }
                case (covariant) {
                    if (argument.isTypeParameter,
                            exists override = overrides[argument.declaration]) {
                        varianceResults.put(parameter, override);
                        resultArgs.add(argument);
                        continue;
                    }
                }
                case (invariant) {
                    // default ok
                }
                value resultArg
                    =   argument.applyVarianceOverrides(variance, overrides);

                if (resultArg.isNothing) {
                    return resultArg;
                }

                resultArgs.add(resultArg);
                if (argument.involvesTypeParametersAny(overrides.keys)) {
                    varianceResults.put(parameter, covariant);
                }
            }
        }

        return
        declaration.appliedType {
            qualifyingType;
            resultArgs.sequence();
            varianceResults;
            // TODO underlyingType ???
        };
    }

    shared
    Boolean occursCovariantly(TypeParameter typeParameter, Boolean covariant = true) {
        if (isUnknown || isNothing) {
            return false;
        }
        if (isUnion) {
            return caseTypes.any((caseType)
                =>  caseType.occursCovariantly(typeParameter, covariant));
        }
        if (isIntersection) {
            return satisfiedTypes.any((satisfiedType)
                =>  satisfiedType.occursCovariantly(typeParameter, covariant));
        }

        if (covariant && declaration == typeParameter) {
            return true;
        }
        if (exists qualifyingType = this.qualifyingType,
                qualifyingType.occursCovariantly(typeParameter, covariant)) {
            return true;
        }
        for (parameter -> argument in typeArgumentListEntries) {
            if (!variance(parameter).isInvariant) {
                return argument.occursCovariantly {
                    parameter;
                    if (variance(parameter).isContravariant)
                        then !covariant
                        else covariant;
                };
            }
        }
        return false;
    }

    shared
    Boolean occursContravariantly(TypeParameter typeParameter, Boolean covariant = true) {
        if (isUnknown || isNothing) {
            return false;
        }
        if (isUnion) {
            return caseTypes.any((caseType)
                =>  caseType.occursContravariantly(typeParameter, covariant));
        }
        if (isIntersection) {
            return satisfiedTypes.any((satisfiedType)
                =>  satisfiedType.occursContravariantly(typeParameter, covariant));
        }

        if (!covariant && declaration == typeParameter) {
            return true;
        }
        if (exists qualifyingType = this.qualifyingType,
                qualifyingType.occursContravariantly(typeParameter, covariant)) {
            return true;
        }
        for (parameter -> argument in typeArgumentListEntries) {
            if (!variance(parameter).isInvariant) {
                return argument.occursContravariantly {
                    parameter;
                    if (variance(parameter).isContravariant)
                        then !covariant
                        else covariant;
                };
            }
        }
        return false;
    }

    // TODO do we really need a Criteria class?
    class SupertypeCriteria(ClassOrInterface | TypeParameter td) satisfies Criteria {
        shared actual
        Boolean satisfiesType(ClassOrInterface | TypeParameter satisfiesTd)
            =>  satisfiesTd.equals(td);

        shared actual
        Boolean memberLookup
            =>  false;
    }

    shared
    Boolean involvesTypeParameters
        =>  isTypeParameter
                // verbose ref to Type.involvesTypeParameters due to ceylon/ceylon#6565
                || isUnion && caseTypes.any((t) => t.involvesTypeParameters)
                || isIntersection && satisfiedTypes.any((t) => t.involvesTypeParameters)
                || typeArgumentList.any((t) => t.involvesTypeParameters)
                || (qualifyingType?.involvesTypeParameters else false);

    shared
    Boolean involvesTypeParametersAny({TypeParameter*} parameters)
        =>  isTypeParameter && parameters.contains(this.declaration)
                || isUnion && caseTypes.any((t)
                        =>  t.involvesTypeParametersAny(parameters))
                || isIntersection && satisfiedTypes.any((t)
                        =>  t.involvesTypeParametersAny(parameters))
                || typeArgumentList.any((t)
                        =>  t.involvesTypeParametersAny(parameters))
                || (qualifyingType
                            ?.involvesTypeParametersAny(parameters) else false);

    shared actual
    String string
        =>  if (isTypeConstructor)
            then formatted + " (type constructor)"
            else formatted + " (type)";

    shared
    String formatted
        =>  format();

    shared
    String formattedAsSourceCode
        =>  formatEscaped();

    String typeArgumentsAsString
        =>  if (nonempty typeArgumentList = this.typeArgumentList.sequence())
            then "<``", ".join(typeArgumentList.map(
                    Type.qualifiedNameWithTypeArguments))``>"
            else "";

    shared
    String qualifiedNameWithTypeArguments {
        if (isUnion) {
            // verbose ref to Type.qualifiedNameWithTypeArguments ceylon/ceylon#6565
            return "|".join(caseTypes.map((t) => t.qualifiedNameWithTypeArguments));
        }

        if (isIntersection) {
            return "&".join(satisfiedTypes.map((t) => t.qualifiedNameWithTypeArguments));
        }

        if (isTypeConstructor) {
            return nothing;
        }

        value sb = StringBuilder();

        if (exists qualifyingType = qualifyingType) {
            sb.append(qualifyingType.qualifiedNameWithTypeArguments);
            sb.append(".");
            sb.append(declaration.name);
        }
        else {
            // includes "package::"
            sb.append(declaration.qualifiedName);
        }

        sb.append(typeArgumentsAsString);

        return sb.string;
    }

    shared
    Type withNullEliminated
        =>  if (declaration.inherits(unit.nullDeclaration)) then
                unit.nothingDeclaration.type
            else if (isUnion) then
                // workaround ceylon issue 6565
                //unionDeduped(caseTypes.map(Type.withNullEliminated), unit)
                unionDeduped(caseTypes.map((t) => t.withNullEliminated), unit)
            else this;

    "Substitute invocation type arguments into an upper bound on a type parameter of the
     invocation, where this type represents an upper bound."
    shared
    Type appliedType(
            "the type that receives the invocation, if any"
            Type? receiver,
            "the invoked member"
            Declaration member,
            "the explicit or inferred type arguments of the invocation"
            [Type*] typeArguments,
            [Variance*] variances) {

        Type? receivingType;
        if (exists receiver) {
            assert (is ClassOrInterface memberContainer = member.container);
            receivingType = receiver.getSupertype(memberContainer);
        }
        else {
            receivingType = null;
        }

        return substitute {
            aggregateTypeArguments {
                receivingType;
                member;
                typeArguments;
            };
            aggregateVariances {
                receivingType;
                member;
                variances;
            };
        };
    }

    shared
    String formatEscaped()
        =>  format {
                escapeLowercased = true;
            };

    shared
    String format(
            Boolean printAbbreviated = true,
            Boolean printTypeParameters = true,
            Boolean printTypeParameterDetail = false,
            Boolean printQualifyingType = true,
            Boolean printQualifier = false,
            Boolean printFullyQualified = false,
            Boolean escapeLowercased = false) {

        // FIXME The name is dependent on the Unit in which the name appears, because of
        //       import aliases! So we need to accept a unit argument and do things like
        //       declaration.getName(unit).

        void printType(StringBuilder sb, Type type) {

            void printSimpleDeclarationName(StringBuilder sb, Declaration declaration) {
                // FIXME unit.getName(declaration), to resolve import aliases
                value name = declaration.name;
                if (escapeLowercased, exists first = name.first, !first.uppercase) {
                    sb.append("\\I");
                }
                sb.append(name);
            }

            void printDeclaration
                    (StringBuilder sb, Declaration declaration, Boolean fullyQualified) {

                if (fullyQualified && !declaration is TypeParameter) {
                    // type parameters are not fully qualified

                    "The first ancestor declaration or package."
                    value container
                        =   loop(declaration of Scope)((c) => c.container else finished)
                                .rest.narrow<Package | Declaration | Null>().first;

                    switch (container)
                    case (is Null) {}
                    case (is Package) {
                        value qName = container.qualifiedName;
                        if (!qName.empty) {
                            sb.append(qName);
                            sb.append("::");
                        }
                    }
                    case (is Declaration) {
                        printDeclaration(sb, container, fullyQualified);
                        sb.append(".");
                    }
                }

                if (printQualifier, exists qualifier = declaration.qualifier) {
                    // TODO We might want to make the qualifier an "official" part of the
                    //      declaration's name, so that declaration.qualifiedNames would
                    //      be unique. This code would then be removed.
                    sb.append(qualifier.string);
                }

                printSimpleDeclarationName(sb, declaration);
            }

            void printWithAnglesIf(Boolean needsAngles, Type type) {
                if (needsAngles) {
                    sb.append("<");
                }
                printType(sb, type);
                if (needsAngles) {
                    sb.append(">");
                }
            }

            void printSimpleProducedTypeName(StringBuilder sb, Type type) {
                variable value fullyQualified = printFullyQualified;

                if (printQualifyingType) {
                    if (exists qt = type.qualifyingType, qt.declaration.isNamed) {
                        printWithAnglesIf {
                            needsAngles = qt.isIntersection || qt.isUnion;
                            qt;
                        };
                        sb.append(".");
                        fullyQualified = false;
                    }
                }

                printDeclaration(sb, type.declaration, fullyQualified);

                if (printTypeParameters,
                    !type.isTypeConstructor,
                    nonempty typeArguments
                        =   type.typeArgumentListEntries.sequence()) {

                    sb.append("<");

                    variable value first = true;

                    for (parameter -> argument in typeArguments) {
                        if (first) {
                            first = false;
                        }
                        else {
                            sb.append(", ");
                        }

                        if (!parameter.variance.isCovariant
                                && type.isCovariant(parameter)) {
                            sb.append("out ");
                        }
                        else if (!parameter.variance.isContravariant
                                && type.isContravariant(parameter)) {
                            sb.append("in ");
                        }

                        printType(sb, argument);
                    }
                    sb.append(">");
                }
            }

            "Is [[type]] a `Tuple` with a minimal `Element` type and an ultimate
             `Rest` type of `Empty`, `Sequential`, or `Sequence`? And, if any element
             is optional, are all subsequent elements optional?"
            function isSimpleWellFormedTuple(variable Type type) {
                if (!type.isTuple) {
                    return false;
                }

                assert (exists elementTypes = unit.getTupleElementTypes(type));
                [Type*] allTypes;
                if (unit.isTupleLengthUnbounded(type)) {
                    assert (exists lastType
                            = elementTypes.last);

                    if (exists lastElementType
                            =   unit.getSequentialElementType(lastType)) {
                        allTypes
                            =   elementTypes.exceptLast
                                    .chain([lastElementType])
                                    .sequence();
                    }
                    else {
                        // Rest doesn't satisfy its constraint.
                        return false;
                    }
                }
                else {
                    allTypes = elementTypes;
                }

                variable value index = -1;
                variable value optional = false;

                while (true) {
                    index++;
                    if (type.isUnion) {
                        // one of the two must be []
                        value cases = type.caseTypes.sequence();
                        if (cases.size != 2) {
                            return false;
                        }
                        assert (exists first = cases[0]);
                        assert (exists second = cases[1]);
                        if (first.isEmpty) {
                            type = second;
                        }
                        else if (second.isEmpty) {
                            type = first;
                        }
                        else {
                            return false;
                        }
                        optional = true;
                    }
                    else if (optional && !type.isSequential && !type.isEmpty) {
                        // After the first optional, the rest must be optional
                        return false;
                    }

                    if (type.isEmpty || type.isSequence || type.isSequential) {
                        return true;
                    }
                    else if (type.isTuple) {
                        value typeArguments = type.typeArgumentList.sequence();
                        assert (exists tupleElement = typeArguments[0]);
                        assert (exists rest = typeArguments[2]);

                        value tupleElements
                            =   unionDeduped(allTypes.skip(index), unit);

                        if (!tupleElements.isExactly(tupleElement)) {
                            return false;
                        }
                        type = rest;
                    }
                    else {
                        return false;
                    }
                }
            }

            function abbreviateOptional(Type type)
                =>  if (type.isUnion)
                    then let (caseTypes = type.caseTypes.take(3).sequence())
                         caseTypes.size == 2 && caseTypes.any(Type.isNull)
                    else false;

            function abbreviateTuple(Type type)
                =>  isSimpleWellFormedTuple(type);

            function abbreviateHomogeneousTuple(Type type)
                =>  type.unit.getHomogeneousTupleLength(type) exists;

            function abbreviateEntry(Type type)
                =>  if (exists [keyType, itemType]
                            =   type.unit.getEntryKeyItemTypes(type))
                    then !keyType.isEntry && !itemType.isEntry
                    else false;

            function abbreviateEmpty(Type type)
                =>  type.isEmpty;

            function abbreviateSequence(Type type)
                =>  type.isSequence;

            function abbreviateSequential(Type type)
                =>  type.isSequential;

            function abbreviateIterable(Type type) {
                if (!type.isIterable) {
                    return false;
                }
                assert (exists absentType = type.typeArgumentList.getFromFirst(1));
                return absentType.isNull || absentType.isNothing;
            }

            function abbreviateCallable(Type type)
                =>  type.isInterface
                    && type.declaration == type.unit.callableDeclaration;

            Boolean abbreviateCallableArg(Type type) {
                if (type.isUnion) {
                    value caseTypes = type.caseTypes.sequence();
                    if (caseTypes.size == 2) {
                        // possibly a single optional parameter, like 'String=', but
                        // abbreviateTuple() returns for '[String=]', which is formatted
                        // as '[]|[String]'.
                        assert (exists first = caseTypes[0]);
                        assert (exists second = caseTypes[1]);
                        return abbreviateEmpty(first)
                            && abbreviateCallableArg(second);
                    }
                    return false;
                }
                else {
                    return abbreviateEmpty(type)
                        || abbreviateSequence(type)
                        || abbreviateSequential(type)
                        || abbreviateTuple(type);
                }
            }

            function isPrimitiveAbbreviatedType(Type type)
                =>  !type.isIntersection
                    && (!type.isUnion || abbreviateOptional(type))
                    && !abbreviateEntry(type);

            void printTupleElementTypeNames(StringBuilder sb, variable Type type) {
                Boolean defaulted;

                if (type.isUnion) {
                    value cases = type.caseTypes.sequence();
                    if (cases.size == 2) {
                        assert (exists first = cases[0]);
                        assert (exists second = cases[1]);
                        if (first.isEmpty) {
                            type = second;
                        }
                        else if (second.isEmpty) {
                            type = first;
                        }
                        defaulted = true;
                    }
                    else {
                        defaulted = false;
                    }
                }
                else {
                    defaulted = false;
                }

                if (type.isEmpty) {
                    if (defaulted) {
                        sb.appendCharacter('=');
                    }
                    return;
                }
                else if (type.isSequential) {
                    assert (exists elementType = unit.getSequentialElementType(type));
                    printWithAnglesIf {
                        !isPrimitiveAbbreviatedType(elementType);
                        elementType;
                    };
                    sb.appendCharacter('*');
                }
                else if (type.isSequence) {
                    assert (exists elementType = unit.getSequentialElementType(type));
                    printWithAnglesIf {
                        !isPrimitiveAbbreviatedType(elementType);
                        elementType;
                    };
                    sb.appendCharacter('+');
                }
                else if (type.isTuple) {
                    value typeArguments = type.typeArgumentList.sequence();
                    assert (exists first = typeArguments[1]);
                    assert (exists rest = typeArguments[2]);

                    printType(sb, first);
                    if (rest.isEmpty) {
                        if (defaulted) {
                            sb.appendCharacter('=');
                        }
                    }
                    else {
                        if (defaulted) {
                            sb.appendCharacter('=');
                        }
                        sb.append(", ");
                    }
                    printTupleElementTypeNames(sb, rest);
                }
                else {
                    throw AssertionError(
                        "Expected an Empty, Sequential, Sequence, or Tuple type");
                }
            }

            if (printAbbreviated && !type.isTypeAlias) {
                if (abbreviateOptional(type)) {
                    value nonOptional = type.withNullEliminated;
                    printWithAnglesIf {
                        needsAngles = !isPrimitiveAbbreviatedType(nonOptional);
                        nonOptional;
                    };
                    sb.append("?");
                    return;
                }
                if (abbreviateEmpty(type)) {
                    sb.append("[]");
                    return;
                }
                if (abbreviateHomogeneousTuple(type)) {
                    assert (exists elementType
                        =   type.unit.getSequentialElementType(type));

                    assert (exists length
                        =   type.unit.getHomogeneousTupleLength(type));

                    printWithAnglesIf {
                        needsAngles = !isPrimitiveAbbreviatedType(elementType);
                        elementType;
                    };
                    sb.append("[");
                    sb.append(length.string);
                    sb.append("]");
                    return;
                }
                if (abbreviateSequential(type)) {
                    assert (exists iteratedType = type.unit.getIteratedType(type));
                    printWithAnglesIf {
                        needsAngles = !isPrimitiveAbbreviatedType(iteratedType);
                        iteratedType;
                    };
                    sb.append("[]");
                    return;
                }
                if (abbreviateSequence(type)) {
                    assert (exists iteratedType = type.unit.getIteratedType(type));
                    sb.append("[");
                    printWithAnglesIf {
                        needsAngles
                            = !(type.isUnion
                                || type.isIntersection
                                || isPrimitiveAbbreviatedType(iteratedType));
                        iteratedType;
                    };
                    sb.append("+]");
                    return;
                }
                if (abbreviateIterable(type)) {
                    value typeArguments = type.typeArgumentList.sequence();
                    assert (exists iteratedType = typeArguments[0]);
                    assert (exists absentType = typeArguments[1]);
                    sb.append("{");
                    printWithAnglesIf {
                        needsAngles
                            = !(type.isUnion
                                || type.isIntersection
                                || isPrimitiveAbbreviatedType(iteratedType));
                        iteratedType;
                    };
                    sb.append(if (absentType.isNothing) then "+" else "*");
                    sb.append("}");
                    return;
                }
                if (abbreviateEntry(type)) {
                    assert (exists [keyType, itemType]
                        =   type.unit.getEntryKeyItemTypes(type));
                    printType(sb, keyType);
                    sb.append("->");
                    printType(sb, itemType);
                    return;
                }
                if (abbreviateCallable(type)) {
                    value typeArguments = type.typeArgumentList.sequence();
                    assert (exists returnType = typeArguments[0]);
                    assert (exists parameterTypes = typeArguments[1]);

                    printWithAnglesIf {
                        needsAngles
                            =   !(isPrimitiveAbbreviatedType(returnType));
                        returnType;
                    };
                    sb.append("(");
                    if (abbreviateCallableArg(parameterTypes)) {
                        printTupleElementTypeNames(sb, parameterTypes);
                    }
                    else {
                        sb.append("*");
                        printWithAnglesIf {
                            needsAngles = !(isPrimitiveAbbreviatedType(parameterTypes));
                            parameterTypes;
                        };
                    }
                    sb.append(")");
                    return;
                }
                if (abbreviateTuple(type)) {
                    sb.append("[");
                    printTupleElementTypeNames(sb, type);
                    sb.append("]");
                    return;
                }
            }

            if (type.isUnion) {
                variable value first = true;
                for (caseType in type.caseTypes) {
                    if (first) {
                        first = false;
                    }
                    else {
                        sb.append("|");
                    }
                    printWithAnglesIf {
                        needsAngles = printAbbreviated && caseType.isEntry;
                        caseType;
                    };
                }
                return;
            }
            else if (type.isIntersection) {
                variable value first = true;
                for (satisfiedType in type.satisfiedTypes) {
                    if (first) {
                        first = false;
                    }
                    else {
                        sb.append("&");
                    }

                    printWithAnglesIf {
                        needsAngles
                            =   satisfiedType.isUnion
                                    || printAbbreviated
                                       && satisfiedType.isEntry;
                        satisfiedType;
                    };
                }
                return;
            }
            else if (is TypeParameter typeParameter = type.declaration) {
                if (printTypeParameterDetail) {
                    switch (typeParameter.variance)
                    case (invariant) {}
                    case (contravariant) {
                        sb.append("in ");
                    }
                    case (covariant) {
                        sb.append("out ");
                    }
                }

                printSimpleProducedTypeName(sb, type);

                if (printTypeParameterDetail,
                        exists defaultArgument = typeParameter.defaultTypeArgument) {
                    sb.append(" = ");
                    printType(sb, defaultArgument);
                }
                return;
            }
            else {
                if (is Alias declaration = type.declaration,
                    declaration.isAnonymous) {

                    if (type.isTypeConstructor) {
                        throw; // FIXME TODO
                    }

                    "Aliases have extended types."
                    assert (exists extendedType = declaration.extendedType);

                    // append type aliased type
                    printType(sb, extendedType.substituteFromType(type));

                    return;
                }
                else {
                    printSimpleProducedTypeName(sb, type);
                    return;
                }
            }
        }

        value sb = StringBuilder();
        printType(sb, this);
        return sb.string;
    }
}

Type createType(
        TypeDeclaration declaration,
        Map<TypeParameter, Type> typeArguments = emptyMap,
        Type? qualifyingType = null,
        Boolean isTypeConstructor = false,
        Map<TypeParameter,Variance> varianceOverrides = emptyMap,
        TypeParameter? typeConstructorParameter = null)
    =>  TypeImpl(declaration, qualifyingType, typeArguments,
                 varianceOverrides, isTypeConstructor, typeConstructorParameter);

Type copyType(
        Type from,
        TypeDeclaration declaration = from.declaration,
        Map<TypeParameter, Type> specifiedTypeArguments = from.specifiedTypeArguments,
        Type? qualifyingType = from.qualifyingType,
        Boolean isTypeConstructor = from.isTypeConstructor,
        Map<TypeParameter,Variance> varianceOverrides = from.varianceOverrides,
        TypeParameter? typeConstructorParameter = from.typeConstructorParameter)
    =>  TypeImpl(declaration, qualifyingType, specifiedTypeArguments,
                 varianceOverrides, isTypeConstructor, typeConstructorParameter);

class TypeImpl(
        declaration,
        qualifyingType,
        specifiedTypeArguments,
        varianceOverrides,
        isTypeConstructor,
        typeConstructorParameter) extends Type() {

    shared actual Map<TypeParameter, Type> specifiedTypeArguments;
    shared actual Type? qualifyingType;
    shared actual TypeDeclaration declaration;
    shared actual Boolean isTypeConstructor;
    shared actual Map<TypeParameter,Variance> varianceOverrides;
    shared actual TypeParameter? typeConstructorParameter;
}
