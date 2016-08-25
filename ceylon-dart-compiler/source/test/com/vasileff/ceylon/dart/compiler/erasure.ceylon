import ceylon.test {
    test
}

shared
object erasure {

    shared test
    void booleanFunctionReturn()
        =>  compileAndCompare("erasure/booleanFunctionReturn");

    shared test
    void integerFunctionReturn()
        =>  compileAndCompare("erasure/integerFunctionReturn");

    shared test
    void floatFunctionReturn()
        =>  compileAndCompare("erasure/floatFunctionReturn");

    shared test
    void stringFunctionReturn()
        =>  compileAndCompare("erasure/stringFunctionReturn");

    shared test
    void booleanArgument()
        =>  compileAndCompare("erasure/booleanArgument");

    shared test
    void genericNon()
        =>  compileAndCompare("erasure/genericNon");

    shared test
    void functionRefNon()
        =>  compileAndCompare("erasure/functionRefNon");

    shared test
    void dontEraseArgumentsToValue()
        =>  compileAndCompare("erasure/dontEraseArgumentsToValue");

    shared test
    void methodRefinementArgument()
        =>  compileAndCompare("erasure/methodRefinementArgument");

    shared test
    void shortcutRefinementParameter()
        =>  compileAndCompare("erasure/shortcutRefinementParameter");

    shared test
    void aliasEraseToObject()
        =>  compileAndCompare("erasure/aliasEraseToObject");
}
