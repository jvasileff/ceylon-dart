import ceylon.test {
    test
}

shared
class NumberTests() {

    shared test
    void simpleIntegerFloatWidening() {
        compileAndCompare {
             """
                shared void run() {
                    value two = 2;
                    value a = 2.0 * two;
                    value b = 2.0 * 2;

                    value c = 2 * 2.0;
                    value d = two * 2.0;
                }
                shared void foo(Integer i = 2) {
                    value e = 2.0 * i;
                    value f = i * 2.0;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int two = 2;
                    $dart$core.double a = 2.0 * $ceylon$language.Integer.instance(two).float;
                    $dart$core.double b = 2.0 * $ceylon$language.Integer.instance(2).float;
                    $dart$core.double c = $ceylon$language.Integer.instance(2).float * 2.0;
                    $dart$core.double d = $ceylon$language.Integer.instance(two).float * 2.0;
                }

                void run() => $package$run();

                void $package$foo([$dart$core.Object i = $ceylon$language.dart$default]) {
                    if ($dart$core.identical(i, $ceylon$language.dart$default)) {
                        i = 2;
                    }
                    $dart$core.double e = 2.0 * $ceylon$language.Integer.instance(i as $dart$core.int).float;
                    $dart$core.double f = $ceylon$language.Integer.instance(i as $dart$core.int).float * 2.0;
                }

                void foo([$dart$core.Object i = $ceylon$language.dart$default]) => $package$foo(i);
             """;
        };
    }
}