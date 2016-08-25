import ceylon.test {
    test
}

shared
object expression {

    shared test
    void genericComparable()
        =>  compileAndCompare("expression/genericComparable");

    shared test
    void addNumbers()
        =>  compileAndCompare("expression/addNumbers");

    shared test
    void boxIfElseExpression()
        =>  compileAndCompare("expression/boxIfElseExpression");

    shared test
    void letExpression()
        =>  compileAndCompare("expression/letExpression");

    shared test
    void letExpressionMultiple()
        =>  compileAndCompare("expression/letExpressionMultiple");

    shared test
    void elseOp()
        =>  compileAndCompare("expression/elseOp");

    shared test
    void elseOpGeneric()
        =>  compileAndCompare("expression/elseOpGeneric");

    shared test
    void elseOpPrimitive()
        =>  compileAndCompare("expression/elseOpPrimitive");

    shared test
    void elseOpPrimitiveGeneric()
        =>  compileAndCompare("expression/elseOpPrimitiveGeneric");

    shared test
    void elseOpDenotableLhs()
        =>  compileAndCompare("expression/elseOpDenotableLhs");

    shared test
    void assignmentExpressionCoercion()
        =>  compileAndCompare("expression/assignmentExpressionCoercion");

    shared test
    void spreadMethodsMemberClass()
        =>  compileAndCompare("expression/spreadMethodsMemberClass");

    shared test
    void spreadAttributes()
        =>  compileAndCompare("expression/spreadAttributes");

    shared test
    void spreadMethods()
        =>  compileAndCompare("expression/spreadMethods");
}
