import ceylon.test {
    test
}

shared
object values {

    shared test
    void simpleToplevelValues()
        =>  compileAndCompare2("values/simpleToplevelValues");
}
