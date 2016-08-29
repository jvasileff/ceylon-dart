import ceylon.test {
    test
}

shared
object assertIsNarrowing {

    shared test
    void narrowObjectToString()
        =>  compileAndCompare("assertIsNarrowing/narrowObjectToString");

    shared test
    void narrowDontShadow()
        // the narrowing doesn't affect the Dart type,
        // so a new variable declaration is not required
        =>  compileAndCompare("assertIsNarrowing/narrowDontShadow");

    shared test
    void useShadowAfterNarrowing()
        =>  compileAndCompare("assertIsNarrowing/useShadowAfterNarrowing");

    shared test
    void defineValueWithAssert()
        =>  compileAndCompare("assertIsNarrowing/defineValueWithAssert");

    shared test
    void narrowToGenericTypeWithErasure()
        // FIXME the (!(s != null)) test isn't great.
        //       When we find a type parameter, should we replace it with its
        //       constraints at least?
        =>  compileAndCompare("assertIsNarrowing/narrowToGenericTypeWithErasure");

    shared test
    void assertExists()
        =>  compileAndCompare("assertIsNarrowing/assertExists");

    shared test
    void assertNonempty()
        =>  compileAndCompare("assertIsNarrowing/assertNonempty");

    shared test
    void guardNarrowing()
        =>  compileAndCompare("assertIsNarrowing/guardNarrowing");

    shared test
    void nativeNarrowing()
        =>  compileAndCompare("assertIsNarrowing/nativeNarrowing");

    shared test
    void assertShadowing()
        =>  compileAndCompare("assertIsNarrowing/assertShadowing");
}
