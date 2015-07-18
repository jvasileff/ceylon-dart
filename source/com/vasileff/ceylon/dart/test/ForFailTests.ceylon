import ceylon.test {
    test
}

shared
class ForFailTests() {

    shared test
    void iterableIsAString() {
        compileAndCompare {
             """
                String myIterable = "abcd";
                shared void run() {
                    for (x in myIterable) {
                        print(x);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.String $package$myIterable = "abcd";

                $dart$core.String get myIterable => $package$myIterable;

                void $package$run() {{
                        $dart$core.Object element$1;
                        $ceylon$language.Iterator iterator$0 = $ceylon$language.String.instance($package$myIterable).iterator();
                        while ((element$1 = iterator$0.next()) is !$ceylon$language.Finished) {
                            $ceylon$language.Character x = element$1 as $ceylon$language.Character;
                            $ceylon$language.print(x);
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void iterableOfIntegers() {
        compileAndCompare {
             """
                {Integer*} myIterable = nothing;
                shared void run() {
                    for (x in myIterable) {
                        print(x);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Iterable $package$myIterable = $ceylon$language.nothing as $ceylon$language.Iterable;

                $ceylon$language.Iterable get myIterable => $package$myIterable;

                void $package$run() {{
                        $dart$core.Object element$1;
                        $ceylon$language.Iterator iterator$0 = $package$myIterable.iterator();
                        while ((element$1 = iterator$0.next()) is !$ceylon$language.Finished) {
                            $ceylon$language.Integer x = element$1 as $ceylon$language.Integer;
                            $ceylon$language.print(x);
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void iterableIsAUnion() {
        compileAndCompare {
             """
                {String*} | {Integer*} myIterable = nothing;
                shared void run() {
                    for (x in myIterable) {
                        print(x);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.Object $package$myIterable = $ceylon$language.nothing;

                $dart$core.Object get myIterable => $package$myIterable;

                void $package$run() {{
                        $dart$core.Object element$1;
                        $ceylon$language.Iterator iterator$0 = ($package$myIterable as $ceylon$language.Iterable).iterator();
                        while ((element$1 = iterator$0.next()) is !$ceylon$language.Finished) {
                            $dart$core.Object x = element$1;
                            $ceylon$language.print(x);
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void iterableOfAUnion() {
        compileAndCompare {
             """
                {String|Integer*} myIterable = nothing;
                shared void run() {
                    for (x in myIterable) {
                        print(x);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Iterable $package$myIterable = $ceylon$language.nothing as $ceylon$language.Iterable;

                $ceylon$language.Iterable get myIterable => $package$myIterable;

                void $package$run() {{
                        $dart$core.Object element$1;
                        $ceylon$language.Iterator iterator$0 = $package$myIterable.iterator();
                        while ((element$1 = iterator$0.next()) is !$ceylon$language.Finished) {
                            $dart$core.Object x = element$1;
                            $ceylon$language.print(x);
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void iterableOfNulls() {
        // FIXME unnecessary casting, maybe Null erasure issue.
        // NOTE: the iteration variable is of type Finished!
        compileAndCompare {
             """
                {Null*} myIterable = nothing;
                shared void run() {
                    for (x in myIterable) {
                        print(x);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.Iterable $package$myIterable = $ceylon$language.nothing as $ceylon$language.Iterable;

                $ceylon$language.Iterable get myIterable => $package$myIterable;

                void $package$run() {{
                        $ceylon$language.Finished element$1;
                        $ceylon$language.Iterator iterator$0 = $package$myIterable.iterator();
                        while ((element$1 = iterator$0.next() as $ceylon$language.Finished) is !$ceylon$language.Finished) {
                            $dart$core.Object x = element$1 as $dart$core.Object;
                            $ceylon$language.print(x);
                        }
                    }
                }

                void run() => $package$run();
             """;
        };
    }
}
