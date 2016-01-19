import ceylon.test {
    test
}

shared
object tryCatchFinally {

    shared test
    void destroyableResources()
        =>  compileAndCompare2("tryCatchFinally/destroyableResources");

    shared test
    void obtainableResources()
        =>  compileAndCompare2("tryCatchFinally/obtainableResources");
}
