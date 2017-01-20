import ceylon.language.meta.declaration {
    Variance, invariant, covariant, contravariant,
    NestableDeclaration,
    ClassOrInterfaceDeclaration,
    ClassDeclaration,
    InterfaceDeclaration,
    TypeParameter,
    OpenType,
    OpenInterfaceType,
    OpenClassType,
    Declaration,
    ClassWithConstructorsDeclaration,
    ClassWithInitializerDeclaration
}
import ceylon.dart.runtime.model {
    ModelVariance = Variance,
    modelInvariant = invariant,
    modelCovariant = covariant,
    modelContravariant = contravariant,
    ModelType = Type,
    ModelTypeParameter = TypeParameter,
    ModelDeclaration = Declaration,
    ModelClassOrInterface = ClassOrInterface,
    ModelClass = Class,
    ModelClassWithInitializer = ClassWithInitializer,
    ModelClassWithConstructors = ClassWithConstructors,
    ModelClassAlias = ClassAlias,
    ModelInterface = Interface,
    ModelGeneric = Generic,
    argumentSatisfiesEnumeratedConstraint
}
import ceylon.language {
    AnnotationType=Annotation
}
import ceylon.language.meta.model {
    ClosedType = Type,
    Member,
    ClassOrInterface,
    IncompatibleTypeException,
    TypeApplicationException
}
import ceylon.language.impl.meta.model {
    modelTypeFromType,
    newType
}

shared
ModelClassWithConstructors modelFromClassWithConstructorsDeclaration
        (ClassWithConstructorsDeclaration d) {
    assert (is ClassWithConstructorsDeclarationImpl d);
    return d.modelDeclaration;
}

shared
ModelClassWithInitializer | ModelClassAlias modelFromClassWithInitializerDeclaration
        (ClassWithInitializerDeclaration d) {
    assert (is ClassWithInitializerDeclarationImpl d);
    return d.modelDeclaration;
}

shared
ModelClass modelFromClassDeclaration(ClassDeclaration d)
    =>  switch (d)
        case (is ClassWithInitializerDeclaration)
            modelFromClassWithInitializerDeclaration(d)
        case (is ClassWithConstructorsDeclaration)
            modelFromClassWithConstructorsDeclaration(d);

shared
ModelInterface modelFromInterfaceDeclaration(InterfaceDeclaration d) {
    assert (is InterfaceDeclarationImpl d);
    return d.modelDeclaration;
}

shared
ModelClassOrInterface modelFromClassOrInterfaceDeclaration(ClassOrInterfaceDeclaration d)
    =>  switch (d)
        case (is ClassDeclaration) modelFromClassDeclaration(d)
        case (is InterfaceDeclaration) modelFromInterfaceDeclaration(d);

Variance | Absent varianceFor<Absent = Nothing>(ModelVariance | Absent variance)
        given Absent satisfies Null
    =>  switch (variance)
        case (modelInvariant) invariant
        case (modelCovariant) covariant
        case (modelContravariant) contravariant
        case (is Null) variance;

ModelType getQualifyingSupertypeOrThrow(
        ModelType receiver,
        ModelDeclaration member) {
    // Validate and use correct supertype for the container
    // https://github.com/ceylon/ceylon/issues/5312
    value container = member.container;
    if (!is ModelClassOrInterface container) {
        throw IncompatibleTypeException(
            "Declaration container is not a type: ``container``");
    }
    value st = receiver.getSupertype(container);
    if (!exists st) {
        throw IncompatibleTypeException(
            "Invalid container type: ``receiver`` is not a subtype of \
             ``container``");
    }
    return st;
}

void validateTypeArgumentsOrThrow(
        ModelType? receiver,
        ModelDeclaration member,
        [ModelType*] typeArguments) {

    if (!is ModelGeneric member) {
        if (!typeArguments.empty) {
            throw TypeApplicationException("Declaration does not accept type arguments");
        }
        return;
    }

    value typeParameters = member.typeParameters.sequence();
    value defaulted = typeParameters.count(ModelTypeParameter.isDefaulted);

    if (typeParameters.size < typeArguments.size) {
        throw TypeApplicationException(
            "Too many type arguments provided: ``typeArguments.size``, but only \
             accepts ``typeParameters.size``");
    }

    if (typeArguments.size < typeParameters.size - defaulted) {
        value requires = defaulted.zero then "exactly" else "at least";
        throw TypeApplicationException(
            "Not enough type arguments provided: ``typeArguments.size``, but requires \
             ``requires`` ``typeParameters.size - defaulted``");
    }

    for (i->[typeArgument, typeParameter]
            in zipPairs(typeArguments, typeParameters).indexed) {
        for (upperBound in typeParameter.satisfiedTypes) {
            value appliedUpperbound
                =   upperBound.appliedType {
                        receiver;
                        member;
                        typeArguments;
                        [];
                    };

            if (!typeArgument.isSubtypeOf(appliedUpperbound)) {
                throw TypeApplicationException(
                        "Type argument ``i``: ``typeArgument.formatted`` \
                         does not conform to upper bound constraint: \
                         ``appliedUpperbound.formatted`` \
                         of type parameter ``typeParameter.name``");
            }
        }

        if (!argumentSatisfiesEnumeratedConstraint(receiver, member,
                    typeArguments, typeParameter, typeArgument)) {
            throw TypeApplicationException(
                    "Type argument ``i``: ``typeArgument.formatted`` \
                        does not conform to enumerated constraints \
                        of type parameter ``typeParameter.name``");
        }
    }
}
