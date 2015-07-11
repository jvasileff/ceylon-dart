import ceylon.test {
    test
}

shared test
void genericComparable() {
    compileAndCompare {
         """shared Element smallest<Element>(Element x, Element y)
                    given Element satisfies Comparable<Element>
                =>  if (x<y) then x else y;
         """;

         """import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            $dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (() {
                if ((x as $ceylon$language.Comparable).smallerThan(y)) {
                    return x;
                } else {
                    return y;
                }
            })();

            $dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);
         """;
    };
}

shared test
void addNumbers() {
    compileAndCompare {
         """
            shared void run() {
                Integer i = 1;
                Integer j = i + 1 + 1;
                Object k = i + 1 + 1;
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$run() {
                $dart$core.int i = 1;
                $dart$core.int j = $ceylon$language.Integer.nativeValue($ceylon$language.Integer.instance(i).plus($ceylon$language.Integer.instance(1)).plus($ceylon$language.Integer.instance(1)));
                $dart$core.Object k = $ceylon$language.Integer.instance(i).plus($ceylon$language.Integer.instance(1)).plus($ceylon$language.Integer.instance(1));
            }

            void run() => $package$run();
         """;
     };
}

shared test
void boxIfElseExpression() {
    compileAndCompare {
         """
            shared void run() {
                Integer x = 1;
                Integer y = 1;
                Integer z = if (x > y) then x else y;
                Object o = if (x > y) then x else y;
                Object p = if (x > y) then x else "";
                Object q = if (x > y) then x else o;
            }
         """;

         """
            import "dart:core" as $dart$core;
            import "package:ceylon/language/language.dart" as $ceylon$language;

            void $package$run() {
                $dart$core.int x = 1;
                $dart$core.int y = 1;
                $dart$core.int z = (() {
                    if ($ceylon$language.Integer.instance(x).largerThan($ceylon$language.Integer.instance(y))) {
                        return x;
                    } else {
                        return y;
                    }
                })();
                $dart$core.Object o = (() {
                    if ($ceylon$language.Integer.instance(x).largerThan($ceylon$language.Integer.instance(y))) {
                        return $ceylon$language.Integer.instance(x);
                    } else {
                        return $ceylon$language.Integer.instance(y);
                    }
                })();
                $dart$core.Object p = (() {
                    if ($ceylon$language.Integer.instance(x).largerThan($ceylon$language.Integer.instance(y))) {
                        return $ceylon$language.Integer.instance(x);
                    } else {
                        return $ceylon$language.String.instance("");
                    }
                })();
                $dart$core.Object q = (() {
                    if ($ceylon$language.Integer.instance(x).largerThan($ceylon$language.Integer.instance(y))) {
                        return $ceylon$language.Integer.instance(x);
                    } else {
                        return o;
                    }
                })();
            }

            void run() => $package$run();
         """;
    };
}
