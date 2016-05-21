import ceylon.collection {
    HashMap,
    HashSet,
    MutableSet,
    ArrayList
}

"Form the union of the given types, without eliminating duplicates."
shared see(`function addToUnion`)
Type union({Type*} types, Unit unit)
    =>  let (seq = types.sequence())
        if (!nonempty seq) then
            unit.nothingDeclaration.type
        else if (seq.size == 1) then
            seq.first
        else
            UnionType(seq, unit).type;

"Form the union of the given types, eliminating duplicates."
shared
Type unionType(Type a, Type b, Unit unit)
    =>  unionDeduped([a, b], unit);

"Form the intersection of the given types, canonicalizing, and eliminating duplicates."
shared
Type intersectionType(Type a, Type b, Unit unit)
    // TODO ceylon-model does a lot more: tries getSimpleIntersection()
    =>  intersectionDeduped([a, b], unit);

"Form the union of the given types, eliminating duplicates."
shared
Type unionDeduped({Type*} types, Unit unit) {
    value set = HashSet<Type>();
    types.each((t) => addToUnion(set, t));
    return union(set, unit);
}

"Add the given `Type` [[that]] to the union of `Type`s [[types]], taking into account
 that a subtype is a 'duplicate' of its supertype."
shared see(`function union`)
void addToUnion(MutableSet<Type> types, Type that) {
    if (that.isExactlyNothing) {
        return;
    }
    if (that.isAnything) {
        types.clear();
        types.add(that);
        return;
    }
    if (that.isUnion) {
        that.caseTypes.each((ct) => addToUnion(types, ct));
        return;
    }
    if (that.isWellDefined) {
        for (existing in types.sequence()) {
            if (existing.isSubtypeOf(that)) {
                return;
            }
            if (that.isSubtypeOf(existing)) {
                types.remove(existing);
            }
        }
    }
    types.add(that);
}

"Form the intersection of the given types, eliminating duplicates."
shared see(`function intersection`)
Type intersectionDeduped({Type*} types, Unit unit) {
    value set = HashSet<Type>();
    types.each((type) => addToIntersection(set, type, unit));
    return intersection(set, unit);
}

// TODO is this redundant?
shared see(`function intersection`)
Type intersectionDedupedCanonical({Type*} types, Unit unit) {
    value set = HashSet<Type>();
    types.each((type) => addToIntersection(set, type, unit));
    return canonicalIntersection(set, unit);
}

"Form the intersection of the given types, without eliminating duplicates nor
 canonicalizing."
shared see(`function addToIntersection`)
Type intersection({Type*} types, Unit unit)
    =>  let (seq = types.sequence())
        if (!nonempty seq) then
            unit.anythingDeclaration.type
        else if (seq.size == 1) then
            seq.first
        else
            IntersectionType(seq, unit).type;

"Form the canonical intersection of the given types, without eliminating duplicates."
Type canonicalIntersection({Type*} types, Unit unit)
    =>  let (seq = types.sequence())
        if (!nonempty seq) then
            unit.anythingDeclaration.type
        else if (seq.size == 1) then
            (seq.first)
        else
            IntersectionType(seq, unit).canonicalized.type;

"Helper method for eliminating duplicate types from lists of types that form an
 intersection type, taking into account that a supertype is a 'duplicate' of its
 subtype."
shared see(`function intersection`, `function intersectionDeduped`)
void addToIntersection(MutableSet<Type> types, Type that, Unit unit) {
    if (types.empty && that.isAnything) {
        return;
    }
    if (that.isExactlyNothing) {
        types.clear();
        types.add(that);
        return;
    }
    if (that.isIntersection) {
        that.satisfiedTypes.each((st) => addToIntersection(types, st, unit));
    }
    if (that.isWellDefined) {
        for (existing in types.sequence()) {
            if (existing.isSubtypeOf(that)) {
                return;
            }
            if (that.isSubtypeOf(existing)) {
                types.remove(existing);
                continue;
            }
            if (disjoint(that, existing, unit)) {
                types.clear();
                types.add(that);
                return;
            }
            if ((that.declaration is ClassOrInterface | TypeParameter)
                    && that.declaration == existing.declaration) {
                // canonicalize a type of form
                // T<InX,OutX>&T<InY,OutY> to
                // T<InX|InY,OutX&OutY>
                value pi = principalInstantiation {
                    that.declaration; that; existing; unit;
                };
                if (exists pi) {
                    types.remove(existing);
                    types.add(pi);
                }
                return;
            }
        }
        if (types.size > 1) {
            // it is possible to have a type that is a supertype of the intersection,
            // even though it is not a supertype of any of the intersected types!
            value t = canonicalIntersection(types, that.unit);
            if (that.isSupertypeOf(t)) {
                return;
            }
        }
        types.add(that);
    }
}

Boolean disjoint(Type a, Type b, Unit unit) {
    "Implement the rule that `Foo&Bar==Nothing` if there exists some enumerated
     type Baz with

         Baz of Foo | Bar

     Returns false if either declaration is a UnionType.

     Returns true if this type is disjoint from the given type, according to
     this rule only."
    Boolean isDisjointEnum(TypeDeclaration a, TypeDeclaration b) {
        function isDisjointFromB(TypeDeclaration satisfiedDeclaration) {
            // ignore unions, type parameters, types w/self types, and types with no
            // case types
            if (satisfiedDeclaration is ClassOrInterface,
                    nonempty enumeratedTypes = satisfiedDeclaration.enumeratedTypes) {
                // if b inherits one of the case types that isn't a, they're disjoint
                value otherCases
                    =   enumeratedTypes.map(Type.declaration).filter(not(a.equals));
                for (caseDeclaration in otherCases) {
                    "An enumerated case type must be a class or interface."
                    assert (is ClassOrInterface caseDeclaration);
                    if (b.inherits(caseDeclaration)) {
                        return true;
                    }
                }
            }
            // if a satisfies a type that is disjoint from b, a and b are disjoint
            return isDisjointEnum(satisfiedDeclaration, b);
        }

        if (a is UnionType || b is UnionType) {
            return false;
        }

        if (a is ClassOrInterface && b is ClassOrInterface && a == b) {
            return false;
        }

        if (a is TypeParameter && b is TypeParameter && a == b) {
            return false;
        }

        return a.extendedAndSatisfiedDeclarations.any(isDisjointFromB);
    }

    Boolean hasEmptyIntersectionOfInvariantInstantiations(Type a, Type b) {
        value supertypesA = a.declaration.supertypeDeclarations;
        value supertypesB = set(b.declaration.supertypeDeclarations);

        value supertypesBoth = supertypesA.filter(supertypesB.contains);

        for (std in supertypesBoth) {
            variable Type? superAMemo = null;
            variable Type? superBMemo = null;

            for (typeParameter in std.typeParameters
                    .filter((tp) => tp.variance.isInvariant)) {

                value superA = superAMemo else (superAMemo = a.getSupertype(std));
                value superB = superBMemo else (superBMemo = a.getSupertype(std));

                if (exists superA, exists superB) {
                    if (exists typeArgumentA = superA.typeArguments[typeParameter],
                        exists typeArgumentB = superB.typeArguments[typeParameter],
                            !typeArgumentA.involvesTypeParameters,
                            !typeArgumentB.involvesTypeParameters) {

                        value varianceA = superA.variance(typeParameter);
                        value varianceB = superB.variance(typeParameter);

                        if (varianceA.isInvariant && varianceB.isInvariant
                                    && !typeArgumentA.isExactly(typeArgumentB)
                                || varianceA.isCovariant && varianceB.isInvariant
                                    && !typeArgumentB.isSubtypeOf(typeArgumentA)
                                || varianceB.isCovariant && varianceA.isInvariant
                                    && !typeArgumentA.isSubtypeOf(typeArgumentB)
                                || varianceA.isContravariant && varianceB.isInvariant
                                    && !typeArgumentA.isSubtypeOf(typeArgumentB)
                                || varianceB.isContravariant && varianceA.isInvariant
                                    && !typeArgumentB.isSubtypeOf(typeArgumentA)) {
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    }

    "The meet of two classes unrelated by inheritance, or of Null with an interface type
     is empty. The meet of an anonymous class with a type to which it is not assignable
     is empty."
    Boolean emptyMeet(variable Type a, variable Type b, Unit unit) {
        if (a.isExactlyNothing || b.isExactlyNothing) {
            return true;
        }

        if (a.isUnknown || b.isUnknown) {
            return false; // JV: I guess this is right?
        }

        if (a.isUnion) {
            return a.caseTypes.every((ct) => emptyMeet(b, ct, unit));
        }

        if (a.declaration.hasEnumeratedTypes
                && a.caseTypes.every((ct) => emptyMeet(b, ct, unit))) {
            return true;
        }

        if (b.isUnion) {
            return b.caseTypes.every((ct) => emptyMeet(a, ct, unit));
        }

        if (b.declaration.hasEnumeratedTypes
                && b.caseTypes.every((ct) => emptyMeet(a, ct, unit))) {
            return true;
        }

        if (a.isIntersection || a.declaration is TypeParameter) {
            return a.satisfiedTypes.any((st) => emptyMeet(b, st, unit));
        }

        if (b.isIntersection || b.declaration is TypeParameter) {
            return b.satisfiedTypes.any((st) => emptyMeet(a, st, unit));
        }

        assert (!is NothingDeclaration | UnionType | IntersectionType | Constructor
            | TypeAlias | TypeParameter| UnknownType aDeclaration = a.declaration);

        assert (!is NothingDeclaration | UnionType | IntersectionType | Constructor
            | TypeAlias | TypeParameter| UnknownType bDeclaration = b.declaration);

        if (a.isClass && b.isClass
                || a.isInterface && b.isNull
                || b.isInterface && a.isNull) {
            if (!aDeclaration.inherits(bDeclaration)
                    && !bDeclaration.inherits(aDeclaration)) {
                return true;
            }
        }

        if (aDeclaration.isFinal) {
            if (aDeclaration.typeParameters.empty
                    && !b.involvesTypeParameters
                    && !a.isSubtypeOf(b)) {
                return true;
            }
            if (b.isClassOrInterface
                    && !aDeclaration.inherits(bDeclaration)) {
                return true;
            }
        }

        value sequential = unit.sequentialDeclaration;
        if (        bDeclaration.inherits(sequential)
                && !aDeclaration.inherits(sequential)
                && !sequential.inherits(aDeclaration)
            ||      aDeclaration.inherits(sequential)
                && !bDeclaration.inherits(sequential)
                && !sequential.inherits(bDeclaration)) {
            return true;
        }

        // A non-empty sequence is disjoint from any other sequential if their element
        // types are disjoint.
        value sequence = unit.sequenceDeclaration;
        if (    aDeclaration.inherits(sequence) && bDeclaration.inherits(sequential)
             || bDeclaration.inherits(sequence) && aDeclaration.inherits(sequential)) {
            assert (exists elementA = unit.getSequentialElementType(a));
            assert (exists elementB = unit.getSequentialElementType(b));
            if (emptyMeet(elementA, elementB, unit)) {
                return true;
            }
        }

        value tuple = unit.tupleDeclaration;
        if (aDeclaration.inherits(tuple) && bDeclaration.inherits(tuple)) {
            value argsA = a.typeArgumentList.rest;
            value argsB = b.typeArgumentList.rest;
            if (anyPair<Type, Type>((x, y) => emptyMeet(x, y, unit), argsA, argsB)) {
                return true;
            }
        }

        if (aDeclaration.inherits(tuple) && bDeclaration.inherits(sequential)) {
            assert (exists arg1 = a.typeArgumentList.getFromFirst(1));
            assert (exists arg2 = a.typeArgumentList.getFromFirst(2));
            assert (exists type = unit.getSequentialElementType(b));
            if (emptyMeet(arg1, type, unit)
                    || emptyMeet(arg2, unit.getSequentialType(type), unit)) {
                return true;
            }
        }
        if (bDeclaration.inherits(tuple) && aDeclaration.inherits(sequential)) {
            assert (exists arg1 = b.typeArgumentList.getFromFirst(1));
            assert (exists arg2 = b.typeArgumentList.getFromFirst(2));
            assert (exists type = unit.getSequentialElementType(a));
            if (emptyMeet(arg1, type, unit)
                    || emptyMeet(arg2, unit.getSequentialType(type), unit)) {
                return true;
            }
        }

        return false;
    }

    // we have to resolve aliases here, or computing supertype declarations gets
    // incredibly slow for the big stack of union type aliases in ceylon.ast
    value ar = a.resolvedAliases;
    value br = b.resolvedAliases;

    if (isDisjointEnum(ar.declaration, br.declaration)) {
        return true;
    }

    return emptyMeet(ar, br, unit)
            || hasEmptyIntersectionOfInvariantInstantiations(ar, br);
}

"The intersection of the types inherited by this declaration. No need to worry
 about canonicalization because:

 1. an inherited type can't be a union, and
 2. they are prevented from being disjoint types."
shared
Type intersectionOfSupertypes
        (ClassOrInterface | TypeParameter typeDeclaration, Unit unit)
    =>  let (types = typeDeclaration.extendedAndSatisfiedTypes.sequence())
        if (!nonempty types)
        then unit.anythingDeclaration.type
        else IntersectionType(types, unit).type;

"Given two instantiations of the same type constructor, construct a principal
 instantiation that is a supertype of both. This is impossible in the following special
 cases:

 - an abstract class which does not obey the principal
   instantiation inheritance rule

 - an intersection between two instantiations of the
   same type where one argument is a type parameter

 Nevertheless, we give it our best shot!"
Type? principalInstantiation(
        TypeDeclaration typeDeclaration, Type first, Type second, Unit unit) {

    Type? principalQualifyingType {
        value qualifyingTypeA = first.qualifyingType;
        value qualifyingTypeB = second.qualifyingType;
        if (exists qualifyingTypeA, exists qualifyingTypeB) {
            value scope = typeDeclaration.container;
            if (is ClassOrInterface scope) { // TODO JV: why not just assert this?
                if (exists supertypeA = qualifyingTypeA.getSupertype(scope),
                    exists supertypeB = qualifyingTypeB.getSupertype(scope)) {
                    return principalInstantiation {
                        scope;
                        supertypeA;
                        supertypeB;
                        unit;
                    };
                }
            }
            else if (qualifyingTypeA.isExactly(qualifyingTypeB)) {
                // JV: when does this happen?
                return qualifyingTypeA;
            }
        }
        return null;
    }

    value varianceOverrides = HashMap<TypeParameter, Variance>();
    value arguments = ArrayList<Type>();

    for (typeParameter in typeDeclaration.typeParameters) {
        assert (exists firstArg = first.typeArguments[typeParameter]);
        assert (exists secondArg = second.typeArguments[typeParameter]);

        value firstVariance = first.variance(typeParameter);
        value secondVariance = second.variance(typeParameter);

        value parameterized
            =   firstArg.involvesTypeParameters
                    || secondArg.involvesTypeParameters;

        Type arg;
        switch (firstVariance)
        case (invariant) {
            switch (secondVariance)
            case (invariant) {
                if (firstArg.isExactly(secondArg)) {
                    arg = firstArg;
                }
                else if (parameterized) {
                    // type parameters that might represent equivalent types at runtime,
                    // irreconcilable instantiations
                    // TODO detect cases where we know for sure that the types are
                    //      disjoint because the type parameters only occur as type args
                    arg = unit.unknownType;
                }
                else {
                    // the type arguments are distinct, and the intersection is Nothing,
                    // so there is no reasonable principal instantiation

                    // Note: if typeDeclaration is a TypeParameter, it may not actually
                    // be invariant, and the principal instantiation may not be
                    // Nothing
                    return null;
                }
            }
            case (covariant) {
                if (firstArg.isSubtypeOf(secondArg)) {
                    arg = firstArg;
                }
                else if (parameterized) {
                    // irreconcilable instantiations
                    arg = unit.unknownType;
                }
                else {
                    // may not be Nothing for TPs
                    return null;
                }
            }
            case (contravariant) {
                if (secondArg.isSubtypeOf(firstArg)) {
                    arg = firstArg;
                }
                else if (parameterized) {
                    // irreconcilable instantiations
                    arg = unit.unknownType;
                }
                else {
                    return null;
                }
            }
        }
        case (covariant) {
            switch (secondVariance)
            case (invariant) {
                if (secondArg.isSubtypeOf(firstArg)) {
                    arg = secondArg;
                }
                else if (parameterized) {
                    // irreconcilable instantiations
                    arg = unit.unknownType;
                }
                else {
                    // may not be Nothing for TPs
                    return null;
                }
            }
            case (covariant) {
                arg = intersectionType(firstArg, secondArg, unit);
                if (!typeParameter.variance.isCovariant) {
                    varianceOverrides.put(typeParameter, covariant);
                }
            }
            case (contravariant) {
                // opposite variances
                // irreconcilable instantiations
                arg = unit.unknownType;
            }
        }
        case (contravariant) {
            switch (secondVariance)
            case (invariant) {
                if (firstArg.isSubtypeOf(secondArg)) {
                    arg = secondArg;
                }
                else if (parameterized) {
                   // irreconcilable instantiations
                   arg = unit.unknownType;
                }
                else {
                    // may not be Nothing for TPs
                    return null;
                }
            }
            case (covariant) {
                // opposite variances
                // irreconcilable instantiations
                arg = unit.unknownType;
            }
            case (contravariant) {
                arg = unionType(firstArg, secondArg, unit);
                if (!typeParameter.variance.isContravariant) {
                    varianceOverrides.put(typeParameter, contravariant);
                }
            }
        }
        arguments.add(arg);
    }

    return typeDeclaration.appliedType {
        principalQualifyingType;
        arguments;
        varianceOverrides;
    };
}

"Given a declaration, a list of type arguments to the declaration, and a receiving type,
 collect together all interesting type arguments. The resulting map  includes all type
 arguments from the receiving type and all its qualifying types. That's useful, because
 [[substitute]] works with a single aggregated map, and so for performance
 [[Type.substitute(Type)]] and [[Type.substitute(TypedReference)]] assume that the given
 type or reference holds such a single aggregated map."
Map<TypeParameter, Type> aggregateTypeArguments(
        "the receiving produced type of which the declaration is a member"
        Type? receivingType,
        "the declaration"
        Declaration declaration,
        "the type arguments for the declaration"
        {Type?*} typeArguments) {

    value result
        =   HashMap<TypeParameter, Type>();

    void aggregate(variable Type? dt, variable Declaration d) {
        while (exists current = dt) {
            assert (!is Null | IntersectionType | NothingDeclaration | TypeAlias
                        | TypeParameter | UnionType | UnknownType declaringType
                =   d.container);

            Type? aqt;
            switch (declaringType)
            case (is ClassOrInterface) {
                aqt = current.getSupertype(declaringType);
            }
            case (is FunctionOrValue | Constructor) {
                // Note: ceylon-model breaks for Constructors, but seems to work.
                // actually FunctionOrValueInterface in ceylon-model
                // take as-is
                aqt = dt;
            }
            case (is Package) {
                break;
            }
            if (!exists aqt) {
                break;
            }
            result.putAll(aqt.typeArguments);
            dt = aqt.qualifyingType;
            d = aqt.declaration;
        }
    }

    if (exists receivingType) {
        if (receivingType.isIntersection) {
            for (superType in receivingType.satisfiedTypes) {
                aggregate(superType, declaration);
            }
        }
        else {
            aggregate(receivingType, declaration);
        }
    }

    // include the passed-in type arguments
    value params
        =   if (is Generic declaration)
            then declaration.typeParameters else [];

    for (param->arg in zipEntries(params, typeArguments)) {
        if (exists arg) {
            result.put(param, arg);
        }
    }

    return result;
}

Type substitute(type, variance, substitutions, varianceOverrides, dedup = true) {
    Type type;
    "variance of the position in which the type occurs"
    Variance variance;
    Map<TypeParameter, Type> substitutions;
    Map<TypeParameter, Variance> varianceOverrides;

    // TODO compare with ceylon-model's use of addToUnion and addToIntersection
    "If true (the default), [[unionDeduped]] and [[intersectionDedupedCanonical]] will
     be used. Otherwise, [[union]] and [[canonicalIntersection]]."
    Boolean dedup;

    value unit = type.declaration.unit;

    Type unionOf({Type*} types)
        =>  if (dedup)
            then unionDeduped(types, unit)
            else union(types, unit);

    Type intersectionOf({Type*} types)
        =>  if (dedup)
            then intersectionDedupedCanonical(types, unit)
            else canonicalIntersection(types, unit);

    Type substitute(Type type, Variance variance) {

        function substitutedType(TypeDeclaration declaration)
            =>  let (qualifyingType
                    =   if (exists receiverType = type.qualifyingType)
                        then substitute(receiverType, variance)
                        else null)
                createType {
                    declaration = declaration;
                    qualifyingType = qualifyingType;
                    typeArguments
                        =   if (exists qualifyingType) then
                                aggregateTypeArguments {
                                    qualifyingType;
                                    declaration;
                                    type.typeArgumentList.map((t)
                                        =>  substitute(t, variance));
                                }
                            else
                                map(type.typeArguments.mapItems((parameter, argument)
                                    =>  substitute {
                                            argument;
                                            type.variance(parameter);
                                        }));
                    isTypeConstructor = type.isTypeConstructor;
                    typeConstructorParameter = type.typeConstructorParameter;
                    varianceOverrides = type.varianceOverrides;
                    // FIXME What is this????
                    //underlyingType = type.underlyingType;
                };

        Type substitutedAppliedTypeConstructor
                (Type sub, TypeParameter typeConstructorParameter) {

            Type substituteIntoTypeConstructors(Type sub, {Type*} args, Type tc)
                =>  nothing;

            return nothing;
        }

        Type substitutedTypeConstructor => nothing;

        TypeDeclaration dec;

        if (type.isUnion) {
            return unionOf(type.caseTypes.map((ct)
                =>  substitute(ct, variance)));
        }
        else if (type.isIntersection) {
            return intersectionOf(type.satisfiedTypes.map((st)
                =>  substitute(st, variance)));
        }
        else if (is TypeParameter typeDeclaration = type.declaration) {
            if (exists sub = substitutions[typeDeclaration]) {
                if (type.isTypeConstructor) {
                    // an unapplied generic type parameter (a type constructor parameter)
                    // in a higher-order abstraction - in this case, the argument itself
                    // must be an assignable type constructor
                    return sub;
                }
                else if (typeDeclaration.typeParameters.empty) {
                    // a regular type parameter. Easy; no type arguments or qualifying
                    // type to substitute
                    return sub;
                }
                else {
                    // an applied generic type parameter in a higher-order generic
                    // abstraction. In this case we need to substitute both the type
                    // constructor and its arguments
                    return substitutedAppliedTypeConstructor(sub, typeDeclaration);
                }
            }
            else {
                if (typeDeclaration.isTypeConstructor) {
                    // if this is an applied type constructor parameter, we still
                    // might need to substitute into its arguments!
                    dec = typeDeclaration;
                }
                else {
                    // a regular type parameter, easy, nothing more to do with it
                    return type;
                }
            }
        }
        else {
            dec = type.declaration;
        }
        if (type.isTypeConstructor) {
            // a type constructor occurring in a higher rank generic abstraction
            return substitutedTypeConstructor;
        }
        else {
            // a plain old type
            return substitutedType(dec);
        }
    }

    return substitute(type, variance);
}

Boolean isTypeArgumentListAssignable(Type supertype, Type type) {
    for (tp in type.declaration.typeParameters) {
        value supertypeArg = supertype.typeArguments[tp];
        value typeArg = type.typeArguments[tp];

        if (!supertypeArg exists || !typeArg exists) {
            return false;
        }
        assert (exists supertypeArg, exists typeArg);

        switch (type.variance(tp))
        case (covariant) {
            if (supertype.variance(tp).isContravariant) {
                //Inv<in T> is a subtype of Inv<out Anything>
                if (!tp.type.isSubtypeOf(typeArg)) {
                    return false;
                }
            }
            else if (!supertypeArg.isSubtypeOf(typeArg)) {
                return false;
            }
        }
        case (contravariant) {
            if (supertype.variance(tp).isCovariant) {
                //Inv<out T> is a subtype of Inv<in Nothing>
                if (!typeArg.isNothing) {
                    return false;
                }
            }
            else if (!typeArg.isSubtypeOf(supertypeArg)) {
                return false;
            }
        }
        case (invariant) {
            //Inv<out Nothing> is a subtype of Inv<Nothing>
            //Inv<in Anything> is a subtype of Inv<Anything>
            if (supertype.variance(tp).isCovariant && !supertypeArg.isNothing
                || supertype.variance(tp).isContravariant && !supertypeArg.isAnything
                || !supertypeArg.isExactly(typeArg)) {
                return false;
            }
        }
    }
    return true;
}
