import ceylon.test {
    test
}

shared
object whiles {

    shared test
    void simpleWhileLoop()
        =>  compileAndCompare("whiles/simpleWhileLoop");

    shared test
    void isDeclareNewTest()
        =>  compileAndCompare("whiles/isDeclareNewTest");

    shared test
    void isTestReplacement()
        =>  compileAndCompare("whiles/isTestReplacement");

    shared test
    void isTestNoReplacement()
        =>  compileAndCompare("whiles/isTestNoReplacement");

    shared test
    void existsTestNoReplacement()
        =>  compileAndCompare("whiles/existsTestNoReplacement");
}
