import ceylon.test {
    test,
    ignore
}

shared
class InterfaceTests() {

    shared test
    void simpleInterface() {
        compileAndCompare {
             """
                interface I {
                    shared formal String fun();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String fun();
                }
             """;
        };
    }

    shared test
    void formalFunctionsAndValues() {
        compileAndCompare {
             """
                interface I {
                    shared formal void f1();
                    shared formal String f2();
                    shared formal String f3(String a, String b);
                    shared formal String v1;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    void f1();
                    $dart$core.String f2();
                    $dart$core.String f3([$dart$core.String a, $dart$core.String b]);
                    $dart$core.String get v1;
                }
             """;
        };
    }

    shared test
    void defaultFunctionsAndValues() {
        compileAndCompare {
             """
                interface I {
                    shared default void f1() {}
                    shared default void f2() => print("");
                    shared default String f3() { return ""; }
                    shared default String f4() => "";
                    shared default String f5(String a, String b) { return ""; }
                    shared default String f6(String a, String b) => "";
                    shared default String v1 { return ""; }
                    shared default String v2 => "";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    void f1();
                    static void $f1([final I $this]) {}
                    void f2();
                    static void $f2([final I $this]) => $ceylon$language.print($ceylon$language.String.instance(""));
                    $dart$core.String f3();
                    static $dart$core.String $f3([final I $this]) {
                        return "";
                    }
                    $dart$core.String f4();
                    static $dart$core.String $f4([final I $this]) => "";
                    $dart$core.String f5([$dart$core.String a, $dart$core.String b]);
                    static $dart$core.String $f5([final I $this, $dart$core.String a, $dart$core.String b]) {
                        return "";
                    }
                    $dart$core.String f6([$dart$core.String a, $dart$core.String b]);
                    static $dart$core.String $f6([final I $this, $dart$core.String a, $dart$core.String b]) => "";
                    $dart$core.String get v1;
                    static $dart$core.String $get$v1([final I $this]) {
                        return "";
                    }
                    $dart$core.String get v2;
                    static $dart$core.String $get$v2([final I $this]) => "";
                }
             """;
        };
    }

    shared test
    void simpleMemberInterface() {
        compileAndCompare {
             """
                interface I {
                    interface J {
                        shared formal String fun();
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J {
                    I $outer$default$I;
                    $dart$core.String fun();
                }
                abstract class I {
                }
             """;
        };
    }

    shared test
    void simpleMemberMemberInterface() {
        compileAndCompare {
             """
                interface I {
                    interface J {
                        interface K {
                            shared formal String fun();
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J$K {
                    I$J $outer$default$I$J;
                    $dart$core.String fun();
                }
                abstract class I$J {
                    I $outer$default$I;
                }
                abstract class I {
                }
             """;
        };
    }

    shared test
    void nestedInterfaceFunctions() {
        compileAndCompare {
             """
                interface I {
                    shared default String fi() => "";
                    interface J {
                        shared default String fj() => fi();
                        interface K {
                            shared default String fki() => fi();
                            shared default String fkj() => fj();
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J$K {
                    I$J $outer$default$I$J;
                    $dart$core.String fki();
                    static $dart$core.String $fki([final I$J$K $this]) => $this.$outer$default$I$J.$outer$default$I.fi();
                    $dart$core.String fkj();
                    static $dart$core.String $fkj([final I$J$K $this]) => $this.$outer$default$I$J.fj();
                }
                abstract class I$J {
                    I $outer$default$I;
                    $dart$core.String fj();
                    static $dart$core.String $fj([final I$J $this]) => $this.$outer$default$I.fi();
                }
                abstract class I {
                    $dart$core.String fi();
                    static $dart$core.String $fi([final I $this]) => "";
                }
             """;
        };
    }

    shared test
    void nestedInterfaceValuesLazy() {
        compileAndCompare {
             """
                interface I {
                    shared default String fi => "";
                    interface J {
                        shared default String fj => fi;
                        interface K {
                            shared default String fki => fi;
                            shared default String fkj => fj;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J$K {
                    I$J $outer$default$I$J;
                    $dart$core.String get fki;
                    static $dart$core.String $get$fki([final I$J$K $this]) => $this.$outer$default$I$J.$outer$default$I.fi;
                    $dart$core.String get fkj;
                    static $dart$core.String $get$fkj([final I$J$K $this]) => $this.$outer$default$I$J.fj;
                }
                abstract class I$J {
                    I $outer$default$I;
                    $dart$core.String get fj;
                    static $dart$core.String $get$fj([final I$J $this]) => $this.$outer$default$I.fi;
                }
                abstract class I {
                    $dart$core.String get fi;
                    static $dart$core.String $get$fi([final I $this]) => "";
                }
             """;
        };
    }

    shared test
    void nestedInterfaceValuesBlock() {
        compileAndCompare {
             """
                interface I {
                    shared default String fi { return ""; }
                    interface J {
                        shared default String fj { return fi; }
                        interface K {
                            shared default String fki { return fi; }
                            shared default String fkj { return fj; }
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J$K {
                    I$J $outer$default$I$J;
                    $dart$core.String get fki;
                    static $dart$core.String $get$fki([final I$J$K $this]) {
                        return $this.$outer$default$I$J.$outer$default$I.fi;
                    }
                    $dart$core.String get fkj;
                    static $dart$core.String $get$fkj([final I$J$K $this]) {
                        return $this.$outer$default$I$J.fj;
                    }
                }
                abstract class I$J {
                    I $outer$default$I;
                    $dart$core.String get fj;
                    static $dart$core.String $get$fj([final I$J $this]) {
                        return $this.$outer$default$I.fi;
                    }
                }
                abstract class I {
                    $dart$core.String get fi;
                    static $dart$core.String $get$fi([final I $this]) {
                        return "";
                    }
                }
             """;
        };
    }

    shared test
    void nestedCombined() {
        compileAndCompare {
             """
                interface Outer {
                    shared formal String outerValue;
                    shared String outerFn() {
                        return "outerFn";
                    }
                    shared void useFns() {
                        value a = outerValue;
                        value b = outerFn();
                    }
                    interface Inner {
                        shared formal String innerValue;
                        shared String innerFn() {
                            return "innerFn";
                        }
                        shared void useFns() {
                            value a = outerValue;
                            value b = outerFn();
                            value c = innerValue;
                            value d = innerFn();
                        }
                        interface Innest {
                            shared formal String innestValue;
                            shared String innestFn() {
                                return "innestFn";
                            }
                            shared void useFns() {
                                value a = outerValue;
                                value b = outerFn();
                                value c = innerValue;
                                value d = innerFn();
                                value e = innestValue;
                                value f = innestFn();
                                value g = string;
                            }
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class Outer$Inner$Innest {
                    Outer$Inner $outer$default$Outer$Inner;
                    $dart$core.String get innestValue;
                    $dart$core.String innestFn();
                    static $dart$core.String $innestFn([final Outer$Inner$Innest $this]) {
                        return "innestFn";
                    }
                    void useFns();
                    static void $useFns([final Outer$Inner$Innest $this]) {
                        $dart$core.String a = $this.$outer$default$Outer$Inner.$outer$default$Outer.outerValue;
                        $dart$core.String b = $this.$outer$default$Outer$Inner.$outer$default$Outer.outerFn();
                        $dart$core.String c = $this.$outer$default$Outer$Inner.innerValue;
                        $dart$core.String d = $this.$outer$default$Outer$Inner.innerFn();
                        $dart$core.String e = $this.innestValue;
                        $dart$core.String f = $this.innestFn();
                        $dart$core.String g = $this.toString();
                    }
                }
                abstract class Outer$Inner {
                    Outer $outer$default$Outer;
                    $dart$core.String get innerValue;
                    $dart$core.String innerFn();
                    static $dart$core.String $innerFn([final Outer$Inner $this]) {
                        return "innerFn";
                    }
                    void useFns();
                    static void $useFns([final Outer$Inner $this]) {
                        $dart$core.String a = $this.$outer$default$Outer.outerValue;
                        $dart$core.String b = $this.$outer$default$Outer.outerFn();
                        $dart$core.String c = $this.innerValue;
                        $dart$core.String d = $this.innerFn();
                    }
                }
                abstract class Outer {
                    $dart$core.String get outerValue;
                    $dart$core.String outerFn();
                    static $dart$core.String $outerFn([final Outer $this]) {
                        return "outerFn";
                    }
                    void useFns();
                    static void $useFns([final Outer $this]) {
                        $dart$core.String a = $this.outerValue;
                        $dart$core.String b = $this.outerFn();
                    }
                }
             """;
        };
    }

    shared test
    void simpleImplement() {
        compileAndCompare {
             """
                interface I {
                    shared formal String fun();
                }
                interface J satisfies I {
                    shared default String funJ() => fun();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String fun();
                }
                abstract class J implements I {
                    $dart$core.String funJ();
                    static $dart$core.String $funJ([final J $this]) => $this.fun();
                }
             """;
        };
    }

    shared test
    void implementAndOverrideFunctions() {
        compileAndCompare {
             """
                interface I {
                    shared formal String f1();
                    shared formal String f2();
                }
                interface J satisfies I {
                    shared actual default String f1() => "";
                    shared actual default String f2() { return ""; }
                    shared default String fj1() => f1();
                    shared default String fj2() { return f2(); }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String f1();
                    $dart$core.String f2();
                }
                abstract class J implements I {
                    $dart$core.String f1();
                    static $dart$core.String $f1([final J $this]) => "";
                    $dart$core.String f2();
                    static $dart$core.String $f2([final J $this]) {
                        return "";
                    }
                    $dart$core.String fj1();
                    static $dart$core.String $fj1([final J $this]) => $this.f1();
                    $dart$core.String fj2();
                    static $dart$core.String $fj2([final J $this]) {
                        return $this.f2();
                    }
                }
             """;
        };
    }

    shared test
    void implementAndOverrideValues() {
        compileAndCompare {
             """
                interface I {
                    shared formal String v1;
                    shared formal String v2;
                }
                interface J satisfies I {
                    shared actual default String v1 => "";
                    shared actual default String v2 { return ""; }
                    shared default String vj1 => v1;
                    shared default String vj2 { return v2; }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get v1;
                    $dart$core.String get v2;
                }
                abstract class J implements I {
                    $dart$core.String get v1;
                    static $dart$core.String $get$v1([final J $this]) => "";
                    $dart$core.String get v2;
                    static $dart$core.String $get$v2([final J $this]) {
                        return "";
                    }
                    $dart$core.String get vj1;
                    static $dart$core.String $get$vj1([final J $this]) => $this.v1;
                    $dart$core.String get vj2;
                    static $dart$core.String $get$vj2([final J $this]) {
                        return $this.v2;
                    }
                }
             """;
        };
    }

    shared test
    void outerWhenMemberSatisfiesContainer() {
        compileAndCompare {
             """
                interface I {
                    shared default String f() => "C.f()";
                    shared interface J satisfies I {
                        shared actual default String f() => "D.f()";
                        shared void testResolution() {
                            print(f());
                            print(outer.f());
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J implements I {
                    I $outer$default$I;
                    $dart$core.String f();
                    static $dart$core.String $f([final I$J $this]) => "D.f()";
                    void testResolution();
                    static void $testResolution([final I$J $this]) {
                        $ceylon$language.print($ceylon$language.String.instance($this.f()));
                        $ceylon$language.print($ceylon$language.String.instance($this.$outer$default$I.f()));
                    }
                }
                abstract class I {
                    $dart$core.String f();
                    static $dart$core.String $f([final I $this]) => "C.f()";
                }
             """;
        };
    }

    shared test
    void superDisambiguation() {
        // NOTE based on the JVM compiler, (super of Right2).fun should
        //      disambiguate to Right.fun, since Right2 doesn't override fun().
        compileAndCompare {
             """
                interface Top {
                    shared default String fun() => "";
                }
                interface Left satisfies Top {
                    shared actual default String fun() => "";
                }
                interface Right satisfies Top {
                    shared actual default String fun() => "";
                }
                interface Right2 satisfies Right {
                }
                interface Bottom satisfies Left & Right2 {
                    shared actual default String fun() => (super of Right2).fun();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class Top {
                    $dart$core.String fun();
                    static $dart$core.String $fun([final Top $this]) => "";
                }
                abstract class Left implements Top {
                    $dart$core.String fun();
                    static $dart$core.String $fun([final Left $this]) => "";
                }
                abstract class Right implements Top {
                    $dart$core.String fun();
                    static $dart$core.String $fun([final Right $this]) => "";
                }
                abstract class Right2 implements Right {
                }
                abstract class Bottom implements Left, Right2 {
                    $dart$core.String fun();
                    static $dart$core.String $fun([final Bottom $this]) => Right.$fun($this);
                }
             """;
        };
    }

    shared test ignore
    void simpleFunctionInterface() {
        compileAndCompare {
             """
                void f() {
                    interface I {
                        shared formal String fun();
                    }
                }
             """;

             """

             """;
        };
    }

    shared test
    void captureAndAssert() {
        compileAndCompare {
             """
                void capturesWithControlBlocks() {
                    Integer|Float|String x = 5;
                    interface Bar {
                        shared void capturesIFS() {
                            Integer|Float|String capture = x;
                            print(capture);
                        }
                    }

                    print(x);
                    assert (is Integer|Float x);
                    print(x);

                    interface Baz satisfies Bar {
                        shared void capturesIF() {
                            Integer|Float capture = x;
                            print(capture);
                        }
                    }

                    print(x);
                    assert (is Integer x);
                    print(x);

                    interface Ban satisfies Baz {
                        shared void capturesI() {
                            Integer capture = x + 1;
                            print(capture);
                        }
                    }

                    //object b satisfies Ban {}
                    //b.capturesI();
                    //b.capturesIF();
                    //b.capturesIFS();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class capturesWithControlBlocks$Bar {
                    void capturesIFS();
                    static void $capturesIFS([final capturesWithControlBlocks$Bar $this]) {
                        $dart$core.Object capture = $this.$capture$capturesWithControlBlocks$x;
                        $ceylon$language.print(capture);
                    }
                    $dart$core.Object $capture$capturesWithControlBlocks$x;
                }
                abstract class capturesWithControlBlocks$Baz implements capturesWithControlBlocks$Bar {
                    void capturesIF();
                    static void $capturesIF([final capturesWithControlBlocks$Baz $this]) {
                        $dart$core.Object capture = $this.$capture$capturesWithControlBlocks$$x;
                        $ceylon$language.print(capture);
                    }
                    $dart$core.Object $capture$capturesWithControlBlocks$$x;
                }
                abstract class capturesWithControlBlocks$Ban implements capturesWithControlBlocks$Baz {
                    void capturesI();
                    static void $capturesI([final capturesWithControlBlocks$Ban $this]) {
                        $dart$core.int capture = $this.$capture$capturesWithControlBlocks$$$x$0 + 1;
                        $ceylon$language.print($ceylon$language.Integer.instance(capture));
                    }
                    $dart$core.int $capture$capturesWithControlBlocks$$$x$0;
                }
                void $package$capturesWithControlBlocks() {
                    $dart$core.Object x = $ceylon$language.Integer.instance(5);
                    $ceylon$language.print(x);
                    if (!((x is $ceylon$language.Integer) || (x is $ceylon$language.Float))) {
                        throw new $ceylon$language.AssertionError("Violated: is Integer|Float x");
                    }
                    $ceylon$language.print(x);
                    $ceylon$language.print(x);
                    $dart$core.int x$0;
                    if (!(x is $ceylon$language.Integer)) {
                        throw new $ceylon$language.AssertionError("Violated: is Integer x");
                    }
                    x$0 = $ceylon$language.Integer.nativeValue(x as $ceylon$language.Integer);
                    $ceylon$language.print($ceylon$language.Integer.instance(x$0));
                }

                void capturesWithControlBlocks() => $package$capturesWithControlBlocks();
             """;
        };
    }

    shared test
    void captureAndAssertScopeVsContainer() {
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
        compileAndCompare {
             """
                void capturesWithControlBlocks() {

                    Integer|Float x = 5;    // 1
                    assert (is Integer x);  // 2
                    Integer y = 5;          // 3

                    interface Bar {
                        shared void foo() {
                            Integer captureX = x;
                            Integer captureY = y;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class capturesWithControlBlocks$Bar {
                    void foo();
                    static void $foo([final capturesWithControlBlocks$Bar $this]) {
                        $dart$core.int captureX = $this.$capture$capturesWithControlBlocks$$x$0;
                        $dart$core.int captureY = $this.$capture$capturesWithControlBlocks$y;
                    }
                    $dart$core.int $capture$capturesWithControlBlocks$$x$0;
                    $dart$core.int $capture$capturesWithControlBlocks$y;
                }
                void $package$capturesWithControlBlocks() {
                    $dart$core.Object x = $ceylon$language.Integer.instance(5);
                    $dart$core.int x$0;
                    if (!(x is $ceylon$language.Integer)) {
                        throw new $ceylon$language.AssertionError("Violated: is Integer x");
                    }
                    x$0 = $ceylon$language.Integer.nativeValue(x as $ceylon$language.Integer);
                    $dart$core.int y = 5;
                }

                void capturesWithControlBlocks() => $package$capturesWithControlBlocks();
             """;
        };
    }

    shared test
    void captureAndControlBlocks() {
        compileAndCompare {
             """
                void capturesWithControlBlocks() {
                    Integer|Float|String x = 5;
                    interface Bar {
                        shared void capturesIFS() {
                            Integer|Float|String capture = x;
                            print(capture);
                        }
                    }
                    if (is Integer|Float x) {
                        interface Baz satisfies Bar {
                            shared void capturesIF() {
                                Integer|Float capture = x;
                                print(capture);
                            }
                        }
                        if (is Integer x) {
                            interface Ban satisfies Baz {
                                shared void capturesI() {
                                    Integer capture = x;
                                    print(capture);
                                }
                            }
                            //object b satisfies Ban {}
                            //b.capturesI();
                            //b.capturesIF();
                            //b.capturesIFS();
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class capturesWithControlBlocks$Bar {
                    void capturesIFS();
                    static void $capturesIFS([final capturesWithControlBlocks$Bar $this]) {
                        $dart$core.Object capture = $this.$capture$capturesWithControlBlocks$x;
                        $ceylon$language.print(capture);
                    }
                    $dart$core.Object $capture$capturesWithControlBlocks$x;
                }
                abstract class capturesWithControlBlocks$Baz implements capturesWithControlBlocks$Bar {
                    void capturesIF();
                    static void $capturesIF([final capturesWithControlBlocks$Baz $this]) {
                        $dart$core.Object capture = $this.$capture$capturesWithControlBlocks$$$x;
                        $ceylon$language.print(capture);
                    }
                    $dart$core.Object $capture$capturesWithControlBlocks$$$x;
                }
                abstract class capturesWithControlBlocks$Ban implements capturesWithControlBlocks$Baz {
                    void capturesI();
                    static void $capturesI([final capturesWithControlBlocks$Ban $this]) {
                        $dart$core.int capture = $this.$capture$capturesWithControlBlocks$$$$$x$0;
                        $ceylon$language.print($ceylon$language.Integer.instance(capture));
                    }
                    $dart$core.int $capture$capturesWithControlBlocks$$$$$x$0;
                }
                void $package$capturesWithControlBlocks() {
                    $dart$core.Object x = $ceylon$language.Integer.instance(5);
                    if ((x is $ceylon$language.Integer) || (x is $ceylon$language.Float)) {
                        if (x is $ceylon$language.Integer) {
                            $dart$core.int x$0;
                            x$0 = $ceylon$language.Integer.nativeValue(x as $ceylon$language.Integer);
                        }
                    }
                }

                void capturesWithControlBlocks() => $package$capturesWithControlBlocks();
             """;
        };
    }

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInner() {
        compileAndCompare {
             """
                void run() {
                    Integer x = 5;
                    interface I1 {
                        interface I2 {
                            shared Integer capturedX => x;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1$I2 {
                    run$I1 $outer$default$run$I1;
                    $dart$core.int get capturedX;
                    static $dart$core.int $get$capturedX([final run$I1$I2 $this]) => $this.$outer$default$run$I1.$capture$run$x;
                }
                abstract class run$I1 {
                    $dart$core.int $capture$run$x;
                }
                void $package$run() {
                    $dart$core.int x = 5;
                }

                void run() => $package$run();
             """;
         };
     }

    "The outermost possible class or interface should make the capture."
    shared test
    void captureOnBehalfOfInnerInner() {
        compileAndCompare {
             """
                void run() {
                    Integer x = 5;
                    interface I1 {
                        interface I2 {
                            shared Integer i2capturedX => x;
                            interface I3 {
                                shared Integer i3capturedX => x;
                            }
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1$I2$I3 {
                    run$I1$I2 $outer$default$run$I1$I2;
                    $dart$core.int get i3capturedX;
                    static $dart$core.int $get$i3capturedX([final run$I1$I2$I3 $this]) => $this.$outer$default$run$I1$I2.$outer$default$run$I1.$capture$run$x;
                }
                abstract class run$I1$I2 {
                    run$I1 $outer$default$run$I1;
                    $dart$core.int get i2capturedX;
                    static $dart$core.int $get$i2capturedX([final run$I1$I2 $this]) => $this.$outer$default$run$I1.$capture$run$x;
                }
                abstract class run$I1 {
                    $dart$core.int $capture$run$x;
                }
                void $package$run() {
                    $dart$core.int x = 5;
                }

                void run() => $package$run();
             """;
         };
     }


    "Don't bother capturing something already captured by a supertype."
    shared test
    void dontCaptureIfSupertypeCaptures() {
        compileAndCompare {
             """
                void run() {
                    Integer x = 5;
                    interface I1 {
                        shared Integer i1capturedX => x;
                    }
                    interface I2 satisfies I1 {
                        shared Integer i2capturedX => x;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1 {
                    $dart$core.int get i1capturedX;
                    static $dart$core.int $get$i1capturedX([final run$I1 $this]) => $this.$capture$run$x;
                    $dart$core.int $capture$run$x;
                }
                abstract class run$I2 implements run$I1 {
                    $dart$core.int get i2capturedX;
                    static $dart$core.int $get$i2capturedX([final run$I2 $this]) => $this.$capture$run$x;
                }
                void $package$run() {
                    $dart$core.int x = 5;
                }

                void run() => $package$run();
             """;
         };
     }

    "Don't bother capturing something already captured by a supertype's supertype."
    shared test
    void dontCaptureIfSupertypeSupertypeCaptures() {
        compileAndCompare {
             """
                void run() {
                    Integer x = 5;
                    interface I1 {
                        shared Integer i1capturedX => x;
                    }
                    interface I2 satisfies I1 {}
                    interface I3 satisfies I2 {
                        shared Integer i3capturedX => x;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1 {
                    $dart$core.int get i1capturedX;
                    static $dart$core.int $get$i1capturedX([final run$I1 $this]) => $this.$capture$run$x;
                    $dart$core.int $capture$run$x;
                }
                abstract class run$I2 implements run$I1 {
                }
                abstract class run$I3 implements run$I2 {
                    $dart$core.int get i3capturedX;
                    static $dart$core.int $get$i3capturedX([final run$I3 $this]) => $this.$capture$run$x;
                }
                void $package$run() {
                    $dart$core.int x = 5;
                }

                void run() => $package$run();
             """;
         };
     }

     "The outer type doesn't make the capture, but its supertype does."
    shared test
    void captureMadeByOutersSupertype() {
        compileAndCompare {
             """
                void run() {
                    Integer x = 5;
                    interface I1 {
                        shared Integer i1capturedX => x;
                    }
                    interface I2 satisfies I1 {
                        interface I3 {
                            shared Integer i3capturedX => x;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1 {
                    $dart$core.int get i1capturedX;
                    static $dart$core.int $get$i1capturedX([final run$I1 $this]) => $this.$capture$run$x;
                    $dart$core.int $capture$run$x;
                }
                abstract class run$I2$I3 {
                    run$I2 $outer$default$run$I2;
                    $dart$core.int get i3capturedX;
                    static $dart$core.int $get$i3capturedX([final run$I2$I3 $this]) => $this.$outer$default$run$I2.$capture$run$x;
                }
                abstract class run$I2 implements run$I1 {
                }
                void $package$run() {
                    $dart$core.int x = 5;
                }

                void run() => $package$run();
             """;
         };
     }

    shared test
    void noFormalForPrivate() {
        compileAndCompare {
             """
                interface I1 {
                    void foo() {}
                    shared void bar() {}

                    String baz => "";
                    shared String ban => "";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I1 {
                    static void $foo([final I1 $this]) {}
                    void bar();
                    static void $bar([final I1 $this]) {}
                    static $dart$core.String $get$baz([final I1 $this]) => "";
                    $dart$core.String get ban;
                    static $dart$core.String $get$ban([final I1 $this]) => "";
                }
             """;
         };
     }
}
