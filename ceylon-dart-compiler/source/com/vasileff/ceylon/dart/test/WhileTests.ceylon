import ceylon.test {
    test
}

shared
object whiles {

    shared test
    void simpleWhileLoop()
        =>  compileAndCompare2("whiles/simpleWhileLoop");

    shared test
    void isDeclareNewTest()
        =>  compileAndCompare2("whiles/isDeclareNewTest");

    shared test
    void isTestReplacement()
        =>  compileAndCompare2("whiles/isTestReplacement");

    shared test
    void isTestNoReplacement()
        =>  compileAndCompare2("whiles/isTestNoReplacement");

    shared test
    void existsTestNoReplacement()
        =>  compileAndCompare2("whiles/existsTestNoReplacement");
}
