import ceylon.language.meta.model {
    ClosedType = Type
}

interface ModelHelper satisfies HasModelReference {
    shared ClosedType<>? container
        =>  if (exists qt = modelType.qualifyingType)
            then newType(qt)
            else null;    
}
