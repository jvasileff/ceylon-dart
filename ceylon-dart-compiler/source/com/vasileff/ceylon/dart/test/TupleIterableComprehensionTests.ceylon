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
                    $ceylon$language.Iterable iter1 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Iterable iter2 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Sequential x = iter0.sequence();
                    $ceylon$language.Sequential y = iter1.sequence();
                    $ceylon$language.Sequence z = iter2.sequence() as $ceylon$language.Sequence;
                    $ceylon$language.Tuple a = new $ceylon$language.Tuple.$withList([$ceylon$language.String.instance("1"), $ceylon$language.String.instance("2"), $ceylon$language.String.instance("3")]);
                    $ceylon$language.Empty b = $ceylon$language.empty;
                    $ceylon$language.Tuple c = a;
                    $ceylon$language.Tuple d = new $ceylon$language.Tuple.$withList([$ceylon$language.String.instance("4")], a);
                    $ceylon$language.Empty e = b;
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
                    $ceylon$language.Iterable iter1 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Iterable iter2 = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
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

    shared test
    void simpleComprehension() {
        compileAndCompare {
             """
                shared void run() {
                    {Integer*} iter0 = { for (i in 0:10) i };
                    {Integer|String*} iter1 = { for (i in 0:10) if (2.divides(i)) then i else "nope" };
                    printAll(iter0);
                    printAll(iter1);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Iterable iter0 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$0 = false;
                        $dart$core.bool step$0$1() {
                            if (step$0$expired$0) {
                                return false;
                            }
                            step$0$expired$0 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$2;
                        $dart$core.bool step$1$Init$5() {
                            if (iterator_1$2 != null) {
                                return true;
                            }
                            if (!step$0$1()) {
                                return false;
                            }
                            iterator_1$2 = ($ceylon$language.measure($ceylon$language.Integer.instance(0), 10) as $ceylon$language.List).iterator();
                            return true;
                        }

                        $ceylon$language.Integer i$3;
                        $dart$core.bool step$1$6() {
                            while (step$1$Init$5()) {
                                $dart$core.Object next$4;
                                if ((next$4 = iterator_1$2.next()) is !$ceylon$language.Finished) {
                                    i$3 = next$4 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$2 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$7() {
                            if (!step$1$6()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer i = i$3;
                            return i;
                        }

                        return new $ceylon$language.dart$Callable(step$2$7);
                    }));
                    $ceylon$language.Iterable iter1 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$8 = false;
                        $dart$core.bool step$0$9() {
                            if (step$0$expired$8) {
                                return false;
                            }
                            step$0$expired$8 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$10;
                        $dart$core.bool step$1$Init$13() {
                            if (iterator_1$10 != null) {
                                return true;
                            }
                            if (!step$0$9()) {
                                return false;
                            }
                            iterator_1$10 = ($ceylon$language.measure($ceylon$language.Integer.instance(0), 10) as $ceylon$language.List).iterator();
                            return true;
                        }

                        $ceylon$language.Integer i$11;
                        $dart$core.bool step$1$14() {
                            while (step$1$Init$13()) {
                                $dart$core.Object next$12;
                                if ((next$12 = iterator_1$10.next()) is !$ceylon$language.Finished) {
                                    i$11 = next$12 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$10 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$15() {
                            if (!step$1$14()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer i = i$11;
                            return (() {
                                if ($ceylon$language.Integer.instance(2).divides(i)) {
                                    return i;
                                } else {
                                    return $ceylon$language.String.instance("nope");
                                }
                            })();
                        }

                        return new $ceylon$language.dart$Callable(step$2$15);
                    }));
                    $ceylon$language.printAll(iter0);
                    $ceylon$language.printAll(iter1);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void comprehensionCartesionIf() {
        compileAndCompare {
             """
                shared void run() {
                    [Integer*]? maybeSeq = [1,2,3];
                    value x = [ -3,-2,-1,0,
                        if (exists seq = maybeSeq)
                        for (i in seq)
                        for (j in seq)
                        if (i > 1, j > 2)
                        i+j
                    ];
                    printAll(x);
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.Sequential maybeSeq = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(1), $ceylon$language.Integer.instance(2), $ceylon$language.Integer.instance(3)]);
                    $ceylon$language.Tuple x = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(3).negated, $ceylon$language.Integer.instance(2).negated, $ceylon$language.Integer.instance(1).negated, $ceylon$language.Integer.instance(0)], $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$0 = false;
                        $dart$core.bool step$0$1() {
                            if (step$0$expired$0) {
                                return false;
                            }
                            step$0$expired$0 = true;
                            return true;
                        }

                        $ceylon$language.Sequential seq$4;
                        $dart$core.bool step$1$2() {
                            while (step$0$1()) {
                                $ceylon$language.Sequential seq;
                                $ceylon$language.Sequential tmp$3 = maybeSeq;
                                if (!(!(tmp$3 == null))) {
                                    continue;
                                }
                                seq = tmp$3;
                                seq$4 = seq;
                                return true;
                            }
                            return false;
                        }

                        $ceylon$language.Iterator iterator_2$5;
                        $dart$core.bool step$2$Init$8() {
                            if (iterator_2$5 != null) {
                                return true;
                            }
                            if (!step$1$2()) {
                                return false;
                            }
                            $ceylon$language.Sequential seq = seq$4;
                            iterator_2$5 = seq.iterator();
                            return true;
                        }

                        $ceylon$language.Integer i$6;
                        $dart$core.bool step$2$9() {
                            while (step$2$Init$8()) {
                                $ceylon$language.Sequential seq = seq$4;
                                $dart$core.Object next$7;
                                if ((next$7 = iterator_2$5.next()) is !$ceylon$language.Finished) {
                                    i$6 = next$7 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_2$5 = null;
                            }
                            return false;
                        }

                        $ceylon$language.Iterator iterator_3$10;
                        $dart$core.bool step$3$Init$13() {
                            if (iterator_3$10 != null) {
                                return true;
                            }
                            if (!step$2$9()) {
                                return false;
                            }
                            $ceylon$language.Sequential seq = seq$4;
                            $ceylon$language.Integer i = i$6;
                            iterator_3$10 = seq.iterator();
                            return true;
                        }

                        $ceylon$language.Integer j$11;
                        $dart$core.bool step$3$14() {
                            while (step$3$Init$13()) {
                                $ceylon$language.Sequential seq = seq$4;
                                $ceylon$language.Integer i = i$6;
                                $dart$core.Object next$12;
                                if ((next$12 = iterator_3$10.next()) is !$ceylon$language.Finished) {
                                    j$11 = next$12 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_3$10 = null;
                            }
                            return false;
                        }

                        $dart$core.bool step$4$15() {
                            while (step$3$14()) {
                                $ceylon$language.Sequential seq = seq$4;
                                $ceylon$language.Integer i = i$6;
                                $ceylon$language.Integer j = j$11;
                                if (($ceylon$language.Integer.nativeValue(i) > 1) && ($ceylon$language.Integer.nativeValue(j) > 2)) {
                                    return true;
                                }
                            }
                            return false;
                        }

                        $dart$core.Object step$5$16() {
                            if (!step$4$15()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Sequential seq = seq$4;
                            $ceylon$language.Integer i = i$6;
                            $ceylon$language.Integer j = j$11;
                            return $ceylon$language.Integer.instance($ceylon$language.Integer.nativeValue(i) + $ceylon$language.Integer.nativeValue(j));
                        }

                        return new $ceylon$language.dart$Callable(step$5$16);
                    })).sequence());
                    $ceylon$language.printAll(x);
                }

                void run() => $package$run();
             """;
         };
    }

    shared test
    void comprehensionCaptureTests() {
        compileAndCompare {
             """
                shared void run() {
                    print("* comprehensionCaptureTest begin");

                    value values = [ 100, 110, 120 ];
                    value valuesNull = [ 100, 110, 120, null ];

                    // capture test 0
                    value funcs0 = {
                        for (v in values)
                        ()=>v
                    };
                    //printAll({ for (f in funcs0.sequence()) f() });
                    assert({ for (f in funcs0.sequence()) f() }.sequence().equals(values));

                    // capture test 1
                    value funcs1 = {
                        for (v in valuesNull)
                        if (exists w=v)
                        ()=>w
                    };
                    //printAll({ for (f in funcs1.sequence()) f() });
                    assert({ for (f in funcs1.sequence()) f() }.sequence().equals(values));

                    // capture test 2
                    value funcs2 = {
                        for (v in values)
                        if (exists w = true then (()=>v))
                        w
                    };
                    //printAll({ for (f in funcs2.sequence()) f() });
                    assert({ for (f in funcs2.sequence()) f() }.sequence().equals(values));

                    // capture test 3
                    value funcs3 = {
                        for (v in values)
                        for (w in { ()=>v })
                        w
                    };
                    //printAll({ for (f in funcs3.sequence()) f() });
                    assert({ for (f in funcs3.sequence()) f() }.sequence().equals(values));

                    print("* comprehensionCaptureTest end");
                }
             """;

             """
                import "dart:core" as $dart$core;
                import "package:ceylon/language/language.dart" as $ceylon$language;

                void $package$run() {
                    $ceylon$language.print($ceylon$language.String.instance("* comprehensionCaptureTest begin"));
                    $ceylon$language.Tuple values = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(100), $ceylon$language.Integer.instance(110), $ceylon$language.Integer.instance(120)]);
                    $ceylon$language.Tuple valuesNull = new $ceylon$language.Tuple.$withList([$ceylon$language.Integer.instance(100), $ceylon$language.Integer.instance(110), $ceylon$language.Integer.instance(120), null]);
                    $ceylon$language.Iterable funcs0 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$0 = false;
                        $dart$core.bool step$0$1() {
                            if (step$0$expired$0) {
                                return false;
                            }
                            step$0$expired$0 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$2;
                        $dart$core.bool step$1$Init$5() {
                            if (iterator_1$2 != null) {
                                return true;
                            }
                            if (!step$0$1()) {
                                return false;
                            }
                            iterator_1$2 = values.iterator();
                            return true;
                        }

                        $ceylon$language.Integer v$3;
                        $dart$core.bool step$1$6() {
                            while (step$1$Init$5()) {
                                $dart$core.Object next$4;
                                if ((next$4 = iterator_1$2.next()) is !$ceylon$language.Finished) {
                                    v$3 = next$4 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$2 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$7() {
                            if (!step$1$6()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer v = v$3;
                            return new $ceylon$language.dart$Callable(() => v);
                        }

                        return new $ceylon$language.dart$Callable(step$2$7);
                    }));
                    if (!$ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$8 = false;
                        $dart$core.bool step$0$9() {
                            if (step$0$expired$8) {
                                return false;
                            }
                            step$0$expired$8 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$10;
                        $dart$core.bool step$1$Init$13() {
                            if (iterator_1$10 != null) {
                                return true;
                            }
                            if (!step$0$9()) {
                                return false;
                            }
                            iterator_1$10 = funcs0.sequence().iterator();
                            return true;
                        }

                        $ceylon$language.Callable f$11;
                        $dart$core.bool step$1$14() {
                            while (step$1$Init$13()) {
                                $dart$core.Object next$12;
                                if ((next$12 = iterator_1$10.next()) is !$ceylon$language.Finished) {
                                    f$11 = next$12 as $ceylon$language.Callable;
                                    return true;
                                }
                                iterator_1$10 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$15() {
                            if (!step$1$14()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Callable f = f$11;
                            return f.f();
                        }

                        return new $ceylon$language.dart$Callable(step$2$15);
                    })).sequence().equals(values)) {
                        throw new $ceylon$language.AssertionError("Violated: { for (f in funcs0.sequence()) f() }.sequence().equals(values)");
                    }
                    $ceylon$language.Iterable funcs1 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$16 = false;
                        $dart$core.bool step$0$17() {
                            if (step$0$expired$16) {
                                return false;
                            }
                            step$0$expired$16 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$18;
                        $dart$core.bool step$1$Init$21() {
                            if (iterator_1$18 != null) {
                                return true;
                            }
                            if (!step$0$17()) {
                                return false;
                            }
                            iterator_1$18 = valuesNull.iterator();
                            return true;
                        }

                        $ceylon$language.Integer v$19;
                        $dart$core.bool step$1$22() {
                            while (step$1$Init$21()) {
                                $dart$core.Object next$20;
                                if ((next$20 = iterator_1$18.next()) is !$ceylon$language.Finished) {
                                    v$19 = next$20 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$18 = null;
                            }
                            return false;
                        }

                        $dart$core.int w$25;
                        $dart$core.bool step$2$23() {
                            while (step$1$22()) {
                                $ceylon$language.Integer v = v$19;
                                $dart$core.int w;
                                $dart$core.int tmp$24 = $ceylon$language.Integer.nativeValue(v);
                                if (!(!(tmp$24 == null))) {
                                    continue;
                                }
                                w = tmp$24;
                                w$25 = w;
                                return true;
                            }
                            return false;
                        }

                        $dart$core.Object step$3$26() {
                            if (!step$2$23()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer v = v$19;
                            $dart$core.int w = w$25;
                            return new $ceylon$language.dart$Callable(() => $ceylon$language.Integer.instance(w));
                        }

                        return new $ceylon$language.dart$Callable(step$3$26);
                    }));
                    if (!$ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$27 = false;
                        $dart$core.bool step$0$28() {
                            if (step$0$expired$27) {
                                return false;
                            }
                            step$0$expired$27 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$29;
                        $dart$core.bool step$1$Init$32() {
                            if (iterator_1$29 != null) {
                                return true;
                            }
                            if (!step$0$28()) {
                                return false;
                            }
                            iterator_1$29 = funcs1.sequence().iterator();
                            return true;
                        }

                        $ceylon$language.Callable f$30;
                        $dart$core.bool step$1$33() {
                            while (step$1$Init$32()) {
                                $dart$core.Object next$31;
                                if ((next$31 = iterator_1$29.next()) is !$ceylon$language.Finished) {
                                    f$30 = next$31 as $ceylon$language.Callable;
                                    return true;
                                }
                                iterator_1$29 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$34() {
                            if (!step$1$33()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Callable f = f$30;
                            return f.f();
                        }

                        return new $ceylon$language.dart$Callable(step$2$34);
                    })).sequence().equals(values)) {
                        throw new $ceylon$language.AssertionError("Violated: { for (f in funcs1.sequence()) f() }.sequence().equals(values)");
                    }
                    $ceylon$language.Iterable funcs2 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$35 = false;
                        $dart$core.bool step$0$36() {
                            if (step$0$expired$35) {
                                return false;
                            }
                            step$0$expired$35 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$37;
                        $dart$core.bool step$1$Init$40() {
                            if (iterator_1$37 != null) {
                                return true;
                            }
                            if (!step$0$36()) {
                                return false;
                            }
                            iterator_1$37 = values.iterator();
                            return true;
                        }

                        $ceylon$language.Integer v$38;
                        $dart$core.bool step$1$41() {
                            while (step$1$Init$40()) {
                                $dart$core.Object next$39;
                                if ((next$39 = iterator_1$37.next()) is !$ceylon$language.Finished) {
                                    v$38 = next$39 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$37 = null;
                            }
                            return false;
                        }

                        $ceylon$language.Callable w$44;
                        $dart$core.bool step$2$42() {
                            while (step$1$41()) {
                                $ceylon$language.Integer v = v$38;
                                $ceylon$language.Callable w;
                                $ceylon$language.Callable tmp$43 = true ? new $ceylon$language.dart$Callable(() => v) : null;
                                if (!(!(tmp$43 == null))) {
                                    continue;
                                }
                                w = tmp$43;
                                w$44 = w;
                                return true;
                            }
                            return false;
                        }

                        $dart$core.Object step$3$45() {
                            if (!step$2$42()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer v = v$38;
                            $ceylon$language.Callable w = w$44;
                            return w;
                        }

                        return new $ceylon$language.dart$Callable(step$3$45);
                    }));
                    if (!$ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$46 = false;
                        $dart$core.bool step$0$47() {
                            if (step$0$expired$46) {
                                return false;
                            }
                            step$0$expired$46 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$48;
                        $dart$core.bool step$1$Init$51() {
                            if (iterator_1$48 != null) {
                                return true;
                            }
                            if (!step$0$47()) {
                                return false;
                            }
                            iterator_1$48 = funcs2.sequence().iterator();
                            return true;
                        }

                        $ceylon$language.Callable f$49;
                        $dart$core.bool step$1$52() {
                            while (step$1$Init$51()) {
                                $dart$core.Object next$50;
                                if ((next$50 = iterator_1$48.next()) is !$ceylon$language.Finished) {
                                    f$49 = next$50 as $ceylon$language.Callable;
                                    return true;
                                }
                                iterator_1$48 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$53() {
                            if (!step$1$52()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Callable f = f$49;
                            return f.f();
                        }

                        return new $ceylon$language.dart$Callable(step$2$53);
                    })).sequence().equals(values)) {
                        throw new $ceylon$language.AssertionError("Violated: { for (f in funcs2.sequence()) f() }.sequence().equals(values)");
                    }
                    $ceylon$language.Iterable funcs3 = $ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$54 = false;
                        $dart$core.bool step$0$55() {
                            if (step$0$expired$54) {
                                return false;
                            }
                            step$0$expired$54 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$56;
                        $dart$core.bool step$1$Init$59() {
                            if (iterator_1$56 != null) {
                                return true;
                            }
                            if (!step$0$55()) {
                                return false;
                            }
                            iterator_1$56 = values.iterator();
                            return true;
                        }

                        $ceylon$language.Integer v$57;
                        $dart$core.bool step$1$60() {
                            while (step$1$Init$59()) {
                                $dart$core.Object next$58;
                                if ((next$58 = iterator_1$56.next()) is !$ceylon$language.Finished) {
                                    v$57 = next$58 as $ceylon$language.Integer;
                                    return true;
                                }
                                iterator_1$56 = null;
                            }
                            return false;
                        }

                        $ceylon$language.Iterator iterator_2$61;
                        $dart$core.bool step$2$Init$64() {
                            if (iterator_2$61 != null) {
                                return true;
                            }
                            if (!step$1$60()) {
                                return false;
                            }
                            $ceylon$language.Integer v = v$57;
                            iterator_2$61 = (new $ceylon$language.LazyIterable(1, (final $dart$core.int $i$) {
                                switch ($i$) {
                                case 0 :
                                return new $ceylon$language.dart$Callable(() => v);
                                }
                            }, null)).iterator();
                            return true;
                        }

                        $ceylon$language.Callable w$62;
                        $dart$core.bool step$2$65() {
                            while (step$2$Init$64()) {
                                $ceylon$language.Integer v = v$57;
                                $dart$core.Object next$63;
                                if ((next$63 = iterator_2$61.next()) is !$ceylon$language.Finished) {
                                    w$62 = next$63 as $ceylon$language.Callable;
                                    return true;
                                }
                                iterator_2$61 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$3$66() {
                            if (!step$2$65()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Integer v = v$57;
                            $ceylon$language.Callable w = w$62;
                            return w;
                        }

                        return new $ceylon$language.dart$Callable(step$3$66);
                    }));
                    if (!$ceylon$language.functionIterable(new $ceylon$language.dart$Callable(() {
                        $dart$core.bool step$0$expired$67 = false;
                        $dart$core.bool step$0$68() {
                            if (step$0$expired$67) {
                                return false;
                            }
                            step$0$expired$67 = true;
                            return true;
                        }

                        $ceylon$language.Iterator iterator_1$69;
                        $dart$core.bool step$1$Init$72() {
                            if (iterator_1$69 != null) {
                                return true;
                            }
                            if (!step$0$68()) {
                                return false;
                            }
                            iterator_1$69 = funcs3.sequence().iterator();
                            return true;
                        }

                        $ceylon$language.Callable f$70;
                        $dart$core.bool step$1$73() {
                            while (step$1$Init$72()) {
                                $dart$core.Object next$71;
                                if ((next$71 = iterator_1$69.next()) is !$ceylon$language.Finished) {
                                    f$70 = next$71 as $ceylon$language.Callable;
                                    return true;
                                }
                                iterator_1$69 = null;
                            }
                            return false;
                        }

                        $dart$core.Object step$2$74() {
                            if (!step$1$73()) {
                                return $ceylon$language.finished;
                            }
                            $ceylon$language.Callable f = f$70;
                            return f.f();
                        }

                        return new $ceylon$language.dart$Callable(step$2$74);
                    })).sequence().equals(values)) {
                        throw new $ceylon$language.AssertionError("Violated: { for (f in funcs3.sequence()) f() }.sequence().equals(values)");
                    }
                    $ceylon$language.print($ceylon$language.String.instance("* comprehensionCaptureTest end"));
                }

                void run() => $package$run();
             """;
         };
    }
}
