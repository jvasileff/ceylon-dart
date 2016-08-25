import ceylon.test {
    test
}

shared
object mpl {

    shared test
    void toplevelMPL()
        =>  compileAndCompare("mpl/toplevelMPL");

    shared test
    void toplevelMPLSC()
        =>  compileAndCompare("mpl/toplevelMPLSC");

    shared test
    void nestedMPL()
        =>  compileAndCompare("mpl/nestedMPL");

    shared test
    void nestedMPLSC()
        =>  compileAndCompare("mpl/nestedMPLSC");

    shared test
    void expressionMPL()
        =>  compileAndCompare("mpl/nestedMPLSC");

    shared test
    void expressionMPLSC()
        =>  compileAndCompare("mpl/expressionMPLSC");

    shared test
    void withDefaults()
        =>  compileAndCompare("mpl/withDefaults");

    shared test
    void manyLists()
        =>  compileAndCompare("mpl/manyLists");
}
