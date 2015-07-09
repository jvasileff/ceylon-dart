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
                $dart$core.int j = $ceylon$language.dart$ceylonIntegerToNative($ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(1)).plus($ceylon$language.dart$nativeToCeylonInteger(1)));
                $dart$core.Object k = $ceylon$language.dart$nativeToCeylonInteger(i).plus($ceylon$language.dart$nativeToCeylonInteger(1)).plus($ceylon$language.dart$nativeToCeylonInteger(1));
            }

            void run() => $package$run();
         """;
     };
}
