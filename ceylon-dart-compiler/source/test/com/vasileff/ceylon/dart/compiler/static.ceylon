import ceylon.test {
    test
}

shared
object static {

    shared test
    void classAlias()
        =>  compileAndCompare("static/classAlias");

    shared test
    void classes()
        =>  compileAndCompare("static/classes");

    shared test
    void constructors()
        =>  compileAndCompare("static/constructors");

    shared test
    void functionsAndValues()
        =>  compileAndCompare("static/functionsAndValues");

    shared test
    void interfaceAlias()
        =>  compileAndCompare("static/interfaceAlias");

    shared test
    void interfaces()
        =>  compileAndCompare("static/interfaces");

    shared test
    void objects()
        =>  compileAndCompare("static/objects");

    shared test
    void specifiedValuesVariablesSetters()
        =>  compileAndCompare("static/specifiedValuesVariablesSetters");

    shared test
    void typeAlias()
        =>  compileAndCompare("static/typeAlias");

    shared test
    void modules()
        =>  compileAndCompare("static/modules");

}
