import ceylon.test {
    test
}

shared
object assertIsNarrowing {

    shared test
    void narrowObjectToString()
        =>  compileAndCompare2("assertIsNarrowing/narrowObjectToString");

    shared test
    void narrowDontShadow()
        // the narrowing doesn't affect the Dart type,
        // so a new variable declaration is not required
        =>  compileAndCompare2("assertIsNarrowing/narrowDontShadow");

    shared test
    void useShadowAfterNarrowing()
        =>  compileAndCompare2("assertIsNarrowing/useShadowAfterNarrowing");

    shared test
    void defineValueWithAssert()
        =>  compileAndCompare2("assertIsNarrowing/defineValueWithAssert");

    shared test
    void narrowToGenericTypeWithErasure()
        // FIXME the (!(s != null)) test isn't great.
        //       When we find a type parameter, should we replace it with its
        //       constraints at least?
        =>  compileAndCompare2("assertIsNarrowing/narrowToGenericTypeWithErasure");

    shared test
    void assertExists()
        =>  compileAndCompare2("assertIsNarrowing/assertExists");

    shared test
    void assertNonempty()
        =>  compileAndCompare2("assertIsNarrowing/assertNonempty");

    shared test
    void guardNarrowing()
        =>  compileAndCompare2("assertIsNarrowing/guardNarrowing");

    shared test
    void nativeNarrowing()
        =>  compileAndCompare2("assertIsNarrowing/nativeNarrowing");
}
