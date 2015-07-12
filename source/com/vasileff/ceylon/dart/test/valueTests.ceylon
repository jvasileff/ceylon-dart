import ceylon.test {
    test
}

shared
class ValueTests() {

    shared test
    void simpleToplevelValues() {
        compileAndCompare {
             """String immutableValue = "";
                variable String variableValue = "";
             """;

             """import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                $dart$core.String $package$immutableValue = "";

                $dart$core.String get immutableValue => $package$immutableValue;

                $dart$core.String $package$variableValue = "";

                $dart$core.String get variableValue => $package$variableValue;

                set variableValue($dart$core.String value) => $package$variableValue = value;
             """;
        };
    }
}
