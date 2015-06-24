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
