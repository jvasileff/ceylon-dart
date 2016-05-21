import ceylon.meta.declaration {
    Variance
}
import ceylon.meta.model {
    ClosedType=Type
}
"A tuple representing a type argument and its use-site variance."
shared alias TypeArgument => [ClosedType<>,Variance];
