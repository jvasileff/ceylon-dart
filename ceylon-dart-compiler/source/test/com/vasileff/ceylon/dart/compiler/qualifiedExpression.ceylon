import ceylon.test {
    test
}

shared
object qualifiedExpression {

    shared test
    void simpleQualifiedExpressions()
        =>  compileAndCompare2("qualifiedExpression/simpleQualifiedExpressions");

    shared test
    void toplevelQualifiedExpressionWithCasting()
        =>  compileAndCompare2("qualifiedExpression/simpleQualifiedExpressions");

    shared test
    void toplevelQualifiedExpressionWithoutCasting()
        =>  compileAndCompare2("qualifiedExpression/toplevelQualifiedExpressionWithoutCasting");

    shared test
    void nullSafeMemberOperator()
        =>  compileAndCompare2("qualifiedExpression/nullSafeMemberOperator");

    shared test
    void nullSafeMemberOperatorNoBoxing()
        =>  compileAndCompare2("qualifiedExpression/nullSafeMemberOperatorNoBoxing");

    "Simple case: `foo()` is an inherited member, available through `this`."
    shared test
    void interfaceThisSharedMethod()
        =>  compileAndCompare2("qualifiedExpression/interfaceThisSharedMethod");

    "Hard case: `foo()` is private and must be called statically, passing `this` as the
     first argument."
    shared test
    void interfaceThisUnsharedMethod()
        =>  compileAndCompare2("qualifiedExpression/interfaceThisUnsharedMethod");

    shared test
    void interfaceSuperMethodInClass()
        =>  compileAndCompare2("qualifiedExpression/interfaceSuperMethodInClass");

    shared test
    void interfaceSuperMethodInInterface()
        =>  compileAndCompare2("qualifiedExpression/interfaceSuperMethodInInterface");

    shared test
    void interfaceOuterMethodInInterface()
        =>  compileAndCompare2("qualifiedExpression/interfaceOuterMethodInInterface");

    shared test
    void interfaceOuterMethodInClass()
        =>  compileAndCompare2("qualifiedExpression/interfaceOuterMethodInClass");

    shared test
    void refToClassInInterfaceInInterface()
        =>  compileAndCompare2("qualifiedExpression/refToClassInInterfaceInInterface");

    shared test
    void eagerReceiverEvaluation()
        =>  compileAndCompare2("qualifiedExpression/eagerReceiverEvaluation");
}
