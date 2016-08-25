import ceylon.test {
    test
}

shared
object tupleIterableComp {

    shared test
    void tupleExpressions()
        =>  compileAndCompare("tupleIterableComp/tupleExpressions");

    shared test
    void iterableExpressions()
        =>  compileAndCompare("tupleIterableComp/iterableExpressions");

    shared test
    void simpleComprehension()
        =>  compileAndCompare("tupleIterableComp/simpleComprehension");

    shared test
    void comprehensionCartesionIf()
        =>  compileAndCompare("tupleIterableComp/comprehensionCartesionIf");

    shared test
    void comprehensionCaptureTests()
        =>  compileAndCompare("tupleIterableComp/comprehensionCaptureTests");
}
