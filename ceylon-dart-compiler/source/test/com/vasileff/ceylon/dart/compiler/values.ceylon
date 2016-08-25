import ceylon.test {
    test
}

shared
object values {

    shared test
    void simpleToplevelValues()
        =>  compileAndCompare("values/simpleToplevelValues");
}
