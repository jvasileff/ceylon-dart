import ceylon.test {
    test
}

shared
class WhileTests() {

    shared test
    void simpleWhileLoop() {
        compileAndCompare {
             """
                void run() {
                    variable Integer i = 0;
                    while (i < 10) {
                        print(++i);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.int i = 0;
                    while (i < 10) {
                        $ceylon$language.print($ceylon$language.Integer.instance(i = $ceylon$language.Integer.nativeValue($ceylon$language.Integer.instance(i).successor)));
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void isDeclareNewTest() {
        compileAndCompare {
             """
                void run() {
                    variable Integer|String isv = 0;
                    while (is Integer i = isv) {
                        isv = "";
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object isv = $ceylon$language.Integer.instance(0);
                    while (true) {
                        $dart$core.int i;{
                            $dart$core.Object i$0 = isv;
                            if (!(i$0 is $ceylon$language.Integer)) {
                                break;
                            }
                            i = $ceylon$language.Integer.nativeValue(i$0 as $ceylon$language.Integer);
                        }
                        isv = $ceylon$language.String.instance("");
                    }
                }

                void run() => $package$run();
             """;
        };
    }


}
