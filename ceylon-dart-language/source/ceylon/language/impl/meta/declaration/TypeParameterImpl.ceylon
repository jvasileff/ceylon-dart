import ceylon.language.meta.declaration {
    TypeParameter
}
import ceylon.dart.runtime.model {
    ModelTypeParameter = TypeParameter
}

class TypeParameterImpl(modelDeclaration)
        satisfies TypeParameter {

    shared ModelTypeParameter modelDeclaration;

    name => modelDeclaration.name;

    qualifiedName => modelDeclaration.qualifiedName;

    container => newNestableDeclaration(modelDeclaration.container);

    defaulted => modelDeclaration.defaultTypeArgument exists;

    defaultTypeArgument
        =>  if (exists defaultArgument = modelDeclaration.defaultTypeArgument)
            then newOpenType(defaultArgument)
            else null;

    variance => varianceFor(modelDeclaration.variance);

    satisfiedTypes => modelDeclaration.satisfiedTypes.collect(newOpenType);

    caseTypes => modelDeclaration.caseTypes.collect(newOpenType);

    // TODO
    string => modelDeclaration.string;

    equals(Object other)
        =>  if (is TypeParameterImpl other)
            then modelDeclaration == other.modelDeclaration
            else false;

    hash => modelDeclaration.hash;
}
