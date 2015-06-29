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
