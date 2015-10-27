import ceylon.test {
    test
}

shared
object baseExpression {

    shared test
    void referenceToStringInitializer()
        =>  compileAndCompare2("baseExpression/referenceToStringInitializer");

    shared test
    void referenceToIntegerInitializer()
        =>  compileAndCompare2("baseExpression/referenceToIntegerInitializer");

    shared test
    void referenceToEntryInitializer()
        =>  compileAndCompare2("baseExpression/referenceToEntryInitializer");

    shared test
    void packageQualifierToToplevelClass()
        =>  compileAndCompare2("baseExpression/packageQualifierToToplevelClass");

    shared test
    void referenceToMemberClass()
        =>  compileAndCompare2("baseExpression/referenceToMemberClass");

    shared test
    void referenceToInnerClassWithCapture()
        =>  compileAndCompare2("baseExpression/referenceToInnerClassWithCapture");

    shared test
    void referenceToMemberClassTwoOuters()
        =>  compileAndCompare2("baseExpression/referenceToMemberClassTwoOuters");

    shared test
    void membersWithCapture()
        =>  compileAndCompare2("baseExpression/membersWithCapture");
}
