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
                    static $dart$core.String $_$echo([final I $this, $dart$core.String s]) => s;
                    void foo();
                    static void $foo([final I $this]) {
                        $ceylon$language.print($ceylon$language.String.instance(I.$_$echo($this, "list")));
                        $ceylon$language.print((() {
                            $dart$core.String arg$0$0 = "named";
                            return $ceylon$language.String.instance(I.$_$echo($this, arg$0$0));
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
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(4)])));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)])));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)])));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(f2.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(f2.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)));
                    $ceylon$language.print(f1.f($ceylon$language.Integer.instance(1)));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(f1.s($ceylon$language.Integer.instance(1), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(f1.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)])));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.f($ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)));
                    $ceylon$language.print(f0.f($ceylon$language.Integer.instance(1)));
                    $ceylon$language.print(f0.f());
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.s($ceylon$language.Integer.instance(1), new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(f0.s($ceylon$language.Integer.instance(1), $ceylon$language.empty));
                    $ceylon$language.print($ceylon$language.String.instance(""));
                    $ceylon$language.print(f0.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(f0.s(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)])));
                    $ceylon$language.print(f0.s($ceylon$language.empty));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void namedArgWithVariadic() {
        compileAndCompare {
             """
                shared void run() {
                    [Integer*] f2(Integer a, Integer b, Integer* xs) => [a, b, *xs];

                    print(f2 { 1; 2; [3]; }); // arg for variadic
                    print(f2 { 1; 2; });      // no arg for variadic
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Sequential f2([$dart$core.int a, $dart$core.int b, $ceylon$language.Sequential xs]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b)], xs);

                    $ceylon$language.print((() {
                        $dart$core.int arg$0$0 = 1;
                        $dart$core.int arg$0$1 = 2;
                        $ceylon$language.Sequential arg$0$2 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)]);
                        return f2(arg$0$0, arg$0$1, arg$0$2);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$1$0 = 1;
                        $dart$core.int arg$1$1 = 2;
                        return f2(arg$1$0, arg$1$1, $ceylon$language.empty);
                    })());
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void namedArgDefaultedIterables() {
        compileAndCompare {
             """
                shared void run() {
                    value it = [1, 2, 3];
                    // Non-defaulted iterable
                    {Integer*} fa({Integer*} xs) => xs;
                    print(fa { });
                    print(fa { *it });

                    // Defaulted iterable
                    {Integer*} fb({Integer*} xs = [1]) => xs;
                    print(fb { });
                    print(fb { *it });

                    // Iterable where the declaration is not constrainted to be
                    // of an Iterable type
                    print(identity<{Integer*}> { });
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Tuple it = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Iterable fa([$ceylon$language.Iterable xs]) => xs;

                    $ceylon$language.print(fa($ceylon$language.empty));
                    $ceylon$language.print((() {
                        $ceylon$language.Iterable arg$1$0 = it;
                        return fa(arg$1$0);
                    })());
                    $ceylon$language.Iterable fb([$dart$core.Object xs = $ceylon$language.dart$default]) {
                        if ($dart$core.identical(xs, $ceylon$language.dart$default)) {
                            xs = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)]);
                        }
                        return xs as $ceylon$language.Iterable;
                    }

                    $ceylon$language.print(fb($ceylon$language.dart$default));
                    $ceylon$language.print((() {
                        $dart$core.Object arg$3$0 = it;
                        return fb(arg$3$0);
                    })());
                    $ceylon$language.print($ceylon$language.identity($ceylon$language.empty));
                }

                void run() => $package$run();
             """;
        };
    }

    "Test for scenarios where the spread argument is *not* used for listed parameters."
    shared test
    void directWithSpreadSimple() {
        compileAndCompare {
             """
                shared void run() {
                    // with default
                    [Integer+] fa(Integer a, Integer b=99, Integer* rest) => [a, b, *rest];

                    print(fa(1));
                    print(fa(1, *[]));
                    print(fa(1, 2));
                    print(fa(1, 2, *[]));
                    print(fa(1, 2, *[3]));
                    print(fa(1, 2, 3));
                    print(fa(1, 2, 3, *[]));
                    print(fa(1, 2, 3, *[4]));
                    print(fa(1, 2, 3, *[4, *[]]));

                    // without default
                    [Integer+] fb(Integer a, Integer b, Integer* rest) => [a, b, *rest];

                    print(fb(1, 2));
                    print(fb(1, 2, *[]));
                    print(fb(1, 2, *[3]));
                    print(fb(1, 2, 3));
                    print(fb(1, 2, 3, *[]));
                    print(fb(1, 2, 3, *[4]));

                    // with default, without variadic
                    [Integer+] fc(Integer a, Integer b=98, Integer c=99) => [a, b, c];

                    print(fc(1));
                    print(fc(1, 2));
                    print(fc(1, 2, 3));

                    // with only variadic
                    [Integer*] fd(Integer* rest) => rest;

                    print(fd());
                    print(fd(*[]));
                    print(fd(1));
                    print(fd(1, *[]));
                    print(fd(1, 2));
                    print(fd(1, 2, *[]));

                    // with no params
                    [Integer*] fe() => [];
                    print(fe());
                    print(fe(*[]));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Sequence fa([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default, $ceylon$language.Sequential rest]) {
                        if ($dart$core.identical(b, $ceylon$language.dart$default)) {
                            b = 99;
                        }
                        return new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b as $dart$core.int)], rest);
                    }

                    $ceylon$language.print(fa(1, $ceylon$language.dart$default, $ceylon$language.empty));
                    $ceylon$language.print((() {
                        $dart$core.int arg$0$0 = 1;
                        $ceylon$language.Empty arg$0$s = $ceylon$language.empty;
                        return fa(arg$0$0, $ceylon$language.dart$default, $ceylon$language.empty);
                    })());
                    $ceylon$language.print(fa(1, 2, $ceylon$language.empty));
                    $ceylon$language.print(fa(1, 2, $ceylon$language.empty));
                    $ceylon$language.print(fa(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(fa(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(fa(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], $ceylon$language.empty)));
                    $ceylon$language.print(fa(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(4)]))));
                    $ceylon$language.print(fa(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(4)], $ceylon$language.empty))));
                    $ceylon$language.Sequence fb([$dart$core.int a, $dart$core.int b, $ceylon$language.Sequential rest]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b)], rest);

                    $ceylon$language.print(fb(1, 2, $ceylon$language.empty));
                    $ceylon$language.print(fb(1, 2, $ceylon$language.empty));
                    $ceylon$language.print(fb(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(fb(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)])));
                    $ceylon$language.print(fb(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], $ceylon$language.empty)));
                    $ceylon$language.print(fb(1, 2, new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3)], new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(4)]))));
                    $ceylon$language.Sequence fc([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default, $dart$core.Object c = $ceylon$language.dart$default]) {
                        if ($dart$core.identical(b, $ceylon$language.dart$default)) {
                            b = 98;
                        }
                        if ($dart$core.identical(c, $ceylon$language.dart$default)) {
                            c = 99;
                        }
                        return new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b as $dart$core.int), $ceylon$language.Integer.instance(c as $dart$core.int)]);
                    }

                    $ceylon$language.print(fc(1));
                    $ceylon$language.print(fc(1, 2));
                    $ceylon$language.print(fc(1, 2, 3));
                    $ceylon$language.Sequential fd([$ceylon$language.Sequential rest]) => rest;

                    $ceylon$language.print(fd($ceylon$language.empty));
                    $ceylon$language.print(fd($ceylon$language.empty));
                    $ceylon$language.print(fd(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)])));
                    $ceylon$language.print(fd(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)], $ceylon$language.empty)));
                    $ceylon$language.print(fd(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)])));
                    $ceylon$language.print(fd(new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)], $ceylon$language.empty)));
                    $ceylon$language.Sequential fe() => $ceylon$language.empty;

                    $ceylon$language.print(fe());
                    $ceylon$language.print((() {
                        $ceylon$language.empty;
                        return fe();
                    })());
                }

                void run() => $package$run();
             """;
        };
    }

    "Test for scenarios where the spread argument *is* used for listed parameters."
    shared test
    void directWithSpreadAdvanced() {
        compileAndCompare {
             """
                shared void run() {
                    // with default
                    [Integer+] fa(Integer a, Integer b=99, Integer* rest) => [a, b, *rest];

                    print(fa(*[1]));
                    print(fa(*[1,2]));
                    print(fa(*[1,2,3]));
                    print(fa(*[1,2,3,4]));

                    print(fa(1));
                    print(fa(1, *[]));
                    print(fa(1, *[2]));
                    print(fa(1, *[2,3]));
                    print(fa(1, *[2,3,4]));

                    // no default
                    [Integer+] fb(Integer a, Integer b, Integer* rest) => [a, b, *rest];

                    print(fb(*[1,2]));
                    print(fb(*[1,2,3]));
                    print(fb(*[1,2,3,4]));

                    print(fb(1, *[2]));
                    print(fb(1, *[2,3]));
                    print(fb(1, *[2,3,4]));

                    // no variadic default
                    [Integer+] fc(Integer a, Integer b=99) => [a, b];

                    print(fc(*[1]));
                    print(fc(*[1,2]));
                    print(fc(1, *[2]));

                    // no variadic no default
                    [Integer+] fd(Integer a, Integer b) => [a, b];

                    print(fd(*[1,2]));
                    print(fd(1, *[2]));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Sequence fa([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default, $ceylon$language.Sequential rest]) {
                        if ($dart$core.identical(b, $ceylon$language.dart$default)) {
                            b = 99;
                        }
                        return new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b as $dart$core.int)], rest);
                    }

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$0$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)]);
                        return fa($ceylon$language.Integer.nativeValue(arg$0$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.dart$default, $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$1$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                        return fa($ceylon$language.Integer.nativeValue(arg$1$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$1$s.getFromFirst(1) as $ceylon$language.Integer), $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$2$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                        return fa($ceylon$language.Integer.nativeValue(arg$2$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$2$s.getFromFirst(1) as $ceylon$language.Integer), arg$2$s.spanFrom($ceylon$language.Integer.instance(2)));
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$3$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)]);
                        return fa($ceylon$language.Integer.nativeValue(arg$3$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$3$s.getFromFirst(1) as $ceylon$language.Integer), arg$3$s.spanFrom($ceylon$language.Integer.instance(2)));
                    })());
                    $ceylon$language.print(fa(1, $ceylon$language.dart$default, $ceylon$language.empty));
                    $ceylon$language.print((() {
                        $dart$core.int arg$4$0 = 1;
                        $ceylon$language.Empty arg$4$s = $ceylon$language.empty;
                        return fa(arg$4$0, $ceylon$language.dart$default, $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$5$0 = 1;
                        $ceylon$language.Tuple arg$5$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)]);
                        return fa(arg$5$0, $ceylon$language.Integer.nativeValue(arg$5$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$6$0 = 1;
                        $ceylon$language.Tuple arg$6$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                        return fa(arg$6$0, $ceylon$language.Integer.nativeValue(arg$6$s.getFromFirst(0) as $ceylon$language.Integer), arg$6$s.spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$7$0 = 1;
                        $ceylon$language.Tuple arg$7$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)]);
                        return fa(arg$7$0, $ceylon$language.Integer.nativeValue(arg$7$s.getFromFirst(0) as $ceylon$language.Integer), arg$7$s.spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.Sequence fb([$dart$core.int a, $dart$core.int b, $ceylon$language.Sequential rest]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b)], rest);

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$8$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                        return fb($ceylon$language.Integer.nativeValue(arg$8$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$8$s.getFromFirst(1) as $ceylon$language.Integer), $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$9$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                        return fb($ceylon$language.Integer.nativeValue(arg$9$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$9$s.getFromFirst(1) as $ceylon$language.Integer), arg$9$s.spanFrom($ceylon$language.Integer.instance(2)));
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$10$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)]);
                        return fb($ceylon$language.Integer.nativeValue(arg$10$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$10$s.getFromFirst(1) as $ceylon$language.Integer), arg$10$s.spanFrom($ceylon$language.Integer.instance(2)));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$11$0 = 1;
                        $ceylon$language.Tuple arg$11$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)]);
                        return fb(arg$11$0, $ceylon$language.Integer.nativeValue(arg$11$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$12$0 = 1;
                        $ceylon$language.Tuple arg$12$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                        return fb(arg$12$0, $ceylon$language.Integer.nativeValue(arg$12$s.getFromFirst(0) as $ceylon$language.Integer), arg$12$s.spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$13$0 = 1;
                        $ceylon$language.Tuple arg$13$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3), $ceylon$language.Integer.instance(4)]);
                        return fb(arg$13$0, $ceylon$language.Integer.nativeValue(arg$13$s.getFromFirst(0) as $ceylon$language.Integer), arg$13$s.spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.Sequence fc([$dart$core.int a, $dart$core.Object b = $ceylon$language.dart$default]) {
                        if ($dart$core.identical(b, $ceylon$language.dart$default)) {
                            b = 99;
                        }
                        return new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b as $dart$core.int)]);
                    }

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$14$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)]);
                        return fc($ceylon$language.Integer.nativeValue(arg$14$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.dart$default);
                    })());
                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$15$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                        return fc($ceylon$language.Integer.nativeValue(arg$15$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$15$s.getFromFirst(1) as $ceylon$language.Integer));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$16$0 = 1;
                        $ceylon$language.Tuple arg$16$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)]);
                        return fc(arg$16$0, $ceylon$language.Integer.nativeValue(arg$16$s.getFromFirst(0) as $ceylon$language.Integer));
                    })());
                    $ceylon$language.Sequence fd([$dart$core.int a, $dart$core.int b]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a), $ceylon$language.Integer.instance(b)]);

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$17$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                        return fd($ceylon$language.Integer.nativeValue(arg$17$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.Integer.nativeValue(arg$17$s.getFromFirst(1) as $ceylon$language.Integer));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.int arg$18$0 = 1;
                        $ceylon$language.Tuple arg$18$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(2)]);
                        return fd(arg$18$0, $ceylon$language.Integer.nativeValue(arg$18$s.getFromFirst(0) as $ceylon$language.Integer));
                    })());
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void directWithSpreadUnbounded() {
        compileAndCompare {
             """
                shared void run() {
                    {Integer*} unbounded0 = {};
                    {Integer*} unbounded1 = {1};
                    {Integer*} unbounded2 = {1,2};

                    [Integer+] fa(Integer a, Integer* rest) => [a, *rest];
                    print(fa(*[0, *unbounded2]));

                    [Integer*] fb(Integer* rest) => rest;
                    print(fb(*unbounded0));
                    print(fb(*unbounded1));
                    print(fb(*unbounded2));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Iterable unbounded0 = $ceylon$language.empty;
                    $ceylon$language.Iterable unbounded1 = new $ceylon$language.LazyIterable(1, (final $dart$core.int $i$) {
                        switch ($i$) {
                        case 0 :
                        return $ceylon$language.Integer.instance(1);
                        }
                    }, null);
                    $ceylon$language.Iterable unbounded2 = new $ceylon$language.LazyIterable(2, (final $dart$core.int $i$) {
                        switch ($i$) {
                        case 0 :
                        return $ceylon$language.Integer.instance(1);
                        case 1 :
                        return $ceylon$language.Integer.instance(2);
                        }
                    }, null);
                    $ceylon$language.Sequence fa([$dart$core.int a, $ceylon$language.Sequential rest]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a)], rest);

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$0$s = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(0)], unbounded2.sequence());
                        return fa($ceylon$language.Integer.nativeValue(arg$0$s.getFromFirst(0) as $ceylon$language.Integer), arg$0$s.spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.Sequential fb([$ceylon$language.Sequential rest]) => rest;

                    $ceylon$language.print(fb(unbounded0.sequence()));
                    $ceylon$language.print(fb(unbounded1.sequence()));
                    $ceylon$language.print(fb(unbounded2.sequence()));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void directWithSpreadBoundedButUnknownLength() {
        compileAndCompare {
             """
                shared void run() {
                    []|[Integer] opt01 = [1];
                    []|[Integer]|[Integer,Integer] opt012 = [1,2];
                    []|[Integer]|[Integer,Integer]|[Integer,Integer,Integer] opt0123 = [1,2,3];

                    [Integer] opt1 = [1];
                    [Integer]|[Integer,Integer] opt12 = [1,2];
                    [Integer]|[Integer,Integer]|[Integer,Integer,Integer] opt123 = [1,2,3];

                    [Integer+] fa(Integer a=99, Integer* rest) => [a, *rest];
                    print(fa(*opt01));
                    print(fa(*opt012));
                    print(fa(*opt0123));

                    [Integer+] fb(Integer a, Integer* rest) => [a, *rest];
                    print(fb(*opt1));
                    print(fb(*opt12));
                    print(fb(*opt123));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.Object opt01 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)]);
                    $dart$core.Object opt012 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                    $dart$core.Object opt0123 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Tuple opt1 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1)]);
                    $dart$core.Object opt12 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2)]);
                    $dart$core.Object opt123 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Sequence fa([$dart$core.Object a = $ceylon$language.dart$default, $ceylon$language.Sequential rest]) {
                        if ($dart$core.identical(a, $ceylon$language.dart$default)) {
                            a = 99;
                        }
                        return new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a as $dart$core.int)], rest);
                    }

                    $ceylon$language.print((() {
                        $dart$core.Object arg$0$s = opt01;
                        $dart$core.int arg$0$l = (arg$0$s as $ceylon$language.Sequential).size;
                        return fa(arg$0$l > 0 ? $ceylon$language.Integer.nativeValue((arg$0$s as $ceylon$language.List).getFromFirst(0) as $ceylon$language.Integer) : $ceylon$language.dart$default, $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.Object arg$1$s = opt012;
                        $dart$core.int arg$1$l = (arg$1$s as $ceylon$language.Sequential).size;
                        return fa(arg$1$l > 0 ? $ceylon$language.Integer.nativeValue((arg$1$s as $ceylon$language.List).getFromFirst(0) as $ceylon$language.Integer) : $ceylon$language.dart$default, (arg$1$s as $ceylon$language.List).spanFrom($ceylon$language.Integer.instance(1)) as $ceylon$language.Sequential);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.Object arg$2$s = opt0123;
                        $dart$core.int arg$2$l = (arg$2$s as $ceylon$language.Sequential).size;
                        return fa(arg$2$l > 0 ? $ceylon$language.Integer.nativeValue((arg$2$s as $ceylon$language.List).getFromFirst(0) as $ceylon$language.Integer) : $ceylon$language.dart$default, (arg$2$s as $ceylon$language.List).spanFrom($ceylon$language.Integer.instance(1)) as $ceylon$language.Sequential);
                    })());
                    $ceylon$language.Sequence fb([$dart$core.int a, $ceylon$language.Sequential rest]) => new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(a)], rest);

                    $ceylon$language.print((() {
                        $ceylon$language.Tuple arg$3$s = opt1;
                        return fb($ceylon$language.Integer.nativeValue(arg$3$s.getFromFirst(0) as $ceylon$language.Integer), $ceylon$language.empty);
                    })());
                    $ceylon$language.print((() {
                        $dart$core.Object arg$4$s = opt12;
                        return fb($ceylon$language.Integer.nativeValue((arg$4$s as $ceylon$language.Tuple).getFromFirst(0) as $ceylon$language.Integer), (arg$4$s as $ceylon$language.Tuple).spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                    $ceylon$language.print((() {
                        $dart$core.Object arg$5$s = opt123;
                        return fb($ceylon$language.Integer.nativeValue((arg$5$s as $ceylon$language.Tuple).getFromFirst(0) as $ceylon$language.Integer), (arg$5$s as $ceylon$language.Tuple).spanFrom($ceylon$language.Integer.instance(1)));
                    })());
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void spreadEmptyWithSideEffects() {
        compileAndCompare {
             """
                variable Integer i = 0;
                [] emptyIncrementI { i = i + 1; return []; }

                void fa() {}
                Integer fb(Integer i) { return i; }

                shared void run() {
                    i = 0;
                    fa(*emptyIncrementI);
                    assert(i == 1);

                    i = 0;
                    value result = fb(++i, *emptyIncrementI);
                    assert (result == 1);
                    assert (i == 2);

                    print("done");
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.int $package$i = 0;

                $dart$core.int get i => $package$i;

                set i($dart$core.int value) => $package$i = value;

                $ceylon$language.Empty get $package$emptyIncrementI {
                    $package$i = $package$i + 1;
                    return $ceylon$language.empty;
                }

                $ceylon$language.Empty get emptyIncrementI => $package$emptyIncrementI;

                void $package$fa() {}

                void fa() => $package$fa();

                $dart$core.int $package$fb([$dart$core.int i]) {
                    return i;
                }

                $dart$core.int fb([$dart$core.int i]) => $package$fb(i);

                void $package$run() {
                    $package$i = 0;
                    (() {
                        $package$emptyIncrementI;
                        return $package$fa();
                    })();
                    if (!$ceylon$language.Integer.instance($package$i).equals($ceylon$language.Integer.instance(1))) {
                        throw new $ceylon$language.AssertionError("Violated: i == 1");
                    }
                    $package$i = 0;
                    $dart$core.int result = $package$fb((() {
                        $dart$core.int tmp$0 = $package$i = $ceylon$language.Integer.nativeValue($ceylon$language.Integer.instance($package$i).successor);
                        $package$emptyIncrementI;
                        return tmp$0;
                    })());
                    if (!$ceylon$language.Integer.instance(result).equals($ceylon$language.Integer.instance(1))) {
                        throw new $ceylon$language.AssertionError("Violated: result == 1");
                    }
                    if (!$ceylon$language.Integer.instance($package$i).equals($ceylon$language.Integer.instance(2))) {
                        throw new $ceylon$language.AssertionError("Violated: i == 2");
                    }
                    $ceylon$language.print($ceylon$language.String.instance("done"));
                }

                void run() => $package$run();
             """;
        };
    }
}
