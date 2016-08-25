import ceylon.test {
    test
}

shared
object qualifiedExpression {

    shared test
    void simpleQualifiedExpressions()
        =>  compileAndCompare("qualifiedExpression/simpleQualifiedExpressions");

    shared test
    void toplevelQualifiedExpressionWithCasting()
        =>  compileAndCompare("qualifiedExpression/simpleQualifiedExpressions");

    shared test
    void toplevelQualifiedExpressionWithoutCasting()
        =>  compileAndCompare("qualifiedExpression/toplevelQualifiedExpressionWithoutCasting");

    shared test
    void nullSafeMemberOperator()
        =>  compileAndCompare("qualifiedExpression/nullSafeMemberOperator");

    shared test
    void nullSafeMemberOperatorNoBoxing()
        =>  compileAndCompare("qualifiedExpression/nullSafeMemberOperatorNoBoxing");

    "Simple case: `foo()` is an inherited member, available through `this`."
    shared test
    void interfaceThisSharedMethod()
        =>  compileAndCompare("qualifiedExpression/interfaceThisSharedMethod");

    "Hard case: `foo()` is private and must be called statically, passing `this` as the
     first argument."
    shared test
    void interfaceThisUnsharedMethod()
        =>  compileAndCompare("qualifiedExpression/interfaceThisUnsharedMethod");

    shared test
    void interfaceSuperMethodInClass()
        =>  compileAndCompare("qualifiedExpression/interfaceSuperMethodInClass");

    shared test
    void interfaceSuperMethodInInterface()
        =>  compileAndCompare("qualifiedExpression/interfaceSuperMethodInInterface");

    shared test
    void interfaceOuterMethodInInterface()
        =>  compileAndCompare("qualifiedExpression/interfaceOuterMethodInInterface");

    shared test
    void interfaceOuterMethodInClass()
        =>  compileAndCompare("qualifiedExpression/interfaceOuterMethodInClass");

    shared test
    void refToClassInInterfaceInInterface()
        =>  compileAndCompare("qualifiedExpression/refToClassInInterfaceInInterface");

    shared test
    void eagerReceiverEvaluation()
        =>  compileAndCompare("qualifiedExpression/eagerReceiverEvaluation");

    shared test
    void refToSuperMethod()
        =>  compileAndCompare("qualifiedExpression/refToSuperMethod");

    shared test
    void nonStaticConstructorReference()
        =>  compileAndCompare("qualifiedExpression/nonStaticConstructorReference");

    shared test
    void staticToplevelConstructorReference()
        =>  compileAndCompare("qualifiedExpression/staticToplevelConstructorReference");
}
