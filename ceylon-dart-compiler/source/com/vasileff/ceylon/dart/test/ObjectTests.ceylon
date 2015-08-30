import ceylon.test {
    test,
    ignore
}

shared
class ObjectTests() {

    shared test ignore
    void simpleToplevelObject() {
        // TODO instantiate object
        compileAndCompare {
             """
                object o1 {
                    shared String s1 => "";
                    shared String s2 { return ""; }
                    shared String s3() => "";
                    shared String s4() { return ""; }
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

                    o1_ o1 = new o1_();
                    o1_ get $package$o1 => o1;
                }
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
             """;
        };
    }
}
