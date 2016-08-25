import ceylon.test {
    test
}

shared
object assignment {

    shared test
    void assignExpressionNativeString()
        =>  compileAndCompare("assignment/assignExpressionNativeString");

    shared test
    void assignExpressionRhsCast()
        // TODO remove unnecessary cast; see generateAssignmentExpression comments
        =>  compileAndCompare("assignment/assignExpressionRhsCast");

    shared test
    void specificationWithThis()
        =>  compileAndCompare("assignment/specificationWithThis");
}