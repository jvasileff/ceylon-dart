import ceylon.test {
    test,
    ignore
}

shared
class GetterTests() {

    shared test
    void toplevelGetterLazy() {
        compileAndCompare {
             """
                String a => "";
                String b = a;
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.String get $package$a => "";

                $dart$core.String get a => $package$a;

                $dart$core.String $package$b = $package$a;

                $dart$core.String get b => $package$b;
             """;
        };
    }

    shared test
    void toplevelGetterBlock() {
        compileAndCompare {
             """
                String a { return ""; }
                String b = a;
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.String get $package$a {
                    return "";
                }

                $dart$core.String get a => $package$a;

                $dart$core.String $package$b = $package$a;

                $dart$core.String get b => $package$b;
             """;
        };
    }

    shared test ignore
    void interfaceGetterLazy() {
        // TODO
        compileAndCompare {
             """
                interface I {
                    shared String a => "";
                }
             """;

             """

             """;
        };
    }

    shared test ignore
    void interfaceGetterBlock() {
        // TODO
        compileAndCompare {
             """
                interface I {
                    shared String a { return ""; }
                }
             """;

             """

             """;
        };
    }

    shared test
    void functionGetterLazy() {
        compileAndCompare {
             """
                void f() {
                    String a => "";
                    String b = a;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$f() {
                    $dart$core.String a$get() => "";

                    $dart$core.String b = a$get();
                }

                void f() => $package$f();
             """;
        };
    }

    shared test
    void functionGetterBlock() {
        compileAndCompare {
             """
                void f() {
                    String a { return ""; }
                    String b = a;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$f() {
                    $dart$core.String a$get() {
                        return "";
                    }

                    $dart$core.String b = a$get();
                }

                void f() => $package$f();
             """;
        };
    }
}