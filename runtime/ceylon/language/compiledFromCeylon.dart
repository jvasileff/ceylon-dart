part of ceylon.language;

// functions.ceylon / identity
$dart$core.Object $package$identity([$dart$core.Object argument]) => argument;

$dart$core.Object identity([$dart$core.Object argument]) => $package$identity(argument);

// identical.ceylon
$dart$core.bool $package$identical([Identifiable x, Identifiable y]) => $dart$core.identical(x, y);

$dart$core.bool identical([Identifiable x, Identifiable y]) => $package$identical(x, y);

// largest.ceylon
$dart$core.Object $package$largest([$dart$core.Object x, $dart$core.Object y]) => (() {
    if ((x as Comparable).largerThan(y)) {
        return x;
    } else {
        return y;
    }
})();

$dart$core.Object largest([$dart$core.Object x, $dart$core.Object y]) => $package$largest(x, y);

// plus.ceylon
$dart$core.Object $package$plus([$dart$core.Object x, $dart$core.Object y]) => (x as Summable).plus(y);

$dart$core.Object plus([$dart$core.Object x, $dart$core.Object y]) => $package$plus(x, y);

// smallest.ceylon
$dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (() {
    if ((x as Comparable).smallerThan(y)) {
        return x;
    } else {
        return y;
    }
})();

$dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);

// times.ceylon
$dart$core.Object $package$times([$dart$core.Object x, $dart$core.Object y]) => (x as Numeric).times(y);

$dart$core.Object times([$dart$core.Object x, $dart$core.Object y]) => $package$times(x, y);

// print.ceylon
void $package$print([$dart$core.Object val]) => process.writeLine($package$stringify(val));

void print([$dart$core.Object val]) => $package$print(val);

void $package$printAll([Iterable values, $dart$core.Object separator = dart$default]) {
    if ($dart$core.identical(separator, dart$default)) {
        separator = ", ";
    }
    $dart$core.bool first = true;
    values.each(new dart$Callable(([$dart$core.Object element]) {
        if (first) {
            first = false;
        } else {
            process.write(separator as $dart$core.String);
        }
        process.write($package$stringify(element));
    }));
    process.write(operatingSystem.newline);
}

void printAll([Iterable values, $dart$core.Object separator = dart$default]) => $package$printAll(values, separator);

$dart$core.String $package$stringify([$dart$core.Object val]) => (($lhs$) => $lhs$ == null ? "<null>" : $lhs$)((($r$) => $r$ == null ? null : $r$.string)(val));

$dart$core.String stringify([$dart$core.Object val]) => $package$stringify(val);

// every.ceylon

$dart$core.bool $package$every([Iterable values]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val = element$1 as Boolean;
            if (!Boolean.nativeValue(val)) {
                return false;
            }
        }
    }
    return true;
}

$dart$core.bool every([Iterable values]) => $package$every(values);
