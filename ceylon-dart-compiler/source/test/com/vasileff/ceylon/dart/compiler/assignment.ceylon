import ceylon.test {
    test
}

shared
object assignment {

    shared test
    void assignExpressionNativeString()
        =>  compileAndCompare2("assignment/assignExpressionNativeString");

    shared test
    void assignExpressionRhsCast()
        // TODO remove unnecessary cast; see generateAssignmentExpression comments
        =>  compileAndCompare2("assignment/assignExpressionRhsCast");

    shared test
    void specificationWithThis()
        =>  compileAndCompare2("assignment/specificationWithThis");

    shared test
    void correspondenceMutator()
            =>  compileAndCompare2("assignment/correspondenceMutator");
}