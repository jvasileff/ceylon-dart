part of ceylon.language;

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
