import ceylon.test {
    test,
    ignore
}

shared
class BaseExpressionTests() {

    shared test
    void typeNameWithTypeArguments() {
        compileAndCompare {
             """
                void run() {
                    value newString1 = String;
                    value newString2 = ({Character*} characters) => String(characters);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable newString1 = new $ceylon$language.dart$Callable(([$ceylon$language.Iterable characters]) => new $ceylon$language.String(characters));
                    $ceylon$language.Callable newString2 = new $ceylon$language.dart$Callable(([$ceylon$language.Iterable characters]) => new $ceylon$language.String(characters));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test ignore
    void typeNameWithTypeArgumentsMember() {
        compileAndCompare {
             """
                class C() {
                    class D(String s) {
                    }
                    shared void foo() {
                        value newD1 = (String s) => D(s);
                        value newD2 = (String s) => D(s);

                        value fooRef = foo;
                        //$ceylon$language.Callable fooRef = new $ceylon$language.dart$Callable(foo);
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class C$D {
                    C $outer$default$C;
                    C$D([C this.$outer$default$C, $dart$core.String this.s]) {}
                    $dart$core.String s;
                }
                class C {
                    C() {}
                    void foo() {
                        $ceylon$language.Callable newD1 = new $ceylon$language.dart$Callable(([$ceylon$language.String s]) => new C$D(this, $ceylon$language.String.nativeValue(s)));
                        $ceylon$language.Callable newD2 = new $ceylon$language.dart$Callable(([$ceylon$language.String s]) => new C$D(this, $ceylon$language.String.nativeValue(s)));
                    }
                }
             """;
        };
    }
}
