import ceylon.test {
    test
}

shared
class AssertIsNarrowingTests() {

    // TODO the dart is expression is not yet complete (always uses Object)

    shared test
    void narrowObjectToString() {
        compileAndCompare {
             """void assertions() {
                    Object obj = "x";
                    assert (is String obj);
                }
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.String.instance("x");
                    if (obj is !$dart$core.Object) {
                        throw new $ceylon$language.AssertionError("Violated: is String obj");
                    }
                    $dart$core.String obj$0 = $ceylon$language.String.nativeValue(obj as $ceylon$language.String);
                }

                void assertions() => $package$assertions();
             """;
        };
    }

    shared test
    void narrowDontShadow() {
        // the narrowing doesn't affect the Dart type,
        // so a new variable declaration is not required
        compileAndCompare {
             """void assertions() {
                    String|Integer|Float obj = "x";
                    assert (!is String obj);
                }
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.String.instance("x");
                    if (obj is $dart$core.Object) {
                        throw new $ceylon$language.AssertionError("Violated: !is String obj");
                    }
                }

                void assertions() => $package$assertions();
             """;
        };
    }

    shared test
    void useShadowAfterNarrowing() {
        compileAndCompare {
             """void assertions() {
                    Object obj = true;
                    assert (is Boolean obj);
                    Boolean bool = obj;
                }
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.$true;
                    if (obj is !$dart$core.Object) {
                        throw new $ceylon$language.AssertionError("Violated: is Boolean obj");
                    }
                    $dart$core.bool obj$0 = $ceylon$language.Boolean.nativeValue(obj as $ceylon$language.Boolean);
                    $dart$core.bool bool = obj$0;
                }

                void assertions() => $package$assertions();
             """;
        };
    }

    shared test
    void defineValueWithAssert() {
        compileAndCompare {
             """void assertions() {
                    Object obj = 1.0;
                    assert (is Float f = obj);
                    Float g = f;
                }
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.Float.instance(1.0);
                    $dart$core.double f;{
                        $dart$core.Object f$0 = obj;
                        if (f$0 is !$dart$core.Object) {
                            throw new $ceylon$language.AssertionError("Violated: is Float f = obj");
                        }
                        f = $ceylon$language.Float.nativeValue(f$0 as $ceylon$language.Float);
                    }
                    $dart$core.double g = f;
                }

                void assertions() => $package$assertions();
             """;
        };
    }

    shared test
    void narrowToGenericTypeWithErasure() {
        compileAndCompare {
             """shared T echoString<T>(T t) given T satisfies String {
                    String s = t;
                    assert (is T s);
                    return s;
                }

                shared void run() {
                    String myString1 = echoString("x");
                }
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.Object $package$echoString([$dart$core.Object t]) {
                    $dart$core.String s = $ceylon$language.String.nativeValue(t as $ceylon$language.String);
                    if (s is !$dart$core.Object) {
                        throw new $ceylon$language.AssertionError("Violated: is T s");
                    }
                    $dart$core.Object s$0 = $ceylon$language.String.instance(s);
                    return s$0;
                }

                $dart$core.Object echoString([$dart$core.Object t]) => $package$echoString(t);

                void $package$run() {
                    $dart$core.String myString1 = $ceylon$language.String.nativeValue($package$echoString($ceylon$language.String.instance("x")) as $ceylon$language.String);
                }

                void run() => $package$run();
             """;
         };
    }
}