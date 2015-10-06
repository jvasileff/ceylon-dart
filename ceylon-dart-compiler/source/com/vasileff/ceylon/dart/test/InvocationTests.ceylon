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

}
