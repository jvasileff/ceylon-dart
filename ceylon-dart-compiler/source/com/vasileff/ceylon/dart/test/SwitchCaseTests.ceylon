import ceylon.test {
    test,
    ignore
}

shared
class SwitchCaseTests() {

    shared test
    void switchStmtMatch() {
        compileAndCompare {
             """
                shared void run() {
                    switch (1+1)
                    case (1 | 2) {
                        print("one or two");
                    }
                    case (3) {
                        print("three");
                    }
                    else {
                        print("else");
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {{
                        $dart$core.int switch$0 = 1 + 1;
                        if ($ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(1)) || $ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(2))) {
                            $ceylon$language.print($ceylon$language.String.instance("one or two"));
                        } else if ($ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(3))) {
                            $ceylon$language.print($ceylon$language.String.instance("three"));
                        } else {
                            $ceylon$language.print($ceylon$language.String.instance("else"));
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchStmtIs() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    switch (si)
                    case (is String) {
                        print("string");
                        print(si.size);
                    }
                    case (is Integer) {
                        print("integer");
                    }
                    else {
                        print("fallback else");
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");{
                        $dart$core.Object switch$0 = si;
                        if (switch$0 is $ceylon$language.String) {
                            $dart$core.String si$1 = $ceylon$language.String.nativeValue(si as $ceylon$language.String);
                            $ceylon$language.print($ceylon$language.String.instance("string"));
                            $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance(si$1).size));
                        } else if (switch$0 is $ceylon$language.Integer) {
                            $dart$core.int si$2 = $ceylon$language.Integer.nativeValue(si as $ceylon$language.Integer);
                            $ceylon$language.print($ceylon$language.String.instance("integer"));
                        } else {
                            $ceylon$language.print($ceylon$language.String.instance("fallback else"));
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchStmtIsNoElse() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    switch (si)
                    case (is String) {
                        print("string");
                        print(si.size);
                    }
                    case (is Integer) {
                        print("integer");
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");{
                        $dart$core.Object switch$0 = si;
                        if (switch$0 is $ceylon$language.String) {
                            $dart$core.String si$1 = $ceylon$language.String.nativeValue(si as $ceylon$language.String);
                            $ceylon$language.print($ceylon$language.String.instance("string"));
                            $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance(si$1).size));
                        } else if (switch$0 is $ceylon$language.Integer) {
                            $dart$core.int si$2 = $ceylon$language.Integer.nativeValue(si as $ceylon$language.Integer);
                            $ceylon$language.print($ceylon$language.String.instance("integer"));
                        } else {
                            throw new $ceylon$language.AssertionError("Supposedly exhaustive switch was not exhaustive");
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchStmtVariableSpec() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    switch (newVar = si)
                    case (is String) {
                        print("string");
                        print(newVar.size);
                    }
                    case (is Integer) {
                        print("integer");
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");{
                        $dart$core.Object newVar = si;
                        if (newVar is $ceylon$language.String) {
                            $dart$core.String newVar$0 = $ceylon$language.String.nativeValue(newVar as $ceylon$language.String);
                            $ceylon$language.print($ceylon$language.String.instance("string"));
                            $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance(newVar$0).size));
                        } else if (newVar is $ceylon$language.Integer) {
                            $dart$core.int newVar$1 = $ceylon$language.Integer.nativeValue(newVar as $ceylon$language.Integer);
                            $ceylon$language.print($ceylon$language.String.instance("integer"));
                        } else {
                            throw new $ceylon$language.AssertionError("Supposedly exhaustive switch was not exhaustive");
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchExprMatch() {
        compileAndCompare {
             """
                shared void run() {
                    value a =
                        switch (1+1)
                        case (1 | 2) "one or two"
                        case (3) "three"
                        else "else";
                    print(a);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String a = (() {
                        $dart$core.int switch$0 = 1 + 1;
                        if ($ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(1)) || $ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(2))) {
                            return "one or two";
                        } else if ($ceylon$language.Integer.instance(switch$0).equals($ceylon$language.Integer.instance(3))) {
                            return "three";
                        } else {
                            return "else";
                        }
                    })();
                    $ceylon$language.print($ceylon$language.String.instance(a));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchExprIs() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    value a =
                        switch (si)
                        case (is String) "string" + si.size.string
                        case (is Integer) "integer"
                        else "fallback else";
                    print(a);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");
                    $dart$core.String a = (() {
                        $dart$core.Object switch$0 = si;
                        if (switch$0 is $ceylon$language.String) {
                            $dart$core.String si$1 = $ceylon$language.String.nativeValue(si as $ceylon$language.String);
                            return "string" + $ceylon$language.Integer.instance($ceylon$language.String.instance(si$1).size).toString();
                        } else if (switch$0 is $ceylon$language.Integer) {
                            $dart$core.int si$2 = $ceylon$language.Integer.nativeValue(si as $ceylon$language.Integer);
                            return "integer";
                        } else {
                            return "fallback else";
                        }
                    })();
                    $ceylon$language.print($ceylon$language.String.instance(a));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchExprIsNoElse() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    value a =
                        switch (si)
                        case (is String) "string" + si.size.string
                        case (is Integer) "integer";
                    print(a);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");
                    $dart$core.String a = (() {
                        $dart$core.Object switch$0 = si;
                        if (switch$0 is $ceylon$language.String) {
                            $dart$core.String si$1 = $ceylon$language.String.nativeValue(si as $ceylon$language.String);
                            return "string" + $ceylon$language.Integer.instance($ceylon$language.String.instance(si$1).size).toString();
                        } else if (switch$0 is $ceylon$language.Integer) {
                            $dart$core.int si$2 = $ceylon$language.Integer.nativeValue(si as $ceylon$language.Integer);
                            return "integer";
                        } else {
                            throw new $ceylon$language.AssertionError("Supposedly exhaustive switch was not exhaustive");
                        }
                    })();
                    $ceylon$language.print($ceylon$language.String.instance(a));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void switchExprVariableSpec() {
        compileAndCompare {
             """
                shared void run() {
                    String|Integer si = "";
                    value a =
                        switch (newVar = si)
                        case (is String) "string" + newVar.size.string
                        case (is Integer) "integer";
                    print(a);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object si = $ceylon$language.String.instance("");
                    $dart$core.String a = (() {
                        $dart$core.Object newVar = si;
                        if (newVar is $ceylon$language.String) {
                            $dart$core.String newVar$0 = $ceylon$language.String.nativeValue(newVar as $ceylon$language.String);
                            return "string" + $ceylon$language.Integer.instance($ceylon$language.String.instance(newVar$0).size).toString();
                        } else if (newVar is $ceylon$language.Integer) {
                            $dart$core.int newVar$1 = $ceylon$language.Integer.nativeValue(newVar as $ceylon$language.Integer);
                            return "integer";
                        } else {
                            throw new $ceylon$language.AssertionError("Supposedly exhaustive switch was not exhaustive");
                        }
                    })();
                    $ceylon$language.print($ceylon$language.String.instance(a));
                }

                void run() => $package$run();
             """;
        };
    }
}
