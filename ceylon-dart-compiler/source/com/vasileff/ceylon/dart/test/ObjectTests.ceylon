import ceylon.test {
    test
}

shared
object objects {

    shared test
    void simpleToplevelObject()
        =>  compileAndCompare2("objects/simpleToplevelObject");

    shared test
    void shortcutRefinement()
        =>  compileAndCompare2("objects/shortcutRefinement");

    shared test
    void bridgeMethods()
        =>  compileAndCompare2("objects/bridgeMethods");

    shared test
    void simpleObjectInFunction()
        =>  compileAndCompare2("objects/simpleObjectInFunction");

    shared test
    void simpleObjectInObject()
        =>  compileAndCompare2("objects/simpleObjectInObject");

    shared test
    void multipleCaptures()
        =>  compileAndCompare2("objects/multipleCaptures");

    shared test
    void outerForSupertypesSupertype()
        =>  compileAndCompare2("objects/outerForSupertypesSupertype");

    "Replacement value from `assert` must be captured as class member."
    shared test
    void replacementDeclarationIsMember()
        =>  compileAndCompare2("objects/replacementDeclarationIsMember");

    shared test
    void objectWithInitialization()
        =>  compileAndCompare2("objects/objectWithInitialization");
}
