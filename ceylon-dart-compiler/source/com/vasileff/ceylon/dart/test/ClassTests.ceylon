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
}
