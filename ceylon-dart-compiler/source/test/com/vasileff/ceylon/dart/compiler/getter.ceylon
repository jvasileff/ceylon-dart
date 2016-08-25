import ceylon.test {
    test
}

shared
object getter {

    shared test
    void toplevelGetterLazy()
        =>  compileAndCompare("getter/toplevelGetterLazy");

    shared test
    void toplevelGetterBlock()
        =>  compileAndCompare("getter/toplevelGetterBlock");

    shared test
    void interfaceGetterLazy()
        =>  compileAndCompare("getter/interfaceGetterLazy");

    shared test
    void interfaceGetterBlock()
        =>  compileAndCompare("getter/interfaceGetterBlock");

    shared test
    void functionGetterLazy()
        =>  compileAndCompare("getter/functionGetterLazy");

    shared test
    void functionGetterBlock()
        =>  compileAndCompare("getter/functionGetterBlock");
}
