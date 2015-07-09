import ceylon.test {
    test
}

shared test
void voidFunctionTest() {
    compileAndCompare {
         """void simpleFunction() { return; }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$simpleFunction() {
                return;
            }

            void simpleFunction() => $package$simpleFunction();
         """;
    };
}

shared test
void anonymousFunctionTest() {
    compileAndCompare {
         """void simpleFunction() {
                String() anon = () => "result";
                print(anon());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$simpleFunction() {
                $ceylon$language.Callable anon = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString((() => "result")());
                });
                $ceylon$language.print(anon.$delegate$());
            }

            void simpleFunction() => $package$simpleFunction();
         """;
    };
}

shared test
void functionReturnBoxingTest() {
    compileAndCompare {
         """void simpleFunction() {
                Anything() anon = () => "result";
                print(anon());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$simpleFunction() {
                $ceylon$language.Callable anon = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString((() => "result")());
                });
                $ceylon$language.print(anon.$delegate$());
            }

            void simpleFunction() => $package$simpleFunction();
         """;
    };
}

shared test
void nestedFunctionTest() {
    compileAndCompare {
         """void simpleFunction() {
                String nested1() => "result1";
                Object nested2() { return "result2"; }
                print(nested1());
                print(nested2());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$simpleFunction() {
                $dart$core.String nested1() => "result1";

                $dart$core.Object nested2() {
                    return $ceylon$language.dart$nativeToCeylonString("result2");
                }

                $ceylon$language.print($ceylon$language.dart$nativeToCeylonString(nested1()));
                $ceylon$language.print(nested2());
            }

            void simpleFunction() => $package$simpleFunction();
         """;
    };
}

shared test
void functionReferenceTest() {
    compileAndCompare {
         """void simpleFunction() {
                String nested1() => "result1";
                value nested1Ref = nested1;
                print(nested1());
                print(nested1Ref());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$simpleFunction() {
                $dart$core.String nested1() => "result1";

                $ceylon$language.Callable nested1Ref = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString(nested1());
                });
                $ceylon$language.print($ceylon$language.dart$nativeToCeylonString(nested1()));
                $ceylon$language.print(nested1Ref.$delegate$());
            }

            void simpleFunction() => $package$simpleFunction();
         """;
    };
}

shared test
void functionDefaultedParameters() {
    compileAndCompare {
         """shared Integer withDefaults(Integer x = 1, Integer y = 2) {
                return y;
            }

            shared void run() {
                withDefaults(3);
                withDefaults(4, 5);
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.int $package$withDefaults([$dart$core.Object x = $ceylon$language.dart$default, $dart$core.Object y = $ceylon$language.dart$default]) {
                if ($dart$core.identical(x, $ceylon$language.dart$default)) {
                    x = 1;
                }
                if ($dart$core.identical(y, $ceylon$language.dart$default)) {
                    y = 2;
                }
                return y as $dart$core.int;
            }

            $dart$core.int withDefaults([$dart$core.Object x = $ceylon$language.dart$default, $dart$core.Object y = $ceylon$language.dart$default]) => $package$withDefaults(x, y);

            void $package$run() {
                $package$withDefaults(3);
                $package$withDefaults(4, 5);
            }

            void run() => $package$run();
         """;
     };
}

shared test
void functionDefaultedParameters2() {
    compileAndCompare {
         """
            shared Integer withDefaults(Integer x = 1, Integer y = x + 1 + 1) {
                return y;
            }

            shared void run() {
                withDefaults();
                withDefaults(1);
                withDefaults(2, 3);
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.int $package$withDefaults([$dart$core.Object x = $ceylon$language.dart$default, $dart$core.Object y = $ceylon$language.dart$default]) {
                if ($dart$core.identical(x, $ceylon$language.dart$default)) {
                    x = 1;
                }
                if ($dart$core.identical(y, $ceylon$language.dart$default)) {
                    y = $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(x as $dart$core.int).plus($ceylon$language.dart$nativeToCeylonInteger(1)).plus($ceylon$language.dart$nativeToCeylonInteger(1)));
                }
                return y as $dart$core.int;
            }

            $dart$core.int withDefaults([$dart$core.Object x = $ceylon$language.dart$default, $dart$core.Object y = $ceylon$language.dart$default]) => $package$withDefaults(x, y);

            void $package$run() {
                $package$withDefaults();
                $package$withDefaults(1);
                $package$withDefaults(2, 3);
            }

            void run() => $package$run();
         """;
     };
}
