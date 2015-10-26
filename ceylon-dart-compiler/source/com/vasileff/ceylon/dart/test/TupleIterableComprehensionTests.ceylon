import ceylon.test {
    test
}

shared
object tupleIterableComp {

    shared test
    void tupleExpressions()
        =>  compileAndCompare2("tupleIterableComp/tupleExpressions");

    shared test
    void iterableExpressions()
        =>  compileAndCompare2("tupleIterableComp/iterableExpressions");

    shared test
    void simpleComprehension()
        =>  compileAndCompare2("tupleIterableComp/simpleComprehension");

    shared test
    void comprehensionCartesionIf()
        =>  compileAndCompare2("tupleIterableComp/comprehensionCartesionIf");

    shared test
    void comprehensionCaptureTests()
        =>  compileAndCompare2("tupleIterableComp/comprehensionCaptureTests");
}
