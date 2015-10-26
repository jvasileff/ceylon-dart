import ceylon.test {
    test
}

shared
object invocation {

    shared test
    void invokeClassInInterfaceInInterface()
        =>  compileAndCompare2("invocation/invokeClassInInterfaceInInterface");

    "This is a special case where the method cannot be invoked on $this."
    shared test
    void namedArgNonsharedInterfaceMethodBaseExpression()
        =>  compileAndCompare2("invocation/namedArgNonsharedInterfaceMethodBaseExpression");

    shared test
    void namedArgToplevelFunction()
        =>  compileAndCompare2("invocation/namedArgToplevelFunction");

    shared test
    void indirectWithSpreads()
        =>  compileAndCompare2("invocation/indirectWithSpreads");

    shared test
    void namedArgWithVariadic()
        =>  compileAndCompare2("invocation/namedArgWithVariadic");

    shared test
    void namedArgDefaultedIterables()
        =>  compileAndCompare2("invocation/namedArgDefaultedIterables");

    "Test for scenarios where the spread argument is *not* used for listed parameters."
    shared test
    void directWithSpreadSimple()
        =>  compileAndCompare2("invocation/directWithSpreadSimple");

    "Test for scenarios where the spread argument *is* used for listed parameters."
    shared test
    void directWithSpreadAdvanced()
        =>  compileAndCompare2("invocation/directWithSpreadAdvanced");

    shared test
    void directWithSpreadUnbounded()
        =>  compileAndCompare2("invocation/directWithSpreadUnbounded");

    shared test
    void directWithSpreadBoundedButUnknownLength()
        =>  compileAndCompare2("invocation/directWithSpreadBoundedButUnknownLength");

    shared test
    void spreadEmptyWithSideEffects()
        =>  compileAndCompare2("invocation/spreadEmptyWithSideEffects");
}
