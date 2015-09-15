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
                        $dart$core.int i;
                        {
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

    shared test
    void isTestReplacement() {
        compileAndCompare {
             """
                void run() {
                    String|Integer|Float sif = 1.0;
                    while (is String sif) {
                        assert(false);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object sif = $ceylon$language.Float.instance(1.0);
                    while (true) {
                        $dart$core.String sif$0;
                        if (!(sif is $ceylon$language.String)) {
                            break;
                        }
                        sif$0 = $ceylon$language.String.nativeValue(sif as $ceylon$language.String);
                        if (!false) {
                            throw new $ceylon$language.AssertionError("Violated: false");
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void isTestNoReplacement() {
        compileAndCompare {
             """
                void run() {
                    String|Integer|Float sif = 1.0;
                    while (is String|Integer sif) {
                        assert(false);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object sif = $ceylon$language.Float.instance(1.0);
                    while (true) {
                        if (!((sif is $ceylon$language.String) || (sif is $ceylon$language.Integer))) {
                            break;
                        }
                        if (!false) {
                            throw new $ceylon$language.AssertionError("Violated: false");
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void existsTestNoReplacement() {
        compileAndCompare {
             """
                void run() {
                    String|Integer|Float? sif = null;
                    while (exists sif) {
                        assert(false);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object sif = null;
                    while (true) {
                        if (sif == null) {
                            break;
                        }
                        if (!false) {
                            throw new $ceylon$language.AssertionError("Violated: false");
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }
}
