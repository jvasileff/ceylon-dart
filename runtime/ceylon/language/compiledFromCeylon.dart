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
