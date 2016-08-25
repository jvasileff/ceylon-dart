import ceylon.test {
    test
}

shared
object functions {

    shared test
    void voidFunction()
        =>  compileAndCompare("functions/voidFunction");

    shared test
    void anonymousFunction()
        =>  compileAndCompare("functions/anonymousFunction");

    shared test
    void functionReturnBoxing()
        =>  compileAndCompare("functions/functionReturnBoxing");

    shared test
    void nestedFunction()
        =>  compileAndCompare("functions/nestedFunction");

    shared test
    void functionReference()
        =>  compileAndCompare("functions/functionReference");

    shared test
    void functionDefaultedParameters()
        =>  compileAndCompare("functions/functionDefaultedParameters");

    shared test
    void functionDefaultedParameters2()
        =>  compileAndCompare("functions/functionDefaultedParameters2");

    shared test
    void functionDefaultedBoolean()
        =>  compileAndCompare("functions/functionDefaultedBoolean");

    shared test
    void functionDefaultedFloat()
        =>  compileAndCompare("functions/functionDefaultedFloat");

    "Return and parameter types of callable parameters should not be erased to native.
     Otherwise, boxing/unboxing wrapper functions would be necessary when generating
     Callables to hold them."
    shared test
    void dontEraseForCallableParameters()
        =>  compileAndCompare("functions/dontEraseForCallableParameters");

    shared test
    void useBlocksVoidFunctions()
        =>  compileAndCompare("functions/useBlocksVoidFunctions");

    shared test
    void forwardDeclaredSimple()
        =>  compileAndCompare("functions/forwardDeclaredSimple");

    shared test
    void forwardDeclaredCurried()
        =>  compileAndCompare("functions/forwardDeclaredCurried");

    shared test
    void forwardDeclaredCurriedSideEffects()
        =>  compileAndCompare("functions/forwardDeclaredCurriedSideEffects");

    shared test
    void forwardDeclaredMember()
        =>  compileAndCompare("functions/forwardDeclaredMember");

    shared test
    void forwardDeclaredVoid()
        =>  compileAndCompare("functions/forwardDeclaredVoid");

    shared test
    void forwardDeclaredDefaultArg()
        =>  compileAndCompare("functions/forwardDeclaredDefaultArg");

    shared test
    void forwardDeclaredValue()
        =>  compileAndCompare("functions/forwardDeclaredValue");

    shared test
    void forwardDeclaredFunctionValue()
        =>  compileAndCompare("functions/forwardDeclaredFunctionValue");
}
