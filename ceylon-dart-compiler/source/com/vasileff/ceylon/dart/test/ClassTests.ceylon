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
                        $capture$fun$captureMe1.f();
                        $capture$fun$captureMe2.f();
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

    shared test
    void valueSpecificationShortcutRefinement() {
        compileAndCompare {
             """
                interface I {
                    shared formal String s;
                }

                class Foo() satisfies I {
                    s = ""; // shortcut refinement
                    String x;
                    x = ""; // not shortcut refinement
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get s;
                }
                class Foo implements I {
                    Foo() {
                        s = "";
                        x = "";
                    }
                    $dart$core.String s;
                    $dart$core.String x;
                }
             """;
        };
    }

    shared test
    void variableReferences() {
        compileAndCompare {
             """
                interface I {
                    shared formal String i1;
                    shared formal String i2;
                    shared formal variable String i3;
                    shared formal variable String i4;
                }

                class C() satisfies I {
                    shared actual variable String i1 = "";
                    shared actual variable String i2;
                    shared actual variable String i3 = "";
                    shared actual variable String i4;

                    i1 = "i1-1";
                    i2 = "i2-1";
                    i3 = "i3-1";
                    i4 = "i4-1";

                    i1 = "i1-2";
                    i2 = "i2-2";
                    i3 = "i3-2";
                    i4 = "i4-2";

                    shared variable String c1 = "";
                    shared variable String c2;
                    variable String c3 = "";
                    variable String c4;

                    c1 = "c1-1";
                    c2 = "c2-1";
                    c3 = "c3-1";
                    c4 = "c4-1";

                    c1 = "c1-2";
                    c2 = "c2-2";
                    c3 = "c3-2";
                    c4 = "c4-2";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get i1;
                    $dart$core.String get i2;
                    $dart$core.String get i3;
                    set i3($dart$core.String i3);
                    $dart$core.String get i4;
                    set i4($dart$core.String i4);
                }
                class C implements I {
                    C() {
                        i1 = "";
                        i3 = "";
                        i1 = "i1-1";
                        i2 = "i2-1";
                        i3 = "i3-1";
                        i4 = "i4-1";
                        i1 = "i1-2";
                        i2 = "i2-2";
                        i3 = "i3-2";
                        i4 = "i4-2";
                        c1 = "";
                        c3 = "";
                        c1 = "c1-1";
                        c2 = "c2-1";
                        c3 = "c3-1";
                        c4 = "c4-1";
                        c1 = "c1-2";
                        c2 = "c2-2";
                        c3 = "c3-2";
                        c4 = "c4-2";
                    }
                    $dart$core.String i1;
                    $dart$core.String i2;
                    $dart$core.String i3;
                    $dart$core.String i4;
                    $dart$core.String c1;
                    $dart$core.String c2;
                    $dart$core.String c3;
                    $dart$core.String c4;
                }
             """;
        };
    }

    shared test
    void nonVariableReferences() {
        compileAndCompare {
             """
                interface I {
                    shared formal String i1;
                    shared formal String i2;
                }

                class C() satisfies I {
                    shared actual String i1 = "";
                    i2 = "i2-1"; // shortcut refinement

                    shared String c1 = "";
                    shared String c2;

                    c2 = "c2-1";

                    String c3 = "";
                    String c4;

                    c4 = "c4-1";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get i1;
                    $dart$core.String get i2;
                }
                class C implements I {
                    C() {
                        i1 = "";
                        i2 = "i2-1";
                        c1 = "";
                        c2 = "c2-1";
                        c3 = "";
                        c4 = "c4-1";
                    }
                    $dart$core.String i1;
                    $dart$core.String i2;
                    $dart$core.String c1;
                    $dart$core.String c2;
                    $dart$core.String c3;
                    $dart$core.String c4;
                }
             """;
        };
    }

    shared test
    void nonVariableGetters() {
        // TODO LazySpecifications see below
        compileAndCompare {
             """
                interface I {
                    shared formal String i1;
                    shared formal String i2;
                }

                class C() satisfies I {
                    shared actual String i1 => "";
                    i2 => i1;

                    shared String c1 => "";
                    shared String c2 => c1;

                    String c3 => "";
                    String c4 => c3;

                    // TODO LazySpecifications that are not shortcut refinements
                    //      are not yet supported.
                    //shared String c5;
                    //c5 => "c5-1";
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get i1;
                    $dart$core.String get i2;
                }
                class C implements I {
                    C() {}
                    $dart$core.String get i1 => "";
                    $dart$core.String get i2 => i1;
                    $dart$core.String get c1 => "";
                    $dart$core.String get c2 => c1;
                    $dart$core.String get c3 => "";
                    $dart$core.String get c4 => c3;
                }
             """;
        };
    }

    shared test
    void variableGetters() {
        compileAndCompare {
             """
                interface I {
                    shared formal variable String i1;
                }

                class C() satisfies I {
                    shared actual String i1 => "";
                    assign i1 { print("Setting i1 to: " + i1); }

                    i1 = "i1-1";
                    i1 = "i1-2";
                    print(i1);

                    shared String c1 => "";
                    assign c1 { print("Setting c1 to: " + c1); }

                    c1 = "c1-1";
                    c1 = "c1-2";
                    print(c1);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                abstract class I {
                    $dart$core.String get i1;
                    set i1($dart$core.String i1);
                }
                class C implements I {
                    C() {
                        i1 = "i1-1";
                        i1 = "i1-2";
                        $ceylon$language.print($ceylon$language.String.instance(i1));
                        c1 = "c1-1";
                        c1 = "c1-2";
                        $ceylon$language.print($ceylon$language.String.instance(c1));
                    }
                    $dart$core.String get i1 => "";
                    void set i1($dart$core.String i1) {
                        $ceylon$language.print($ceylon$language.String.instance("Setting i1 to: " + i1));
                    }
                    $dart$core.String get c1 => "";
                    void set c1($dart$core.String c1) {
                        $ceylon$language.print($ceylon$language.String.instance("Setting c1 to: " + c1));
                    }
                }
             """;
        };
    }

    shared test
    void referencesToNonReferences() {
        compileAndCompare {
             """
                class C() {
                    shared default String c1 = "";
                    shared default variable String c2 = "";
                }

                class D() extends C() {
                    shared actual String c1 => "";
                    assign c1 { print("assigning c1 to: " + c1); }

                    shared actual String c2 => "";
                    assign c2 { print("assigning c2 to: " + c2); }
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class C {
                    C() {
                        c1 = "";
                        c2 = "";
                    }
                    $dart$core.String c1;
                    $dart$core.String c2;
                }
                class D  extends C {
                    D() {}
                    $dart$core.String get c1 => "";
                    void set c1($dart$core.String c1) {
                        $ceylon$language.print($ceylon$language.String.instance("assigning c1 to: " + c1));
                    }
                    $dart$core.String get c2 => "";
                    void set c2($dart$core.String c2) {
                        $ceylon$language.print($ceylon$language.String.instance("assigning c2 to: " + c2));
                    }
                }
             """;
        };
    }

    shared test
    void invokeClassMethodStatically() {
        // This is very unoptimized.
        compileAndCompare {
             """
                class A() {
                    shared class B() {
                        shared String foo() => "foo";
                        shared String bar => "bar";
                    }
                }
                shared void run() {
                    String() f = A.B.foo(A().B());
                    String b = A.B.bar(A().B());

                    print(f());
                    print(b);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class A$B {
                    A $outer$default$A;
                    A$B([A this.$outer$default$A]) {}
                    $dart$core.String foo() => "foo";
                    $dart$core.String get bar => "bar";
                }
                class A {
                    A() {}
                }
                void $package$run() {
                    $ceylon$language.Callable f = (new $ceylon$language.dart$Callable(([$dart$core.Object $r$]) => new $ceylon$language.dart$Callable(() => $ceylon$language.String.instance(($r$ as A$B).foo())))).f(new A$B(new A())) as $ceylon$language.Callable;
                    $dart$core.String b = $ceylon$language.String.nativeValue((new $ceylon$language.dart$Callable(([$dart$core.Object $r$]) => $ceylon$language.String.instance(($r$ as A$B).bar))).f(new A$B(new A())) as $ceylon$language.String);
                    $ceylon$language.print(f.f());
                    $ceylon$language.print($ceylon$language.String.instance(b));
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void invokeMemberClass() {
        compileAndCompare {
             """
                shared class C() {
                    shared class D(String s) {}
                    shared D d1 = D("d1");
                    shared D d2 = C().D("d2");
                }
                shared void run() {
                    value d3 = C().D("d3");
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
                    C() {
                        d1 = new C$D(this, "d1");
                        d2 = new C$D(new C(), "d2");
                    }
                    C$D d1;
                    C$D d2;
                }
                void $package$run() {
                    C$D d3 = new C$D(new C(), "d3");
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void invokeMemberClassSafe() {
        compileAndCompare {
             """
                shared class C() {
                    shared class D(String s) {
                        print(s);
                    }
                }
                shared void run() {
                    C? c1 = C();
                    C? c2 = null;

                    c1?.D("Test1");
                    c2?.D("Test2");
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class C$D {
                    C $outer$default$C;
                    C$D([C this.$outer$default$C, $dart$core.String this.s]) {
                        $ceylon$language.print($ceylon$language.String.instance(s));
                    }
                    $dart$core.String s;
                }
                class C {
                    C() {}
                }
                void $package$run() {
                    C c1 = new C();
                    C c2 = null;
                    ((C $r$) => $r$ == null ? null : new C$D($r$, "Test1"))(c1);
                    ((C $r$) => $r$ == null ? null : new C$D($r$, "Test2"))(c2);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void outerReferenceTest() {
        compileAndCompare {
             """
                interface I1 {
                    shared default String ident => "i1";
                    shared interface I2 {
                        shared default String ident => "i2";
                        shared default String outerIdent => outer.ident;
                        shared class C(Integer version) satisfies I2 {
                            shared default String cident => "c-``version``";
                            shared default String couterIdent => outer.ident;
                            shared actual String ident => "i2byC-``version``";
                        }
                    }
                    shared formal I2 i2;
                }

                shared void run() {
                    I1 i1o => object satisfies I1 {
                        shared actual String ident => "i1o";
                        shared actual I2 i2 => object satisfies I1.I2 {
                            shared actual String ident => "i2o";
                            shared actual String outerIdent => outer.ident;
                        };
                    };

                    I1.I2.C(Integer)(I1.I2) newC => I1.I2.C;

                    value c = newC(i1o.i2)(1);
                    value c1 = I1.I2.C(i1o.i2)(1);
                    value c2 = I1.I2.C(i1o.i2)(1);

                    assert(c.cident == "c-1");
                    assert(c.couterIdent == "i2o");
                    assert(c.ident == "i2byC-1");
                    assert(c.outerIdent == "i1o");

                    value cSelfOuter = newC(c)(2);
                    assert(cSelfOuter.cident == "c-2");
                    assert(cSelfOuter.couterIdent == "i2byC-1");
                    assert(cSelfOuter.ident == "i2byC-2");
                    assert(cSelfOuter.outerIdent == "i1o");

                    print("done");
                }

             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                class I1$I2$C implements I1$I2 {
                    I1$I2 $outer$default$I1$I2;
                    I1 get $outer$default$I1 => $outer$default$I1$I2.$outer$default$I1;
                    I1$I2$C([I1$I2 this.$outer$default$I1$I2, $dart$core.int this.version]) {}
                    $dart$core.int version;
                    $dart$core.String get cident => ("c-" + $ceylon$language.Integer.instance(version).toString()) + "";
                    $dart$core.String get couterIdent => $outer$default$I1$I2.ident;
                    $dart$core.String get ident => ("i2byC-" + $ceylon$language.Integer.instance(version).toString()) + "";
                    $dart$core.String get outerIdent => I1$I2.$get$outerIdent(this);
                }
                abstract class I1$I2 {
                    I1 get $outer$default$I1;
                    $dart$core.String get ident;
                    static $dart$core.String $get$ident([final I1$I2 $this]) => "i2";
                    $dart$core.String get outerIdent;
                    static $dart$core.String $get$outerIdent([final I1$I2 $this]) => $this.$outer$default$I1.ident;
                }
                abstract class I1 {
                    $dart$core.String get ident;
                    static $dart$core.String $get$ident([final I1 $this]) => "i1";
                    I1$I2 get i2;
                }
                class run$i1o$$anonymous$0_$i2$$anonymous$1_ implements I1$I2 {
                    run$i1o$$anonymous$0_ $outer$default$run$i1o$$anonymous$0_;
                    I1 get $outer$default$I1 => $outer$default$run$i1o$$anonymous$0_;
                    run$i1o$$anonymous$0_$i2$$anonymous$1_([run$i1o$$anonymous$0_ this.$outer$default$run$i1o$$anonymous$0_]) {}
                    $dart$core.String get ident => "i2o";
                    $dart$core.String get outerIdent => $outer$default$run$i1o$$anonymous$0_.ident;
                }
                class run$i1o$$anonymous$0_ implements I1 {
                    run$i1o$$anonymous$0_() {}
                    $dart$core.String get ident => "i1o";
                    I1$I2 get i2 => new run$i1o$$anonymous$0_$i2$$anonymous$1_(this);
                }
                void $package$run() {
                    I1 i1o$get() => new run$i1o$$anonymous$0_();

                    $ceylon$language.Callable newC$get() => new $ceylon$language.dart$Callable(([$dart$core.Object $r$]) => new $ceylon$language.dart$Callable(([$dart$core.Object version]) => new I1$I2$C($r$, $ceylon$language.Integer.nativeValue(version as $ceylon$language.Integer))));

                    I1$I2$C c = (newC$get().f(i1o$get().i2) as $ceylon$language.Callable).f($ceylon$language.Integer.instance(1)) as I1$I2$C;
                    I1$I2$C c1 = (new $ceylon$language.dart$Callable(([$dart$core.Object version]) => new I1$I2$C(i1o$get().i2, $ceylon$language.Integer.nativeValue(version as $ceylon$language.Integer)))).f($ceylon$language.Integer.instance(1)) as I1$I2$C;
                    I1$I2$C c2 = (new $ceylon$language.dart$Callable(([$dart$core.Object version]) => new I1$I2$C(i1o$get().i2, $ceylon$language.Integer.nativeValue(version as $ceylon$language.Integer)))).f($ceylon$language.Integer.instance(1)) as I1$I2$C;
                    if (!$ceylon$language.String.instance(c.cident).equals($ceylon$language.String.instance("c-1"))) {
                        throw new $ceylon$language.AssertionError("Violated: c.cident == \"c-1\"");
                    }
                    if (!$ceylon$language.String.instance(c.couterIdent).equals($ceylon$language.String.instance("i2o"))) {
                        throw new $ceylon$language.AssertionError("Violated: c.couterIdent == \"i2o\"");
                    }
                    if (!$ceylon$language.String.instance(c.ident).equals($ceylon$language.String.instance("i2byC-1"))) {
                        throw new $ceylon$language.AssertionError("Violated: c.ident == \"i2byC-1\"");
                    }
                    if (!$ceylon$language.String.instance(c.outerIdent).equals($ceylon$language.String.instance("i1o"))) {
                        throw new $ceylon$language.AssertionError("Violated: c.outerIdent == \"i1o\"");
                    }
                    I1$I2$C cSelfOuter = (newC$get().f(c) as $ceylon$language.Callable).f($ceylon$language.Integer.instance(2)) as I1$I2$C;
                    if (!$ceylon$language.String.instance(cSelfOuter.cident).equals($ceylon$language.String.instance("c-2"))) {
                        throw new $ceylon$language.AssertionError("Violated: cSelfOuter.cident == \"c-2\"");
                    }
                    if (!$ceylon$language.String.instance(cSelfOuter.couterIdent).equals($ceylon$language.String.instance("i2byC-1"))) {
                        throw new $ceylon$language.AssertionError("Violated: cSelfOuter.couterIdent == \"i2byC-1\"");
                    }
                    if (!$ceylon$language.String.instance(cSelfOuter.ident).equals($ceylon$language.String.instance("i2byC-2"))) {
                        throw new $ceylon$language.AssertionError("Violated: cSelfOuter.ident == \"i2byC-2\"");
                    }
                    if (!$ceylon$language.String.instance(cSelfOuter.outerIdent).equals($ceylon$language.String.instance("i1o"))) {
                        throw new $ceylon$language.AssertionError("Violated: cSelfOuter.outerIdent == \"i1o\"");
                    }
                    $ceylon$language.print($ceylon$language.String.instance("done"));
                }

                void run() => $package$run();
             """;
        };
    }
}
