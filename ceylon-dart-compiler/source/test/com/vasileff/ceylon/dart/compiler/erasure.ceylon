import ceylon.test {
    test
}

shared
object erasure {

    shared test
    void booleanFunctionReturn()
        =>  compileAndCompare2("erasure/booleanFunctionReturn");

    shared test
    void integerFunctionReturn()
        =>  compileAndCompare2("erasure/integerFunctionReturn");

    shared test
    void floatFunctionReturn()
        =>  compileAndCompare2("erasure/floatFunctionReturn");

    shared test
    void stringFunctionReturn()
        =>  compileAndCompare2("erasure/stringFunctionReturn");

    shared test
    void booleanArgument()
        =>  compileAndCompare2("erasure/booleanArgument");

    shared test
    void genericNon()
        =>  compileAndCompare2("erasure/genericNon");

    shared test
    void functionRefNon()
        =>  compileAndCompare2("erasure/functionRefNon");

    shared test
    void dontEraseArgumentsToValue()
        =>  compileAndCompare2("erasure/dontEraseArgumentsToValue");

    shared test
    void methodRefinementArgument()
        =>  compileAndCompare2("erasure/methodRefinementArgument");

    shared test
    void shortcutRefinementParameter()
        =>  compileAndCompare2("erasure/shortcutRefinementParameter");

    shared test
    void aliasEraseToObject()
        =>  compileAndCompare2("erasure/aliasEraseToObject");
}
