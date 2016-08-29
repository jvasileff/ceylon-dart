import ceylon.test {
    test
}

shared
object clazz {

    shared test
    void simpleNestedClasses()
        =>  compileAndCompare("clazz/simpleNestedClasses");

    shared test
    void captureMembersDeclaredByAssert()
        =>  compileAndCompare("clazz/captureMembersDeclaredByAssert");

    shared test
    void memberClassInstantiation()
        =>  compileAndCompare("clazz/memberClassInstantiation");

    shared test
    void functionMemberClassInstantiation()
        =>  compileAndCompare("clazz/functionMemberClassInstantiation");

    shared test
    void functionMemberClassInstantiationCaptures()
        =>  compileAndCompare("clazz/functionMemberClassInstantiationCaptures");

    shared test
    void noBridgeForFormals()
        =>  compileAndCompare("clazz/noBridgeForFormals");

    shared test
    void capturedCallableParameter()
        =>  compileAndCompare("clazz/capturedCallableParameter");

    shared test
    void valueSpecificationShortcutRefinement()
        =>  compileAndCompare("clazz/valueSpecificationShortcutRefinement");

    shared test
    void variableReferences()
        =>  compileAndCompare("clazz/variableReferences");

    shared test
    void nonVariableReferences()
        =>  compileAndCompare("clazz/nonVariableReferences");

    shared test
    void nonVariableGetters()
        =>  compileAndCompare("clazz/nonVariableGetters");

    shared test
    void variableGetters()
        =>  compileAndCompare("clazz/variableGetters");

    shared test
    void referencesToNonReferences()
        =>  compileAndCompare("clazz/referencesToNonReferences");

    shared test
    void invokeClassMethodStatically()
        // This is very unoptimized.
        =>  compileAndCompare("clazz/invokeClassMethodStatically");

    shared test
    void invokeMemberClass()
        =>  compileAndCompare("clazz/invokeMemberClass");

    shared test
    void invokeMemberClassSafe()
        =>  compileAndCompare("clazz/invokeMemberClassSafe");

    shared test
    void outerReferenceTest()
        =>  compileAndCompare("clazz/outerReferenceTest");

    shared test
    void captureWithAnonymousClass()
        =>  compileAndCompare("clazz/captureWithAnonymousClass");

    shared test
    void defaultedParameter()
        =>  compileAndCompare("clazz/defaultedParameter");

    shared test
    void defaultedCallableParameter()
        =>  compileAndCompare("clazz/defaultedCallableParameter");

    shared test
    void defaultedWithCapture()
        =>  compileAndCompare("clazz/defaultedWithCapture");

    shared test
    void defaultedMemberWithCapture()
        =>  compileAndCompare("clazz/defaultedMemberWithCapture");

    shared test
    void capturedFunction()
        =>  compileAndCompare("clazz/capturedFunction");

    shared test
    void capturedGetter()
        =>  compileAndCompare("clazz/capturedGetter");

    shared test
    void constructorsCombined()
        =>  compileAndCompare("clazz/constructorsCombined");

    shared test
    void initializersCombined()
        =>  compileAndCompare("clazz/initializersCombined");

    shared test
    void outersWithSameDepth()
        =>  compileAndCompare("clazz/outersWithSameDepth");

    shared test
    void outersWithMixedDepth()
        =>  compileAndCompare("clazz/outersWithMixedDepth");

    shared test
    void outerAndCaptureInSuperInvocation()
        =>  compileAndCompare("clazz/outerAndCaptureInSuperInvocation");

    shared test
    void valueDeclarationInConstructor()
        =>  compileAndCompare("clazz/valueDeclarationInConstructor");

    shared test
    void functionDeclarationInConstructor()
        =>  compileAndCompare("clazz/functionDeclarationInConstructor");

    shared test
    void mappingsForString()
        =>  compileAndCompare("clazz/mappingsForString");

    shared test
    void mappingsForHash()
        =>  compileAndCompare("clazz/mappingsForHash");

    shared test
    void mappingsForNegated()
        =>  compileAndCompare("clazz/mappingsForNegated");

    shared test
    void mappedMembersAsParameters()
        =>  compileAndCompare("clazz/mappedMembersAsParameters");

    shared test
    void mappedMembersAsDeclarations()
        =>  compileAndCompare("clazz/mappedMembersAsDeclarations");

    shared test
    void superRefsMember()
        =>  compileAndCompare("clazz/superRefsMember");

    shared test
    void superRefsParam()
        =>  compileAndCompare("clazz/superRefsParam");

    shared test
    void toplevelClassAlias()
        =>  compileAndCompare("clazz/toplevelClassAlias");

    shared test
    void toplevelClassAliasDefaults()
        =>  compileAndCompare("clazz/toplevelClassAliasDefaults");

    shared test
    void toplevelClassAliasConstructors()
        =>  compileAndCompare("clazz/toplevelClassAliasConstructors");

    shared test
    void toplevelClassAliasRefs()
        =>  compileAndCompare("clazz/toplevelClassAliasRefs");

    shared test
    void toplevelClassAliasTypes()
        =>  compileAndCompare("clazz/toplevelClassAliasTypes");

    shared test
    void capturedByConstructor()
        =>  compileAndCompare("clazz/capturedByConstructor");

    shared test
    void forwardDeclaredValue()
        =>  compileAndCompare("clazz/forwardDeclaredValue");

    shared test
    void forwardDeclaredValueMapped()
        =>  compileAndCompare("clazz/forwardDeclaredValueMapped");

    shared test
    void capturedImplicitlyByInstantiation()
        =>  compileAndCompare("clazz/capturedImplicitlyByInstantiation");

    shared test
    void capturedImplicitlyByMemberClassAlias()
        =>  compileAndCompare("clazz/capturedImplicitlyByMemberClassAlias");

    shared test
    void capturedImplicitlyByMemberClassSuper()
        =>  compileAndCompare("clazz/capturedImplicitlyByMemberClassSuper");

    shared test
    void capturedImplicitlyByMemberClassSatisfied()
        =>  compileAndCompare("clazz/capturedImplicitlyByMemberClassSatisfied");

    shared test
    void superMemberClassInstantiations()
        =>  compileAndCompare("clazz/superMemberClassInstantiations");

    shared test
    void memberClassRefinement()
        =>  compileAndCompare("clazz/memberClassRefinement");

    shared test
    void memberClassAliases()
        =>  compileAndCompare("clazz/memberClassAliases");

    shared test
    void memberClassAliasesComplex()
        =>  compileAndCompare("clazz/memberClassAliasesComplex");

    shared test
    void extendConstructorAnotherClass()
        =>  compileAndCompare("clazz/extendConstructorAnotherClass");

    shared test
    void extendDefaultConstructor()
        =>  compileAndCompare("clazz/extendDefaultConstructor");

    shared test
    void extendConstructorWithDefaults()
        =>  compileAndCompare("clazz/extendConstructorWithDefaults");

    shared test
    void shortcutRefinementBySpecification()
        =>  compileAndCompare("clazz/shortcutRefinementBySpecification");

    shared test
    void extendNoArgConstructor()
        =>  compileAndCompare("clazz/extendNoArgConstructor");

    shared test
    void valueConstructorCaptureOwn()
        =>  compileAndCompare("clazz/valueConstructorCaptureOwn");

    shared test
    void valueConstructorInnerClass()
        =>  compileAndCompare("clazz/valueConstructorInnerClass");

    shared test
    void valueConstructorMemberClass()
        =>  compileAndCompare("clazz/valueConstructorMemberClass");

    shared test
    void valueConstructorStaticRef()
        =>  compileAndCompare("clazz/valueConstructorStaticRef");

    shared test
    void valueConstructorSwitch()
        =>  compileAndCompare("clazz/valueConstructorSwitch");

    shared test
    void valueConstructorToplevel()
        =>  compileAndCompare("clazz/valueConstructorToplevel");

    shared test
    void shortcutRefinementFunctionValue()
        =>  compileAndCompare("clazz/shortcutRefinementFunctionValue");

    shared test
    void shadowPrivateMember1()
        =>  compileAndCompare("clazz/shadowPrivateMember1");

    shared test
    void shadowPrivateMember2()
        =>  compileAndCompare("clazz/shadowPrivateMember2");

    shared test
    void shadowPrivateMember3()
        =>  compileAndCompare("clazz/shadowPrivateMember3");

    shared test
    void avoidPolymorphicPrivates1()
        =>  compileAndCompare("clazz/avoidPolymorphicPrivates1");

    shared test
    void avoidPolymorphicPrivates2()
        =>  compileAndCompare("clazz/avoidPolymorphicPrivates2");

    shared test
    void avoidPolymorphicPrivates3()
        =>  compileAndCompare("clazz/avoidPolymorphicPrivates3");

    shared test
    void elideBridgesIfPossible()
        =>  compileAndCompare("clazz/elideBridgesIfPossible");
}
