import ceylon.test {
    test
}

shared
object interfaces {

    shared test
    void simpleInterface()
        =>  compileAndCompare2("interfaces/simpleInterface");

    shared test
    void formalFunctionsAndValues()
        =>  compileAndCompare2("interfaces/formalFunctionsAndValues");

    shared test
    void defaultFunctionsAndValues()
        =>  compileAndCompare2("interfaces/defaultFunctionsAndValues");

    shared test
    void simpleMemberInterface()
        =>  compileAndCompare2("interfaces/simpleMemberInterface");

    shared test
    void simpleMemberMemberInterface()
        =>  compileAndCompare2("interfaces/simpleMemberMemberInterface");

    shared test
    void nestedInterfaceFunctions()
        =>  compileAndCompare2("interfaces/nestedInterfaceFunctions");

    shared test
    void nestedInterfaceValuesLazy()
        =>  compileAndCompare2("interfaces/nestedInterfaceValuesLazy");

    shared test
    void nestedInterfaceValuesBlock()
        =>  compileAndCompare2("interfaces/nestedInterfaceValuesBlock");

    shared test
    void nestedCombined()
        =>  compileAndCompare2("interfaces/nestedCombined");

    shared test
    void simpleImplement()
        =>  compileAndCompare2("interfaces/simpleImplement");

    shared test
    void implementAndOverrideFunctions()
        =>  compileAndCompare2("interfaces/implementAndOverrideFunctions");

    shared test
    void implementAndOverrideValues()
        =>  compileAndCompare2("interfaces/implementAndOverrideValues");

    shared test
    void outerWhenMemberSatisfiesContainer()
        =>  compileAndCompare2("interfaces/outerWhenMemberSatisfiesContainer");

    shared test
    void superDisambiguation()
        // NOTE based on the JVM compiler, (super of Right2).fun should
        //      disambiguate to Right.fun, since Right2 doesn't override fun().
        =>  compileAndCompare2("interfaces/superDisambiguation");

    shared test
    void simpleFunctionInterface()
        =>  compileAndCompare2("interfaces/simpleFunctionInterface");

    shared test
    void captureAndAssert()
        =>  compileAndCompare2("interfaces/captureAndAssert");

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
        =>  compileAndCompare2("interfaces/captureAndAssertScopeVsContainer");

    shared test
    void captureAndControlBlocks()
        =>  compileAndCompare2("interfaces/captureAndControlBlocks");

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInner()
        =>  compileAndCompare2("interfaces/captureOnBehalfOfInner");

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInnerInner()
        =>  compileAndCompare2("interfaces/captureOnBehalfOfInnerInner");

    "Don't bother capturing something already captured by a supertype."
    shared test
    void dontCaptureIfSupertypeCaptures()
        =>  compileAndCompare2("interfaces/dontCaptureIfSupertypeCaptures");

    "Don't bother capturing something already captured by a supertype's supertype."
    shared test
    void dontCaptureIfSupertypeSupertypeCaptures()
        =>  compileAndCompare2("interfaces/dontCaptureIfSupertypeSupertypeCaptures");

     "The outer type doesn't make the capture, but its supertype does."
    shared test
    void captureMadeByOutersSupertype()
        =>  compileAndCompare2("interfaces/captureMadeByOutersSupertype");

    shared test
    void noFormalForPrivate()
        =>  compileAndCompare2("interfaces/noFormalForPrivate");

    shared test
    void useOutermostOuter()
        =>  compileAndCompare2("interfaces/useOutermostOuter");

    shared test
    void useOutermostOuter2()
        =>  compileAndCompare2("interfaces/useOutermostOuter2");

    shared test
    void useOutermostOuter3()
        =>  compileAndCompare2("interfaces/useOutermostOuter3");

    shared test
    void outerInterfaceSandwich()
        =>  compileAndCompare2("interfaces/outerInterfaceSandwich");

    shared test
    void invokeLocalValue()
        =>  compileAndCompare2("interfaces/invokeLocalValue");

    shared test
    void invokeLocalFunction()
        =>  compileAndCompare2("interfaces/invokeLocalFunction");

    shared test
    void bridgeSetter()
        =>  compileAndCompare2("interfaces/bridgeSetter");

    shared test
    void assignToSuperValues()
        =>  compileAndCompare2("interfaces/assignToSuperValues");

    shared test
    void assignToNonSharedInterfaceValue()
        =>  compileAndCompare2("interfaces/assignToNonSharedInterfaceValue");

    shared test
    void bridgeAssignmentExpression()
        =>  compileAndCompare2("interfaces/bridgeAssignmentExpression");
}
