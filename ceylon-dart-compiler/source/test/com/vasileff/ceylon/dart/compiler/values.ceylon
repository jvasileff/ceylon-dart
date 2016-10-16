import ceylon.test {
    test
}

shared
object values {

    shared test
    void simpleToplevelValues()
        =>  compileAndCompare("values/simpleToplevelValues");

    shared test
    void toplevelLateValues()
        =>  compileAndCompare("values/toplevelLateValues");
}
