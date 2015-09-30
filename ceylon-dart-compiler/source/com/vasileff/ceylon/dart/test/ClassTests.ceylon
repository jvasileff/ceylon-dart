import ceylon.test {
    test
}

shared
class ClassTests() {

    shared test
    void simpleNestedClasses() {
        compileAndCompare {
             """
                abstract class AbstractFoo() {}

                class Foo() {
                    class FooMemberClass() {}
                    void fooMethod() {
                        class ClassInAMethod() {
                        }
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class AbstractFoo {
                    AbstractFoo() {}
                }
                class Foo$FooMemberClass {
                    Foo $outer$default$Foo;
                    Foo$FooMemberClass([Foo this.$outer$default$Foo]) {}
                }
                class Foo$fooMethod$ClassInAMethod {
                    Foo $outer$default$Foo;
                    Foo$fooMethod$ClassInAMethod([Foo this.$outer$default$Foo]) {}
                }
                class Foo {
                    Foo() {}
                    void fooMethod() {}
                }
             """;
        };
    }

    shared test
    void captureMembersDeclaredByAssert() {
        compileAndCompare {
             """
                class Foo(String | Integer si1,
                          String | Integer si2,
                          String | Integer | Float isf) {
                    assert (is String si1);
                    assert (is String si2);
                    assert (is String | Integer isf);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class Foo {
                    Foo([$dart$core.Object this.si1, $dart$core.Object this.si2, $dart$core.Object this.isf]) {
                        if (!(si1 is $ceylon$language.String)) {
                            throw new $ceylon$language.AssertionError("Violated: is String si1");
                        }
                        si1$0 = $ceylon$language.String.nativeValue(si1 as $ceylon$language.String);
                        if (!(si2 is $ceylon$language.String)) {
                            throw new $ceylon$language.AssertionError("Violated: is String si2");
                        }
                        si2$1 = $ceylon$language.String.nativeValue(si2 as $ceylon$language.String);
                        if (!((isf is $ceylon$language.String) || (isf is $ceylon$language.Integer))) {
                            throw new $ceylon$language.AssertionError("Violated: is String | Integer isf");
                        }
                    }
                    $dart$core.Object si1;
                    $dart$core.Object si2;
                    $dart$core.Object isf;
                    $dart$core.String si1$0;
                    $dart$core.String si2$1;
                }
             """;
        };
    }

    shared test
    void memberClassInstantiation() {
        compileAndCompare {
             """
                class Foo() {
                    class FooMember() {
                    }
                    value x = FooMember();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class Foo$FooMember {
                    Foo $outer$default$Foo;
                    Foo$FooMember([Foo this.$outer$default$Foo]) {}
                }
                class Foo {
                    Foo() {
                        x = new Foo$FooMember(this);
                    }
                    Foo$FooMember x;
                }
             """;
        };
    }

    shared test
    void functionMemberClassInstantiation() {
        compileAndCompare {
             """
                shared void run() {
                    class Foo() {
                        class FooMember() {
                        }
                        value x = FooMember();
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class run$Foo$FooMember {
                    run$Foo $outer$default$run$Foo;
                    run$Foo$FooMember([run$Foo this.$outer$default$run$Foo]) {}
                }
                class run$Foo {
                    run$Foo() {
                        x = new run$Foo$FooMember(this);
                    }
                    run$Foo$FooMember x;
                }
                void $package$run() {}

                void run() => $package$run();
             """;
        };
    }

    shared test
    void functionMemberClassInstantiationCaptures() {
        compileAndCompare {
             """
                variable Integer counter = 0;

                shared void run() {
                    value runString1 = "runString1";
                    value runString2 = "runString2";
                    class Foo(Integer fooInt) {
                        value fooString1 => runString1;
                        shared class FooMember(Integer fooMemberInt) {
                            value fooMemberString2 => runString2;
                            shared Foo fooMemberHoldsAFooLazily => Foo(11);
                            shared {<String-><String|Integer>>*} data => [
                                "fooString1" -> fooString1,
                                "fooMemberString2" -> fooMemberString2,
                                "fooInt" -> fooInt,
                                "fooMemberInt" -> fooMemberInt
                            ];
                        }
                        shared FooMember x = FooMember(counter++);
                    }
                    value runFoo = Foo(33);
                    printAll(runFoo.x.data);
                    printAll(runFoo.x.data);
                    printAll(runFoo.x.fooMemberHoldsAFooLazily.x.data);
                    printAll(runFoo.x.fooMemberHoldsAFooLazily.x.data);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.int $package$counter = 0;

                $dart$core.int get counter => $package$counter;

                set counter($dart$core.int value) => $package$counter = value;

                class run$Foo$FooMember {
                    run$Foo $outer$default$run$Foo;
                    run$Foo$FooMember([run$Foo this.$outer$default$run$Foo, $dart$core.int this.fooMemberInt]) {}
                    $dart$core.int fooMemberInt;
                    $dart$core.String get fooMemberString2 => $outer$default$run$Foo.$capture$run$runString2;
                    run$Foo get fooMemberHoldsAFooLazily => new run$Foo($outer$default$run$Foo.$capture$run$runString1, $outer$default$run$Foo.$capture$run$runString2, 11);
                    $ceylon$language.Iterable get data => new $ceylon$language.Tuple.$withList([new $ceylon$language.Entry($ceylon$language.String.instance("fooString1"), $ceylon$language.String.instance($outer$default$run$Foo.fooString1)), new $ceylon$language.Entry($ceylon$language.String.instance("fooMemberString2"), $ceylon$language.String.instance(fooMemberString2)), new $ceylon$language.Entry($ceylon$language.String.instance("fooInt"), $ceylon$language.Integer.instance($outer$default$run$Foo.fooInt)), new $ceylon$language.Entry($ceylon$language.String.instance("fooMemberInt"), $ceylon$language.Integer.instance(fooMemberInt))], null);
                }
                class run$Foo {
                    $dart$core.String $capture$run$runString1;
                    $dart$core.String $capture$run$runString2;
                    run$Foo([$dart$core.String this.$capture$run$runString1, $dart$core.String this.$capture$run$runString2, $dart$core.int this.fooInt]) {
                        x = new run$Foo$FooMember(this, (() {
                            $dart$core.int tmp$0 = $package$counter;
                            $package$counter = $ceylon$language.Integer.nativeValue($ceylon$language.Integer.instance($package$counter).successor);
                            return tmp$0;
                        })());
                    }
                    $dart$core.int fooInt;
                    $dart$core.String get fooString1 => $capture$run$runString1;
                    run$Foo$FooMember x;
                }
                void $package$run() {
                    $dart$core.String runString1 = "runString1";
                    $dart$core.String runString2 = "runString2";
                    run$Foo runFoo = new run$Foo(runString1, runString2, 33);
                    $ceylon$language.printAll(runFoo.x.data);
                    $ceylon$language.printAll(runFoo.x.data);
                    $ceylon$language.printAll(runFoo.x.fooMemberHoldsAFooLazily.x.data);
                    $ceylon$language.printAll(runFoo.x.fooMemberHoldsAFooLazily.x.data);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void noBridgeForFormals() {
        compileAndCompare {
             """
                interface I {
                    shared default void foo0() {}
                    shared default void foo1() {}
                    shared formal void foo2();
                    shared formal void foo3();
                }

                abstract class C() satisfies I {
                    shared actual formal void foo1();
                    shared actual formal void foo3();
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    void foo0();
                    static void $foo0([final I $this]) {}
                    void foo1();
                    static void $foo1([final I $this]) {}
                    void foo2();
                    void foo3();
                }
                abstract class C implements I {
                    C() {}
                    void foo1();
                    void foo3();
                    void foo0() => I.$foo0(this);
                }
             """;
        };
    }

    shared test
    void capturedCallableParameter() {
        compileAndCompare {
             """
                shared void fun(String captureMe1(), String() captureMe2) {
                    class C() {
                        captureMe1();
                        captureMe2();

                        value cm1 = captureMe1;
                        value cm2 = captureMe2;
                    }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class fun$C {
                    $ceylon$language.Callable $capture$fun$captureMe1;
                    $ceylon$language.Callable $capture$fun$captureMe2;
                    fun$C([$ceylon$language.Callable this.$capture$fun$captureMe1, $ceylon$language.Callable this.$capture$fun$captureMe2]) {
                        $capture$fun$captureMe1.$delegate$();
                        $capture$fun$captureMe2.$delegate$();
                        cm1 = $capture$fun$captureMe1;
                        cm2 = $capture$fun$captureMe2;
                    }
                    $ceylon$language.Callable cm1;
                    $ceylon$language.Callable cm2;
                }
                void $package$fun([$ceylon$language.Callable captureMe1, $ceylon$language.Callable captureMe2]) {}

                void fun([$ceylon$language.Callable captureMe1, $ceylon$language.Callable captureMe2]) => $package$fun(captureMe1, captureMe2);
             """;
        };
    }
}
