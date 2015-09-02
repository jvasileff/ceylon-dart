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
    void simpleObjectInFunction() {
        // FIXME include outer function names in type name
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

                class o1_ {
                    o1_() {}
                    $dart$core.String get s1 => "";
                }
                void $package$run() {
                    final o1_ o1 = new o1_();
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

    shared test //ignore
    void multipleCaptures() {
        // TODO interface bridge methods
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

                class I1$I2$o_ implements I1$I2 {
                    I1$I2 $outer$default$I1$I2;
                    I1 $outer$default$I1;
                    $dart$core.String $capture$run$I1$I1$I2$i2Foo$i2foo;
                    $dart$core.String $capture$run$s1;
                    I1$I2$o_([I1$I2 this.$outer$default$I1$I2, I1 this.$outer$default$I1, $dart$core.String this.$capture$run$I1$I1$I2$i2Foo$i2foo, $dart$core.String this.$capture$run$s1]) {}
                    $dart$core.String get i2fooo => $capture$run$I1$I1$I2$i2Foo$i2foo;
                    void i2Foo() => I1$I2.$i2Foo(this);
                    $dart$core.String get i1s1 => I1.$get$i1s1(this);
                }
                abstract class I1$I2 implements I1 {
                    I1 $outer$default$I1;
                    void i2Foo();
                    static void $i2Foo([final I1$I2 $this]) {
                        $dart$core.String i2foo = "";
                        final I1$I2$o_ o = new I1$I2$o_($this, $this.$outer$default$I1, i2foo, $this.$capture$run$s1);
                    }
                }
                abstract class I1 {
                    $dart$core.String get i1s1;
                    static $dart$core.String $get$i1s1([final I1 $this]) => $this.$capture$run$s1;
                    $dart$core.String $capture$run$s1;
                }
                void $package$run() {
                    $dart$core.String s1 = "";
                }

                void run() => $package$run();
             """;
        };
    }

    shared test //ignore
    void outerForSupertypesSupertype() {
        // TODO interface bridge methods
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

                abstract class I1$I2 implements I1 {
                    I1 $outer$default$I1;
                }
                abstract class I1$I3 implements I1$I2 {
                    I1 $outer$default$I1;
                }
                class I1$o_ implements I1$I3 {
                    I1 $outer$default$I1;
                    I1$o_([I1 this.$outer$default$I1]) {}
                    void foo() => I1.$foo(this);
                }
                abstract class I1 {
                    void foo();
                    static void $foo([final I1 $this]) {
                        final I1$o_ o = new I1$o_($this);
                    }
                }
                void $package$run() {}

                void run() => $package$run();
             """;
        };
    }

    "Replacement value from `assert` must be captured as class member."
    shared test ignore
    void replacementDeclarationIsMember() {
        compileAndCompare {
             """
                class C() {
                    shared String? x = "";
                    assert (exists x);
                    shared String y => x;
                }
             """;
             """
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
