import ceylon.test {
    test
}

shared
object switchCase {

    shared test
    void switchStmtMatch()
        =>  compileAndCompare("switchCase/switchStmtMatch");

    shared test
    void switchStmtIs()
        =>  compileAndCompare("switchCase/switchStmtIs");

    shared test
    void switchStmtIsNoElse()
        =>  compileAndCompare("switchCase/switchStmtIsNoElse");

    shared test
    void switchStmtVariableSpec()
        =>  compileAndCompare("switchCase/switchStmtVariableSpec");

    shared test
    void switchExprMatch()
        =>  compileAndCompare("switchCase/switchExprMatch");

    shared test
    void switchExprIs()
        =>  compileAndCompare("switchCase/switchExprIs");

    shared test
    void switchExprIsNoElse()
        =>  compileAndCompare("switchCase/switchExprIsNoElse");

    shared test
    void switchExprVariableSpec()
        =>  compileAndCompare("switchCase/switchExprVariableSpec");

    shared test
    void switchVariableShadowing()
        =>  compileAndCompare("switchCase/switchVariableShadowing");
}
