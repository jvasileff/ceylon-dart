import ceylon.test {
    test
}

shared
object interfaces {

    shared test
    void simpleInterface()
        =>  compileAndCompare("interfaces/simpleInterface");

    shared test
    void formalFunctionsAndValues()
        =>  compileAndCompare("interfaces/formalFunctionsAndValues");

    shared test
    void defaultFunctionsAndValues()
        =>  compileAndCompare("interfaces/defaultFunctionsAndValues");

    shared test
    void simpleMemberInterface()
        =>  compileAndCompare("interfaces/simpleMemberInterface");

    shared test
    void simpleMemberMemberInterface()
        =>  compileAndCompare("interfaces/simpleMemberMemberInterface");

    shared test
    void nestedInterfaceFunctions()
        =>  compileAndCompare("interfaces/nestedInterfaceFunctions");

    shared test
    void nestedInterfaceValuesLazy()
        =>  compileAndCompare("interfaces/nestedInterfaceValuesLazy");

    shared test
    void nestedInterfaceValuesBlock()
        =>  compileAndCompare("interfaces/nestedInterfaceValuesBlock");

    shared test
    void nestedCombined()
        =>  compileAndCompare("interfaces/nestedCombined");

    shared test
    void simpleImplement()
        =>  compileAndCompare("interfaces/simpleImplement");

    shared test
    void implementAndOverrideFunctions()
        =>  compileAndCompare("interfaces/implementAndOverrideFunctions");

    shared test
    void implementAndOverrideValues()
        =>  compileAndCompare("interfaces/implementAndOverrideValues");

    shared test
    void outerWhenMemberSatisfiesContainer()
        =>  compileAndCompare("interfaces/outerWhenMemberSatisfiesContainer");

    shared test
    void superDisambiguation()
        // NOTE based on the JVM compiler, (super of Right2).fun should
        //      disambiguate to Right.fun, since Right2 doesn't override fun().
        =>  compileAndCompare("interfaces/superDisambiguation");

    shared test
    void simpleFunctionInterface()
        =>  compileAndCompare("interfaces/simpleFunctionInterface");

    shared test
    void captureAndAssert()
        =>  compileAndCompare("interfaces/captureAndAssert");

    shared test
    void captureAndAssertScopeVsContainer()
        /*
            This test demonstrates the difference between `scope.scope` and
            `scope.container`.

            For the `x` defined in (2) below, the declaration's `scope` and `container`
            are *both* `ConditionScope`. Presumably, `container` does not consider it to
            be a "fake" scope since it is necessary to distinguish the two `x`s.

            For the `y` defined in (3) below, the declaration's `scope` is a
            `ConditionScope`, but its `container` is a `Function`, skipping the so
            called "Fake" condition scope.

            `container` is used when generating identifiers for captures, even though it
            makes `y` and the second `x` appear to be in different scopes. `container`
            should work find, and it's the one we will usually use in other areas of the
            code. (Easier to just always use the same property).
         */
        =>  compileAndCompare("interfaces/captureAndAssertScopeVsContainer");

    shared test
    void captureAndControlBlocks()
        =>  compileAndCompare("interfaces/captureAndControlBlocks");

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInner()
        =>  compileAndCompare("interfaces/captureOnBehalfOfInner");

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInnerInner()
        =>  compileAndCompare("interfaces/captureOnBehalfOfInnerInner");

    "Don't bother capturing something already captured by a supertype."
    shared test
    void dontCaptureIfSupertypeCaptures()
        =>  compileAndCompare("interfaces/dontCaptureIfSupertypeCaptures");

    "Don't bother capturing something already captured by a supertype's supertype."
    shared test
    void dontCaptureIfSupertypeSupertypeCaptures()
        =>  compileAndCompare("interfaces/dontCaptureIfSupertypeSupertypeCaptures");

     "The outer type doesn't make the capture, but its supertype does."
    shared test
    void captureMadeByOutersSupertype()
        =>  compileAndCompare("interfaces/captureMadeByOutersSupertype");

    shared test
    void noFormalForPrivate()
        =>  compileAndCompare("interfaces/noFormalForPrivate");

    shared test
    void useOutermostOuter()
        =>  compileAndCompare("interfaces/useOutermostOuter");

    shared test
    void useOutermostOuter2()
        =>  compileAndCompare("interfaces/useOutermostOuter2");

    shared test
    void useOutermostOuter3()
        =>  compileAndCompare("interfaces/useOutermostOuter3");

    shared test
    void outerInterfaceSandwich()
        =>  compileAndCompare("interfaces/outerInterfaceSandwich");

    shared test
    void invokeLocalValue()
        =>  compileAndCompare("interfaces/invokeLocalValue");

    shared test
    void invokeLocalFunction()
        =>  compileAndCompare("interfaces/invokeLocalFunction");

    shared test
    void bridgeSetter()
        =>  compileAndCompare("interfaces/bridgeSetter");

    shared test
    void assignToSuperValues()
        =>  compileAndCompare("interfaces/assignToSuperValues");

    shared test
    void assignToNonSharedInterfaceValue()
        =>  compileAndCompare("interfaces/assignToNonSharedInterfaceValue");

    shared test
    void bridgeAssignmentExpression()
        =>  compileAndCompare("interfaces/bridgeAssignmentExpression");

    shared test
    void toplevelInterfaceAlias()
        =>  compileAndCompare("interfaces/toplevelInterfaceAlias");

    shared test
    void toplevelInterfaceAliasTypes()
        =>  compileAndCompare("interfaces/toplevelInterfaceAliasTypes");

    shared test
    void outerInvocationOfNonSharedMembers()
        =>  compileAndCompare("interfaces/outerInvocationOfNonSharedMembers");
}
