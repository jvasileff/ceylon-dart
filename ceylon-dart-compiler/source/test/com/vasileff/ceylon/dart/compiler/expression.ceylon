import ceylon.test {
    test
}

shared
object expression {

    shared test
    void genericComparable()
        =>  compileAndCompare2("expression/genericComparable");

    shared test
    void addNumbers()
        =>  compileAndCompare2("expression/addNumbers");

    shared test
    void boxIfElseExpression()
        =>  compileAndCompare2("expression/boxIfElseExpression");

    shared test
    void letExpression()
        =>  compileAndCompare2("expression/letExpression");

    shared test
    void letExpressionMultiple()
        =>  compileAndCompare2("expression/letExpressionMultiple");

    shared test
    void elseOp()
        =>  compileAndCompare2("expression/elseOp");

    shared test
    void elseOpGeneric()
        =>  compileAndCompare2("expression/elseOpGeneric");

    shared test
    void elseOpPrimitive()
        =>  compileAndCompare2("expression/elseOpPrimitive");

    shared test
    void elseOpPrimitiveGeneric()
        =>  compileAndCompare2("expression/elseOpPrimitiveGeneric");

    shared test
    void elseOpDenotableLhs()
        =>  compileAndCompare2("expression/elseOpDenotableLhs");

    shared test
    void assignmentExpressionCoercion()
        =>  compileAndCompare2("expression/assignmentExpressionCoercion");
}
