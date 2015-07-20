part of ceylon.language;

$dart$core.Object $package$identity([$dart$core.Object argument]) => argument;

$dart$core.Object identity([$dart$core.Object argument]) => $package$identity(argument);

$dart$core.int $package$minRadix = 2;

$dart$core.int get minRadix => $package$minRadix;

$dart$core.int $package$maxRadix = 36;

$dart$core.int get maxRadix => $package$maxRadix;

$dart$core.int $package$aIntLower = (new Character.$fromInt(97)).integer;

$dart$core.int get aIntLower => $package$aIntLower;

$dart$core.int $package$aIntUpper = (new Character.$fromInt(65)).integer;

$dart$core.int get aIntUpper => $package$aIntUpper;

$dart$core.int $package$zeroInt = (new Character.$fromInt(48)).integer;

$dart$core.int get zeroInt => $package$zeroInt;

$dart$core.bool $package$any([Iterable values]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val = element$1 as Boolean;
            if (Boolean.nativeValue(val)) {
                return true;
            }
        }
    }
    return false;
}

$dart$core.bool any([Iterable values]) => $package$any(values);

Array $package$arrayOfSize([$dart$core.int size, $dart$core.Object element]) => new Array.ofSize(size, element);

Array arrayOfSize([$dart$core.int size, $dart$core.Object element]) => $package$arrayOfSize(size, element);

$dart$core.int $package$count([Iterable values]) {
    $dart$core.int count = 0;{
        $dart$core.Object element$3;
        Iterator iterator$2 = values.iterator();
        while ((element$3 = iterator$2.next()) is !Finished) {
            Boolean val = element$3 as Boolean;
            if (Boolean.nativeValue(val)) {
                count = Integer.nativeValue(Integer.instance(count).successor);
            }
        }
    }
    return count;
}

$dart$core.int count([Iterable values]) => $package$count(values);

$dart$core.bool $package$every([Iterable values]) {{
        $dart$core.Object element$5;
        Iterator iterator$4 = values.iterator();
        while ((element$5 = iterator$4.next()) is !Finished) {
            Boolean val = element$5 as Boolean;
            if (!Boolean.nativeValue(val)) {
                return false;
            }
        }
    }
    return true;
}

$dart$core.bool every([Iterable values]) => $package$every(values);

$dart$core.String $package$formatInteger([$dart$core.int integer, $dart$core.Object radix = dart$default]) {
    if ($dart$core.identical(radix, dart$default)) {
        radix = 10;
    }
    if (!(Integer.instance(radix as $dart$core.int).notSmallerThan(Integer.instance($package$minRadix)) && Integer.instance(radix as $dart$core.int).notLargerThan(Integer.instance($package$maxRadix)))) {
        throw new AssertionError("Violated: minRadix <= radix <= maxRadix");
    }
    if (Integer.instance(integer).equals(Integer.instance(0))) {
        return "0";
    }
    Iterable digits = String.instance("");
    $dart$core.int i = (($dart$core.int $lhs$) => $lhs$ == null ? Integer.nativeValue(Integer.instance(integer).negated) : $lhs$)(Integer.instance(integer).smallerThan(Integer.instance(0)) ? integer : null);
    while (!Integer.instance(i).equals(Integer.instance(0))) {
        $dart$core.int d = Integer.nativeValue(Integer.instance(i).remainder(Integer.instance(radix as $dart$core.int)).negated);
        Character c;
        if (Integer.instance(d).notSmallerThan(Integer.instance(0)) && Integer.instance(d).smallerThan(Integer.instance(10))) {
            c = Integer.instance(d).plus(Integer.instance($package$zeroInt)).character;
        } else if (Integer.instance(d).notSmallerThan(Integer.instance(10)) && Integer.instance(d).smallerThan(Integer.instance(36))) {
            c = Integer.instance(d).minus(Integer.instance(10)).plus(Integer.instance($package$aIntLower)).character;
        } else {
            if (!false) {
                throw new AssertionError("Violated: false");
            }
        }
        digits = digits.follow(c);
        i = Integer.nativeValue(Integer.instance(i).plus(Integer.instance(d)).divided(Integer.instance(radix as $dart$core.int)));
    }
    if (Integer.instance(integer).smallerThan(Integer.instance(0))) {
        digits = digits.follow(new Character.$fromInt(45));
    }
    return String.nativeValue(new String(digits));
}

$dart$core.String formatInteger([$dart$core.int integer, $dart$core.Object radix = dart$default]) => $package$formatInteger(integer, radix);

$dart$core.bool $package$identical([Identifiable x, Identifiable y]) => $dart$core.identical(x, y);

$dart$core.bool identical([Identifiable x, Identifiable y]) => $package$identical(x, y);

$dart$core.double $package$infinity = Float.nativeValue(Float.instance(1.0).divided(Float.instance(0.0)));

$dart$core.double get infinity => $package$infinity;

$dart$core.Object $package$largest([$dart$core.Object x, $dart$core.Object y]) => (($dart$core.Object $lhs$) => $lhs$ == null ? y : $lhs$)((x as Comparable).largerThan(y) ? x : null);

$dart$core.Object largest([$dart$core.Object x, $dart$core.Object y]) => $package$largest(x, y);

$dart$core.Object $package$plus([$dart$core.Object x, $dart$core.Object y]) => (x as Summable).plus(y);

$dart$core.Object plus([$dart$core.Object x, $dart$core.Object y]) => $package$plus(x, y);

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

$dart$core.String $package$stringify([$dart$core.Object val]) => (($dart$core.String $lhs$) => $lhs$ == null ? "<null>" : $lhs$)((($dart$core.Object $r$) => $r$ == null ? null : $r$.string)(val));

$dart$core.String stringify([$dart$core.Object val]) => $package$stringify(val);

$dart$core.Object $package$product([Iterable values]) {
    $dart$core.Object product = values.first;{
        $dart$core.Object element$7;
        Iterator iterator$6 = values.rest.iterator();
        while ((element$7 = iterator$6.next()) is !Finished) {
            $dart$core.Object val = element$7;
            product = (product as Numeric).times(val);
        }
    }
    return product;
}

$dart$core.Object product([Iterable values]) => $package$product(values);

$dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (($dart$core.Object $lhs$) => $lhs$ == null ? y : $lhs$)((x as Comparable).smallerThan(y) ? x : null);

$dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);

$dart$core.Object $package$sum([Iterable values]) {
    Iterator it = values.iterator();
    $dart$core.Object first;{
        $dart$core.Object first$8 = it.next();
        if (first$8 is Finished) {
            throw new AssertionError("Violated: !is Finished first = it.next()");
        }
        first = first$8;
    }
    $dart$core.Object sum = first;
    while (true) {
        $dart$core.Object val;
        $dart$core.Object val$9 = it.next();
        if (val$9 is Finished) {
            break;
        }
        val = val$9;
        sum = (sum as Summable).plus(val);
    }
    return sum;
}

$dart$core.Object sum([Iterable values]) => $package$sum(values);

$dart$core.Object $package$times([$dart$core.Object x, $dart$core.Object y]) => (x as Numeric).times(y);

$dart$core.Object times([$dart$core.Object x, $dart$core.Object y]) => $package$times(x, y);
