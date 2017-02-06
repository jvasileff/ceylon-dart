import ceylon.language.meta.model {
    ClosedType = Type
}

interface ModelHelper satisfies HasModelReference {
    shared ClosedType<>? container
        =>  if (exists qt = modelReference.qualifyingType)
            then newType(qt)
            else null;    
}
