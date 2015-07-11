import ceylon.test {
    test
}

shared
class MultipleParameterListTests() {

    shared test
    void toplevelMPL() {
        compileAndCompare {
             """
                Integer adder(Integer x)(Integer y) {
                    return x + y;
                }

                shared void run() {
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Callable $package$adder([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                    return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) {
                        return $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y)));
                    })($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                });

                $ceylon$language.Callable adder([$dart$core.int x]) => $package$adder(x);

                void $package$run() {
                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return $package$adder($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = $package$adder(1);
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative($package$adder(1).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void toplevelMPLSC() {
        compileAndCompare {
             """
                Integer adder(Integer x)(Integer y)
                    =>  x + y;

                shared void run() {
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Callable $package$adder([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                    return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) => $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y))))($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                });

                $ceylon$language.Callable adder([$dart$core.int x]) => $package$adder(x);

                void $package$run() {
                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return $package$adder($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = $package$adder(1);
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative($package$adder(1).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void nestedMPL() {
        compileAndCompare {
             """
                shared void run() {
                    Integer adder(Integer x)(Integer y) {
                        return x + y;
                    }
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;
             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable adder([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                        return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) {
                            return $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y)));
                        })($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                    });

                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return adder($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = adder(1);
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative(adder(1).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void nestedMPLSC() {
        compileAndCompare {
             """
                shared void run() {
                    Integer adder(Integer x)(Integer y)
                        =>  x + y;
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;
             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable adder([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                        return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) => $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y))))($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                    });

                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return adder($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = adder(1);
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative(adder(1).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }


    shared test
    void expressionMPL() {
        compileAndCompare {
             """
                shared void run() {
                    value adder = (Integer x)(Integer y) {
                        return x + y;
                    };
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;
             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable adder = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                            return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) {
                                return $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y)));
                            })($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                        }))($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer)));
                    });
                    $ceylon$language.Callable f = adder;
                    $ceylon$language.Callable g = adder.$delegate$($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Callable;
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative((adder.$delegate$($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Callable).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void expressionMPLSC() {
        compileAndCompare {
             """
                shared void run() {
                    value adder = (Integer x)(Integer y)
                        =>  x + y;
                    value f = adder;
                    value g = adder(1);
                    value h = adder(1)(2);
                }
             """;
             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable adder = new $ceylon$language.dart$Callable(([$dart$core.Object x]) {
                        return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int x]) => new $ceylon$language.dart$Callable(([$dart$core.Object y]) {
                            return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int y]) => $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y))))($ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer)));
                        }))($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer)));
                    });
                    $ceylon$language.Callable f = adder;
                    $ceylon$language.Callable g = adder.$delegate$($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Callable;
                    $dart$core.int h = $ceylon$language.dart$ceylonIntegerToNative((adder.$delegate$($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Callable).$delegate$($ceylon$language.dart$nativeToCeylonInteger(2)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void withDefaults() {
        compileAndCompare {
             """
                Integer adder(Integer x, Integer y = 10)(Integer z) {
                    return x + y + z;
                }

                shared void run() {
                    value f = adder;
                    value g = adder(1);
                    value h = adder(2, 3);
                    value i = adder(4)(5);
                    value j = adder(6, 7)(8);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Callable $package$adder([$dart$core.int x, $dart$core.Object y = $ceylon$language.dart$default]) {
                    if ($dart$core.identical(y, $ceylon$language.dart$default)) {
                        y = 10;
                    }
                    return new $ceylon$language.dart$Callable(([$dart$core.Object z]) {
                        return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.int z]) {
                            return $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x).plus($ceylon$language.dart$nativeToCeylonInteger(y as $dart$core.int)).plus($ceylon$language.dart$nativeToCeylonInteger(z)));
                        })($ceylon$language.dart$ceylonIntegerToNative(z as $ceylon$language.Integer)));
                    });
                }

                $ceylon$language.Callable adder([$dart$core.int x, $dart$core.Object y = $ceylon$language.dart$default]) => $package$adder(x, y);

                void $package$run() {
                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object x, $dart$core.Object y = $ceylon$language.dart$default]) {
                        return $package$adder($ceylon$language.dart$ceylonIntegerToNative(x as $ceylon$language.Integer), $dart$core.identical(y, $ceylon$language.dart$default) ? $ceylon$language.dart$default : $ceylon$language.dart$ceylonIntegerToNative(y as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = $package$adder(1);
                    $ceylon$language.Callable h = $package$adder(2, 3);
                    $dart$core.int i = $ceylon$language.dart$ceylonIntegerToNative($package$adder(4).$delegate$($ceylon$language.dart$nativeToCeylonInteger(5)) as $ceylon$language.Integer);
                    $dart$core.int j = $ceylon$language.dart$ceylonIntegerToNative($package$adder(6, 7).$delegate$($ceylon$language.dart$nativeToCeylonInteger(8)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void manyLists() {
        compileAndCompare {
             """
                Integer fun(Integer a, Integer b = 10)(Integer c)(String d, Float e)(Boolean f) {
                    return a + b + c;
                }

                shared void run() {
                    value f = fun;
                    value g = fun(1);
                    value h = fun(2, 3);
                    value i = fun(4)(5);
                    value j = fun(4)(5)("s", 1.0);
                    value k = fun(4)(5)("s", 1.0)(true);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Callable $package$fun([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default]) {
                    if ($dart$core.identical(b, $ceylon$language.dart$default)) {
                        b = 10;
                    }
                    return new $ceylon$language.dart$Callable(([$dart$core.Object c]) {
                        return (([$dart$core.int c]) => new $ceylon$language.dart$Callable(([$dart$core.Object d, $dart$core.Object e]) {
                            return (([$dart$core.String d, $dart$core.double e]) => new $ceylon$language.dart$Callable(([$dart$core.Object f]) {
                                return $ceylon$language.dart$nativeToCeylonInteger((([$dart$core.bool f]) {
                                    return $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(a).plus($ceylon$language.dart$nativeToCeylonInteger(b as $dart$core.int)).plus($ceylon$language.dart$nativeToCeylonInteger(c)));
                                })($ceylon$language.dart$ceylonBooleanToNative(f as $ceylon$language.Boolean)));
                            }))($ceylon$language.dart$ceylonStringToNative(d as $ceylon$language.String), $ceylon$language.dart$ceylonFloatToNative(e as $ceylon$language.Float));
                        }))($ceylon$language.dart$ceylonIntegerToNative(c as $ceylon$language.Integer));
                    });
                }

                $ceylon$language.Callable fun([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default]) => $package$fun(a, b);

                void $package$run() {
                    $ceylon$language.Callable f = new $ceylon$language.dart$Callable(([$dart$core.Object a, $dart$core.Object b = $ceylon$language.dart$default]) {
                        return $package$fun($ceylon$language.dart$ceylonIntegerToNative(a as $ceylon$language.Integer), $dart$core.identical(b, $ceylon$language.dart$default) ? $ceylon$language.dart$default : $ceylon$language.dart$ceylonIntegerToNative(b as $ceylon$language.Integer));
                    });
                    $ceylon$language.Callable g = $package$fun(1);
                    $ceylon$language.Callable h = $package$fun(2, 3);
                    $ceylon$language.Callable i = $package$fun(4).$delegate$($ceylon$language.dart$nativeToCeylonInteger(5)) as $ceylon$language.Callable;
                    $ceylon$language.Callable j = ($package$fun(4).$delegate$($ceylon$language.dart$nativeToCeylonInteger(5)) as $ceylon$language.Callable).$delegate$($ceylon$language.dart$nativeToCeylonString("s"), $ceylon$language.dart$nativeToCeylonFloat(1.0)) as $ceylon$language.Callable;
                    $dart$core.int k = $ceylon$language.dart$ceylonIntegerToNative((($package$fun(4).$delegate$($ceylon$language.dart$nativeToCeylonInteger(5)) as $ceylon$language.Callable).$delegate$($ceylon$language.dart$nativeToCeylonString("s"), $ceylon$language.dart$nativeToCeylonFloat(1.0)) as $ceylon$language.Callable).$delegate$($ceylon$language.$true) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }
}
