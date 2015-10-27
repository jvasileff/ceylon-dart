import ceylon.test {
    test
}

shared
object getter {

    shared test
    void toplevelGetterLazy()
        =>  compileAndCompare2("getter/toplevelGetterLazy");

    shared test
    void toplevelGetterBlock()
        =>  compileAndCompare2("getter/toplevelGetterBlock");

    shared test
    void interfaceGetterLazy()
        =>  compileAndCompare2("getter/interfaceGetterLazy");

    shared test
    void interfaceGetterBlock()
        =>  compileAndCompare2("getter/interfaceGetterBlock");

    shared test
    void functionGetterLazy()
        =>  compileAndCompare2("getter/functionGetterLazy");

    shared test
    void functionGetterBlock()
        =>  compileAndCompare2("getter/functionGetterBlock");
}
