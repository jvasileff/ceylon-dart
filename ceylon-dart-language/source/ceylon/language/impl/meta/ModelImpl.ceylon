import ceylon.language.meta.model {
    AppliedType = Type
}

interface ModelHelper satisfies HasModelReference {
    shared AppliedType<>? container
        =>  if (exists qt = modelType.qualifyingType)
            then newType(qt)
            else null;    
}
