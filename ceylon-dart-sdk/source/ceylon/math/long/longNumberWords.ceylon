import ceylon.math.long.internal {
    LongImpl16, LongImpl64,
    realInts
}

Long longNumberOfWords(
            Integer w3, Integer w2,
            Integer w1, Integer w0)
    =>  if (realInts)
        then LongImpl64.ofWords(w3, w2, w1, w0)
        else LongImpl16.ofWords(w3, w2, w1, w0);
 
