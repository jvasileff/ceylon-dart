import ceylon.test {
    test,
    ignore
}

shared
class BaseExpressionTests() {

    shared test
    void referenceToStringInitializer() {
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

    shared test
    void referenceToIntegerInitializer() {
        compileAndCompare {
             """
                void run() {
                    value newInteger = Integer;
                    value five = newInteger(5);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable newInteger = new $ceylon$language.dart$Callable(([$ceylon$language.Integer integer]) => new $ceylon$language.Integer($ceylon$language.Integer.nativeValue(integer)));
                    $dart$core.int five = $ceylon$language.Integer.nativeValue(newInteger.$delegate$($ceylon$language.Integer.instance(5)) as $ceylon$language.Integer);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void referenceToEntryInitializer() {
        compileAndCompare {
             """
                shared void run() {
                    value newEntry = Entry<String, Destroyable?>;
                    value entry = newEntry("d", null);
                    print(entry);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Callable newEntry = new $ceylon$language.dart$Callable(([$dart$core.Object key, $dart$core.Object item]) => new $ceylon$language.Entry(key, item));
                    $ceylon$language.Entry entry = newEntry.$delegate$($ceylon$language.String.instance("d"), null) as $ceylon$language.Entry;
                    $ceylon$language.print(entry);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void packageQualifierToToplevelClass() {
        compileAndCompare {
             """
                class Foo(String s, Destroyable d) {}

                shared void run() {
                    value newFoo1 = Foo;
                    value newFoo2 = package.Foo;
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class Foo {
                    Foo([$dart$core.String this.s, $ceylon$language.Destroyable this.d]) {}
                    $dart$core.String s;
                    $ceylon$language.Destroyable d;
                }
                void $package$run() {
                    $ceylon$language.Callable newFoo1 = new $ceylon$language.dart$Callable(([$ceylon$language.String s, $ceylon$language.Destroyable d]) => new Foo($ceylon$language.String.nativeValue(s), d));
                    $ceylon$language.Callable newFoo2 = new $ceylon$language.dart$Callable(([$ceylon$language.String s, $ceylon$language.Destroyable d]) => new Foo($ceylon$language.String.nativeValue(s), d));
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
