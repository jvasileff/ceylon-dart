import ceylon.test {
    test
}

shared
object switchCase {

    shared test
    void switchStmtMatch()
        =>  compileAndCompare2("switchCase/switchStmtMatch");

    shared test
    void switchStmtIs()
        =>  compileAndCompare2("switchCase/switchStmtIs");

    shared test
    void switchStmtIsNoElse()
        =>  compileAndCompare2("switchCase/switchStmtIsNoElse");

    shared test
    void switchStmtVariableSpec()
        =>  compileAndCompare2("switchCase/switchStmtVariableSpec");

    shared test
    void switchExprMatch()
        =>  compileAndCompare2("switchCase/switchExprMatch");

    shared test
    void switchExprIs()
        =>  compileAndCompare2("switchCase/switchExprIs");

    shared test
    void switchExprIsNoElse()
        =>  compileAndCompare2("switchCase/switchExprIsNoElse");

    shared test
    void switchExprVariableSpec()
        =>  compileAndCompare2("switchCase/switchExprVariableSpec");
}
