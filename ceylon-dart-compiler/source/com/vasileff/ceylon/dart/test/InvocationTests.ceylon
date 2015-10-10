import ceylon.test {
    test
}

shared
class InvocationTests() {

    shared test
    void invokeClassInInterfaceInInterface() {
        compileAndCompare {
             """
                interface I {
                    shared interface J {
                        shared class C() {}
                    }
                    shared J j => object satisfies J {};
                }

                I.J j = object satisfies I {}.j;

                I.J.C() newC = I.J.C(j);
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class I$J$C {
                    I$J $outer$default$I$J;
                    I$J$C([I$J this.$outer$default$I$J]) {}
                }
                abstract class I$J {
                    I get $outer$default$I;
                }
                class I$j$$anonymous$0_ implements I$J {
                    I $outer$default$I;
                    I$j$$anonymous$0_([I this.$outer$default$I]) {}
                }
                abstract class I {
                    I$J get j;
                    static I$J $get$j([final I $this]) => new I$j$$anonymous$0_($this);
                }
                class j$$anonymous$1_ implements I {
                    j$$anonymous$1_() {}
                    I$J get j => I.$get$j(this);
                }
                I$J $package$j = (new j$$anonymous$1_()).j;

                I$J get j => $package$j;

                $ceylon$language.Callable $package$newC = new $ceylon$language.dart$Callable(() => new I$J$C($package$j));

                $ceylon$language.Callable get newC => $package$newC;
             """;
        };
    }

    "This is a special case where the method cannot be invoked on $this."
    shared test
    void namedArgNonsharedInterfaceMethodBaseExpression() {
        compileAndCompare {
             """
                interface I {
                    String echo(String s) => s;

                    shared void foo() {
                        print(echo("list"));
                        print(echo { "named"; });
                    }
                }
                shared void run() {
                    object satisfies I {}.foo();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    static $dart$core.String $echo([final I $this, $dart$core.String s]) => s;
                    void foo();
                    static void $foo([final I $this]) {
                        $ceylon$language.print($ceylon$language.String.instance(I.$echo($this, "list")));
                        $ceylon$language.print((() {
                            $dart$core.String arg$0$0 = "named";
                            return $ceylon$language.String.instance(I.$echo($this, arg$0$0));
                        })());
                    }
                }
                class run$$anonymous$0_ implements I {
                    run$$anonymous$0_() {}
                    void foo() => I.$foo(this);
                }
                void $package$run() {
                    (new run$$anonymous$0_()).foo();
                }

                void run() => $package$run();
             """;
        };
    }


    shared test
    void namedArgToplevelFunction() {
        compileAndCompare {
             """
                String echo(String s) => s;

                shared void run() {
                    print(echo("list"));
                    print(package.echo("list"));
                    print(echo { "named"; });
                    print(package.echo { "named"; });
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.String $package$echo([$dart$core.String s]) => s;

                $dart$core.String echo([$dart$core.String s]) => $package$echo(s);

                void $package$run() {
                    $ceylon$language.print($ceylon$language.String.instance($package$echo("list")));
                    $ceylon$language.print($ceylon$language.String.instance($package$echo("list")));
                    $ceylon$language.print((() {
                        $dart$core.String arg$0$0 = "named";
                        return $ceylon$language.String.instance($package$echo(arg$0$0));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.String arg$1$0 = "named";
                        return $ceylon$language.String.instance($package$echo(arg$1$0));
                    })());
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void indirectWithSpreads() {
        compileAndCompare {
             """
                shared void run() {
                    [Integer*](Integer, Integer, Integer*) f2 = (Integer a, Integer b, Integer* xs) => [a, b, *xs];
                    [Integer*](Integer, Integer*) f1 = (Integer a, Integer* xs) => [a, *xs];
                    [Integer*](Integer*) f0 = (Integer* xs) => xs;

                    print(f0(*{1, 2, 3, 4}));   // spread iterable (compiler must add .sequence())

                    print("");
                    print(f2(1, 2, 3, 4));      // tests (f) using regular as variadic
                    print(f2(1, 2, 3));         // tests (f) using regular as variadic
                    print(f2(1, 2));            // tests (f)

                    print("");
                    print(f2(1, 2, 3, *[4]));   // tests (s) using regular as variadic join
                    print(f2(1, 2, 3, *[]));    // tests (s) using regular as variadic join empty

                    print("");
                    print(f2(1, 2, *[3, 4]));   // tests (s) pass-through
                    print(f2(1, 2, *[3]));      // tests (s) pass-through
                    print(f2(1, 2, *[]));       // tests (s) pass-through

                    print("");
                    print(f2(1, *[2, 3, 4]));   // tests (s) splitting spread
                    print(f2(1, *[2, 3]));      // tests (s) splitting spread
                    print(f2(1, *[2]));         // tests (s) using spread as regular
                    print(f2(*[1, 2]));         // tests (s) using spread as regular

                    print("");
                    print(f1(1, 2, 3));         // tests (f) using regular as variadic
                    print(f1(1, 2));            // tests (f) using regular as variadic
                    print(f1(1));               // tests (f)

                    print("");
                    print(f1(1, 2, *[3]));      // tests (s) using regular as variadic join
                    print(f1(1, 2, *[]));       // tests (s) using regular as variadic join empty

                    print("");
                    print(f1(1, *[2, 3]));      // tests pass-through
                    print(f1(1, *[2]));         // tests pass-through
                    print(f1(1, *[]));          // tests pass-through

                    print("");
                    print(f1(*[1, 2, 3]));      // tests splitting spread
                    print(f1(*[1, 2]));         // tests splitting spread
                    print(f1(*[1]));            // tests using spread as regular

                    print("");
                    print(f0(1, 2));            // tests (f) using regular as variadic
                    print(f0(1));               // tests (f) using regular as variadic
                    print(f0());                // tests (f) empty variadic

                    print("");
                    print(f0(1, *[2]));      // tests (s) using regular as variadic join
                    print(f0(1, *[]));          // tests (s) using regular as variadic join empty

                    print("");
                    print(f0(*[1, 2]));         // tests pass-through
                    print(f0(*[1]));            // tests pass-through
                    print(f0(*[]));             // tests pass-through
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable f2 = new $ceylon$language.dart$Callable(([$ceylon$language.Integer a, $ceylon$language.Integer b, $ceylon$language.Sequential xs]) => new $ceylon$language.Tuple.$withList([a, b], xs), 2);
                    $ceylon$language.Callable f1 = new $ceylon$language.dart$Callable(([$ceylon$language.Integer a, $ceylon$language.Sequential xs]) => new $ceylon$language.Tuple.$withList([a], xs), 1);
                    $ceylon$language.Callable f0 = new $ceylon$language.dart$Callable(([$ceylon$language.Sequential xs]) => xs, 0);
                    $ceylon$language.print(f0.s((new $ceylon$language.LazyIterable(4, (final $dart$core.int $i$) {
                        switch ($i$) {
                        case 0 :
                        return $ceylon$language.Integer.instance(1);
                        case 1 :
                        return $ceylon$language.Integer.instance(2);
                        case 2 :
                        return $ceylon$language.Integer.instance(3);
                        case 3 :
                        return $ceylon$language.Integer.instance(4);
                        }
                    }, null)).sequence()));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)));
                    $ceylon$language.print(f2.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)));
                    $ceylon$language.print(f2.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(4)], null)));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)], null)));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], null)));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)], null)));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null)));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print(f2.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1)));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], null)));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null)));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null)));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)], null)));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)));
                    $ceylon$language.print(f0.f($ceylon$language.Integer.instance(1)));
                    $ceylon$language.print(f0.f());
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print(f0.s($ceylon$language.Integer.instance(1), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)], null)));
                    $ceylon$language.print(f0.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)], null)));
                    $ceylon$language.print(f0.s($ceylon$language.empty));
                }

                void run() => $package$run();
             """;
        };
    }
}
