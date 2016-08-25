import ceylon.test {
    test
}

shared
object tryCatchFinally {

    shared test
    void destroyableResources()
        =>  compileAndCompare("tryCatchFinally/destroyableResources");

    shared test
    void obtainableResources()
        =>  compileAndCompare("tryCatchFinally/obtainableResources");
}
