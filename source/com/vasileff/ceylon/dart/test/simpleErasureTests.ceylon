import ceylon.test {
    test
}

shared test
void booleanFunctionReturnErasure() {
     compileAndCompare {
         """Boolean f1() => true;
            Boolean? f2() => true;
            Object f3() => true;
            Object? f4() => true;
            \Itrue f5() => true;
            \Itrue? f6() => true;
            \Ifalse f7() => false;
            \Ifalse? f8() => false;
            \Itrue|\Ifalse f9() => true;
            Boolean|\Itrue f10() => true;
            Boolean|\Ifalse f11() => true;
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.bool f1() => true;

            $dart$core.bool f2() => true;

            $dart$core.Object f3() => $ceylon$language.$true;

            $dart$core.Object f4() => $ceylon$language.$true;

            $dart$core.bool f5() => true;

            $dart$core.bool f6() => true;

            $dart$core.bool f7() => false;

            $dart$core.bool f8() => false;

            $dart$core.bool f9() => true;

            $dart$core.bool f10() => true;

            $dart$core.bool f11() => true;
         """;
    };
}

shared test
void integerFunctionReturnErasure() {
     compileAndCompare {
         """Integer f1() => 1;
            Integer? f2() => 1;
            Object f3() => 1;
            Object? f4() => 1;
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.int f1() => 1;

            $dart$core.int f2() => 1;

            $dart$core.Object f3() => $ceylon$language.dart$nativeToCeylonInteger(1);

            $dart$core.Object f4() => $ceylon$language.dart$nativeToCeylonInteger(1);
         """;
    };
}

shared test
void floatFunctionReturnErasure() {
     compileAndCompare {
         """Float f1() => 1.0;
            Float? f2() => 1.0;
            Object f3() => 1.0;
            Object? f4() => 1.0;
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.double f1() => 1.0;

            $dart$core.double f2() => 1.0;

            $dart$core.Object f3() => $ceylon$language.dart$nativeToCeylonFloat(1.0);

            $dart$core.Object f4() => $ceylon$language.dart$nativeToCeylonFloat(1.0);
         """;
    };
}

shared test
void stringFunctionReturnErasure() {
     compileAndCompare {
         """String f1() => "x";
            String? f2() => "x";
            Object f3() => "x";
            Object? f4() => "x";
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.String f1() => "x";

            $dart$core.String f2() => "x";

            $dart$core.Object f3() => $ceylon$language.dart$nativeToCeylonString("x");

            $dart$core.Object f4() => $ceylon$language.dart$nativeToCeylonString("x");
         """;
    };
}

shared test
void booleanArgumentErasure() {
    // TODO still need to generate $package$... alias for toplevels
    compileAndCompare {
         """void f1(Boolean x) {}
            void f2(Boolean? x) {}
            void f3(Object x) {}
            void f4(Object? x) {}
            void f5(\Itrue x) {}
            void f6(\Itrue? x) {}
            void f7(\Ifalse x) {}
            void f8(\Ifalse? x) {}
            void f9(\Itrue|\Ifalse x) {}
            void f10(Boolean|\Itrue x) {}
            void f11(Boolean|\Ifalse x) {}

            Boolean booleanBoolean = true;
            Object booleanObject = true;

            void callFunctions() {
                f1(booleanBoolean);
                f2(booleanBoolean);
                f2(null);
                f3(booleanBoolean);
                f3(booleanObject);
                f4(booleanBoolean);
                f4(booleanObject);
                f4(null);

                f5(true);
                f6(true);
                f6(null);
                f7(false);
                f8(false);
                f8(null);
                f9(true);

                f10(booleanBoolean);
                f10(booleanBoolean);
                f11(booleanBoolean);
                f11(booleanBoolean);
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void f1([$dart$core.bool x]) {}

            void f2([$dart$core.bool x]) {}

            void f3([$dart$core.Object x]) {}

            void f4([$dart$core.Object x]) {}

            void f5([$dart$core.bool x]) {}

            void f6([$dart$core.bool x]) {}

            void f7([$dart$core.bool x]) {}

            void f8([$dart$core.bool x]) {}

            void f9([$dart$core.bool x]) {}

            void f10([$dart$core.bool x]) {}

            void f11([$dart$core.bool x]) {}

            $dart$core.bool booleanBoolean = true;

            $dart$core.Object booleanObject = $ceylon$language.$true;

            void callFunctions() {
                f1($package$booleanBoolean);
                f2($package$booleanBoolean);
                f2(null);
                f3($ceylon$language.dart$nativeToCeylonBoolean($package$booleanBoolean));
                f3($package$booleanObject);
                f4($ceylon$language.dart$nativeToCeylonBoolean($package$booleanBoolean));
                f4($package$booleanObject);
                f4(null);
                f5(true);
                f6(true);
                f6(null);
                f7(false);
                f8(false);
                f8(null);
                f9(true);
                f10($package$booleanBoolean);
                f10($package$booleanBoolean);
                f11($package$booleanBoolean);
                f11($package$booleanBoolean);
            }
         """;
    };
}


shared test
void genericNonErasure() {
     compileAndCompare {
         """shared T generic<T>(T x)  {
                return x;
            }

            shared String nonGeneric(String x) {
                return x;
            }

            shared void run() {
                String myString1 = generic("true");
                String myString2 = nonGeneric("true");
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.Object generic([$dart$core.Object x]) {
                return x;
            }

            $dart$core.String nonGeneric([$dart$core.String x]) {
                return x;
            }

            void run() {
                $dart$core.String myString1 = $ceylon$language.dart$ceylonStringToNative(generic($ceylon$language.dart$nativeToCeylonString("true")));
                $dart$core.String myString2 = nonGeneric("true");
            }
         """;
    };
}

shared test
void functionRefNonErasure() {
    // TODO creating Callable's for references to functions not implemented yet
    compileAndCompare {
         """String echoString() => "x";

            shared void run() {
                value ref = echoString;
                value result = ref();
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.String echoString() => "x";

            void run() {
                $ceylon$language.Callable ref = echoString;
                $dart$core.String result = $ceylon$language.dart$ceylonStringToNative((ref).$delegate$());
            }
         """;
    };
}

shared test
void dontEraseArgumentsToValue() {
    // TODO creating Callable's for references to functions not implemented yet
    compileAndCompare {
         """String echoString(String s) => s;

            shared void run() {
                value ref = echoString;
                value result = ref(".");
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.String echoString([$dart$core.String s]) => s;

            void run() {
                $ceylon$language.Callable ref = echoString;
                $dart$core.String result = $ceylon$language.dart$ceylonStringToNative((ref).$delegate$($ceylon$language.dart$nativeToCeylonString(".")));
            }
         """;
     };
}
