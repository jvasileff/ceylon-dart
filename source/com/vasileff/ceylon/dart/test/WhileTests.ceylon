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
                    while ($ceylon$language.Integer.instance(i).smallerThan($ceylon$language.Integer.instance(10))) {
                        $ceylon$language.print($ceylon$language.Integer.instance(i = $ceylon$language.Integer.nativeValue($ceylon$language.Integer.instance(i).successor)));
                    }
                }

                void run() => $package$run();
             """;
        };
    }
}
