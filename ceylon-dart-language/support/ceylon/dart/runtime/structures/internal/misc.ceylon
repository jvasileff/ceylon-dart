shared Boolean eq(Anything a, Anything b)
    =>  if (exists a, exists b)
        then a == b
        else !a exists && !b exists;

shared interface Direction of forward | backward {}
shared object forward satisfies Direction {}
shared object backward satisfies Direction {}
