import ceylon.test {
    test
}

shared
object forFail {

    shared test
    void iterableIsAString()
        =>  compileAndCompare("forFail/iterableIsAString");

    shared test
    void iterableOfIntegers()
        =>  compileAndCompare("forFail/iterableOfIntegers");

    shared test
    void iterableIsAUnion()
        =>  compileAndCompare("forFail/iterableIsAUnion");

    shared test
    void iterableOfAUnion()
        =>  compileAndCompare("forFail/iterableOfAUnion");

    shared test
    void iterableOfNulls()
        // Note: the iteration variable is of type Finished, of course!
        =>  compileAndCompare("forFail/iterableOfNulls");
}
