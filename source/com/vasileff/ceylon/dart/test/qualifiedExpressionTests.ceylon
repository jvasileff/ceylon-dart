import ceylon.test {
    test
}

shared test
void simpleQualifiedExpressions() {
    compileAndCompare {
         """
            void run() {
                variable String s = "-";
                print(s.size);
                print("".size);
                Object o = s.size;
                value f1 = "".contains;
                value b = "".contains("apples");
            }

         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$run() {
                $dart$core.String s = "-";
                $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance(s).size));
                $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance("").size));
                $dart$core.Object o = $ceylon$language.Integer.instance($ceylon$language.String.instance(s).size);
                $ceylon$language.Callable f1 = (() {
                    $dart$core.Function $capturedDelegate$ = $ceylon$language.String.instance("").contains;
                    return new $ceylon$language.dart$Callable(([$dart$core.Object element]) {
                        return $ceylon$language.Boolean.instance($capturedDelegate$(element));
                    });
                })();
                $dart$core.bool b = $ceylon$language.String.instance("").contains($ceylon$language.String.instance("apples"));
            }

            void run() => $package$run();
         """;
    };
}

shared test
void toplevelQualifiedExpressionWithCasting() {
    compileAndCompare {
         """
            List&Usable something = nothing;

            void run() {
                value c = something.contains;
                something.contains("x");
                print(something.contains("x"));
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.Object $package$something = $ceylon$language.nothing;

            $dart$core.Object get something => $package$something;

            void $package$run() {
                $ceylon$language.Callable c = (() {
                    $dart$core.Function $capturedDelegate$ = ($package$something as $ceylon$language.List).contains;
                    return new $ceylon$language.dart$Callable(([$dart$core.Object element]) {
                        return $ceylon$language.Boolean.instance($capturedDelegate$(element));
                    });
                })();
                ($package$something as $ceylon$language.List).contains($ceylon$language.String.instance("x"));
                $ceylon$language.print($ceylon$language.Boolean.instance(($package$something as $ceylon$language.List).contains($ceylon$language.String.instance("x"))));
            }

            void run() => $package$run();
         """;
    };
}

shared test
void toplevelQualifiedExpressionWithoutCasting() {
    compileAndCompare {
         """
            List something = nothing;

            void run() {
                value c = something.contains;
                something.contains("x");
                print(something.contains("x"));
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $ceylon$language.List $package$something = $ceylon$language.nothing;

            $ceylon$language.List get something => $package$something;

            void $package$run() {
                $ceylon$language.Callable c = (() {
                    $dart$core.Function $capturedDelegate$ = $package$something.contains;
                    return new $ceylon$language.dart$Callable(([$dart$core.Object element]) {
                        return $ceylon$language.Boolean.instance($capturedDelegate$(element));
                    });
                })();
                $package$something.contains($ceylon$language.String.instance("x"));
                $ceylon$language.print($ceylon$language.Boolean.instance($package$something.contains($ceylon$language.String.instance("x"))));
            }

            void run() => $package$run();
         """;
    };
}
