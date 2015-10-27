import ceylon.test {
    test
}

shared
object mpl {

    shared test
    void toplevelMPL()
        =>  compileAndCompare2("mpl/toplevelMPL");

    shared test
    void toplevelMPLSC()
        =>  compileAndCompare2("mpl/toplevelMPLSC");

    shared test
    void nestedMPL()
        =>  compileAndCompare2("mpl/nestedMPL");

    shared test
    void nestedMPLSC()
        =>  compileAndCompare2("mpl/nestedMPLSC");

    shared test
    void expressionMPL()
        =>  compileAndCompare2("mpl/nestedMPLSC");

    shared test
    void expressionMPLSC()
        =>  compileAndCompare2("mpl/expressionMPLSC");

    shared test
    void withDefaults()
        =>  compileAndCompare2("mpl/withDefaults");

    shared test
    void manyLists()
        =>  compileAndCompare2("mpl/manyLists");
}
