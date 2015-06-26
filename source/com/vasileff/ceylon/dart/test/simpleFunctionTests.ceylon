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

        // FIXME this is what we get now....
        //       which is sort of correct, since the anonymous function
        //       needs to be boxed
         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void simpleFunction() {
                $dart$core.Function anon = () => "result";
                print(anon());
            }
         """;
    };
}

shared test
void functionReturnBoxingTest() {
    // FIXME bad code; need to box the function to box the result
    compileAndCompare {
         """void simpleFunction() {
                Anything() anon = () => "result";
                print(anon());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void simpleFunction() {
                $dart$core.Function anon = () => "result";
                print(anon());
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
    // TODO this works, but pretty much by accident
    compileAndCompare {
         """void simpleFunction() {
                String nested1() => "result1";
                value nested1Ref = nested1;
                print(nested1());
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void simpleFunction() {
                $dart$core.String nested1() => "result1";

                $dart$core.Function nested1Ref = nested1;
                print($ceylon$language.dart$nativeToCeylonString(nested1()));
            }
         """;
    };
}
