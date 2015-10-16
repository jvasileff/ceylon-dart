import ceylon.test {
    test
}

shared
class ExpressionTests() {
    shared test
    void genericComparable() {
        compileAndCompare {
             """shared Element smallest<Element>(Element x, Element y)
                        given Element satisfies Comparable<Element>
                    =>  if (x<y) then x else y;
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (() {
                    if ((x as $ceylon$language.Comparable).smallerThan(y)) {
                        return x;
                    } else {
                        return y;
                    }
                })();

                $dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);
             """;
        };
    }

    shared test
    void addNumbers() {
        compileAndCompare {
             """
                shared void run() {
                    Integer i = 1;
                    Integer j = i + 1 + 1;
                    Object k = i + 1 + 1;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int i = 1;
                    $dart$core.int j = (i + 1) + 1;
                    $dart$core.Object k = $ceylon$language.Integer.instance((i + 1) + 1);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void boxIfElseExpression() {
        compileAndCompare {
             """
                shared void run() {
                    Integer x = 1;
                    Integer y = 1;
                    Integer z = if (x > y) then x else y;
                    Object o = if (x > y) then x else y;
                    Object p = if (x > y) then x else "";
                    Object q = if (x > y) then x else o;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int x = 1;
                    $dart$core.int y = 1;
                    $dart$core.int z = (() {
                        if (x > y) {
                            return x;
                        } else {
                            return y;
                        }
                    })();
                    $dart$core.Object o = (() {
                        if (x > y) {
                            return $ceylon$language.Integer.instance(x);
                        } else {
                            return $ceylon$language.Integer.instance(y);
                        }
                    })();
                    $dart$core.Object p = (() {
                        if (x > y) {
                            return $ceylon$language.Integer.instance(x);
                        } else {
                            return $ceylon$language.String.instance("");
                        }
                    })();
                    $dart$core.Object q = (() {
                        if (x > y) {
                            return $ceylon$language.Integer.instance(x);
                        } else {
                            return o;
                        }
                    })();
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void letExpression() {
        compileAndCompare {
             """
                shared void run() {
                    value i = let (x = 1) x;
                    print(i);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int i = (() {
                        $dart$core.int x = 1;
                        return x;
                    })();
                    $ceylon$language.print($ceylon$language.Integer.instance(i));
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void letExpressionMultiple() {
        compileAndCompare {
             """
                shared void run() {
                    value i = let (x = 1, y = 2) x + y;
                    print(i);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int i = (() {
                        $dart$core.int x = 1;
                        $dart$core.int y = 2;
                        return x + y;
                    })();
                    $ceylon$language.print($ceylon$language.Integer.instance(i));
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void elseOp() {
        compileAndCompare {
             """
                shared void run() {
                    interface A {}
                    interface B satisfies A & Identifiable {}

                    B? x => nothing;
                    A y = x else (nothing of A);

                    print(y);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$A {
                }
                abstract class run$B implements run$A, $ceylon$language.Identifiable {
                }
                void $package$run() {
                    run$B x$get() => $ceylon$language.nothing as run$B;

                    run$A y = ((run$A $lhs$) => $lhs$ == null ? $ceylon$language.nothing as run$A : $lhs$)(x$get());
                    $ceylon$language.print(y);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void elseOpGeneric() {
        compileAndCompare {
             """
                shared void run() {
                    interface A {}
                    interface B satisfies A & Identifiable {}

                    B? x => nothing;
                    A y = identity(x else (nothing of A));

                    print(y);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class run$A {
                }
                abstract class run$B implements run$A, $ceylon$language.Identifiable {
                }
                void $package$run() {
                    run$B x$get() => $ceylon$language.nothing as run$B;

                    run$A y = $ceylon$language.identity((($dart$core.Object $lhs$) => $lhs$ == null ? $ceylon$language.nothing : $lhs$)(x$get())) as run$A;
                    $ceylon$language.print(y);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void elseOpPrimitive() {
        compileAndCompare {
             """
                shared void run() {
                    String? x => null;
                    String y = x else "default";

                    print(y);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String x$get() => null;

                    $dart$core.String y = (($dart$core.String $lhs$) => $lhs$ == null ? "default" : $lhs$)(x$get());
                    $ceylon$language.print($ceylon$language.String.instance(y));
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void elseOpPrimitiveGeneric() {
        compileAndCompare {
             """
                shared void run() {
                    String? x => null;
                    String y = identity(x else "default");
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String x$get() => null;

                    $dart$core.String y = $ceylon$language.String.nativeValue($ceylon$language.identity((($dart$core.Object $lhs$) => $lhs$ == null ? $ceylon$language.String.instance("default") : $lhs$)($ceylon$language.String.instance(x$get()))) as $ceylon$language.String);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void elseOpDenotableLhs() {
        compileAndCompare {
             """
                shared void run() {
                    Comparison? a = larger;
                    Comparison b = larger;
                    value bool = (a else b) === b;

                    print(bool);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Comparison a = $ceylon$language.larger;
                    $ceylon$language.Comparison b = $ceylon$language.larger;
                    $dart$core.bool bool = $dart$core.identical((($ceylon$language.Identifiable $lhs$) => $lhs$ == null ? b : $lhs$)(a), b);
                    $ceylon$language.print($ceylon$language.Boolean.instance(bool));
                }

                void run() => $package$run();
             """;
         };
    }

}
