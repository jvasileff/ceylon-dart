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

            $dart$core.bool $package$f1() => true;

            $dart$core.bool f1() => $package$f1();

            $dart$core.bool $package$f2() => true;

            $dart$core.bool f2() => $package$f2();

            $dart$core.Object $package$f3() => $ceylon$language.$true;

            $dart$core.Object f3() => $package$f3();

            $dart$core.Object $package$f4() => $ceylon$language.$true;

            $dart$core.Object f4() => $package$f4();

            $dart$core.bool $package$f5() => true;

            $dart$core.bool f5() => $package$f5();

            $dart$core.bool $package$f6() => true;

            $dart$core.bool f6() => $package$f6();

            $dart$core.bool $package$f7() => false;

            $dart$core.bool f7() => $package$f7();

            $dart$core.bool $package$f8() => false;

            $dart$core.bool f8() => $package$f8();

            $dart$core.bool $package$f9() => true;

            $dart$core.bool f9() => $package$f9();

            $dart$core.bool $package$f10() => true;

            $dart$core.bool f10() => $package$f10();

            $dart$core.bool $package$f11() => true;

            $dart$core.bool f11() => $package$f11();
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

            $dart$core.int $package$f1() => 1;

            $dart$core.int f1() => $package$f1();

            $dart$core.int $package$f2() => 1;

            $dart$core.int f2() => $package$f2();

            $dart$core.Object $package$f3() => $ceylon$language.dart$nativeToCeylonInteger(1);

            $dart$core.Object f3() => $package$f3();

            $dart$core.Object $package$f4() => $ceylon$language.dart$nativeToCeylonInteger(1);

            $dart$core.Object f4() => $package$f4();
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

            $dart$core.double $package$f1() => 1.0;

            $dart$core.double f1() => $package$f1();

            $dart$core.double $package$f2() => 1.0;

            $dart$core.double f2() => $package$f2();

            $dart$core.Object $package$f3() => $ceylon$language.dart$nativeToCeylonFloat(1.0);

            $dart$core.Object f3() => $package$f3();

            $dart$core.Object $package$f4() => $ceylon$language.dart$nativeToCeylonFloat(1.0);

            $dart$core.Object f4() => $package$f4();
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

            $dart$core.String $package$f1() => "x";

            $dart$core.String f1() => $package$f1();

            $dart$core.String $package$f2() => "x";

            $dart$core.String f2() => $package$f2();

            $dart$core.Object $package$f3() => $ceylon$language.dart$nativeToCeylonString("x");

            $dart$core.Object f3() => $package$f3();

            $dart$core.Object $package$f4() => $ceylon$language.dart$nativeToCeylonString("x");

            $dart$core.Object f4() => $package$f4();
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

            void $package$f1([$dart$core.bool x]) {}

            void f1([$dart$core.bool x]) => $package$f1(x);

            void $package$f2([$dart$core.bool x]) {}

            void f2([$dart$core.bool x]) => $package$f2(x);

            void $package$f3([$dart$core.Object x]) {}

            void f3([$dart$core.Object x]) => $package$f3(x);

            void $package$f4([$dart$core.Object x]) {}

            void f4([$dart$core.Object x]) => $package$f4(x);

            void $package$f5([$dart$core.bool x]) {}

            void f5([$dart$core.bool x]) => $package$f5(x);

            void $package$f6([$dart$core.bool x]) {}

            void f6([$dart$core.bool x]) => $package$f6(x);

            void $package$f7([$dart$core.bool x]) {}

            void f7([$dart$core.bool x]) => $package$f7(x);

            void $package$f8([$dart$core.bool x]) {}

            void f8([$dart$core.bool x]) => $package$f8(x);

            void $package$f9([$dart$core.bool x]) {}

            void f9([$dart$core.bool x]) => $package$f9(x);

            void $package$f10([$dart$core.bool x]) {}

            void f10([$dart$core.bool x]) => $package$f10(x);

            void $package$f11([$dart$core.bool x]) {}

            void f11([$dart$core.bool x]) => $package$f11(x);

            $dart$core.bool $package$booleanBoolean = true;

            $dart$core.bool get booleanBoolean => $package$booleanBoolean;

            $dart$core.Object $package$booleanObject = $ceylon$language.$true;

            $dart$core.Object get booleanObject => $package$booleanObject;

            void $package$callFunctions() {
                $package$f1($package$booleanBoolean);
                $package$f2($package$booleanBoolean);
                $package$f2(null);
                $package$f3($ceylon$language.dart$nativeToCeylonBoolean($package$booleanBoolean));
                $package$f3($package$booleanObject);
                $package$f4($ceylon$language.dart$nativeToCeylonBoolean($package$booleanBoolean));
                $package$f4($package$booleanObject);
                $package$f4(null);
                $package$f5(true);
                $package$f6(true);
                $package$f6(null);
                $package$f7(false);
                $package$f8(false);
                $package$f8(null);
                $package$f9(true);
                $package$f10($package$booleanBoolean);
                $package$f10($package$booleanBoolean);
                $package$f11($package$booleanBoolean);
                $package$f11($package$booleanBoolean);
            }

            void callFunctions() => $package$callFunctions();
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

            $dart$core.Object $package$generic([$dart$core.Object x]) {
                return x;
            }

            $dart$core.Object generic([$dart$core.Object x]) => $package$generic(x);

            $dart$core.String $package$nonGeneric([$dart$core.String x]) {
                return x;
            }

            $dart$core.String nonGeneric([$dart$core.String x]) => $package$nonGeneric(x);

            void $package$run() {
                $dart$core.String myString1 = $ceylon$language.dart$ceylonStringToNative($package$generic($ceylon$language.dart$nativeToCeylonString("true")) as $ceylon$language.String);
                $dart$core.String myString2 = $package$nonGeneric("true");
            }

            void run() => $package$run();
         """;
    };
}

shared test
void functionRefNonErasure() {
    compileAndCompare {
         """String echoString() => "x";

            shared void run() {
                value ref = echoString;
                value result = ref();
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.String $package$echoString() => "x";

            $dart$core.String echoString() => $package$echoString();

            void $package$run() {
                $ceylon$language.Callable ref = new $ceylon$language.dart$Callable(() {
                    return $ceylon$language.dart$nativeToCeylonString($package$echoString());
                });
                $dart$core.String result = $ceylon$language.dart$ceylonStringToNative(ref.$delegate$() as $ceylon$language.String);
            }

            void run() => $package$run();
         """;
    };
}

shared test
void dontEraseArgumentsToValue() {
    compileAndCompare {
         """String echoString(String s) => s;

            shared void run() {
                value ref = echoString;
                value result = ref(".");
            }
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.String $package$echoString([$dart$core.String s]) => s;

            $dart$core.String echoString([$dart$core.String s]) => $package$echoString(s);

            void $package$run() {
                $ceylon$language.Callable ref = new $ceylon$language.dart$Callable(([$dart$core.Object s]) {
                    return $ceylon$language.dart$nativeToCeylonString($package$echoString($ceylon$language.dart$ceylonStringToNative(s as $ceylon$language.String)));
                });
                $dart$core.String result = $ceylon$language.dart$ceylonStringToNative(ref.$delegate$($ceylon$language.dart$nativeToCeylonString(".")) as $ceylon$language.String);
            }

            void run() => $package$run();
         """;
     };
}

shared test
void methodRefinementArgumentErasure() {
    // TODO casting of invocation results isn't correct when the
    //      result is an expression for the receiver of a subsequent
    //      invocation
    compileAndCompare {
         """
            shared void run() {
                Integer i = 1;
                Integer j = i.plus(1);
                Integer k = i.plus(2).plus(3);
                Object l = i.plus(4);
                Object m = i.plus(5).plus(6);
                Integer n = 1.plus(1).plus(1);
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$run() {
                $dart$core.int i = 1;
                $dart$core.int j = $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Integer);
                $dart$core.int k = $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(2)).plus($ceylon$language.dart$nativeToCeylonInteger(3)) as $ceylon$language.Integer);
                $dart$core.Object l = $ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(4));
                $dart$core.Object m = $ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(5)).plus($ceylon$language.dart$nativeToCeylonInteger(6));
                $dart$core.int n = $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(1).plus($ceylon$language.dart$nativeToCeylonInteger(1)).plus($ceylon$language.dart$nativeToCeylonInteger(1)) as $ceylon$language.Integer);
            }

            void run() => $package$run();
         """;
     };
}
