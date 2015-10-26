import ceylon.test {
    test
}

shared
object forFail {

    shared test
    void iterableIsAString()
        =>  compileAndCompare2("forFail/iterableIsAString");

    shared test
    void iterableOfIntegers()
        =>  compileAndCompare2("forFail/iterableOfIntegers");

    shared test
    void iterableIsAUnion()
        =>  compileAndCompare2("forFail/iterableIsAUnion");

    shared test
    void iterableOfAUnion()
        =>  compileAndCompare2("forFail/iterableOfAUnion");

    shared test
    void iterableOfNulls()
        // Note: the iteration variable is of type Finished, of course!
        =>  compileAndCompare2("forFail/iterableOfNulls");
}
