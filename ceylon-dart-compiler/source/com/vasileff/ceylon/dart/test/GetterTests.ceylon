import ceylon.test {
    test
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

    shared test
    void interfaceGetterLazy() {
        compileAndCompare {
             """
                interface I {
                    shared String a => "";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get a;
                    static $dart$core.String $get$a([final I $this]) => "";
                }
             """;
        };
    }

    shared test
    void interfaceGetterBlock() {
        compileAndCompare {
             """
                interface I {
                    shared String a { return ""; }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get a;
                    static $dart$core.String $get$a([final I $this]) {
                        return "";
                    }
                }
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