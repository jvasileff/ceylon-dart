import ceylon.test {
    test,
    ignore
}

shared
class ObjectTests() {

    shared test
    void simpleToplevelObject() {
        compileAndCompare {
             """
                object o1 {
                    shared String s1 => "";
                    shared String s2 { return ""; }
                    shared String s3() => "";
                    shared String s4() { return ""; }
                }

                shared void run() {
                    print(o1.s1);
                    print(o1.s2);
                    print(o1.s3());
                    print(o1.s4());
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class o1_ {
                    o1_() {}
                    $dart$core.String get s1 => "";
                    $dart$core.String get s2 {
                        return "";
                    }
                    $dart$core.String s3() => "";
                    $dart$core.String s4() {
                        return "";
                    }
                }
                final o1_ $package$o1 = new o1_();

                o1_ get o1 => $package$o1;

                void $package$run() {
                    $ceylon$language.print($ceylon$language.String.instance($package$o1.s1));
                    $ceylon$language.print($ceylon$language.String.instance($package$o1.s2));
                    $ceylon$language.print($ceylon$language.String.instance($package$o1.s3()));
                    $ceylon$language.print($ceylon$language.String.instance($package$o1.s4()));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void shortcutRefinement() {
        compileAndCompare {
             """
                interface I {
                    shared formal String s1;
                    shared formal String s2();
                }

                object o satisfies I {
                    s1 => "s1Value";
                    s2() => "s2Value";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get s1;
                    $dart$core.String s2();
                }
                class o_ implements I {
                    o_() {}
                    $dart$core.String get s1 => "s1Value";
                    $dart$core.String s2() => "s2Value";
                }
                final o_ $package$o = new o_();

                o_ get o => $package$o;
             """;
        };
    }

    shared test
    void bridgeMethods() {
        compileAndCompare {
             """
                interface I {
                    shared String s1 => "";
                    shared String s2 { return ""; }
                    shared String s3() => "";
                    shared String s4() { return ""; }

                    assign s1 {
                        print("Setting s1");
                    }
                    assign s2 {
                        print("Setting s2");
                    }
                }

                object o satisfies I {}
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get s1;
                    static $dart$core.String $get$s1([final I $this]) => "";
                    $dart$core.String get s2;
                    static $dart$core.String $get$s2([final I $this]) {
                        return "";
                    }
                    $dart$core.String s3();
                    static $dart$core.String $s3([final I $this]) => "";
                    $dart$core.String s4();
                    static $dart$core.String $s4([final I $this]) {
                        return "";
                    }
                    void set s1($dart$core.String s1);
                    static void $set$s1([final I $this, $dart$core.String s1]) {
                        $ceylon$language.print($ceylon$language.String.instance("Setting s1"));
                    }
                    void set s2($dart$core.String s2);
                    static void $set$s2([final I $this, $dart$core.String s2]) {
                        $ceylon$language.print($ceylon$language.String.instance("Setting s2"));
                    }
                }
                class o_ implements I {
                    o_() {}
                    $dart$core.String get s1 => I.$get$s1(this);
                    $dart$core.String get s2 => I.$get$s2(this);
                    $dart$core.String s3() => I.$s3(this);
                    $dart$core.String s4() => I.$s4(this);
                    void set s1 => I.$set$s1(this, s1);
                    void set s2 => I.$set$s2(this, s2);
                }
                final o_ $package$o = new o_();

                o_ get o => $package$o;
             """;
        };
    }

    shared test
    void simpleObjectInFunction() {
        compileAndCompare {
             """
                shared void run() {
                    object o1 {
                        shared String s1 => "";
                    }
                 }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class run$o1_ {
                    run$o1_() {}
                    $dart$core.String get s1 => "";
                }
                void $package$run() {
                    final run$o1_ o1 = new run$o1_();
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void simpleObjectInObject() {
        compileAndCompare {
             """
                object o1 {
                    object o2 {
                        shared String s1 => "";
                    }
                 }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class o1_$o2_ {
                    o1_ $outer$default$o1_;
                    o1_$o2_([o1_ this.$outer$default$o1_]) {}
                    $dart$core.String get s1 => "";
                }
                class o1_ {
                    o1_() {
                        o2 = new o1_$o2_(this);
                    }
                    o1_$o2_ o2;
                }
                final o1_ $package$o1 = new o1_();

                o1_ get o1 => $package$o1;
             """;
        };
    }

    shared test
    void multipleCaptures() {
        compileAndCompare {
             """
                shared void run() {
                    value s1 = "";
                    interface I1 {
                        shared default String i1s1 => s1;
                        interface I2 satisfies I1 {
                            shared void i2Foo() {
                                value i2foo = "";
                                object o satisfies I2 {
                                    shared String i2fooo => i2foo;
                                }
                            }
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class run$I1$I2$i2Foo$o_ implements run$I1$I2 {
                    run$I1$I2 $outer$default$run$I1$I2;
                    run$I1 $outer$default$run$I1;
                    $dart$core.String $capture$run$run$I1$run$I1$I2$i2Foo$i2foo;
                    $dart$core.String $capture$run$s1;
                    run$I1$I2$i2Foo$o_([run$I1$I2 this.$outer$default$run$I1$I2, run$I1 this.$outer$default$run$I1, $dart$core.String this.$capture$run$run$I1$run$I1$I2$i2Foo$i2foo, $dart$core.String this.$capture$run$s1]) {}
                    $dart$core.String get i2fooo => $capture$run$run$I1$run$I1$I2$i2Foo$i2foo;
                    void i2Foo() => run$I1$I2.$i2Foo(this);
                    $dart$core.String get i1s1 => run$I1.$get$i1s1(this);
                }
                abstract class run$I1$I2 implements run$I1 {
                    run$I1 $outer$default$run$I1;
                    void i2Foo();
                    static void $i2Foo([final run$I1$I2 $this]) {
                        $dart$core.String i2foo = "";
                        final run$I1$I2$i2Foo$o_ o = new run$I1$I2$i2Foo$o_($this, $this.$outer$default$run$I1, i2foo, $this.$capture$run$s1);
                    }
                }
                abstract class run$I1 {
                    $dart$core.String get i1s1;
                    static $dart$core.String $get$i1s1([final run$I1 $this]) => $this.$capture$run$s1;
                    $dart$core.String $capture$run$s1;
                }
                void $package$run() {
                    $dart$core.String s1 = "";
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void outerForSupertypesSupertype() {
        compileAndCompare {
             """
                void run() {
                    interface I1 {
                        interface I2 satisfies I1 {}
                        interface I3 satisfies I2 {}
                        shared default void foo() {
                            object o satisfies I3 {}
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$I1$I2 implements run$I1 {
                    run$I1 $outer$default$run$I1;
                }
                abstract class run$I1$I3 implements run$I1$I2 {
                    run$I1 $outer$default$run$I1;
                }
                class run$I1$foo$o_ implements run$I1$I3 {
                    run$I1 $outer$default$run$I1;
                    run$I1$foo$o_([run$I1 this.$outer$default$run$I1]) {}
                    void foo() => run$I1.$foo(this);
                }
                abstract class run$I1 {
                    void foo();
                    static void $foo([final run$I1 $this]) {
                        final run$I1$foo$o_ o = new run$I1$foo$o_($this);
                    }
                }
                void $package$run() {}

                void run() => $package$run();
             """;
        };
    }

    "Replacement value from `assert` must be captured as class member."
    shared test
    void replacementDeclarationIsMember() {
        compileAndCompare {
             """
                class C() {
                    shared String|Integer x = "";
                    assert (is String x);
                    shared String y => x;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class C {
                    C() {
                        x = $ceylon$language.String.instance("");
                        if (!(x is $ceylon$language.String)) {
                            throw new $ceylon$language.AssertionError("Violated: is String x");
                        }
                        x$0 = $ceylon$language.String.nativeValue(x as $ceylon$language.String);
                    }
                    $dart$core.Object x;
                    $dart$core.String x$0;
                    $dart$core.String get y => x$0;
                }
             """;
         };
    }

    shared test
    void objectWithInitialization() {
        compileAndCompare {
             """
                object o {
                    String myIterable = "abcd";
                    shared void run() {
                        for (x in myIterable) {
                            print(x);
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class o_ {
                    o_() {
                        myIterable = "abcd";
                    }
                    $dart$core.String myIterable;
                    void run() {{
                            $dart$core.Object element$1;
                            $ceylon$language.Iterator iterator$0 = $ceylon$language.String.instance(myIterable).iterator();
                            while ((element$1 = iterator$0.next()) is !$ceylon$language.Finished) {
                                $ceylon$language.Character x = element$1 as $ceylon$language.Character;
                                $ceylon$language.print(x);
                            }
                        }
                    }
                }
                final o_ $package$o = new o_();

                o_ get o => $package$o;
             """;
        };
    }
}
