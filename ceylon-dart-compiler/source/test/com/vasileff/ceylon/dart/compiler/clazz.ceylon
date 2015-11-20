import ceylon.test {
    test
}

shared
object clazz {

    shared test
    void simpleNestedClasses()
        =>  compileAndCompare2("clazz/simpleNestedClasses");

    shared test
    void captureMembersDeclaredByAssert()
        =>  compileAndCompare2("clazz/captureMembersDeclaredByAssert");

    shared test
    void memberClassInstantiation()
        =>  compileAndCompare2("clazz/memberClassInstantiation");

    shared test
    void functionMemberClassInstantiation()
        =>  compileAndCompare2("clazz/functionMemberClassInstantiation");

    shared test
    void functionMemberClassInstantiationCaptures()
        =>  compileAndCompare2("clazz/functionMemberClassInstantiationCaptures");

    shared test
    void noBridgeForFormals()
        =>  compileAndCompare2("clazz/noBridgeForFormals");

    shared test
    void capturedCallableParameter()
        =>  compileAndCompare2("clazz/capturedCallableParameter");

    shared test
    void valueSpecificationShortcutRefinement()
        =>  compileAndCompare2("clazz/valueSpecificationShortcutRefinement");

    shared test
    void variableReferences()
        =>  compileAndCompare2("clazz/variableReferences");

    shared test
    void nonVariableReferences()
        =>  compileAndCompare2("clazz/nonVariableReferences");

    shared test
    void nonVariableGetters()
        // TODO LazySpecifications that are not shortcut refinements
        //      are not yet supported.
        //shared String c5;
        //c5 => "c5-1";
        =>  compileAndCompare2("clazz/nonVariableGetters");

    shared test
    void variableGetters()
        =>  compileAndCompare2("clazz/variableGetters");

    shared test
    void referencesToNonReferences()
        =>  compileAndCompare2("clazz/referencesToNonReferences");

    shared test
    void invokeClassMethodStatically()
        // This is very unoptimized.
        =>  compileAndCompare2("clazz/invokeClassMethodStatically");

    shared test
    void invokeMemberClass()
        =>  compileAndCompare2("clazz/invokeMemberClass");

    shared test
    void invokeMemberClassSafe()
        =>  compileAndCompare2("clazz/invokeMemberClassSafe");

    shared test
    void outerReferenceTest()
        =>  compileAndCompare2("clazz/outerReferenceTest");

    shared test
    void captureWithAnonymousClass()
        =>  compileAndCompare2("clazz/captureWithAnonymousClass");

    shared test
    void defaultedParameter()
        =>  compileAndCompare2("clazz/defaultedParameter");

    shared test
    void defaultedCallableParameter()
        // TODO this has an ugly cast `this._$f as $ceylon$language.Callable`
        =>  compileAndCompare2("clazz/defaultedCallableParameter");

    shared test
    void defaultedWithCapture()
        =>  compileAndCompare2("clazz/defaultedWithCapture");

    shared test
    void defaultedMemberWithCapture()
        =>  compileAndCompare2("clazz/defaultedMemberWithCapture");

    shared test
    void capturedFunction()
        =>  compileAndCompare2("clazz/capturedFunction");

    shared test
    void capturedGetter()
        =>  compileAndCompare2("clazz/capturedGetter");

    shared test
    void constructorsCombined()
        =>  compileAndCompare2("clazz/constructorsCombined");

    shared test
    void initializersCombined()
        =>  compileAndCompare2("clazz/initializersCombined");

    shared test
    void outersWithSameDepth()
        =>  compileAndCompare2("clazz/outersWithSameDepth");

    shared test
    void outersWithMixedDepth()
        =>  compileAndCompare2("clazz/outersWithMixedDepth");

    shared test
    void outerAndCaptureInSuperInvocation()
        =>  compileAndCompare2("clazz/outerAndCaptureInSuperInvocation");

    shared test
    void valueDeclarationInConstructor()
        =>  compileAndCompare2("clazz/valueDeclarationInConstructor");

    shared test
    void functionDeclarationInConstructor()
        =>  compileAndCompare2("clazz/functionDeclarationInConstructor");
}
