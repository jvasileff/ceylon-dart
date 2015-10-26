import ceylon.test {
    test
}

shared
object parameter {

    shared test
    void parameterReference()
        =>  compileAndCompare2("parameter/parameterReference");
}
