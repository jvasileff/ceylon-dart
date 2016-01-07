import ceylon.test {
    test
}

shared
object parameter {
    shared test
    void parameterReference()
        =>  compileAndCompare2("parameter/parameterReference");

    shared test
    void recursiveDefaultedCallableClass()
        =>  compileAndCompare2("parameter/recursiveDefaultedCallableClass");

    shared test
    void recursiveNonSharedDefaultedCallableClass()
        =>  compileAndCompare2("parameter/recursiveNonSharedDefaultedCallableClass");

    shared test
    void recursiveDefaultedCallableFunction()
        =>  compileAndCompare2("parameter/recursiveDefaultedCallableFunction");

    shared test
    void callPriorDefaultedCallableParamClass()
        =>  compileAndCompare2("parameter/callPriorDefaultedCallableParamClass");

    shared test
    void callPriorDefaultedCallableParamFunction()
        =>  compileAndCompare2("parameter/callPriorDefaultedCallableParamFunction");

    shared test
    void callNonDefaultedCallableParamClass()
        =>  compileAndCompare2("parameter/callNonDefaultedCallableParamClass");

    shared test
    void callPriorNonDefaultedCallableParamFunction()
        =>  compileAndCompare2("parameter/callPriorNonDefaultedCallableParamFunction");

    shared test
    void callOuterSuperSharedCallableParam()
        =>  compileAndCompare2("parameter/callOuterSuperSharedCallableParam");

    shared test
    void callOuterSuperNonSharedCallableParam()
        =>  compileAndCompare2("parameter/callOuterSuperNonSharedCallableParam");

    shared test
    void recursiveDefaultCallableParameterDefault()
        =>  compileAndCompare2("parameter/recursiveDefaultCallableParameterDefault");

    shared test
    void referenceToCallableParam()
        =>  compileAndCompare2("parameter/referenceToCallableParam");

    shared test
    void referenceToCallableParamQE()
        =>  compileAndCompare2("parameter/referenceToCallableParamQE");

    shared test
    void returnTypeErasureCallableParam()
        =>  compileAndCompare2("parameter/returnTypeErasureCallableParam");

    shared test
    void superAndOuterCallableParam()
        =>  compileAndCompare2("parameter/superAndOuterCallableParam");

    shared test
    void superAndOuterSharedCallableParam()
        =>  compileAndCompare2("parameter/superAndOuterSharedCallableParam");

    shared test
    void staticInvocationOfCallableParam()
        =>  compileAndCompare2("parameter/staticInvocationOfCallableParam");

    shared test
    void staticInvocationOfSharedCallableParam()
        =>  compileAndCompare2("parameter/staticInvocationOfSharedCallableParam");

    shared test
    void callableParameterCallsPriorWithQE()
        =>  compileAndCompare2("parameter/callableParameterCallsPriorWithQE");
}
