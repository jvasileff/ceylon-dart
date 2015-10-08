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

}
