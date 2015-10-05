import ceylon.test {
    test
}

shared
class AssertIsNarrowingTests() {

    shared test
    void narrowObjectToString() {
        compileAndCompare {
             """
                void assertions() {
                    Object obj = "x";
                    assert (is String obj);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.String.instance("x");
                    $dart$core.String obj$0;
                    if (!(obj is $ceylon$language.String)) {
                        throw new $ceylon$language.AssertionError("Violated: is String obj");
                    }
                    obj$0 = $ceylon$language.String.nativeValue(obj as $ceylon$language.String);
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
                    if (obj is $ceylon$language.String) {
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
             """
                void assertions() {
                    Object obj = true;
                    assert (is Boolean obj);
                    Boolean bool = obj;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$assertions() {
                    $dart$core.Object obj = $ceylon$language.$true;
                    $dart$core.bool obj$0;
                    if (!(obj is $ceylon$language.Boolean)) {
                        throw new $ceylon$language.AssertionError("Violated: is Boolean obj");
                    }
                    obj$0 = $ceylon$language.Boolean.nativeValue(obj as $ceylon$language.Boolean);
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
                    $dart$core.double f;
                    {
                        $dart$core.Object f$0 = obj;
                        if (!(f$0 is $ceylon$language.Float)) {
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
        // FIXME the (!true) test isn't great.
        //       When we find a type parameter, should we replace it with its
        //       constraints at least?
        compileAndCompare {
             """
                shared T echoString<T>(T t) given T satisfies String {
                    String s = t;
                    assert (is T s);
                    return s;
                }

                shared void run() {
                    String myString1 = echoString("x");
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.Object $package$echoString([$dart$core.Object t]) {
                    $dart$core.String s = $ceylon$language.String.nativeValue(t as $ceylon$language.String);
                    $dart$core.Object s$0;
                    if (!true) {
                        throw new $ceylon$language.AssertionError("Violated: is T s");
                    }
                    s$0 = $ceylon$language.String.instance(s);
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

    shared test
    void assertExists() {
        compileAndCompare {
             """
                shared void run() {
                    String? s = "";
                    assert(exists s);
                    print(s);
                    assert(exists s2 = true then s);
                    print(s2);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String s = "";
                    if (s == null) {
                        throw new $ceylon$language.AssertionError("Violated: exists s");
                    }
                    $ceylon$language.print($ceylon$language.String.instance(s));
                    $dart$core.String s2;
                    {
                        $dart$core.String tmp$0 = true ? s : null;
                        if (tmp$0 == null) {
                            throw new $ceylon$language.AssertionError("Violated: exists s2 = true then s");
                        }
                        s2 = tmp$0;
                    }
                    $ceylon$language.print($ceylon$language.String.instance(s2));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void assertNonempty() {
        compileAndCompare {
             """
                shared void run() {
                    [Integer*] ints = [1];
                    assert(nonempty ints2 = ints);
                    print(ints2);
                    assert(nonempty ints);
                    print(ints);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Sequential ints = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)], null);
                    $ceylon$language.Sequence ints2;
                    {
                        $ceylon$language.Sequential tmp$0 = ints;
                        if (!(tmp$0 is $ceylon$language.Sequence)) {
                            throw new $ceylon$language.AssertionError("Violated: nonempty ints2 = ints");
                        }
                        ints2 = tmp$0 as $ceylon$language.Sequence;
                    }
                    $ceylon$language.print(ints2);
                    $ceylon$language.Sequence ints$1;
                    if (!(ints is $ceylon$language.Sequence)) {
                        throw new $ceylon$language.AssertionError("Violated: nonempty ints");
                    }
                    ints$1 = ints as $ceylon$language.Sequence;
                    $ceylon$language.print(ints$1);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void guardNarrowing() {
         compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "abc";
                    if (is Integer si) { return; }
                    print(si.size);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("abc");
                    if (si is $ceylon$language.Integer) {
                        $dart$core.int si$0;
                        si$0 = $ceylon$language.Integer.nativeValue(si as $ceylon$language.Integer);
                        return;
                    }
                    $ceylon$language.print($ceylon$language.Integer.instance((si as $ceylon$language.String).size));
                }

                void run() => $package$run();
             """;
        };
    }
}