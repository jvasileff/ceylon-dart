import ceylon.test {
    test
}

shared
object invocation {

    shared test
    void invokeClassInInterfaceInInterface()
        =>  compileAndCompare("invocation/invokeClassInInterfaceInInterface");

    "This is a special case where the method cannot be invoked on $this."
    shared test
    void namedArgNonsharedInterfaceMethodBaseExpression()
        =>  compileAndCompare("invocation/namedArgNonsharedInterfaceMethodBaseExpression");

    shared test
    void namedArgToplevelFunction()
        =>  compileAndCompare("invocation/namedArgToplevelFunction");

    shared test
    void indirectWithSpreads()
        =>  compileAndCompare("invocation/indirectWithSpreads");

    shared test
    void namedArgWithVariadic()
        =>  compileAndCompare("invocation/namedArgWithVariadic");

    shared test
    void namedArgDefaultedIterables()
        =>  compileAndCompare("invocation/namedArgDefaultedIterables");

    "Test for scenarios where the spread argument is *not* used for listed parameters."
    shared test
    void directWithSpreadSimple()
        =>  compileAndCompare("invocation/directWithSpreadSimple");

    "Test for scenarios where the spread argument *is* used for listed parameters."
    shared test
    void directWithSpreadAdvanced()
        =>  compileAndCompare("invocation/directWithSpreadAdvanced");

    shared test
    void directWithSpreadUnbounded()
        =>  compileAndCompare("invocation/directWithSpreadUnbounded");

    shared test
    void directWithSpreadBoundedButUnknownLength()
        =>  compileAndCompare("invocation/directWithSpreadBoundedButUnknownLength");

    shared test
    void spreadEmptyWithSideEffects()
        =>  compileAndCompare("invocation/spreadEmptyWithSideEffects");
}
