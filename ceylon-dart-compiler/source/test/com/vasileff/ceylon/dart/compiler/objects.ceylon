import ceylon.test {
    test
}

shared
object objects {

    shared test
    void simpleToplevelObject()
        =>  compileAndCompare("objects/simpleToplevelObject");

    shared test
    void shortcutRefinement()
        =>  compileAndCompare("objects/shortcutRefinement");

    shared test
    void bridgeMethods()
        =>  compileAndCompare("objects/bridgeMethods");

    shared test
    void simpleObjectInFunction()
        =>  compileAndCompare("objects/simpleObjectInFunction");

    shared test
    void simpleObjectInObject()
        =>  compileAndCompare("objects/simpleObjectInObject");

    shared test
    void multipleCaptures()
        =>  compileAndCompare("objects/multipleCaptures");

    shared test
    void outerForSupertypesSupertype()
        =>  compileAndCompare("objects/outerForSupertypesSupertype");

    "Replacement value from `assert` must be captured as class member."
    shared test
    void replacementDeclarationIsMember()
        =>  compileAndCompare("objects/replacementDeclarationIsMember");

    shared test
    void objectWithInitialization()
        =>  compileAndCompare("objects/objectWithInitialization");

    shared test
    void imports()
        =>  compileAndCompare("objects/imports");
}
