import ceylon.language.meta.model {
    AppliedType = Type, TypeArgument
}
import ceylon.language.meta.declaration {
    TypeParameter
}

interface GenericHelper satisfies HasModelReference {

    shared
    AppliedType<>[] typeArgumentList
        =>  modelType.typeArguments.map(Entry.item).collect(newType);

    shared
    TypeArgument[] typeArgumentWithVarianceList
        =>  nothing;

    shared
    Map<TypeParameter, TypeArgument> typeArgumentWithVariances
        =>  nothing;

    shared Map<TypeParameter, AppliedType<>> typeArguments
        =>  nothing;    
}
