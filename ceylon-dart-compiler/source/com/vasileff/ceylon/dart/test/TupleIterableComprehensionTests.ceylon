import ceylon.test {
    test
}

shared
class TupleIterableComprehensionTests() {

    shared test
    void tupleExpressions() {
        compileAndCompare {
             """
                shared void run() {
                    {Integer*} iter0 = [];
                    {Integer*} iter1 = [1,2,3];
                    {Integer+} iter2 = [1,2,3];

                    value x = [*iter0];
                    value y = [*iter1];
                    value z = [*iter2];

                    value a = ["1", "2", "3"];
                    value b = [];
                    value c = [*a];
                    value d = ["4", *a];
                    value e = [*b];

                    print(a);
                    print(b);
                    print(c);
                    print(d);
                    print(e);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Iterable iter0 = $ceylon$language.empty;
                    $ceylon$language.Iterable iter1 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null);
                    $ceylon$language.Iterable iter2 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null);
                    $ceylon$language.Sequential x = iter0.sequence();
                    $ceylon$language.Sequential y = iter1.sequence();
                    $ceylon$language.Sequence z = iter2.sequence() as $ceylon$language.Sequence;
                    $ceylon$language.Tuple a = new $ceylon$language.Tuple.$withList([$ceylon$language.String.instance("1"), $ceylon$language.String.instance("2"), $ceylon$language.String.instance("3")], null);
                    $ceylon$language.Empty b = $ceylon$language.empty;
                    $ceylon$language.Tuple c = a;
                    $ceylon$language.Tuple d = new $ceylon$language.Tuple.$withList([$ceylon$language.String.instance("4")], a);
                    $ceylon$language.Empty e = $ceylon$language.empty;
                    $ceylon$language.print(a);
                    $ceylon$language.print(b);
                    $ceylon$language.print(c);
                    $ceylon$language.print(d);
                    $ceylon$language.print(e);
                }

                void run() => $package$run();
             """;
        };
    }

    shared test
    void iterableExpressions() {
        compileAndCompare {
             """
                shared void run() {
                    {Integer*} iter0 = [];
                    {Integer*} iter1 = [1,2,3];
                    {Integer+} iter2 = [1,2,3];

                    value x = {*iter0};
                    value y = {*iter1};
                    value z = {*iter2};

                    value a = {"1", "2", "3"};
                    value b = {};
                    value c = {*a};
                    value d = {"4", *a};
                    value e = {*b};

                    print(a);
                    print(b);
                    print(c);
                    print(d);
                    print(e);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Iterable iter0 = $ceylon$language.empty;
                    $ceylon$language.Iterable iter1 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null);
                    $ceylon$language.Iterable iter2 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)], null);
                    $ceylon$language.Iterable x = iter0;
                    $ceylon$language.Iterable y = iter1;
                    $ceylon$language.Iterable z = iter2;
                    $ceylon$language.Iterable a = new $ceylon$language.LazyIterable(3, (final $dart$core.int $i$) {
                        switch ($i$) {
                        case 0 :
                        return $ceylon$language.String.instance("1");
                        case 1 :
                        return $ceylon$language.String.instance("2");
                        case 2 :
                        return $ceylon$language.String.instance("3");
                        }
                    }, null);
                    $ceylon$language.Iterable b = $ceylon$language.empty;
                    $ceylon$language.Iterable c = a;
                    $ceylon$language.Iterable d = new $ceylon$language.LazyIterable(1, (final $dart$core.int $i$) {
                        switch ($i$) {
                        case 0 :
                        return $ceylon$language.String.instance("4");
                        }
                    }, a);
                    $ceylon$language.Iterable e = b;
                    $ceylon$language.print(a);
                    $ceylon$language.print(b);
                    $ceylon$language.print(c);
                    $ceylon$language.print(d);
                    $ceylon$language.print(e);
                }

                void run() => $package$run();
             """;
        };
    }

}
