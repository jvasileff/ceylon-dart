import ceylon.test {
    test
}

shared
class QualifiedExpressionTests() {

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

                $ceylon$language.List $package$something = $ceylon$language.nothing as $ceylon$language.List;

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

    shared test
    void nullSafeMemberOperator() {
        compileAndCompare {
             """
                shared void run() {
                    String? os1 = "os1";
                    String? os2 = null;

                    print(os1?.size);
                    print(os2?.size);

                    value fos1 = os1?.getFromFirst;
                    value fos2 = os2?.getFromFirst;

                    print(fos1(0));
                    print(fos2(0));

                    print(os1?.getFromFirst(0));
                    print(os2?.getFromFirst(0));
                }
             """;
             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String os1 = "os1";
                    $dart$core.String os2 = null;
                    $ceylon$language.print($ceylon$language.Integer.instance((($ceylon$language.String $r$) => $r$ == null ? null : $r$.size)($ceylon$language.String.instance(os1))));
                    $ceylon$language.print($ceylon$language.Integer.instance((($ceylon$language.String $r$) => $r$ == null ? null : $r$.size)($ceylon$language.String.instance(os2))));
                    $ceylon$language.Callable fos1 = (() {
                        $dart$core.Function $capturedDelegate$ = (($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst)($ceylon$language.String.instance(os1));
                        return new $ceylon$language.dart$Callable(([$dart$core.Object index]) {
                            return $capturedDelegate$ == null ? null : $capturedDelegate$($ceylon$language.Integer.nativeValue(index as $ceylon$language.Integer));
                        });
                    })();
                    $ceylon$language.Callable fos2 = (() {
                        $dart$core.Function $capturedDelegate$ = (($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst)($ceylon$language.String.instance(os2));
                        return new $ceylon$language.dart$Callable(([$dart$core.Object index]) {
                            return $capturedDelegate$ == null ? null : $capturedDelegate$($ceylon$language.Integer.nativeValue(index as $ceylon$language.Integer));
                        });
                    })();
                    $ceylon$language.print(fos1.$delegate$($ceylon$language.Integer.instance(0)));
                    $ceylon$language.print(fos2.$delegate$($ceylon$language.Integer.instance(0)));
                    $ceylon$language.print((($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst(0))($ceylon$language.String.instance(os1)));
                    $ceylon$language.print((($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst(0))($ceylon$language.String.instance(os2)));
                }

                void run() => $package$run();
             """;
         };
    }
}