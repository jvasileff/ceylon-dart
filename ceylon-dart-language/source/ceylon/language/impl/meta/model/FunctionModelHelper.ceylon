import ceylon.language.meta.model {
    ClosedType = Type
}

interface FunctionModelHelper<out Type, in Arguments>
        satisfies GenericHelper
        given Arguments satisfies Anything[] {

    shared
    ClosedType<Type> type => `Type`;

    // Functional

    shared
    ClosedType<>[] parameterTypes {
        assert (is TypeImpl<Anything> t = `Arguments`);
        value tupleModel = t.modelReference;
        assert (exists modelArgs = tupleModel.unit.getTupleElementTypes(tupleModel));
        return modelArgs.collect(newType);
    }
}
