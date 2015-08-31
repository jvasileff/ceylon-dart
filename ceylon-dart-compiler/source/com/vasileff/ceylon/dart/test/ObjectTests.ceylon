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

    shared test ignore
    void simpleObjectInFunction() {
        // TODO instantiate object
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
                    $dart$core.String get s1 => "";
                }
                void $package$run() {
                    o1_ o1 = new o1_();
                    o1_ get $package$o1 => o1;
                }

                void run() => $package$run();
             """;
        };
    }

    shared test ignore
    void simpleObjectInObject() {
        // TODO instantiate object
        //      constructors
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
                    o1_$o2_(o1_ this.$outer$default$o1_$o2_) {}
                    o1_ $outer$default$o1_$o2_;
                    $dart$core.String get s1 => "";
                }
                class o1_ {
                    o1_$o2_ o2;
                    o1_() {
                      o2 = new o1_$o2_(this);
                    }
                }
                final o1_ $package$o1 = new o1_();

                o1_ get o1 => $package$o1;
             """;
        };
    }

    shared test ignore
    void outerForSupertypesSupertype() {
        // TODO constructor, instantiation
        // TODO outer references are unique to the inner (i.e. declarations all have
        //      their own ref for I1), but is this necessary?
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
                    I1 $outer$default$I1$I2;
                }
                abstract class I1$I3 implements I1$I2 {
                    I1 $outer$default$I1$I3;
                }
                class I1$o_ implements I1$I3 {
                    I1 $outer$default$I1$o_;
                    I1 $outer$default$I1$I3;
                    I1 $outer$default$I1$I2;
                    // TODO constructor
                }
                abstract class I1 {
                    void foo();
                    static void $foo([final I1 $this]) {
                        // TODO object value declaration
                    }
                }
                void $package$run() {}

                void run() => $package$run();
             """;
        };
    }
}
