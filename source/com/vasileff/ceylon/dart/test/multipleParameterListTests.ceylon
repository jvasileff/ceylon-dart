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
}
