import ceylon.test {
    test
}

shared
object baseExpression {

    shared test
    void referenceToStringInitializer()
        =>  compileAndCompare("baseExpression/referenceToStringInitializer");

    shared test
    void referenceToIntegerInitializer()
        =>  compileAndCompare("baseExpression/referenceToIntegerInitializer");

    shared test
    void referenceToEntryInitializer()
        =>  compileAndCompare("baseExpression/referenceToEntryInitializer");

    shared test
    void packageQualifierToToplevelClass()
        =>  compileAndCompare("baseExpression/packageQualifierToToplevelClass");

    shared test
    void referenceToMemberClass()
        =>  compileAndCompare("baseExpression/referenceToMemberClass");

    shared test
    void referenceToInnerClassWithCapture()
        =>  compileAndCompare("baseExpression/referenceToInnerClassWithCapture");

    shared test
    void referenceToMemberClassTwoOuters()
        =>  compileAndCompare("baseExpression/referenceToMemberClassTwoOuters");

    shared test
    void membersWithCapture()
        =>  compileAndCompare("baseExpression/membersWithCapture");
}
