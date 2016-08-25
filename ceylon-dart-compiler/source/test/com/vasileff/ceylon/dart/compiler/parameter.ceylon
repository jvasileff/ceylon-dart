import ceylon.test {
    test
}

shared
object parameter {
    shared test
    void parameterReference()
        =>  compileAndCompare("parameter/parameterReference");

    shared test
    void recursiveDefaultedCallableClass()
        =>  compileAndCompare("parameter/recursiveDefaultedCallableClass");

    shared test
    void recursiveNonSharedDefaultedCallableClass()
        =>  compileAndCompare("parameter/recursiveNonSharedDefaultedCallableClass");

    shared test
    void recursiveDefaultedCallableFunction()
        =>  compileAndCompare("parameter/recursiveDefaultedCallableFunction");

    shared test
    void callPriorDefaultedCallableParamClass()
        =>  compileAndCompare("parameter/callPriorDefaultedCallableParamClass");

    shared test
    void callPriorDefaultedCallableParamFunction()
        =>  compileAndCompare("parameter/callPriorDefaultedCallableParamFunction");

    shared test
    void callNonDefaultedCallableParamClass()
        =>  compileAndCompare("parameter/callNonDefaultedCallableParamClass");

    shared test
    void callPriorNonDefaultedCallableParamFunction()
        =>  compileAndCompare("parameter/callPriorNonDefaultedCallableParamFunction");

    shared test
    void callOuterSuperSharedCallableParam()
        =>  compileAndCompare("parameter/callOuterSuperSharedCallableParam");

    shared test
    void callOuterSuperNonSharedCallableParam()
        =>  compileAndCompare("parameter/callOuterSuperNonSharedCallableParam");

    shared test
    void recursiveDefaultCallableParameterDefault()
        =>  compileAndCompare("parameter/recursiveDefaultCallableParameterDefault");

    shared test
    void referenceToCallableParam()
        =>  compileAndCompare("parameter/referenceToCallableParam");

    shared test
    void referenceToCallableParamQE()
        =>  compileAndCompare("parameter/referenceToCallableParamQE");

    shared test
    void returnTypeErasureCallableParam()
        =>  compileAndCompare("parameter/returnTypeErasureCallableParam");

    shared test
    void superAndOuterCallableParam()
        =>  compileAndCompare("parameter/superAndOuterCallableParam");

    shared test
    void superAndOuterSharedCallableParam()
        =>  compileAndCompare("parameter/superAndOuterSharedCallableParam");

    shared test
    void staticInvocationOfCallableParam()
        =>  compileAndCompare("parameter/staticInvocationOfCallableParam");

    shared test
    void staticInvocationOfSharedCallableParam()
        =>  compileAndCompare("parameter/staticInvocationOfSharedCallableParam");

    shared test
    void callableParameterCallsPriorWithQE()
        =>  compileAndCompare("parameter/callableParameterCallsPriorWithQE");

    shared test
    void callableParamDefaultedByValueSpecification()
        =>  compileAndCompare("parameter/callableParamDefaultedByValueSpecification");
}
