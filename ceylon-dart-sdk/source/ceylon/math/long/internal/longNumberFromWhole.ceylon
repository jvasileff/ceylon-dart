import ceylon.math.long {
    Long
}
import ceylon.math.long.internal {
    LongImpl16
}
import ceylon.math.whole {
    Whole
}

shared
Long longNumberFromWhole(Whole whole)
    =>  if (realInts)
        then LongImpl64.ofInteger(whole.integer)
        else LongImpl16.ofWhole(whole);
