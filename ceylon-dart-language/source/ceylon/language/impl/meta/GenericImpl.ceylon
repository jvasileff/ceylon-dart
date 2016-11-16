import ceylon.language.meta.model {
    ClosedType = Type, TypeArgument
}
import ceylon.language.meta.declaration {
    TypeParameter
}

interface GenericHelper satisfies HasModelReference {

    shared
    ClosedType<>[] typeArgumentList
        =>  modelType.typeArguments.map(Entry.item).collect(newType);

    shared
    TypeArgument[] typeArgumentWithVarianceList
        =>  nothing;

    shared
    Map<TypeParameter, TypeArgument> typeArgumentWithVariances
        =>  nothing;

    shared Map<TypeParameter, ClosedType<>> typeArguments
        =>  nothing;    
}
