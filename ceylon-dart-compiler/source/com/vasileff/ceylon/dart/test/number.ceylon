import ceylon.test {
    test
}

shared
object number {

    shared test
    void simpleIntegerFloatWidening()
        =>  compileAndCompare2("number/simpleIntegerFloatWidening");
}
