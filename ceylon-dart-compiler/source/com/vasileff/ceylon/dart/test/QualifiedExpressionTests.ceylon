import ceylon.test {
    test
}

shared
class QualifiedExpressionTests() {

    shared test
    void simpleQualifiedExpressions() {
        compileAndCompare {
             """
                void run() {
                    variable String s = "-";
                    print(s.size);
                    print("".size);
                    Object o = s.size;
                    value f1 = "".contains;
                    value b = "".contains("apples");
                }

             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String s = "-";
                    $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance(s).size));
                    $ceylon$language.print($ceylon$language.Integer.instance($ceylon$language.String.instance("").size));
                    $dart$core.Object o = $ceylon$language.Integer.instance($ceylon$language.String.instance(s).size);
                    $ceylon$language.Callable f1 = (() {
                        $ceylon$language.String $capturedReceiver$ = $ceylon$language.String.instance("");
                        return new $ceylon$language.dart$Callable(([$dart$core.Object element]) => $ceylon$language.Boolean.instance($capturedReceiver$.contains(element)));
                    })();
                    $dart$core.bool b = $ceylon$language.String.instance("").contains($ceylon$language.String.instance("apples"));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void toplevelQualifiedExpressionWithCasting() {
        compileAndCompare {
             """
                List&Usable somethingE = nothing;
                List&Usable somethingL => nothing;

                void run() {
                    value ce = somethingE.contains;
                    value cl = somethingL.contains;

                    somethingE.contains("x");
                    print(somethingE.contains("x"));

                    somethingL.contains("x");
                    print(somethingL.contains("x"));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.Object $package$somethingE = $ceylon$language.nothing;

                $dart$core.Object get somethingE => $package$somethingE;

                $dart$core.Object get $package$somethingL => $ceylon$language.nothing;

                $dart$core.Object get somethingL => $package$somethingL;

                void $package$run() {
                    $ceylon$language.Callable ce = new $ceylon$language.dart$Callable(([$dart$core.Object element]) => $ceylon$language.Boolean.instance(($package$somethingE as $ceylon$language.List).contains(element)));
                    $ceylon$language.Callable cl = (() {
                        $ceylon$language.List $capturedReceiver$ = $package$somethingL as $ceylon$language.List;
                        return new $ceylon$language.dart$Callable(([$dart$core.Object element]) => $ceylon$language.Boolean.instance($capturedReceiver$.contains(element)));
                    })();
                    ($package$somethingE as $ceylon$language.List).contains($ceylon$language.String.instance("x"));
                    $ceylon$language.print($ceylon$language.Boolean.instance(($package$somethingE as $ceylon$language.List).contains($ceylon$language.String.instance("x"))));
                    ($package$somethingL as $ceylon$language.List).contains($ceylon$language.String.instance("x"));
                    $ceylon$language.print($ceylon$language.Boolean.instance(($package$somethingL as $ceylon$language.List).contains($ceylon$language.String.instance("x"))));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void toplevelQualifiedExpressionWithoutCasting() {
        compileAndCompare {
             """
                List somethingE = nothing;
                List somethingL = nothing;

                void run() {
                    value ce = somethingE.contains;
                    value cl = somethingL.contains;

                    somethingE.contains("x");
                    print(somethingE.contains("x"));

                    somethingL.contains("x");
                    print(somethingL.contains("x"));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $ceylon$language.List $package$somethingE = $ceylon$language.nothing as $ceylon$language.List;

                $ceylon$language.List get somethingE => $package$somethingE;

                $ceylon$language.List $package$somethingL = $ceylon$language.nothing as $ceylon$language.List;

                $ceylon$language.List get somethingL => $package$somethingL;

                void $package$run() {
                    $ceylon$language.Callable ce = new $ceylon$language.dart$Callable(([$dart$core.Object element]) => $ceylon$language.Boolean.instance($package$somethingE.contains(element)));
                    $ceylon$language.Callable cl = new $ceylon$language.dart$Callable(([$dart$core.Object element]) => $ceylon$language.Boolean.instance($package$somethingL.contains(element)));
                    $package$somethingE.contains($ceylon$language.String.instance("x"));
                    $ceylon$language.print($ceylon$language.Boolean.instance($package$somethingE.contains($ceylon$language.String.instance("x"))));
                    $package$somethingL.contains($ceylon$language.String.instance("x"));
                    $ceylon$language.print($ceylon$language.Boolean.instance($package$somethingL.contains($ceylon$language.String.instance("x"))));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void nullSafeMemberOperator() {
        compileAndCompare {
             """
                shared void run() {
                    String? os1 => "os1";
                    String? os2 => null;

                    print(os1?.size);
                    print(os2?.size);

                    value fos1 = os1?.getFromFirst;
                    value fos2 = os2?.getFromFirst;

                    print(fos1(0));
                    print(fos2(0));

                    print(os1?.getFromFirst(0));
                    print(os2?.getFromFirst(0));
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $dart$core.String os1$get() => "os1";

                    $dart$core.String os2$get() => null;

                    $ceylon$language.print($ceylon$language.Integer.instance((($ceylon$language.String $r$) => $r$ == null ? null : $r$.size)($ceylon$language.String.instance(os1$get()))));
                    $ceylon$language.print($ceylon$language.Integer.instance((($ceylon$language.String $r$) => $r$ == null ? null : $r$.size)($ceylon$language.String.instance(os2$get()))));
                    $ceylon$language.Callable fos1 = (() {
                        $ceylon$language.String $capturedReceiver$ = $ceylon$language.String.instance(os1$get());
                        return new $ceylon$language.dart$Callable(([$dart$core.Object index]) => (($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst($ceylon$language.Integer.nativeValue(index as $ceylon$language.Integer)))($capturedReceiver$));
                    })();
                    $ceylon$language.Callable fos2 = (() {
                        $ceylon$language.String $capturedReceiver$ = $ceylon$language.String.instance(os2$get());
                        return new $ceylon$language.dart$Callable(([$dart$core.Object index]) => (($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst($ceylon$language.Integer.nativeValue(index as $ceylon$language.Integer)))($capturedReceiver$));
                    })();
                    $ceylon$language.print(fos1.$delegate$($ceylon$language.Integer.instance(0)));
                    $ceylon$language.print(fos2.$delegate$($ceylon$language.Integer.instance(0)));
                    $ceylon$language.print((($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst(0))($ceylon$language.String.instance(os1$get())));
                    $ceylon$language.print((($ceylon$language.String $r$) => $r$ == null ? null : $r$.getFromFirst(0))($ceylon$language.String.instance(os2$get())));
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void nullSafeMemberOperatorNoBoxing() {
        compileAndCompare {
             """
                shared void run() {
                    Destroyable? u1 => nothing;

                    value destroy = u1?.destroy;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Destroyable u1$get() => $ceylon$language.nothing as $ceylon$language.Destroyable;

                    $ceylon$language.Callable destroy = (() {
                        $ceylon$language.Destroyable $capturedReceiver$ = u1$get();
                        return new $ceylon$language.dart$Callable(([$dart$core.Object error]) => (($ceylon$language.Destroyable $r$) => $r$ == null ? null : $r$.destroy(error as $ceylon$language.Throwable))($capturedReceiver$));
                    })();
                }

                void run() => $package$run();
             """;
         };
    }

    "Simple case: `foo()` is an inherited member, available through `this`."
    shared test
    void interfaceThisSharedMethod() {
        compileAndCompare {
             """
                interface I {
                    shared Usable foo(Usable u) => nothing;

                    shared void run() {
                        value fooRef = this.foo;

                        // private with non-this receiver:
                        I ie = nothing;
                        I il => nothing;
                        value fooRefIe = ie.foo;
                        value fooRefIl = il.foo;

                        // private with null safe operator
                        I? me = nothing;
                        I? ml => nothing;
                        value fooRefMe = me?.foo;
                        value fooRefMl = ml?.foo;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run();
                    static void $run([final I $this]) {
                        $ceylon$language.Callable fooRef = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => $this.foo(u as $ceylon$language.Usable));
                        I ie = $ceylon$language.nothing as I;
                        I il$get() => $ceylon$language.nothing as I;

                        $ceylon$language.Callable fooRefIe = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => ie.foo(u as $ceylon$language.Usable));
                        $ceylon$language.Callable fooRefIl = (() {
                            I $capturedReceiver$ = il$get();
                            return new $ceylon$language.dart$Callable(([$dart$core.Object u]) => $capturedReceiver$.foo(u as $ceylon$language.Usable));
                        })();
                        I me = $ceylon$language.nothing as I;
                        I ml$get() => $ceylon$language.nothing as I;

                        $ceylon$language.Callable fooRefMe = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => ((I $r$) => $r$ == null ? null : $r$.foo(u as $ceylon$language.Usable))(me));
                        $ceylon$language.Callable fooRefMl = (() {
                            I $capturedReceiver$ = ml$get();
                            return new $ceylon$language.dart$Callable(([$dart$core.Object u]) => ((I $r$) => $r$ == null ? null : $r$.foo(u as $ceylon$language.Usable))($capturedReceiver$));
                        })();
                    }
                }
             """;
        };
    }

    "Hard case: `foo()` is private and must be called statically, passing `this` as the
     first argument."
    shared test
    void interfaceThisUnsharedMethod() {
        compileAndCompare {
             """
                interface I {
                    Usable foo(Usable u) => nothing;
                    shared void run() {
                        value fooRef = this.foo;

                        // private with non-this receiver:
                        I ie = nothing;
                        I il => nothing;
                        value fooRefIe = ie.foo;
                        value fooRefIl = il.foo;

                        // private with null safe operator
                        I? me = nothing;
                        I? ml => nothing;
                        value fooRefMe = me?.foo;
                        value fooRefMl => ml?.foo;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    static $ceylon$language.Usable $foo([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run();
                    static void $run([final I $this]) {
                        $ceylon$language.Callable fooRef = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => I.$foo($this, u as $ceylon$language.Usable));
                        I ie = $ceylon$language.nothing as I;
                        I il$get() => $ceylon$language.nothing as I;

                        $ceylon$language.Callable fooRefIe = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => I.$foo(ie, u as $ceylon$language.Usable));
                        $ceylon$language.Callable fooRefIl = (() {
                            I $capturedReceiver$ = il$get();
                            return new $ceylon$language.dart$Callable(([$dart$core.Object u]) => I.$foo($capturedReceiver$, u as $ceylon$language.Usable));
                        })();
                        I me = $ceylon$language.nothing as I;
                        I ml$get() => $ceylon$language.nothing as I;

                        $ceylon$language.Callable fooRefMe = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => ((I $r$) => $r$ == null ? null : I.$foo($r$, u as $ceylon$language.Usable))(me));
                        $ceylon$language.Callable fooRefMl$get() => (() {
                            I $capturedReceiver$ = ml$get();
                            return new $ceylon$language.dart$Callable(([$dart$core.Object u]) => ((I $r$) => $r$ == null ? null : I.$foo($r$, u as $ceylon$language.Usable))($capturedReceiver$));
                        })();

                    }
                }
             """;
        };
    }

    shared test
    void interfaceSuperMethodInClass() {
        compileAndCompare {
             """
                interface Top {
                    shared default Usable foo(Usable u) => nothing;
                    shared default Usable bar(Usable u) => nothing;
                }
                interface Left satisfies Top {
                    shared actual default Usable foo(Usable u) => nothing;
                }
                interface Right satisfies Top {
                    shared actual default Usable foo(Usable u) => nothing;
                }
                class C() satisfies Left & Right {
                    shared actual default Usable foo(Usable u) => nothing;
                    shared void run() {
                        value sBar = super.bar;
                        value lFoo = (super of Left).foo;
                        value rFoo = (super of Right).foo;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Top $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    $ceylon$language.Usable bar([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $bar([final Top $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                abstract class Left implements Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Left $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                abstract class Right implements Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Right $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                class C implements Left, Right {
                    C() {}
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run() {
                        $ceylon$language.Callable sBar = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Top.$bar(this, u as $ceylon$language.Usable));
                        $ceylon$language.Callable lFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Left.$foo(this, u as $ceylon$language.Usable));
                        $ceylon$language.Callable rFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Right.$foo(this, u as $ceylon$language.Usable));
                    }
                    $ceylon$language.Usable bar([$ceylon$language.Usable u]) => Top.$bar(this, u);
                }
             """;
        };
    }

    shared test
    void interfaceSuperMethodInInterface() {
        compileAndCompare {
             """
                interface Top {
                    shared default Usable foo(Usable u) => nothing;
                    shared default Usable bar(Usable u) => nothing;
                }
                interface Left satisfies Top {
                    shared actual default Usable foo(Usable u) => nothing;
                }
                interface Right satisfies Top {
                    shared actual default Usable foo(Usable u) => nothing;
                }
                interface Bottom satisfies Left & Right {
                    shared actual default Usable foo(Usable u) => nothing;
                    shared void run() {
                        value sBar = super.bar;
                        value lFoo = (super of Left).foo;
                        value rFoo = (super of Right).foo;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Top $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    $ceylon$language.Usable bar([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $bar([final Top $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                abstract class Left implements Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Left $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                abstract class Right implements Top {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Right $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
                abstract class Bottom implements Left, Right {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final Bottom $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run();
                    static void $run([final Bottom $this]) {
                        $ceylon$language.Callable sBar = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Top.$bar($this, u as $ceylon$language.Usable));
                        $ceylon$language.Callable lFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Left.$foo($this, u as $ceylon$language.Usable));
                        $ceylon$language.Callable rFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => Right.$foo($this, u as $ceylon$language.Usable));
                    }
                }
             """;
        };
    }

    shared test
    void interfaceOuterMethodInInterface() {
        compileAndCompare {
             """
                interface I {
                    shared default Usable foo(Usable u) => nothing;
                    Usable bar(Usable u) => nothing;

                    interface J {
                        shared default Usable foo(Usable u) => nothing;
                        shared void run() {
                            value iFoo = outer.foo;
                            value iBar = outer.bar;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I$J {
                    I get $outer$default$I;
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final I$J $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run();
                    static void $run([final I$J $this]) {
                        $ceylon$language.Callable iFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => $this.$outer$default$I.foo(u as $ceylon$language.Usable));
                        $ceylon$language.Callable iBar = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => I.$bar($this.$outer$default$I, u as $ceylon$language.Usable));
                    }
                }
                abstract class I {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    static $ceylon$language.Usable $bar([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
             """;
        };
    }

    shared test
    void interfaceOuterMethodInClass() {
        compileAndCompare {
             """
                interface I {
                    shared default Usable foo(Usable u) => nothing;
                    Usable bar(Usable u) => nothing;

                    class C() {
                        shared default Usable foo(Usable u) => nothing;
                        shared void run() {
                            value iFoo = outer.foo;
                            value iBar = outer.bar;
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class I$C {
                    I $outer$default$I;
                    I$C([I this.$outer$default$I]) {}
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    void run() {
                        $ceylon$language.Callable iFoo = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => $outer$default$I.foo(u as $ceylon$language.Usable));
                        $ceylon$language.Callable iBar = new $ceylon$language.dart$Callable(([$dart$core.Object u]) => I.$bar($outer$default$I, u as $ceylon$language.Usable));
                    }
                }
                abstract class I {
                    $ceylon$language.Usable foo([$ceylon$language.Usable u]);
                    static $ceylon$language.Usable $foo([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                    static $ceylon$language.Usable $bar([final I $this, $ceylon$language.Usable u]) => $ceylon$language.nothing as $ceylon$language.Usable;
                }
             """;
        };
    }

    shared test
    void refToClassInInterfaceInInterface() {
        compileAndCompare {
             """
                interface I {
                    shared interface J {
                        shared class C(String s) {}
                    }
                }

                I.J.C(String)(I.J) newC = I.J.C;
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class I$J$C {
                    I$J $outer$default$I$J;
                    I$J$C([I$J this.$outer$default$I$J, $dart$core.String this.s]) {}
                    $dart$core.String s;
                }
                abstract class I$J {
                    I get $outer$default$I;
                }
                abstract class I {
                }
                $ceylon$language.Callable $package$newC = new $ceylon$language.dart$Callable(([$dart$core.Object $r$]) => new $ceylon$language.dart$Callable(([$dart$core.Object s]) => new I$J$C($r$, $ceylon$language.String.nativeValue(s as $ceylon$language.String))));

                $ceylon$language.Callable get newC => $package$newC;
             """;
        };
    }

}
