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
                    $dart$core.String v1;
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
                    I $outer$default$I$J;
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
                    I$J $outer$default$I$J$K;
                    $dart$core.String fun();
                }
                abstract class I$J {
                    I $outer$default$I$J;
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
                    I$J $outer$default$I$J$K;
                    $dart$core.String fki();
                    static $dart$core.String $fki([final I$J$K $this]) => $this.$outer$default$I$J$K.$outer$default$I$J.fi();
                    $dart$core.String fkj();
                    static $dart$core.String $fkj([final I$J$K $this]) => $this.$outer$default$I$J$K.fj();
                }
                abstract class I$J {
                    I $outer$default$I$J;
                    $dart$core.String fj();
                    static $dart$core.String $fj([final I$J $this]) => $this.$outer$default$I$J.fi();
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
                    I$J $outer$default$I$J$K;
                    $dart$core.String get fki;
                    static $dart$core.String $get$fki([final I$J$K $this]) => $this.$outer$default$I$J$K.$outer$default$I$J.fi;
                    $dart$core.String get fkj;
                    static $dart$core.String $get$fkj([final I$J$K $this]) => $this.$outer$default$I$J$K.fj;
                }
                abstract class I$J {
                    I $outer$default$I$J;
                    $dart$core.String get fj;
                    static $dart$core.String $get$fj([final I$J $this]) => $this.$outer$default$I$J.fi;
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
                    I$J $outer$default$I$J$K;
                    $dart$core.String get fki;
                    static $dart$core.String $get$fki([final I$J$K $this]) {
                        return $this.$outer$default$I$J$K.$outer$default$I$J.fi;
                    }
                    $dart$core.String get fkj;
                    static $dart$core.String $get$fkj([final I$J$K $this]) {
                        return $this.$outer$default$I$J$K.fj;
                    }
                }
                abstract class I$J {
                    I $outer$default$I$J;
                    $dart$core.String get fj;
                    static $dart$core.String $get$fj([final I$J $this]) {
                        return $this.$outer$default$I$J.fi;
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
                    Outer$Inner $outer$default$Outer$Inner$Innest;
                    $dart$core.String innestValue;
                    $dart$core.String innestFn();
                    static $dart$core.String $innestFn([final Outer$Inner$Innest $this]) {
                        return "innestFn";
                    }
                    void useFns();
                    static void $useFns([final Outer$Inner$Innest $this]) {
                        $dart$core.String a = $this.$outer$default$Outer$Inner$Innest.$outer$default$Outer$Inner.outerValue;
                        $dart$core.String b = $this.$outer$default$Outer$Inner$Innest.$outer$default$Outer$Inner.outerFn();
                        $dart$core.String c = $this.$outer$default$Outer$Inner$Innest.innerValue;
                        $dart$core.String d = $this.$outer$default$Outer$Inner$Innest.innerFn();
                        $dart$core.String e = $this.innestValue;
                        $dart$core.String f = $this.innestFn();
                        $dart$core.String g = $this.toString();
                    }
                }
                abstract class Outer$Inner {
                    Outer $outer$default$Outer$Inner;
                    $dart$core.String innerValue;
                    $dart$core.String innerFn();
                    static $dart$core.String $innerFn([final Outer$Inner $this]) {
                        return "innerFn";
                    }
                    void useFns();
                    static void $useFns([final Outer$Inner $this]) {
                        $dart$core.String a = $this.$outer$default$Outer$Inner.outerValue;
                        $dart$core.String b = $this.$outer$default$Outer$Inner.outerFn();
                        $dart$core.String c = $this.innerValue;
                        $dart$core.String d = $this.innerFn();
                    }
                }
                abstract class Outer {
                    $dart$core.String outerValue;
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
                    $dart$core.String v1;
                    $dart$core.String v2;
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

    shared test ignore
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

}