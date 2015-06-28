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

            void simpleFunction() {
                return;
            }
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

            void simpleFunction() {
                $ceylon$language.Callable anon = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString((() => "result")());
                });
                print((anon).$delegate$());
            }
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

            void simpleFunction() {
                $ceylon$language.Callable anon = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString((() => "result")());
                });
                print((anon).$delegate$());
            }

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

            void simpleFunction() {
                $dart$core.String nested1() => "result1";

                $dart$core.Object nested2() {
                    return $ceylon$language.dart$nativeToCeylonString("result2");
                }

                print($ceylon$language.dart$nativeToCeylonString(nested1()));
                print(nested2());
            }
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

            void simpleFunction() {
                $dart$core.String nested1() => "result1";

                $ceylon$language.Callable nested1Ref = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString((nested1)());
                });
                print($ceylon$language.dart$nativeToCeylonString(nested1()));
                print((nested1Ref).$delegate$());
            }
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

            $dart$core.int withDefaults([$dart$core.int x = $ceylon$language.dart$defaulted, $dart$core.int y = $ceylon$language.dart$defaulted]) {
                if ($dart$core.identical(x, $ceylon$language.dart$defaulted)) {
                    x = 1;
                }
                if ($dart$core.identical(y, $ceylon$language.dart$defaulted)) {
                    y = 2;
                }
                return y;
            }

            void run() {
                withDefaults(3);
                withDefaults(4, 5);
            }""";
     };
}
