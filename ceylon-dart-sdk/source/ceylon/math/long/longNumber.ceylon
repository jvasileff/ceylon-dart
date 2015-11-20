import ceylon.math.long.internal {
    LongImpl16, LongImpl64, realInts
}

shared
Long longNumber(Integer number)
    =>  if (realInts)
        then LongImpl64.ofInteger(number)
        else LongImpl16.ofInteger(number);
