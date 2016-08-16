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

    shared test
    void mappingsForString()
        =>  compileAndCompare2("clazz/mappingsForString");

    shared test
    void mappingsForHash()
        =>  compileAndCompare2("clazz/mappingsForHash");

    shared test
    void mappingsForNegated()
        =>  compileAndCompare2("clazz/mappingsForNegated");

    shared test
    void mappedMembersAsParameters()
        =>  compileAndCompare2("clazz/mappedMembersAsParameters");

    shared test
    void mappedMembersAsDeclarations()
        =>  compileAndCompare2("clazz/mappedMembersAsDeclarations");

    shared test
    void superRefsMember()
        =>  compileAndCompare2("clazz/superRefsMember");

    shared test
    void superRefsParam()
        =>  compileAndCompare2("clazz/superRefsParam");

    shared test
    void toplevelClassAlias()
        =>  compileAndCompare2("clazz/toplevelClassAlias");

    shared test
    void toplevelClassAliasDefaults()
        =>  compileAndCompare2("clazz/toplevelClassAliasDefaults");

    shared test
    void toplevelClassAliasConstructors()
        =>  compileAndCompare2("clazz/toplevelClassAliasConstructors");

    shared test
    void toplevelClassAliasRefs()
        =>  compileAndCompare2("clazz/toplevelClassAliasRefs");

    shared test
    void toplevelClassAliasTypes()
        =>  compileAndCompare2("clazz/toplevelClassAliasTypes");

    shared test
    void capturedByConstructor()
        =>  compileAndCompare2("clazz/capturedByConstructor");

    shared test
    void forwardDeclaredValue()
        =>  compileAndCompare2("clazz/forwardDeclaredValue");

    shared test
    void forwardDeclaredValueMapped()
        =>  compileAndCompare2("clazz/forwardDeclaredValueMapped");

    shared test
    void capturedImplicitlyByInstantiation()
        =>  compileAndCompare2("clazz/capturedImplicitlyByInstantiation");

    shared test
    void capturedImplicitlyByMemberClassAlias()
        =>  compileAndCompare2("clazz/capturedImplicitlyByMemberClassAlias");

    shared test
    void capturedImplicitlyByMemberClassSuper()
        =>  compileAndCompare2("clazz/capturedImplicitlyByMemberClassSuper");

    shared test
    void capturedImplicitlyByMemberClassSatisfied()
        =>  compileAndCompare2("clazz/capturedImplicitlyByMemberClassSatisfied");

    shared test
    void superMemberClassInstantiations()
        =>  compileAndCompare2("clazz/superMemberClassInstantiations");

    shared test
    void memberClassRefinement()
        =>  compileAndCompare2("clazz/memberClassRefinement");

    shared test
    void memberClassAliases()
        =>  compileAndCompare2("clazz/memberClassAliases");

    shared test
    void memberClassAliasesComplex()
        =>  compileAndCompare2("clazz/memberClassAliasesComplex");

    shared test
    void extendConstructorAnotherClass()
        =>  compileAndCompare2("clazz/extendConstructorAnotherClass");

    shared test
    void extendDefaultConstructor()
        =>  compileAndCompare2("clazz/extendDefaultConstructor");

    shared test
    void extendConstructorWithDefaults()
        =>  compileAndCompare2("clazz/extendConstructorWithDefaults");

    shared test
    void shortcutRefinementBySpecification()
        =>  compileAndCompare2("clazz/shortcutRefinementBySpecification");

    shared test
    void extendNoArgConstructor()
        =>  compileAndCompare2("clazz/extendNoArgConstructor");

    shared test
    void valueConstructorCaptureOwn()
        =>  compileAndCompare2("clazz/valueConstructorCaptureOwn");

    shared test
    void valueConstructorInnerClass()
        =>  compileAndCompare2("clazz/valueConstructorInnerClass");

    shared test
    void valueConstructorMemberClass()
        =>  compileAndCompare2("clazz/valueConstructorMemberClass");

    shared test
    void valueConstructorStaticRef()
        =>  compileAndCompare2("clazz/valueConstructorStaticRef");

    shared test
    void valueConstructorSwitch()
        =>  compileAndCompare2("clazz/valueConstructorSwitch");

    shared test
    void valueConstructorToplevel()
        =>  compileAndCompare2("clazz/valueConstructorToplevel");

    shared test
    void shortcutRefinementFunctionValue()
        =>  compileAndCompare2("clazz/shortcutRefinementFunctionValue");
}
