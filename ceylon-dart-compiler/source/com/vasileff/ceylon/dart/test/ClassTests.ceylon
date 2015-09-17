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
}
