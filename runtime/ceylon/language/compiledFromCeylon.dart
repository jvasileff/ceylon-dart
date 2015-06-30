part of ceylon.language;

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

// smallest.ceylon
$dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (() {
    if ((x as Comparable).smallerThan(y)) {
        return x;
    } else {
        return y;
    }
})();

$dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);
