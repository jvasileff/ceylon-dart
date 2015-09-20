
import "dart:core" as $dart$core;
import "dart:io" as $dart$io;
import "dart:math" as $dart$math;
import "dart:mirrors" as $dart$mirrors;
import "source/ceylon/language/module.dart";

Callable $package$and([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object val]) {
    return Boolean.instance((([$dart$core.Object val]) => Boolean.nativeValue(p.$delegate$(val) as Boolean) && Boolean.nativeValue(q.$delegate$(val) as Boolean))(val));
});

Callable and([Callable p, Callable q]) => $package$and(p, q);

abstract class Annotated {
    $dart$core.bool annotated();
}
abstract class Annotation {
}
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

$dart$core.Object $package$apply([Callable f, $dart$core.Object args]) => $package$unflatten(f).$delegate$(args);

$dart$core.Object apply([Callable f, $dart$core.Object args]) => $package$apply(f, args);

Array $package$arrayOfSize([$dart$core.int size, $dart$core.Object element]) => new Array.ofSize(size, element);

Array arrayOfSize([$dart$core.int size, $dart$core.Object element]) => $package$arrayOfSize(size, element);

class ArraySequence implements Sequence {
    ArraySequence([Array this.array]) {
        if (!(!array.empty)) {
            throw new AssertionError("Violated: !array.empty");
        }
    }
    Array array;
    $dart$core.Object getFromFirst([$dart$core.int index]) => array.getFromFirst(index);
    $dart$core.bool contains([$dart$core.Object element]) => array.contains(element);
    $dart$core.int get size => array.size;
    Iterator iterator() => array.iterator();
    $dart$core.Object get first {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object tmp$1 = array.first;
                if (!(tmp$1 == null)) {
                    $dart$core.Object first;
                    first = tmp$1;
                    doElse$0 = false;
                    return first;
                }
            }
            if (doElse$0) {
                if (!true) {
                    throw new AssertionError("Violated: is Element null");
                }
                return null;
            }
        }
    }
    $dart$core.Object get last {{
            $dart$core.bool doElse$2 = true;
            {
                $dart$core.Object tmp$3 = array.last;
                if (!(tmp$3 == null)) {
                    $dart$core.Object last;
                    last = tmp$3;
                    doElse$2 = false;
                    return last;
                }
            }
            if (doElse$2) {
                if (!true) {
                    throw new AssertionError("Violated: is Element null");
                }
                return null;
            }
        }
    }
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(array.spanFrom(Integer.instance(1))) : $lhs$)(Integer.instance(size).equals(Integer.instance(1)) ? $package$empty : null);
    Sequence clone() => new ArraySequence(array.clone());
    void each([Callable step]) => array.each(step);
    $dart$core.int count([Callable selecting]) => array.count(selecting);
    $dart$core.bool every([Callable selecting]) => array.every(selecting);
    $dart$core.bool any([Callable selecting]) => array.any(selecting);
    $dart$core.Object find([Callable selecting]) => array.find(selecting);
    $dart$core.Object findLast([Callable selecting]) => array.findLast(selecting);
    $dart$core.Object reduce([Callable accumulating]) {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$4 = array.reduce(accumulating);
            if (tmp$4 == null) {
                throw new AssertionError("Violated: exists result = array.reduce(accumulating)");
            }
            result = tmp$4;
        }
        return result;
    }
    Sequence collect([Callable collecting]) {
        Sequence sequence;
        {
            Sequential tmp$5 = array.collect(collecting);
            if (!(tmp$5 is Sequence)) {
                throw new AssertionError("Violated: nonempty sequence = array.collect(collecting)");
            }
            sequence = tmp$5 as Sequence;
        }
        return sequence;
    }
    Sequence sort([Callable comparing]) {
        Sequence sequence;
        {
            Sequential tmp$6 = array.sort(comparing);
            if (!(tmp$6 is Sequence)) {
                throw new AssertionError("Violated: nonempty sequence = array.sort(comparing)");
            }
            sequence = tmp$6 as Sequence;
        }
        return sequence;
    }
    Sequential measure([Integer from, $dart$core.int length]) {
        if (((Integer.nativeValue(from) > lastIndex) || (length <= 0)) || ((Integer.nativeValue(from) + length) <= 0)) {
            return $package$empty;
        } else if (Integer.nativeValue(from) < 0) {
            return new ArraySequence(array.measure(Integer.instance(0), length + Integer.nativeValue(from)));
        } else {
            return new ArraySequence(array.measure(from, length));
        }
    }
    Sequential span([Integer from, Integer to]) {
        if (Integer.nativeValue(from) <= Integer.nativeValue(to)) {
            return ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(array.span(from, to)) : $lhs$)((Integer.nativeValue(to) < 0) || (Integer.nativeValue(from) > lastIndex) ? $package$empty : null);
        } else {
            return ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(array.span(from, to)) : $lhs$)((Integer.nativeValue(from) < 0) || (Integer.nativeValue(to) > lastIndex) ? $package$empty : null);
        }
    }
    Sequential spanFrom([$dart$core.int from]) => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(array.spanFrom(Integer.instance(from))) : $lhs$)(from > lastIndex ? $package$empty : null);
    Sequential spanTo([$dart$core.int to]) => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(array.spanTo(Integer.instance(to))) : $lhs$)(to < 0 ? $package$empty : null);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => array.firstOccurrence(element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => array.lastOccurrence(element);
    $dart$core.bool occurs([$dart$core.Object element]) => array.occurs(element);
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Binary {
    $dart$core.Object get not;
    $dart$core.Object leftLogicalShift([$dart$core.int shift]);
    $dart$core.Object rightLogicalShift([$dart$core.int shift]);
    $dart$core.Object rightArithmeticShift([$dart$core.int shift]);
    $dart$core.Object and([$dart$core.Object other]);
    $dart$core.Object or([$dart$core.Object other]);
    $dart$core.Object xor([$dart$core.Object other]);
    $dart$core.bool get([$dart$core.int index]);
    $dart$core.Object set([$dart$core.int index, $dart$core.Object bit = $package$dart$default]);
    $dart$core.Object clear([$dart$core.int index]);
    static $dart$core.Object $clear([final Binary $this, $dart$core.int index]) => $this.set(index, false);
    $dart$core.Object flip([$dart$core.int index]);
}
Callable $package$byDecreasing([Callable comparable]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) => (comparable.$delegate$(y) as Comparable).compare(comparable.$delegate$(x)));

Callable byDecreasing([Callable comparable]) => $package$byDecreasing(comparable);

Comparison $package$decreasing([$dart$core.Object x, $dart$core.Object y]) => (y as Comparable).compare(x);

Comparison decreasing([$dart$core.Object x, $dart$core.Object y]) => $package$decreasing(x, y);

Comparison $package$decreasingKey([Entry x, Entry y]) => (y.key as Comparable).compare(x.key);

Comparison decreasingKey([Entry x, Entry y]) => $package$decreasingKey(x, y);

Comparison $package$decreasingItem([Entry x, Entry y]) => (y.item as Comparable).compare(x.item);

Comparison decreasingItem([Entry x, Entry y]) => $package$decreasingItem(x, y);

Callable $package$byIncreasing([Callable comparable]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) => (comparable.$delegate$(x) as Comparable).compare(comparable.$delegate$(y)));

Callable byIncreasing([Callable comparable]) => $package$byIncreasing(comparable);

Comparison $package$increasing([$dart$core.Object x, $dart$core.Object y]) => (x as Comparable).compare(y);

Comparison increasing([$dart$core.Object x, $dart$core.Object y]) => $package$increasing(x, y);

Comparison $package$increasingKey([Entry x, Entry y]) => (x.key as Comparable).compare(y.key);

Comparison increasingKey([Entry x, Entry y]) => $package$increasingKey(x, y);

Comparison $package$increasingItem([Entry x, Entry y]) => (x.item as Comparable).compare(y.item);

Comparison increasingItem([Entry x, Entry y]) => $package$increasingItem(x, y);

Callable $package$byItem([Callable comparing]) => new dart$Callable(([Entry x, Entry y]) => comparing.$delegate$(x.item, y.item) as Comparison);

Callable byItem([Callable comparing]) => $package$byItem(comparing);

Callable $package$byKey([Callable comparing]) => new dart$Callable(([Entry x, Entry y]) => comparing.$delegate$(x.key, y.key) as Comparison);

Callable byKey([Callable comparing]) => $package$byKey(comparing);

abstract class Category {
    $dart$core.bool contains([$dart$core.Object element]);
    $dart$core.bool containsEvery([Iterable elements]);
    static $dart$core.bool $containsEvery([final Category $this, Iterable elements]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = elements.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object element = element$1;
                if (!$this.contains(element)) {
                    return false;
                }
            }
        }
        return true;
    }
    $dart$core.bool containsAny([Iterable elements]);
    static $dart$core.bool $containsAny([final Category $this, Iterable elements]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = elements.iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                $dart$core.Object element = element$3;
                if ($this.contains(element)) {
                    return true;
                }
            }
        }
        return false;
    }
}
class ChainedIterator implements Iterator {
    ChainedIterator([Iterable this.first, Iterable this.second]) {
        iter = first.iterator();
        more = true;
    }
    Iterable first;
    Iterable second;
    Iterator iter;
    $dart$core.bool more;
    $dart$core.Object next() {
        $dart$core.Object element = iter.next();
        if (more && (element is Finished)) {
            iter = second.iterator();
            more = false;
            return iter.next();
        } else {
            return element;
        }
    }
    $dart$core.String toString() => ((("" + first.toString()) + ".chain(") + second.toString()) + ").iterator()";
}
abstract class Collection implements Iterable {
    Collection clone();
    $dart$core.bool get empty;
    static $dart$core.bool $get$empty([final Collection $this]) => Integer.instance($this.size).equals(Integer.instance(0));
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Collection $this, $dart$core.Object element]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = $this.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object elem = element$1;
                if (!(elem == null)) {
                    if (elem.equals(element)) {
                        return true;
                    }
                }
            }
            {
                return false;
            }
        }
    }
    $dart$core.String toString();
    static $dart$core.String $get$string([final Collection $this]) => (($dart$core.String $lhs$) => $lhs$ == null ? ("{ " + $package$commaList($this)) + " }" : $lhs$)($this.empty ? "{}" : null);
}
abstract class Comparable {
    Comparison compare([$dart$core.Object other]);
    $dart$core.bool largerThan([$dart$core.Object other]);
    static $dart$core.bool $largerThan([final Comparable $this, $dart$core.Object other]) => $dart$core.identical($this.compare(other), $package$larger);
    $dart$core.bool smallerThan([$dart$core.Object other]);
    static $dart$core.bool $smallerThan([final Comparable $this, $dart$core.Object other]) => $dart$core.identical($this.compare(other), $package$smaller);
    $dart$core.bool notSmallerThan([$dart$core.Object other]);
    static $dart$core.bool $notSmallerThan([final Comparable $this, $dart$core.Object other]) => !$dart$core.identical($this.compare(other), $package$smaller);
    $dart$core.bool notLargerThan([$dart$core.Object other]);
    static $dart$core.bool $notLargerThan([final Comparable $this, $dart$core.Object other]) => !$dart$core.identical($this.compare(other), $package$larger);
}
abstract class ConstrainedAnnotation implements Annotation {
}
class Correspondence$keys$$anonymous$0_ implements Category {
    Correspondence $outer$ceylon$language$Correspondence;
    Correspondence$keys$$anonymous$0_([Correspondence this.$outer$ceylon$language$Correspondence]) {}
    $dart$core.bool contains([$dart$core.Object key]) => $outer$ceylon$language$Correspondence.defines(key);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class Correspondence {
    $dart$core.Object get([$dart$core.Object key]);
    $dart$core.bool defines([$dart$core.Object key]);
    Category get keys;
    static Category $get$keys([final Correspondence $this]) => new Correspondence$keys$$anonymous$0_($this);
    $dart$core.bool definesEvery([Iterable keys]);
    static $dart$core.bool $definesEvery([final Correspondence $this, Iterable keys]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = keys.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object key = element$1;
                if (!$this.defines(key)) {
                    return false;
                }
            }
            {
                return true;
            }
        }
    }
    $dart$core.bool definesAny([Iterable keys]);
    static $dart$core.bool $definesAny([final Correspondence $this, Iterable keys]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = keys.iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                $dart$core.Object key = element$3;
                if ($this.defines(key)) {
                    return true;
                }
            }
            {
                return false;
            }
        }
    }
    Iterable getAll([Iterable keys]);
    static Iterable $getAll([final Correspondence $this, Iterable keys]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$4 = false;
        $dart$core.bool step$0$5() {
            if (step$0$expired$4) {
                return false;
            }
            step$0$expired$4 = true;
            return true;
        }

        Iterator iterator_1$6;
        $dart$core.bool step$1$Init$9() {
            if (iterator_1$6 != null) {
                return true;
            }
            if (!step$0$5()) {
                return false;
            }
            iterator_1$6 = keys.iterator();
            return true;
        }

        $dart$core.Object key$7;
        $dart$core.bool step$1$10() {
            while (step$1$Init$9()) {
                $dart$core.Object next$8;
                if ((next$8 = iterator_1$6.next()) is !Finished) {
                    key$7 = next$8;
                    return true;
                }
                iterator_1$6 = null;
            }
            return false;
        }

        $dart$core.Object step$2$11() {
            if (!step$1$10()) {
                return $package$finished;
            }
            $dart$core.Object key = key$7;
            return $this.get(key);
        }

        return new dart$Callable(step$2$11);
    }));
}
$dart$core.bool $package$corresponding([Iterable firstIterable, Iterable secondIterable, $dart$core.Object comparing = $package$dart$default]) {
    if ($dart$core.identical(comparing, $package$dart$default)) {
        comparing = new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => (() {
            $dart$core.bool doElse$0 = true;
            if (!(first == null)) {
                if (!(second == null)) {
                    doElse$0 = false;
                    return Boolean.instance(first.equals(second));
                }
            }
            if (doElse$0) {
                return Boolean.instance((!(!(first == null))) && (!(!(second == null))));
            }
        })());
    }
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    while (true) {
        $dart$core.Object first = firstIter.next();
        $dart$core.Object second = secondIter.next();
        {
            $dart$core.bool doElse$1 = true;
            if (!(first is Finished)) {
                if (!(second is Finished)) {
                    doElse$1 = false;
                    if (!Boolean.nativeValue((comparing as Callable).$delegate$(first, second) as Boolean)) {
                        return false;
                    }
                }
            }
            if (doElse$1) {
                return (first is Finished) && (second is Finished);
            }
        }
    }
}

$dart$core.bool corresponding([Iterable firstIterable, Iterable secondIterable, $dart$core.Object comparing = $package$dart$default]) => $package$corresponding(firstIterable, secondIterable, comparing);

$dart$core.int $package$count([Iterable values]) {
    $dart$core.int count = 0;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val = element$1 as Boolean;
            if (Boolean.nativeValue(val)) {
                count = Integer.nativeValue(Integer.instance(count).successor);
            }
        }
    }
    return count;
}

$dart$core.int count([Iterable values]) => $package$count(values);

Callable $package$curry([Callable f]) => new dart$Callable(([$dart$core.Object first]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => $package$unflatten(f).$delegate$(new Tuple(first, args)))));

Callable curry([Callable f]) => $package$curry(f);

Callable $package$uncurry([Callable f]) => $package$flatten(new dart$Callable(([Tuple args]) => $package$unflatten(f.$delegate$(args.first) as Callable).$delegate$(args.rest)));

Callable uncurry([Callable f]) => $package$uncurry(f);

class CycledIterator implements Iterator {
    CycledIterator([Iterable this.iterable, $dart$core.int this.times]) {
        iter = $package$emptyIterator;
        count = 0;
    }
    Iterable iterable;
    $dart$core.int times;
    Iterator iter;
    $dart$core.int count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object next$1 = iter.next();
                if (!(next$1 is Finished)) {
                    $dart$core.Object next;
                    next = next$1;
                    doElse$0 = false;
                    return next;
                }
            }
            if (doElse$0) {
                if (count < times) {
                    count = Integer.nativeValue(Integer.instance(count).successor);
                    iter = iterable.iterator();
                } else {
                    iter = $package$emptyIterator;
                }
                return iter.next();
            }
        }
    }
    $dart$core.String toString() => ((("" + iterable.toString()) + ".repeat(") + Integer.instance(times).toString()) + ").iterator()";
}
class functionIterable$$anonymous$0_$$anonymous$1_ implements Iterator {
    functionIterable$$anonymous$0_ $outer$ceylon$language$functionIterable$$anonymous$0_;
    functionIterable$$anonymous$0_$$anonymous$1_([functionIterable$$anonymous$0_ this.$outer$ceylon$language$functionIterable$$anonymous$0_]) {
        n = $outer$ceylon$language$functionIterable$$anonymous$0_.$capture$functionIterable$f.$delegate$() as Callable;
    }
    Callable n;
    $dart$core.Object next() => n.$delegate$();
}
class functionIterable$$anonymous$0_ implements Iterable {
    Callable $capture$functionIterable$f;
    functionIterable$$anonymous$0_([Callable this.$capture$functionIterable$f]) {}
    Iterator iterator() => new functionIterable$$anonymous$0_$$anonymous$1_(this);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Iterable $package$functionIterable([Callable f]) => new functionIterable$$anonymous$0_(f);

Iterable functionIterable([Callable f]) => $package$functionIterable(f);

$dart$core.String $package$dartJoin([$dart$core.String val, Iterable objects]) {
    $dart$core.String result = "";
    $dart$core.bool first = true;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = objects.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            $dart$core.Object el = element$1;
            if (first) {
                first = false;
            } else {
                result = result + val;
            }
            result = result + el.toString();
        }
    }
    return result;
}

$dart$core.String dartJoin([$dart$core.String val, Iterable objects]) => $package$dartJoin(val, objects);

abstract class Destroyable implements Usable {
    void destroy([Throwable error]);
}
abstract class Empty implements Sequential, Ranged {
    $dart$core.Object getFromLast([$dart$core.int index]);
    static $dart$core.Object $getFromLast([final Empty $this, $dart$core.int index]) => null;
    $dart$core.Object getFromFirst([$dart$core.int index]);
    static $dart$core.Object $getFromFirst([final Empty $this, $dart$core.int index]) => null;
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Empty $this, $dart$core.Object element]) => false;
    $dart$core.bool defines([Integer index]);
    static $dart$core.bool $defines([final Empty $this, Integer index]) => false;
    Empty get keys;
    static Empty $get$keys([final Empty $this]) => $this;
    Empty indexes();
    static Empty $indexes([final Empty $this]) => $this;
    $dart$core.bool get empty;
    static $dart$core.bool $get$empty([final Empty $this]) => true;
    $dart$core.int get size;
    static $dart$core.int $get$size([final Empty $this]) => 0;
    Empty get reversed;
    static Empty $get$reversed([final Empty $this]) => $this;
    Empty sequence();
    static Empty $sequence([final Empty $this]) => $this;
    $dart$core.String toString();
    static $dart$core.String $get$string([final Empty $this]) => "[]";
    $dart$core.Object get lastIndex;
    static $dart$core.Object $get$lastIndex([final Empty $this]) => null;
    $dart$core.Object get first;
    static $dart$core.Object $get$first([final Empty $this]) => null;
    $dart$core.Object get last;
    static $dart$core.Object $get$last([final Empty $this]) => null;
    Empty get rest;
    static Empty $get$rest([final Empty $this]) => $this;
    Empty clone();
    static Empty $clone([final Empty $this]) => $this;
    Empty get coalesced;
    static Empty $get$coalesced([final Empty $this]) => $this;
    Empty get indexed;
    static Empty $get$indexed([final Empty $this]) => $this;
    Empty repeat([$dart$core.int times]);
    static Empty $repeat([final Empty $this, $dart$core.int times]) => $this;
    Empty get cycled;
    static Empty $get$cycled([final Empty $this]) => $this;
    Empty get paired;
    static Empty $get$paired([final Empty $this]) => $this;
    Iterator iterator();
    static Iterator $iterator([final Empty $this]) => $package$emptyIterator;
    Empty measure([Integer from, $dart$core.int length]);
    static Empty $measure([final Empty $this, Integer from, $dart$core.int length]) => $this;
    Empty span([Integer from, Integer to]);
    static Empty $span([final Empty $this, Integer from, Integer to]) => $this;
    Empty spanTo([Integer to]);
    static Empty $spanTo([final Empty $this, Integer to]) => $this;
    Empty spanFrom([Integer from]);
    static Empty $spanFrom([final Empty $this, Integer from]) => $this;
    Iterable chain([Iterable other]);
    static Iterable $chain([final Empty $this, Iterable other]) => other;
    Empty defaultNullElements([$dart$core.Object defaultValue]);
    static Empty $defaultNullElements([final Empty $this, $dart$core.Object defaultValue]) => $this;
    $dart$core.int count([Callable selecting]);
    static $dart$core.int $count([final Empty $this, Callable selecting]) => 0;
    Empty map([Callable collecting]);
    static Empty $map([final Empty $this, Callable collecting]) => $this;
    Empty flatMap([Callable collecting]);
    static Empty $flatMap([final Empty $this, Callable collecting]) => $this;
    Callable spread([Callable method]);
    static Callable $spread([final Empty $this, Callable method]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => $this));
    Empty filter([Callable selecting]);
    static Empty $filter([final Empty $this, Callable selecting]) => $this;
    Callable fold([$dart$core.Object initial]);
    static Callable $fold([final Empty $this, $dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) => initial);
    $dart$core.Object reduce([Callable accumulating]);
    static $dart$core.Object $reduce([final Empty $this, Callable accumulating]) => null;
    $dart$core.Object find([Callable selecting]);
    static $dart$core.Object $find([final Empty $this, Callable selecting]) => null;
    Empty sort([Callable comparing]);
    static Empty $sort([final Empty $this, Callable comparing]) => $this;
    Empty collect([Callable collecting]);
    static Empty $collect([final Empty $this, Callable collecting]) => $this;
    Empty select([Callable selecting]);
    static Empty $select([final Empty $this, Callable selecting]) => $this;
    $dart$core.bool any([Callable selecting]);
    static $dart$core.bool $any([final Empty $this, Callable selecting]) => false;
    $dart$core.bool every([Callable selecting]);
    static $dart$core.bool $every([final Empty $this, Callable selecting]) => true;
    Empty skip([$dart$core.int skipping]);
    static Empty $skip([final Empty $this, $dart$core.int skipping]) => $this;
    Empty take([$dart$core.int taking]);
    static Empty $take([final Empty $this, $dart$core.int taking]) => $this;
    Empty skipWhile([Callable skipping]);
    static Empty $skipWhile([final Empty $this, Callable skipping]) => $this;
    Empty takeWhile([Callable taking]);
    static Empty $takeWhile([final Empty $this, Callable taking]) => $this;
    Empty by([$dart$core.int step]);
    static Empty $by([final Empty $this, $dart$core.int step]) => $this;
    Tuple withLeading([$dart$core.Object element]);
    static Tuple $withLeading([final Empty $this, $dart$core.Object element]) => new Tuple.$withList([element], null);
    Tuple withTrailing([$dart$core.Object element]);
    static Tuple $withTrailing([final Empty $this, $dart$core.Object element]) => new Tuple.$withList([element], null);
    Sequential append([Sequential elements]);
    static Sequential $append([final Empty $this, Sequential elements]) => elements;
    Sequential prepend([Sequential elements]);
    static Sequential $prepend([final Empty $this, Sequential elements]) => elements;
    Iterable follow([$dart$core.Object head]);
    static Iterable $follow([final Empty $this, $dart$core.Object head]) => new LazyIterable(1, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return head;
        }
    }, null);
    Empty sublist([$dart$core.int from, $dart$core.int to]);
    static Empty $sublist([final Empty $this, $dart$core.int from, $dart$core.int to]) => $this;
    Empty sublistFrom([$dart$core.int from]);
    static Empty $sublistFrom([final Empty $this, $dart$core.int from]) => $this;
    Empty sublistTo([$dart$core.int to]);
    static Empty $sublistTo([final Empty $this, $dart$core.int to]) => $this;
    Empty initial([$dart$core.int length]);
    static Empty $initial([final Empty $this, $dart$core.int length]) => $this;
    Empty terminal([$dart$core.int length]);
    static Empty $terminal([final Empty $this, $dart$core.int length]) => $this;
    Empty indexesWhere([Callable selecting]);
    static Empty $indexesWhere([final Empty $this, Callable selecting]) => $this;
    $dart$core.Object firstIndexWhere([Callable selecting]);
    static $dart$core.Object $firstIndexWhere([final Empty $this, Callable selecting]) => null;
    $dart$core.Object lastIndexWhere([Callable selecting]);
    static $dart$core.Object $lastIndexWhere([final Empty $this, Callable selecting]) => null;
    $dart$core.bool includes([List sublist]);
    static $dart$core.bool $includes([final Empty $this, List sublist]) => sublist.empty;
    Empty trim([Callable trimming]);
    static Empty $trim([final Empty $this, Callable trimming]) => $this;
    Empty trimLeading([Callable trimming]);
    static Empty $trimLeading([final Empty $this, Callable trimming]) => $this;
    Empty trimTrailing([Callable trimming]);
    static Empty $trimTrailing([final Empty $this, Callable trimming]) => $this;
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final Empty $this, $dart$core.int index]) => new Tuple.$withList([$this, $this], null);
    void each([Callable step]);
    static void $each([final Empty $this, Callable step]) {}
}
class empty_ implements Empty {
    empty_() {}
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Empty.$get$string(this);
    $dart$core.Object getFromLast([$dart$core.int index]) => Empty.$getFromLast(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Empty.$getFromFirst(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => Empty.$contains(this, element);
    $dart$core.bool defines([Integer index]) => Empty.$defines(this, index);
    Empty get keys => Empty.$get$keys(this);
    Empty indexes() => Empty.$indexes(this);
    $dart$core.bool get empty => Empty.$get$empty(this);
    $dart$core.int get size => Empty.$get$size(this);
    Empty get reversed => Empty.$get$reversed(this);
    Empty sequence() => Empty.$sequence(this);
    $dart$core.Object get lastIndex => Empty.$get$lastIndex(this);
    $dart$core.Object get first => Empty.$get$first(this);
    $dart$core.Object get last => Empty.$get$last(this);
    Empty get rest => Empty.$get$rest(this);
    Empty clone() => Empty.$clone(this);
    Empty get coalesced => Empty.$get$coalesced(this);
    Empty get indexed => Empty.$get$indexed(this);
    Empty repeat([$dart$core.int times]) => Empty.$repeat(this, times);
    Empty get cycled => Empty.$get$cycled(this);
    Empty get paired => Empty.$get$paired(this);
    Iterator iterator() => Empty.$iterator(this);
    Empty measure([Integer from, $dart$core.int length]) => Empty.$measure(this, from, length);
    Empty span([Integer from, Integer to]) => Empty.$span(this, from, to);
    Empty spanTo([Integer to]) => Empty.$spanTo(this, to);
    Empty spanFrom([Integer from]) => Empty.$spanFrom(this, from);
    Iterable chain([Iterable other]) => Empty.$chain(this, other);
    Empty defaultNullElements([$dart$core.Object defaultValue]) => Empty.$defaultNullElements(this, defaultValue);
    $dart$core.int count([Callable selecting]) => Empty.$count(this, selecting);
    Empty map([Callable collecting]) => Empty.$map(this, collecting);
    Empty flatMap([Callable collecting]) => Empty.$flatMap(this, collecting);
    Callable spread([Callable method]) => Empty.$spread(this, method);
    Empty filter([Callable selecting]) => Empty.$filter(this, selecting);
    Callable fold([$dart$core.Object initial]) => Empty.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Empty.$reduce(this, accumulating);
    $dart$core.Object find([Callable selecting]) => Empty.$find(this, selecting);
    Empty sort([Callable comparing]) => Empty.$sort(this, comparing);
    Empty collect([Callable collecting]) => Empty.$collect(this, collecting);
    Empty select([Callable selecting]) => Empty.$select(this, selecting);
    $dart$core.bool any([Callable selecting]) => Empty.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Empty.$every(this, selecting);
    Empty skip([$dart$core.int skipping]) => Empty.$skip(this, skipping);
    Empty take([$dart$core.int taking]) => Empty.$take(this, taking);
    Empty skipWhile([Callable skipping]) => Empty.$skipWhile(this, skipping);
    Empty takeWhile([Callable taking]) => Empty.$takeWhile(this, taking);
    Empty by([$dart$core.int step]) => Empty.$by(this, step);
    Tuple withLeading([$dart$core.Object element]) => Empty.$withLeading(this, element);
    Tuple withTrailing([$dart$core.Object element]) => Empty.$withTrailing(this, element);
    Sequential append([Sequential elements]) => Empty.$append(this, elements);
    Sequential prepend([Sequential elements]) => Empty.$prepend(this, elements);
    Iterable follow([$dart$core.Object head]) => Empty.$follow(this, head);
    Empty sublist([$dart$core.int from, $dart$core.int to]) => Empty.$sublist(this, from, to);
    Empty sublistFrom([$dart$core.int from]) => Empty.$sublistFrom(this, from);
    Empty sublistTo([$dart$core.int to]) => Empty.$sublistTo(this, to);
    Empty initial([$dart$core.int length]) => Empty.$initial(this, length);
    Empty terminal([$dart$core.int length]) => Empty.$terminal(this, length);
    Empty indexesWhere([Callable selecting]) => Empty.$indexesWhere(this, selecting);
    $dart$core.Object firstIndexWhere([Callable selecting]) => Empty.$firstIndexWhere(this, selecting);
    $dart$core.Object lastIndexWhere([Callable selecting]) => Empty.$lastIndexWhere(this, selecting);
    $dart$core.bool includes([List sublist]) => Empty.$includes(this, sublist);
    Empty trim([Callable trimming]) => Empty.$trim(this, trimming);
    Empty trimLeading([Callable trimming]) => Empty.$trimLeading(this, trimming);
    Empty trimTrailing([Callable trimming]) => Empty.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => Empty.$slice(this, index);
    void each([Callable step]) => Empty.$each(this, step);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable narrow() => Iterable.$narrow(this);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
final empty_ $package$empty = new empty_();

empty_ get empty => $package$empty;

class emptyIterator_ implements Iterator {
    emptyIterator_() {}
    Finished next() => $package$finished;
    $dart$core.String toString() => "empty.iterator()";
}
final emptyIterator_ $package$emptyIterator = new emptyIterator_();

emptyIterator_ get emptyIterator => $package$emptyIterator;

$dart$core.Object $package$emptyOrSingleton([$dart$core.Object element]) => (() {
    $dart$core.bool doElse$0 = true;
    if (!(element == null)) {
        doElse$0 = false;
        return new Tuple.$withList([element], null);
    }
    if (doElse$0) {
        return $package$empty;
    }
})();

$dart$core.Object emptyOrSingleton([$dart$core.Object element]) => $package$emptyOrSingleton(element);

class Entry {
    Entry([$dart$core.Object this.key, $dart$core.Object this.item]) {}
    $dart$core.Object key;
    $dart$core.Object item;
    Tuple get pair => new Tuple.$withList([key, item], null);
    Entry get coalesced => (() {
        $dart$core.bool doElse$0 = true;
        if (!(item == null)) {
            doElse$0 = false;
            return new Entry(key, item);
        }
        if (doElse$0) {
            return null;
        }
    })();
    $dart$core.bool equals([$dart$core.Object that]) {{
            $dart$core.bool doElse$1 = true;
            if (that is Entry) {
                Entry that$2;
                that$2 = that as Entry;
                doElse$1 = false;
                if (!this.key.equals(that$2.key)) {
                    return false;
                }
                {
                    $dart$core.bool doElse$3 = true;
                    {
                        $dart$core.Object tmp$4 = this.item;
                        if (!(tmp$4 == null)) {
                            $dart$core.Object thisItem;
                            thisItem = tmp$4;
                            {
                                $dart$core.Object tmp$5 = that$2.item;
                                if (!(tmp$5 == null)) {
                                    $dart$core.Object thatItem;
                                    thatItem = tmp$5;
                                    doElse$3 = false;
                                    return thisItem.equals(thatItem);
                                }
                            }
                        }
                    }
                    if (doElse$3) {
                        return (!(!(this.item == null))) && (!(!(that$2.item == null)));
                    }
                }
            }
            if (doElse$1) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode => ((31 + key.hashCode) * 31) + (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)((($dart$core.Object $r$) => $r$ == null ? null : $r$.hashCode)(item));
    $dart$core.String toString() => ((("" + key.toString()) + "->") + $package$stringify(item)) + "";
}
abstract class Enumerable implements Ordinal {
    $dart$core.Object neighbour([$dart$core.int offset]);
    $dart$core.Object get successor;
    static $dart$core.Object $get$successor([final Enumerable $this]) => $this.neighbour(1);
    $dart$core.Object get predecessor;
    static $dart$core.Object $get$predecessor([final Enumerable $this]) => $this.neighbour(Integer.nativeValue(Integer.instance(1).negated));
    $dart$core.int offset([$dart$core.Object other]);
    $dart$core.int offsetSign([$dart$core.Object other]);
    static $dart$core.int $offsetSign([final Enumerable $this, $dart$core.Object other]) => Integer.instance($this.offset(other)).sign;
}
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

Iterable $package$expand([Iterable iterables]) => functionIterable(new dart$Callable(() {
    $dart$core.bool step$0$expired$0 = false;
    $dart$core.bool step$0$1() {
        if (step$0$expired$0) {
            return false;
        }
        step$0$expired$0 = true;
        return true;
    }

    Iterator iterator_1$2;
    $dart$core.bool step$1$Init$5() {
        if (iterator_1$2 != null) {
            return true;
        }
        if (!step$0$1()) {
            return false;
        }
        iterator_1$2 = iterables.iterator();
        return true;
    }

    Iterable it$3;
    $dart$core.bool step$1$6() {
        while (step$1$Init$5()) {
            $dart$core.Object next$4;
            if ((next$4 = iterator_1$2.next()) is !Finished) {
                it$3 = next$4 as Iterable;
                return true;
            }
            iterator_1$2 = null;
        }
        return false;
    }

    Iterator iterator_2$7;
    $dart$core.bool step$2$Init$10() {
        if (iterator_2$7 != null) {
            return true;
        }
        if (!step$1$6()) {
            return false;
        }
        Iterable it = it$3;
        iterator_2$7 = it.iterator();
        return true;
    }

    $dart$core.Object val$8;
    $dart$core.bool step$2$11() {
        while (step$2$Init$10()) {
            Iterable it = it$3;
            $dart$core.Object next$9;
            if ((next$9 = iterator_2$7.next()) is !Finished) {
                val$8 = next$9;
                return true;
            }
            iterator_2$7 = null;
        }
        return false;
    }

    $dart$core.Object step$3$12() {
        if (!step$2$11()) {
            return $package$finished;
        }
        Iterable it = it$3;
        $dart$core.Object val = val$8;
        return val;
    }

    return new dart$Callable(step$3$12);
}));

Iterable expand([Iterable iterables]) => $package$expand(iterables);

abstract class Exponentiable implements Numeric {
    $dart$core.Object power([$dart$core.Object other]);
}
abstract class Finished {
    Finished() {}
}
class finished_  extends Finished {
    finished_() {}
    $dart$core.String toString() => "finished";
}
final finished_ $package$finished = new finished_();

finished_ get finished => $package$finished;

Callable $package$forItem([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.$delegate$(entry.item));

Callable forItem([Callable resulting]) => $package$forItem(resulting);

Callable $package$forKey([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.$delegate$(entry.key));

Callable forKey([Callable resulting]) => $package$forKey(resulting);

$dart$core.String $package$formatInteger([$dart$core.int integer, $dart$core.Object radix = $package$dart$default]) {
    if ($dart$core.identical(radix, $package$dart$default)) {
        radix = 10;
    }
    if (!(((radix as $dart$core.int) >= $package$minRadix) && ((radix as $dart$core.int) <= $package$maxRadix))) {
        throw new AssertionError("Violated: minRadix <= radix <= maxRadix");
    }
    if (Integer.instance(integer).equals(Integer.instance(0))) {
        return "0";
    }
    Iterable digits = $package$empty;
    $dart$core.int i = (($dart$core.int $lhs$) => $lhs$ == null ? Integer.nativeValue(Integer.instance(integer).negated) : $lhs$)(integer < 0 ? integer : null);
    while (!Integer.instance(i).equals(Integer.instance(0))) {
        $dart$core.int d = Integer.nativeValue(Integer.instance(i).remainder(Integer.instance(radix as $dart$core.int)).negated);
        Character c;
        if ((d >= 0) && (d < 10)) {
            c = Integer.instance(d + $package$zeroInt).character;
        } else if ((d >= 10) && (d < 36)) {
            c = Integer.instance((d - 10) + $package$aIntLower).character;
        } else {
            if (!false) {
                throw new AssertionError("Violated: false");
            }
        }
        digits = digits.follow(c);
        i = (i + d) ~/ (radix as $dart$core.int);
    }
    if (integer < 0) {
        digits = digits.follow(new Character.$fromInt(45));
    }
    return String.nativeValue(new String(digits));
}

$dart$core.String formatInteger([$dart$core.int integer, $dart$core.Object radix = $package$dart$default]) => $package$formatInteger(integer, radix);

$dart$core.Object $package$identity([$dart$core.Object argument]) => argument;

$dart$core.Object identity([$dart$core.Object argument]) => $package$identity(argument);

$dart$core.bool $package$identical([Identifiable x, Identifiable y]) => $dart$core.identical(x, y);

$dart$core.bool identical([Identifiable x, Identifiable y]) => $package$identical(x, y);

abstract class Identifiable {
    $dart$core.bool equals([$dart$core.Object that]);
    static $dart$core.bool $equals([final Identifiable $this, $dart$core.Object that]) => (() {
        $dart$core.bool doElse$0 = true;
        if (that is Identifiable) {
            Identifiable that$1;
            that$1 = that as Identifiable;
            doElse$0 = false;
            return $dart$core.identical($this, that$1);
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.int get hashCode;
    static $dart$core.int $get$hash([final Identifiable $this]) => $package$identityHash($this);
}
abstract class impl$BaseIterable implements Iterable {
    impl$BaseIterable() {}
    $dart$core.String toString() => Iterable.$get$string(this);
    Iterator iterator() => Iterable.$iterator(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class impl$BaseIterator implements Iterator {
    impl$BaseIterator() {}
    $dart$core.Object next() => Iterator.$next(this);
}
abstract class impl$BaseMap implements Map {
    impl$BaseMap() {}
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get([$dart$core.Object key]) => Map.$get(this, key);
    $dart$core.bool defines([$dart$core.Object key]) => Map.$defines(this, key);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Map clone() => Map.$clone(this);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Iterator iterator() => Iterable.$iterator(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseList implements List {
    impl$BaseList() {}
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => List.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.int get lastIndex => List.$get$lastIndex(this);
    $dart$core.int get size => List.$get$size(this);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    List clone() => List.$clone(this);
    Iterator iterator() => List.$iterator(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseCharacterList implements List {
    impl$BaseCharacterList() {}
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => List.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.int get lastIndex => List.$get$lastIndex(this);
    $dart$core.int get size => List.$get$size(this);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    List clone() => List.$clone(this);
    Iterator iterator() => List.$iterator(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseSequence implements Sequence {
    impl$BaseSequence() {}
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.Object get first => Sequence.$get$first(this);
    $dart$core.Object get last => Sequence.$get$last(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get size => Sequence.$get$size(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequential get rest => Sequence.$get$rest(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential measure([Integer from, $dart$core.int length]) => Sequence.$measure(this, from, length);
    Sequential span([Integer from, Integer to]) => Sequence.$span(this, from, to);
    Sequential spanFrom([Integer from]) => Sequence.$spanFrom(this, from);
    Sequential spanTo([Integer to]) => Sequence.$spanTo(this, to);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    Iterator iterator() => Iterable.$iterator(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
$dart$core.double $package$infinity = 1.0 / 0.0;

$dart$core.double get infinity => $package$infinity;

abstract class Integral implements Number, Enumerable {
    $dart$core.Object remainder([$dart$core.Object other]);
    $dart$core.bool get zero;
    $dart$core.bool get unit;
    $dart$core.bool divides([$dart$core.Object other]);
    static $dart$core.bool $divides([final Integral $this, $dart$core.Object other]) => ((other as Integral).remainder($this) as Integral).zero;
}
abstract class Invertible implements Summable {
    $dart$core.Object get negated;
    $dart$core.Object minus([$dart$core.Object other]);
    static $dart$core.Object $minus([final Invertible $this, $dart$core.Object other]) => $this.plus((other as Invertible).negated);
}
class Iterable$exceptLast$$anonymous$2_$$anonymous$3_ implements Iterator {
    Iterable$exceptLast$$anonymous$2_ $outer$ceylon$language$Iterable$exceptLast$$anonymous$2_;
    Iterator $capture$$iter;
    Iterable$exceptLast$$anonymous$2_$$anonymous$3_([Iterable$exceptLast$$anonymous$2_ this.$outer$ceylon$language$Iterable$exceptLast$$anonymous$2_, Iterator this.$capture$$iter]) {
        current = $capture$$iter.next();
    }
    $dart$core.Object current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$13 = true;
            {
                $dart$core.Object next$14 = $capture$$iter.next();
                if (!(next$14 is Finished)) {
                    $dart$core.Object next;
                    next = next$14;
                    doElse$13 = false;
                    $dart$core.Object result = current;
                    current = next;
                    return result;
                }
            }
            if (doElse$13) {
                return $package$finished;
            }
        }
    }
}
class Iterable$exceptLast$$anonymous$2_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$exceptLast$$anonymous$2_([Iterable this.$outer$ceylon$language$Iterable]) {}
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$exceptLast$$anonymous$2_$$anonymous$3_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$scan$$anonymous$4_$$anonymous$5_ implements Iterator {
    Iterable$scan$$anonymous$4_ $outer$ceylon$language$Iterable$scan$$anonymous$4_;
    Iterator $capture$$iter;
    Iterable$scan$$anonymous$4_$$anonymous$5_([Iterable$scan$$anonymous$4_ this.$outer$ceylon$language$Iterable$scan$$anonymous$4_, Iterator this.$capture$$iter]) {
        returnInitial = true;
        partial = $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
    }
    $dart$core.bool returnInitial;
    $dart$core.Object partial;
    $dart$core.Object next() {
        if (returnInitial) {
            returnInitial = false;
            return $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
        } else {
            $dart$core.bool doElse$48 = true;
            {
                $dart$core.Object element$49 = $capture$$iter.next();
                if (!(element$49 is Finished)) {
                    $dart$core.Object element;
                    element = element$49;
                    doElse$48 = false;
                    partial = accumulating.$delegate$(partial, element);
                    return partial;
                }
            }
            if (doElse$48) {
                return $package$finished;
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$scan$$anonymous$4_.toString() + ".iterator()";
}
class Iterable$scan$$anonymous$4_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.Object $capture$Iterable$scan$initial;
    Callable $capture$Iterable$scan$accumulating;
    Iterable$scan$$anonymous$4_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.Object this.$capture$Iterable$scan$initial, Callable this.$capture$Iterable$scan$accumulating]) {}
    $dart$core.bool get empty => false;
    $dart$core.Object get first => $capture$Iterable$scan$initial;
    $dart$core.int get size => 1 + $outer$ceylon$language$Iterable.size;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$scan$$anonymous$4_$$anonymous$5_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$locations$$anonymous$6_$$anonymous$7_ implements Iterator {
    Iterable$locations$$anonymous$6_ $outer$ceylon$language$Iterable$locations$$anonymous$6_;
    Iterator $capture$$iter;
    Iterable$locations$$anonymous$6_$$anonymous$7_([Iterable$locations$$anonymous$6_ this.$outer$ceylon$language$Iterable$locations$$anonymous$6_, Iterator this.$capture$$iter]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() {
        while (true) {
            $dart$core.Object next;
            {
                $dart$core.Object next$60 = $capture$$iter.next();
                if (next$60 is Finished) {
                    break;
                }
                next = next$60;
            }
            {
                $dart$core.bool doElse$58 = true;
                if (!(next == null)) {
                    if (Boolean.nativeValue(selecting.$delegate$(next) as Boolean)) {
                        doElse$58 = false;
                        return new Entry((() {
                            $dart$core.Object tmp$59 = Integer.instance(i);
                            Integer.instance(i = Integer.nativeValue(Integer.instance(i).successor));
                            return tmp$59;
                        })(), next);
                    }
                }
                if (doElse$58) {
                    i = Integer.nativeValue(Integer.instance(i).successor);
                }
            }
        }
        return $package$finished;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$locations$$anonymous$6_.toString() + ".iterator()";
}
class Iterable$locations$$anonymous$6_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$locations$selecting;
    Iterable$locations$$anonymous$6_([Iterable this.$outer$ceylon$language$Iterable, Callable this.$capture$Iterable$locations$selecting]) {}
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$locations$$anonymous$6_$$anonymous$7_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$skip$$anonymous$9_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$skip$skipping;
    Iterable$skip$$anonymous$9_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$skip$skipping]) {}
    Iterator iterator() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        $dart$core.int i = 0;
        while (((() {
            $dart$core.int tmp$70 = i;
            i = Integer.nativeValue(Integer.instance(i).successor);
            return tmp$70;
        })() < $capture$Iterable$skip$skipping) && (!(iter.next() is Finished))) {}
        return iter;
    }
    $dart$core.String get string => $outer$ceylon$language$Iterable.toString() + ".iterator()";
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$take$$anonymous$10_$iterator$$anonymous$11_ implements Iterator {
    Iterable$take$$anonymous$10_ $outer$ceylon$language$Iterable$take$$anonymous$10_;
    Iterator $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter;
    Iterable$take$$anonymous$10_$iterator$$anonymous$11_([Iterable$take$$anonymous$10_ this.$outer$ceylon$language$Iterable$take$$anonymous$10_, Iterator this.$capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter.next() : $lhs$)((i = Integer.nativeValue(Integer.instance(i).successor)) > $outer$ceylon$language$Iterable$take$$anonymous$10_.$capture$Iterable$take$taking ? $package$finished : null);
    $dart$core.String toString() => $outer$ceylon$language$Iterable$take$$anonymous$10_.toString() + ".iterator()";
}
class Iterable$take$$anonymous$10_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$take$taking;
    Iterable$take$$anonymous$10_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$take$taking]) {}
    Iterator iterator() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$take$$anonymous$10_$iterator$$anonymous$11_(this, iter);
    }
    $dart$core.Object get first => $outer$ceylon$language$Iterable.first;
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_ implements Iterator {
    Iterable$skipWhile$$anonymous$12_ $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_;
    $dart$core.Object $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem;
    Iterator $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter;
    Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_([Iterable$skipWhile$$anonymous$12_ this.$outer$ceylon$language$Iterable$skipWhile$$anonymous$12_, $dart$core.Object this.$capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem, Iterator this.$capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter]) {
        first = true;
    }
    $dart$core.bool first;
    $dart$core.Object next() {
        if (first) {
            first = false;
            return $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem;
        } else {
            return $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter.next();
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_.toString() + ".iterator()";
}
class Iterable$skipWhile$$anonymous$12_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$skipWhile$skipping;
    Iterable$skipWhile$$anonymous$12_([Iterable this.$outer$ceylon$language$Iterable, Callable this.$capture$Iterable$skipWhile$skipping]) {}
    Iterator iterator() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        while (true) {
            $dart$core.Object elem;
            {
                $dart$core.Object elem$71 = iter.next();
                if (elem$71 is Finished) {
                    break;
                }
                elem = elem$71;
            }
            if (!Boolean.nativeValue(skipping.$delegate$(elem) as Boolean)) {
                return new Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_(this, elem, iter);
            }
        }
        return $package$emptyIterator;
    }
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$takeWhile$$anonymous$14_$$anonymous$15_ implements Iterator {
    Iterable$takeWhile$$anonymous$14_ $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_;
    Iterator $capture$$iter;
    Iterable$takeWhile$$anonymous$14_$$anonymous$15_([Iterable$takeWhile$$anonymous$14_ this.$outer$ceylon$language$Iterable$takeWhile$$anonymous$14_, Iterator this.$capture$$iter]) {
        alive = true;
    }
    $dart$core.bool alive;
    $dart$core.Object next() {
        if (alive) {{
                $dart$core.Object next$72 = $capture$$iter.next();
                if (!(next$72 is Finished)) {
                    $dart$core.Object next;
                    next = next$72;
                    if (Boolean.nativeValue(taking.$delegate$(next) as Boolean)) {
                        return next;
                    } else {
                        alive = false;
                    }
                }
            }
        }
        return $package$finished;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_.toString() + ".iterator()";
}
class Iterable$takeWhile$$anonymous$14_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$takeWhile$taking;
    Iterable$takeWhile$$anonymous$14_([Iterable this.$outer$ceylon$language$Iterable, Callable this.$capture$Iterable$takeWhile$taking]) {}
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$takeWhile$$anonymous$14_$$anonymous$15_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$repeat$$anonymous$16_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$repeat$times;
    Iterable$repeat$$anonymous$16_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$repeat$times]) {}
    $dart$core.int get size => $capture$Iterable$repeat$times * $outer$ceylon$language$Iterable.size;
    $dart$core.String get string => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").repeat(") + Integer.instance($capture$Iterable$repeat$times).toString()) + ")";
    Iterator iterator() => new CycledIterator($outer$ceylon$language$Iterable, $capture$Iterable$repeat$times);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$by$$anonymous$17_$$anonymous$18_ implements Iterator {
    Iterable$by$$anonymous$17_ $outer$ceylon$language$Iterable$by$$anonymous$17_;
    Iterator $capture$$iter;
    Iterable$by$$anonymous$17_$$anonymous$18_([Iterable$by$$anonymous$17_ this.$outer$ceylon$language$Iterable$by$$anonymous$17_, Iterator this.$capture$$iter]) {}
    $dart$core.Object next() {
        $dart$core.Object next = $capture$$iter.next();
        $dart$core.int i = 0;
        while (((i = Integer.nativeValue(Integer.instance(i).successor)) < $outer$ceylon$language$Iterable$by$$anonymous$17_.$capture$Iterable$by$step) && (!($capture$$iter.next() is Finished))) {}
        return next;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$by$$anonymous$17_.string + ".iterator()";
}
class Iterable$by$$anonymous$17_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$by$step;
    Iterable$by$$anonymous$17_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$by$step]) {}
    $dart$core.String get string => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").by(") + Integer.instance($capture$Iterable$by$step).toString()) + ")";
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$by$$anonymous$17_$$anonymous$18_(this, iter);
    })();
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$indexed$$anonymous$19_$$anonymous$20_ implements Iterator {
    Iterable$indexed$$anonymous$19_ $outer$ceylon$language$Iterable$indexed$$anonymous$19_;
    Iterator $capture$$iter;
    Iterable$indexed$$anonymous$19_$$anonymous$20_([Iterable$indexed$$anonymous$19_ this.$outer$ceylon$language$Iterable$indexed$$anonymous$19_, Iterator this.$capture$$iter]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() => (() {
        $dart$core.bool doElse$90 = true;
        {
            $dart$core.Object next$91 = $capture$$iter.next();
            if (!(next$91 is Finished)) {
                $dart$core.Object next;
                next = next$91;
                doElse$90 = false;
                return new Entry((() {
                    $dart$core.Object tmp$92 = Integer.instance(i);
                    Integer.instance(i = Integer.nativeValue(Integer.instance(i).successor));
                    return tmp$92;
                })(), next);
            }
        }
        if (doElse$90) {
            return $package$finished;
        }
    })();
    $dart$core.String toString() => $outer$ceylon$language$Iterable$indexed$$anonymous$19_.toString() + ".iterator()";
}
class Iterable$indexed$$anonymous$19_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$indexed$$anonymous$19_([Iterable this.$outer$ceylon$language$Iterable]) {}
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$indexed$$anonymous$19_$$anonymous$20_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$paired$$anonymous$21_$$anonymous$22_ implements Iterator {
    Iterable$paired$$anonymous$21_ $outer$ceylon$language$Iterable$paired$$anonymous$21_;
    Iterator $capture$$iter;
    Iterable$paired$$anonymous$21_$$anonymous$22_([Iterable$paired$$anonymous$21_ this.$outer$ceylon$language$Iterable$paired$$anonymous$21_, Iterator this.$capture$$iter]) {
        previous = $capture$$iter.next();
    }
    $dart$core.Object previous;
    $dart$core.Object next() {{
            $dart$core.bool doElse$93 = true;
            {
                $dart$core.Object head$94 = previous;
                if (!(head$94 is Finished)) {
                    $dart$core.Object head;
                    head = head$94;
                    {
                        $dart$core.Object tip$95 = $capture$$iter.next();
                        if (!(tip$95 is Finished)) {
                            $dart$core.Object tip;
                            tip = tip$95;
                            doElse$93 = false;
                            previous = tip;
                            return new Tuple.$withList([head, tip], null);
                        }
                    }
                }
            }
            if (doElse$93) {
                return $package$finished;
            }
        }
    }
}
class Iterable$paired$$anonymous$21_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$paired$$anonymous$21_([Iterable this.$outer$ceylon$language$Iterable]) {}
    $dart$core.int get size => (() {
        $dart$core.int size = $outer$ceylon$language$Iterable.size - 1;
        return (() {
            if (size < 0) {
                return 0;
            } else {
                return size;
            }
        })();
    })();
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.size < 2;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$paired$$anonymous$21_$$anonymous$22_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$partition$$anonymous$23_$$anonymous$24_ implements Iterator {
    Iterable$partition$$anonymous$23_ $outer$ceylon$language$Iterable$partition$$anonymous$23_;
    Iterator $capture$$iter;
    Iterable$partition$$anonymous$23_$$anonymous$24_([Iterable$partition$$anonymous$23_ this.$outer$ceylon$language$Iterable$partition$$anonymous$23_, Iterator this.$capture$$iter]) {}
    $dart$core.Object next() {{
            $dart$core.bool doElse$96 = true;
            {
                $dart$core.Object next$97 = $capture$$iter.next();
                if (!(next$97 is Finished)) {
                    $dart$core.Object next;
                    next = next$97;
                    doElse$96 = false;
                    Array array = $package$arrayOfSize($outer$ceylon$language$Iterable$partition$$anonymous$23_.$capture$Iterable$partition$length, next);
                    $dart$core.int index = 0;
                    while ((index = Integer.nativeValue(Integer.instance(index).successor)) < $outer$ceylon$language$Iterable$partition$$anonymous$23_.$capture$Iterable$partition$length) {{
                            $dart$core.bool doElse$98 = true;
                            {
                                $dart$core.Object current$99 = $capture$$iter.next();
                                if (!(current$99 is Finished)) {
                                    $dart$core.Object current;
                                    current = current$99;
                                    doElse$98 = false;
                                    array.set(index, current);
                                }
                            }
                            if (doElse$98) {
                                return new ArraySequence(array.spanTo(Integer.instance(index - 1)));
                            }
                        }
                    }
                    return new ArraySequence(array);
                }
            }
            if (doElse$96) {
                return $package$finished;
            }
        }
    }
}
class Iterable$partition$$anonymous$23_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$partition$length;
    Iterable$partition$$anonymous$23_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$partition$length]) {}
    $dart$core.int get size => (() {
        $dart$core.int outerSize = $outer$ceylon$language$Iterable.size;
        $dart$core.int quotient = outerSize ~/ $capture$Iterable$partition$length;
        return (() {
            if (Integer.instance($capture$Iterable$partition$length).divides(Integer.instance(outerSize))) {
                return quotient;
            } else {
                return quotient + 1;
            }
        })();
    })();
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.empty;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$partition$$anonymous$23_$$anonymous$24_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$chain$$anonymous$25_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable $capture$Iterable$chain$other;
    Iterable$chain$$anonymous$25_([Iterable this.$outer$ceylon$language$Iterable, Iterable this.$capture$Iterable$chain$other]) {}
    Iterator iterator() => new ChainedIterator($outer$ceylon$language$Iterable, $capture$Iterable$chain$other);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$cycled$$anonymous$26_$$anonymous$27_ implements Iterator {
    Iterable$cycled$$anonymous$26_ $outer$ceylon$language$Iterable$cycled$$anonymous$26_;
    Iterable$cycled$$anonymous$26_$$anonymous$27_([Iterable$cycled$$anonymous$26_ this.$outer$ceylon$language$Iterable$cycled$$anonymous$26_]) {
        iter = $package$emptyIterator;
    }
    Iterator iter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$113 = true;
            {
                $dart$core.Object next$114 = iter.next();
                if (!(next$114 is Finished)) {
                    $dart$core.Object next;
                    next = next$114;
                    doElse$113 = false;
                    return next;
                }
            }
            if (doElse$113) {
                iter = $outer$ceylon$language$Iterable$cycled$$anonymous$26_.orig.iterator();
                return iter.next();
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$cycled$$anonymous$26_.string + ".iterator()";
}
class Iterable$cycled$$anonymous$26_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$cycled$$anonymous$26_([Iterable this.$outer$ceylon$language$Iterable]) {}
    Iterable get orig => $outer$ceylon$language$Iterable;
    $dart$core.String get string => ("(" + $outer$ceylon$language$Iterable.toString()) + ").cycled";
    $dart$core.int get size {
        if (!false) {
            throw new AssertionError("Violated: false");
        }
    }
    Iterator iterator() => new Iterable$cycled$$anonymous$26_$$anonymous$27_(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$interpose$$anonymous$28_$$anonymous$29_ implements Iterator {
    Iterable$interpose$$anonymous$28_ $outer$ceylon$language$Iterable$interpose$$anonymous$28_;
    Iterator $capture$$iter;
    Iterable$interpose$$anonymous$28_$$anonymous$29_([Iterable$interpose$$anonymous$28_ this.$outer$ceylon$language$Iterable$interpose$$anonymous$28_, Iterator this.$capture$$iter]) {
        current = $capture$$iter.next();
        count = 0;
    }
    $dart$core.Object current;
    $dart$core.int count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$115 = true;
            {
                $dart$core.Object curr$116 = current;
                if (!(curr$116 is Finished)) {
                    $dart$core.Object curr;
                    curr = curr$116;
                    doElse$115 = false;
                    if (Integer.instance(($outer$ceylon$language$Iterable$interpose$$anonymous$28_.$capture$Iterable$interpose$step as $dart$core.int) + 1).divides(Integer.instance(count = Integer.nativeValue(Integer.instance(count).successor)))) {
                        return $outer$ceylon$language$Iterable$interpose$$anonymous$28_.$capture$Iterable$interpose$element;
                    } else {
                        current = $capture$$iter.next();
                        return curr;
                    }
                }
            }
            if (doElse$115) {
                return $package$finished;
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$interpose$$anonymous$28_.toString() + ".iterator()";
}
class Iterable$interpose$$anonymous$28_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.Object $capture$Iterable$interpose$step;
    $dart$core.Object $capture$Iterable$interpose$element;
    Iterable$interpose$$anonymous$28_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.Object this.$capture$Iterable$interpose$step, $dart$core.Object this.$capture$Iterable$interpose$element]) {}
    $dart$core.int get size {
        $dart$core.int outerSize = $outer$ceylon$language$Iterable.size;
        return (() {
            if (outerSize > 0) {
                return outerSize + ((outerSize - 1) ~/ ($capture$Iterable$interpose$step as $dart$core.int));
            } else {
                return 0;
            }
        })();
    }
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.empty;
    $dart$core.Object get first => $outer$ceylon$language$Iterable.first;
    $dart$core.Object get last => $outer$ceylon$language$Iterable.last;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$interpose$$anonymous$28_$$anonymous$29_(this, iter);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$distinct$$anonymous$30_$$anonymous$31_ implements Iterator {
    Iterable$distinct$$anonymous$30_ $outer$ceylon$language$Iterable$distinct$$anonymous$30_;
    Iterable $capture$$elements;
    Iterable$distinct$$anonymous$30_$$anonymous$31_([Iterable$distinct$$anonymous$30_ this.$outer$ceylon$language$Iterable$distinct$$anonymous$30_, Iterable this.$capture$$elements]) {
        it = $capture$$elements.iterator();
        count = 0;
        store = new Array.ofSize(16, null);
    }
    Iterator it;
    $dart$core.int count;
    Array store;
    $dart$core.int hash([$dart$core.Object element, $dart$core.int size]) => (() {
        $dart$core.bool doElse$117 = true;
        if (!(element == null)) {
            doElse$117 = false;
            return Integer.nativeValue(Integer.instance(element.hashCode).magnitude.remainder(Integer.instance(size)));
        }
        if (doElse$117) {
            return 0;
        }
    })();
    Array rebuild([Array store]) {
        Array newStore = new Array.ofSize(store.size * 2, null);
        {
            $dart$core.Object element$119;
            Iterator iterator$118 = store.iterator();
            while ((element$119 = iterator$118.next()) is !Finished) {
                ElementEntry entries = element$119 as ElementEntry;
                ElementEntry entry = entries;
                while (true) {
                    ElementEntry e;
                    {
                        ElementEntry tmp$120 = entry;
                        if (tmp$120 == null) {
                            break;
                        }
                        e = tmp$120;
                    }
                    $dart$core.int index = hash(e.element, newStore.size);
                    newStore.set(index, new ElementEntry(e.element, newStore.get(Integer.instance(index)) as ElementEntry));
                    entry = e.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.Object next() {
        while (true) {{
                $dart$core.Object element = it.next();
                if (element is Finished) {
                    Finished element$121;
                    element$121 = element as Finished;
                    return element$121;
                } else {
                    $dart$core.int index = hash(element, store.size);
                    ElementEntry entry = store.get(Integer.instance(index)) as ElementEntry;
                    {
                        $dart$core.bool doElse$122 = true;
                        if (!(entry == null)) {
                            if (entry.has(element)) {
                                doElse$122 = false;
                            }
                        }
                        if (doElse$122) {
                            store.set(index, new ElementEntry(element, entry));
                            count = Integer.nativeValue(Integer.instance(count).successor);
                            if (count > (store.size * 2)) {
                                store = rebuild(store);
                            }
                            return element;
                        }
                    }
                }
            }
        }
    }
}
class Iterable$distinct$$anonymous$30_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$distinct$$anonymous$30_([Iterable this.$outer$ceylon$language$Iterable]) {}
    Iterator iterator() => (() {
        Iterable elements = $outer$ceylon$language$Iterable;
        return new Iterable$distinct$$anonymous$30_$$anonymous$31_(this, elements);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$group$$anonymous$32_$$anonymous$33_ implements Iterator {
    Iterable$group$$anonymous$32_ $outer$ceylon$language$Iterable$group$$anonymous$32_;
    Iterable$group$$anonymous$32_$$anonymous$33_([Iterable$group$$anonymous$32_ this.$outer$ceylon$language$Iterable$group$$anonymous$32_]) {
        index = 0;
        entry = null;
    }
    $dart$core.int index;
    GroupEntry entry;
    $dart$core.Object next() {{
            $dart$core.bool doElse$132 = true;
            {
                GroupEntry tmp$133 = entry;
                if (!(tmp$133 == null)) {
                    GroupEntry e;
                    e = tmp$133;
                    doElse$132 = false;
                    entry = e.next;
                    return new Entry(e.group, e.elements);
                }
            }
            if (doElse$132) {
                while (true) {
                    if (index >= $outer$ceylon$language$Iterable$group$$anonymous$32_.store.size) {
                        return $package$finished;
                    } else {
                        entry = $outer$ceylon$language$Iterable$group$$anonymous$32_.store.get((() {
                            Integer tmp$134 = Integer.instance(index);
                            Integer.instance(index = Integer.nativeValue(Integer.instance(index).successor));
                            return tmp$134;
                        })()) as GroupEntry;
                        {
                            GroupEntry tmp$135 = entry;
                            if (!(tmp$135 == null)) {
                                GroupEntry e;
                                e = tmp$135;
                                entry = e.next;
                                return new Entry(e.group, e.elements);
                            }
                        }
                    }
                }
            }
        }
    }
}
class Iterable$group$$anonymous$32_ implements Map {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$group$grouping;
    Iterable$group$$anonymous$32_([Iterable this.$outer$ceylon$language$Iterable, Callable this.$capture$Iterable$group$grouping]) {
        store = new Array.ofSize(16, null);
        _count = 0;
        {
            $dart$core.Object element$124;
            Iterator iterator$123 = $outer$ceylon$language$Iterable.iterator();
            while ((element$124 = iterator$123.next()) is !Finished) {
                $dart$core.Object element = element$124;
                $dart$core.Object group = grouping.$delegate$(element);
                $dart$core.int index = hash(group, store.size);
                GroupEntry newEntry;
                {
                    $dart$core.bool doElse$125 = true;
                    {
                        GroupEntry tmp$126 = store.get(Integer.instance(index)) as GroupEntry;
                        if (!(tmp$126 == null)) {
                            GroupEntry entries;
                            entries = tmp$126;
                            doElse$125 = false;
                            {
                                $dart$core.bool doElse$127 = true;
                                {
                                    GroupEntry tmp$128 = entries.get(group);
                                    if (!(tmp$128 == null)) {
                                        GroupEntry entry;
                                        entry = tmp$128;
                                        doElse$127 = false;
                                        entry.elements = new ElementEntry(element, entry.elements);
                                        continue;
                                    }
                                }
                                if (doElse$127) {
                                    newEntry = new GroupEntry(group, new ElementEntry(element, null), entries);
                                }
                            }
                        }
                    }
                    if (doElse$125) {
                        newEntry = new GroupEntry(group, new ElementEntry(element, null), null);
                    }
                }
                store.set(index, newEntry);
                _count = Integer.nativeValue(Integer.instance(_count).successor);
                if (_count > (store.size * 2)) {
                    store = rebuild(store);
                }
            }
        }
    }
    Array store;
    $dart$core.int hash([$dart$core.Object group, $dart$core.int size]) => Integer.nativeValue(Integer.instance(group.hashCode).magnitude.remainder(Integer.instance(size)));
    Array rebuild([Array store]) {
        Array newStore = new Array.ofSize(store.size * 2, null);
        {
            $dart$core.Object element$130;
            Iterator iterator$129 = store.iterator();
            while ((element$130 = iterator$129.next()) is !Finished) {
                GroupEntry groups = element$130 as GroupEntry;
                GroupEntry group = groups;
                while (true) {
                    GroupEntry g;
                    {
                        GroupEntry tmp$131 = group;
                        if (tmp$131 == null) {
                            break;
                        }
                        g = tmp$131;
                    }
                    $dart$core.int index = hash(g.group, newStore.size);
                    newStore.set(index, new GroupEntry(g.group, g.elements, newStore.get(Integer.instance(index)) as GroupEntry));
                    group = g.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.int _count;
    $dart$core.int get size => _count;
    Iterator iterator() => new Iterable$group$$anonymous$32_$$anonymous$33_(this);
    Map clone() => this;
    GroupEntry group_([$dart$core.Object key]) => ((GroupEntry $r$) => $r$ == null ? null : $r$.get(key))(store.get(Integer.instance(hash(key, store.size))) as GroupEntry);
    $dart$core.bool defines([$dart$core.Object key]) => !(group_(key) == null);
    Sequence get([$dart$core.Object key]) => ((GroupEntry $r$) => $r$ == null ? null : $r$.elements)(group_(key));
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Iterable implements Category {
    Iterator iterator();
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Iterable $this, $dart$core.Object element]) => $this.any(new dart$Callable(([$dart$core.Object e]) => (() {
        $dart$core.bool doElse$0 = true;
        if (!(e == null)) {
            doElse$0 = false;
            return Boolean.instance(e.equals(element));
        }
        if (doElse$0) {
            return $package$$false;
        }
    })()));
    $dart$core.bool get empty;
    static $dart$core.bool $get$empty([final Iterable $this]) => $this.iterator().next() is Finished;
    $dart$core.int get size;
    static $dart$core.int $get$size([final Iterable $this]) => $this.count(new dart$Callable(([$dart$core.Object e]) => $package$$true));
    $dart$core.bool longerThan([$dart$core.int length]);
    static $dart$core.bool $longerThan([final Iterable $this, $dart$core.int length]) {
        if (length < 0) {
            return true;
        }
        $dart$core.int count = 0;
        {
            $dart$core.Object element$2;
            Iterator iterator$1 = $this.iterator();
            while ((element$2 = iterator$1.next()) is !Finished) {
                $dart$core.Object element = element$2;
                if ((() {
                    Integer tmp$3 = Integer.instance(count);
                    Integer.instance(count = Integer.nativeValue(Integer.instance(count).successor));
                    return tmp$3;
                })().equals(Integer.instance(length))) {
                    return true;
                }
            }
        }
        return false;
    }
    $dart$core.bool shorterThan([$dart$core.int length]);
    static $dart$core.bool $shorterThan([final Iterable $this, $dart$core.int length]) {
        if (length <= 0) {
            return false;
        }
        $dart$core.int count = 0;
        {
            $dart$core.Object element$5;
            Iterator iterator$4 = $this.iterator();
            while ((element$5 = iterator$4.next()) is !Finished) {
                $dart$core.Object element = element$5;
                if (Integer.instance(count = Integer.nativeValue(Integer.instance(count).successor)).equals(Integer.instance(length))) {
                    return false;
                }
            }
        }
        return true;
    }
    $dart$core.Object get first;
    static $dart$core.Object $get$first([final Iterable $this]) {{
            $dart$core.bool doElse$6 = true;
            {
                $dart$core.Object first$7 = $this.iterator().next();
                if (!(first$7 is Finished)) {
                    $dart$core.Object first;
                    first = first$7;
                    doElse$6 = false;
                    return first;
                }
            }
            if (doElse$6) {
                if (!true) {
                    throw new AssertionError("Violated: is Absent null");
                }
                return null;
            }
        }
    }
    $dart$core.Object get last;
    static $dart$core.Object $get$last([final Iterable $this]) {
        $dart$core.Object e = $this.first;
        {
            $dart$core.Object element$9;
            Iterator iterator$8 = $this.iterator();
            while ((element$9 = iterator$8.next()) is !Finished) {
                $dart$core.Object x = element$9;
                e = x;
            }
        }
        return e;
    }
    $dart$core.Object getFromFirst([$dart$core.int index]);
    static $dart$core.Object $getFromFirst([final Iterable $this, $dart$core.int index]) {
        $dart$core.int current = 0;
        {
            $dart$core.Object element$11;
            Iterator iterator$10 = $this.iterator();
            while ((element$11 = iterator$10.next()) is !Finished) {
                $dart$core.Object element = element$11;
                if ((() {
                    Integer tmp$12 = Integer.instance(current);
                    Integer.instance(current = Integer.nativeValue(Integer.instance(current).successor));
                    return tmp$12;
                })().equals(Integer.instance(index))) {
                    return element;
                }
            }
            {
                return null;
            }
        }
    }
    Sequential sequence();
    static Sequential $sequence([final Iterable $this]) => (() {
        Array array = new Array($this);
        return (() {
            if (array.empty) {
                return $package$empty;
            } else {
                return new ArraySequence(array);
            }
        })();
    })();
    $dart$core.Object indexes();
    static $dart$core.Object $indexes([final Iterable $this]) => $package$measure(Integer.instance(0), $this.size);
    Iterable get rest;
    static Iterable $get$rest([final Iterable $this]) => $this.skip(1);
    Iterable get exceptLast;
    static Iterable $get$exceptLast([final Iterable $this]) => new Iterable$exceptLast$$anonymous$2_($this);
    void each([Callable step]);
    static void $each([final Iterable $this, Callable step]) {{
            $dart$core.Object element$16;
            Iterator iterator$15 = $this.iterator();
            while ((element$16 = iterator$15.next()) is !Finished) {
                $dart$core.Object element = element$16;
                step.$delegate$(element);
            }
        }
    }
    Iterable map([Callable collecting]);
    static Iterable $map([final Iterable $this, Callable collecting]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$17 = false;
        $dart$core.bool step$0$18() {
            if (step$0$expired$17) {
                return false;
            }
            step$0$expired$17 = true;
            return true;
        }

        Iterator iterator_1$19;
        $dart$core.bool step$1$Init$22() {
            if (iterator_1$19 != null) {
                return true;
            }
            if (!step$0$18()) {
                return false;
            }
            iterator_1$19 = $this.iterator();
            return true;
        }

        $dart$core.Object elem$20;
        $dart$core.bool step$1$23() {
            while (step$1$Init$22()) {
                $dart$core.Object next$21;
                if ((next$21 = iterator_1$19.next()) is !Finished) {
                    elem$20 = next$21;
                    return true;
                }
                iterator_1$19 = null;
            }
            return false;
        }

        $dart$core.Object step$2$24() {
            if (!step$1$23()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$20;
            return collecting.$delegate$(elem);
        }

        return new dart$Callable(step$2$24);
    }));
    Iterable flatMap([Callable collecting]);
    static Iterable $flatMap([final Iterable $this, Callable collecting]) => $package$expand($this.map(collecting));
    Iterable filter([Callable selecting]);
    static Iterable $filter([final Iterable $this, Callable selecting]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$25 = false;
        $dart$core.bool step$0$26() {
            if (step$0$expired$25) {
                return false;
            }
            step$0$expired$25 = true;
            return true;
        }

        Iterator iterator_1$27;
        $dart$core.bool step$1$Init$30() {
            if (iterator_1$27 != null) {
                return true;
            }
            if (!step$0$26()) {
                return false;
            }
            iterator_1$27 = $this.iterator();
            return true;
        }

        $dart$core.Object elem$28;
        $dart$core.bool step$1$31() {
            while (step$1$Init$30()) {
                $dart$core.Object next$29;
                if ((next$29 = iterator_1$27.next()) is !Finished) {
                    elem$28 = next$29;
                    return true;
                }
                iterator_1$27 = null;
            }
            return false;
        }

        $dart$core.bool step$2$32() {
            while (step$1$31()) {
                $dart$core.Object elem = elem$28;
                if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                    return true;
                }
            }
            return false;
        }

        $dart$core.Object step$3$33() {
            if (!step$2$32()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$28;
            return elem;
        }

        return new dart$Callable(step$3$33);
    }));
    Iterable narrow();
    static Iterable $narrow([final Iterable $this]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$34 = false;
        $dart$core.bool step$0$35() {
            if (step$0$expired$34) {
                return false;
            }
            step$0$expired$34 = true;
            return true;
        }

        Iterator iterator_1$36;
        $dart$core.bool step$1$Init$39() {
            if (iterator_1$36 != null) {
                return true;
            }
            if (!step$0$35()) {
                return false;
            }
            iterator_1$36 = $this.iterator();
            return true;
        }

        $dart$core.Object elem$37;
        $dart$core.bool step$1$40() {
            while (step$1$Init$39()) {
                $dart$core.Object next$38;
                if ((next$38 = iterator_1$36.next()) is !Finished) {
                    elem$37 = next$38;
                    return true;
                }
                iterator_1$36 = null;
            }
            return false;
        }

        $dart$core.bool step$2$41() {
            while (step$1$40()) {
                $dart$core.Object elem = elem$37;
                if (!true) {
                    continue;
                }
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$42() {
            if (!step$2$41()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$37;
            return elem;
        }

        return new dart$Callable(step$3$42);
    }));
    Callable fold([$dart$core.Object initial]);
    static Callable $fold([final Iterable $this, $dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) {
        $dart$core.Object partial = initial;
        {
            $dart$core.Object element$44;
            Iterator iterator$43 = $this.iterator();
            while ((element$44 = iterator$43.next()) is !Finished) {
                $dart$core.Object elem = element$44;
                partial = accumulating.$delegate$(partial, elem);
            }
        }
        return partial;
    });
    $dart$core.Object reduce([Callable accumulating]);
    static $dart$core.Object $reduce([final Iterable $this, Callable accumulating]) {
        Iterator it = $this.iterator();
        {
            $dart$core.bool doElse$45 = true;
            {
                $dart$core.Object initial$46 = it.next();
                if (!(initial$46 is Finished)) {
                    $dart$core.Object initial;
                    initial = initial$46;
                    doElse$45 = false;
                    $dart$core.Object partial = initial;
                    while (true) {
                        $dart$core.Object next;
                        {
                            $dart$core.Object next$47 = it.next();
                            if (next$47 is Finished) {
                                break;
                            }
                            next = next$47;
                        }
                        partial = accumulating.$delegate$(partial, next);
                    }
                    return partial;
                }
            }
            if (doElse$45) {
                if (!true) {
                    throw new AssertionError("Violated: is Absent null");
                }
                return null;
            }
        }
    }
    Callable scan([$dart$core.Object initial]);
    static Callable $scan([final Iterable $this, $dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) => new Iterable$scan$$anonymous$4_($this, initial, accumulating));
    $dart$core.Object find([Callable selecting]);
    static $dart$core.Object $find([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$51;
            Iterator iterator$50 = $this.iterator();
            while ((element$51 = iterator$50.next()) is !Finished) {
                $dart$core.Object elem = element$51;
                if (!(elem == null)) {
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        return elem;
                    }
                }
            }
        }
        return null;
    }
    $dart$core.Object findLast([Callable selecting]);
    static $dart$core.Object $findLast([final Iterable $this, Callable selecting]) {
        $dart$core.Object last = null;
        {
            $dart$core.Object element$53;
            Iterator iterator$52 = $this.iterator();
            while ((element$53 = iterator$52.next()) is !Finished) {
                $dart$core.Object elem = element$53;
                if (!(elem == null)) {
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        last = elem;
                    }
                }
            }
        }
        return last;
    }
    Entry locate([Callable selecting]);
    static Entry $locate([final Iterable $this, Callable selecting]) {
        $dart$core.int index = 0;
        {
            $dart$core.Object element$55;
            Iterator iterator$54 = $this.iterator();
            while ((element$55 = iterator$54.next()) is !Finished) {
                $dart$core.Object elem = element$55;
                if (!(elem == null)) {
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        return new Entry(Integer.instance(index), elem);
                    }
                }
                index = Integer.nativeValue(Integer.instance(index).successor);
            }
        }
        return null;
    }
    Entry locateLast([Callable selecting]);
    static Entry $locateLast([final Iterable $this, Callable selecting]) {
        Entry last = null;
        $dart$core.int index = 0;
        {
            $dart$core.Object element$57;
            Iterator iterator$56 = $this.iterator();
            while ((element$57 = iterator$56.next()) is !Finished) {
                $dart$core.Object elem = element$57;
                if (!(elem == null)) {
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        last = new Entry(Integer.instance(index), elem);
                    }
                }
                index = Integer.nativeValue(Integer.instance(index).successor);
            }
        }
        return last;
    }
    Iterable locations([Callable selecting]);
    static Iterable $locations([final Iterable $this, Callable selecting]) => new Iterable$locations$$anonymous$6_($this, selecting);
    $dart$core.Object max([Callable comparing]);
    static $dart$core.Object $max([final Iterable $this, Callable comparing]) {
        Iterator it = $this.iterator();
        {
            $dart$core.bool doElse$61 = true;
            {
                $dart$core.Object first$62 = it.next();
                if (!(first$62 is Finished)) {
                    $dart$core.Object first;
                    first = first$62;
                    doElse$61 = false;
                    $dart$core.Object max = first;
                    while (true) {
                        $dart$core.Object val;
                        {
                            $dart$core.Object val$63 = it.next();
                            if (val$63 is Finished) {
                                break;
                            }
                            val = val$63;
                        }
                        if ((comparing.$delegate$(val, max) as Identifiable).equals($package$larger)) {
                            max = val;
                        }
                    }
                    return max;
                }
            }
            if (doElse$61) {
                if (!true) {
                    throw new AssertionError("Violated: is Absent null");
                }
                return null;
            }
        }
    }
    Sequential sort([Callable comparing]);
    static Sequential $sort([final Iterable $this, Callable comparing]) {
        Array array = new Array($this);
        if (array.empty) {
            return $package$empty;
        } else {
            array.sortInPlace(comparing);
            return new ArraySequence(array);
        }
    }
    Sequential collect([Callable collecting]);
    static Sequential $collect([final Iterable $this, Callable collecting]) => $this.map(collecting).sequence();
    Sequential select([Callable selecting]);
    static Sequential $select([final Iterable $this, Callable selecting]) => $this.filter(selecting).sequence();
    $dart$core.int count([Callable selecting]);
    static $dart$core.int $count([final Iterable $this, Callable selecting]) {
        $dart$core.int count = 0;
        {
            $dart$core.Object element$65;
            Iterator iterator$64 = $this.iterator();
            while ((element$65 = iterator$64.next()) is !Finished) {
                $dart$core.Object elem = element$65;
                if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                    count = Integer.nativeValue(Integer.instance(count).successor);
                }
            }
        }
        return count;
    }
    $dart$core.bool any([Callable selecting]);
    static $dart$core.bool $any([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$67;
            Iterator iterator$66 = $this.iterator();
            while ((element$67 = iterator$66.next()) is !Finished) {
                $dart$core.Object e = element$67;
                if (Boolean.nativeValue(selecting.$delegate$(e) as Boolean)) {
                    return true;
                }
            }
        }
        return false;
    }
    $dart$core.bool every([Callable selecting]);
    static $dart$core.bool $every([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$69;
            Iterator iterator$68 = $this.iterator();
            while ((element$69 = iterator$68.next()) is !Finished) {
                $dart$core.Object e = element$69;
                if (!Boolean.nativeValue(selecting.$delegate$(e) as Boolean)) {
                    return false;
                }
            }
        }
        return true;
    }
    Iterable skip([$dart$core.int skipping]);
    static Iterable $skip([final Iterable $this, $dart$core.int skipping]) {
        if (skipping <= 0) {
            return $this;
        } else {
            return new Iterable$skip$$anonymous$9_($this, skipping);
        }
    }
    Iterable take([$dart$core.int taking]);
    static Iterable $take([final Iterable $this, $dart$core.int taking]) {
        if (taking <= 0) {
            return $package$empty;
        } else {
            return new Iterable$take$$anonymous$10_($this, taking);
        }
    }
    Iterable skipWhile([Callable skipping]);
    static Iterable $skipWhile([final Iterable $this, Callable skipping]) => new Iterable$skipWhile$$anonymous$12_($this, skipping);
    Iterable takeWhile([Callable taking]);
    static Iterable $takeWhile([final Iterable $this, Callable taking]) => new Iterable$takeWhile$$anonymous$14_($this, taking);
    Iterable repeat([$dart$core.int times]);
    static Iterable $repeat([final Iterable $this, $dart$core.int times]) => new Iterable$repeat$$anonymous$16_($this, times);
    Iterable by([$dart$core.int step]);
    static Iterable $by([final Iterable $this, $dart$core.int step]) {
        if (!(step > 0)) {
            throw new AssertionError("Violated: step > 0");
        }
        if (Integer.instance(step).equals(Integer.instance(1))) {
            return $this;
        } else {
            return new Iterable$by$$anonymous$17_($this, step);
        }
    }
    Iterable defaultNullElements([$dart$core.Object defaultValue]);
    static Iterable $defaultNullElements([final Iterable $this, $dart$core.Object defaultValue]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$73 = false;
        $dart$core.bool step$0$74() {
            if (step$0$expired$73) {
                return false;
            }
            step$0$expired$73 = true;
            return true;
        }

        Iterator iterator_1$75;
        $dart$core.bool step$1$Init$78() {
            if (iterator_1$75 != null) {
                return true;
            }
            if (!step$0$74()) {
                return false;
            }
            iterator_1$75 = $this.iterator();
            return true;
        }

        $dart$core.Object elem$76;
        $dart$core.bool step$1$79() {
            while (step$1$Init$78()) {
                $dart$core.Object next$77;
                if ((next$77 = iterator_1$75.next()) is !Finished) {
                    elem$76 = next$77;
                    return true;
                }
                iterator_1$75 = null;
            }
            return false;
        }

        $dart$core.Object step$2$80() {
            if (!step$1$79()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$76;
            return (($dart$core.Object $lhs$) => $lhs$ == null ? defaultValue : $lhs$)(elem);
        }

        return new dart$Callable(step$2$80);
    }));
    Iterable get coalesced;
    static Iterable $get$coalesced([final Iterable $this]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$81 = false;
        $dart$core.bool step$0$82() {
            if (step$0$expired$81) {
                return false;
            }
            step$0$expired$81 = true;
            return true;
        }

        Iterator iterator_1$83;
        $dart$core.bool step$1$Init$86() {
            if (iterator_1$83 != null) {
                return true;
            }
            if (!step$0$82()) {
                return false;
            }
            iterator_1$83 = $this.iterator();
            return true;
        }

        $dart$core.Object e$84;
        $dart$core.bool step$1$87() {
            while (step$1$Init$86()) {
                $dart$core.Object next$85;
                if ((next$85 = iterator_1$83.next()) is !Finished) {
                    e$84 = next$85;
                    return true;
                }
                iterator_1$83 = null;
            }
            return false;
        }

        $dart$core.bool step$2$88() {
            while (step$1$87()) {
                $dart$core.Object e = e$84;
                if (!(!(e == null))) {
                    continue;
                }
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$89() {
            if (!step$2$88()) {
                return $package$finished;
            }
            $dart$core.Object e = e$84;
            return e;
        }

        return new dart$Callable(step$3$89);
    }));
    Iterable get indexed;
    static Iterable $get$indexed([final Iterable $this]) => new Iterable$indexed$$anonymous$19_($this);
    Iterable get paired;
    static Iterable $get$paired([final Iterable $this]) => new Iterable$paired$$anonymous$21_($this);
    Iterable partition([$dart$core.int length]);
    static Iterable $partition([final Iterable $this, $dart$core.int length]) {
        if (!(length > 0)) {
            throw new AssertionError("Violated: length>0");
        }
        return new Iterable$partition$$anonymous$23_($this, length);
    }
    Iterable follow([$dart$core.Object head]);
    static Iterable $follow([final Iterable $this, $dart$core.Object head]) => new LazyIterable(1, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return head;
        }
    }, $this);
    Iterable chain([Iterable other]);
    static Iterable $chain([final Iterable $this, Iterable other]) => new Iterable$chain$$anonymous$25_($this, other);
    Iterable product([Iterable other]);
    static Iterable $product([final Iterable $this, Iterable other]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$100 = false;
        $dart$core.bool step$0$101() {
            if (step$0$expired$100) {
                return false;
            }
            step$0$expired$100 = true;
            return true;
        }

        Iterator iterator_1$102;
        $dart$core.bool step$1$Init$105() {
            if (iterator_1$102 != null) {
                return true;
            }
            if (!step$0$101()) {
                return false;
            }
            iterator_1$102 = $this.iterator();
            return true;
        }

        $dart$core.Object x$103;
        $dart$core.bool step$1$106() {
            while (step$1$Init$105()) {
                $dart$core.Object next$104;
                if ((next$104 = iterator_1$102.next()) is !Finished) {
                    x$103 = next$104;
                    return true;
                }
                iterator_1$102 = null;
            }
            return false;
        }

        Iterator iterator_2$107;
        $dart$core.bool step$2$Init$110() {
            if (iterator_2$107 != null) {
                return true;
            }
            if (!step$1$106()) {
                return false;
            }
            $dart$core.Object x = x$103;
            iterator_2$107 = other.iterator();
            return true;
        }

        $dart$core.Object y$108;
        $dart$core.bool step$2$111() {
            while (step$2$Init$110()) {
                $dart$core.Object x = x$103;
                $dart$core.Object next$109;
                if ((next$109 = iterator_2$107.next()) is !Finished) {
                    y$108 = next$109;
                    return true;
                }
                iterator_2$107 = null;
            }
            return false;
        }

        $dart$core.Object step$3$112() {
            if (!step$2$111()) {
                return $package$finished;
            }
            $dart$core.Object x = x$103;
            $dart$core.Object y = y$108;
            return new Tuple.$withList([x, y], null);
        }

        return new dart$Callable(step$3$112);
    }));
    Iterable get cycled;
    static Iterable $get$cycled([final Iterable $this]) => new Iterable$cycled$$anonymous$26_($this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]);
    static Iterable $interpose([final Iterable $this, $dart$core.Object element, $dart$core.Object step = $package$dart$default]) {
        if ($dart$core.identical(step, $package$dart$default)) {
            step = 1;
        }
        if (!((step as $dart$core.int) >= 1)) {
            throw new AssertionError("Violated: step>=1");
        }
        return new Iterable$interpose$$anonymous$28_($this, step, element);
    }
    Iterable get distinct;
    static Iterable $get$distinct([final Iterable $this]) => new Iterable$distinct$$anonymous$30_($this);
    Map group([Callable grouping]);
    static Map $group([final Iterable $this, Callable grouping]) => new Iterable$group$$anonymous$32_($this, grouping);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Iterable $this]) => (() {
        Sequential elements = $this.take(31).sequence();
        return (() {
            if (elements.empty) {
                return "{}";
            } else {
                return (() {
                    if (Integer.instance(elements.size).equals(Integer.instance(31))) {
                        return ("{ " + $package$commaList(elements.take(30))) + ", ... }";
                    } else {
                        return ("{ " + $package$commaList(elements)) + " }";
                    }
                })();
            }
        })();
    })();
}
$dart$core.String $package$commaList([Iterable elements]) => String.instance(", ").join(elements.map(new dart$Callable(([$dart$core.Object val]) {
    return String.instance($package$stringify(val));
})));

$dart$core.String commaList([Iterable elements]) => $package$commaList(elements);

class ElementEntry$$anonymous$34_ implements Iterator {
    ElementEntry $outer$ceylon$language$ElementEntry;
    ElementEntry$$anonymous$34_([ElementEntry this.$outer$ceylon$language$ElementEntry]) {
        entry = $outer$ceylon$language$ElementEntry;
    }
    ElementEntry entry;
    $dart$core.Object next() {{
            $dart$core.bool doElse$145 = true;
            {
                ElementEntry tmp$146 = entry;
                if (!(tmp$146 == null)) {
                    ElementEntry e;
                    e = tmp$146;
                    doElse$145 = false;
                    entry = e.next;
                    return e.element;
                }
            }
            if (doElse$145) {
                return $package$finished;
            }
        }
    }
}
class ElementEntry implements Sequence {
    ElementEntry([$dart$core.Object this.element, ElementEntry this.next]) {}
    $dart$core.Object element;
    ElementEntry next;
    $dart$core.Object get first => element;
    $dart$core.bool has([$dart$core.Object element]) {
        ElementEntry entry = this;
        while (true) {
            ElementEntry e;
            {
                ElementEntry tmp$138 = entry;
                if (tmp$138 == null) {
                    break;
                }
                e = tmp$138;
            }
            {
                $dart$core.bool doElse$136 = true;
                if (!(element == null)) {
                    doElse$136 = false;
                    {
                        $dart$core.Object tmp$137 = e.element;
                        if (!(tmp$137 == null)) {
                            $dart$core.Object ee;
                            ee = tmp$137;
                            if (element.equals(ee)) {
                                return true;
                            }
                        }
                    }
                }
                if (doElse$136) {
                    if (!(!(e.element == null))) {
                        return true;
                    }
                }
            }
            entry = e.next;
        }
        return false;
    }
    $dart$core.Object getFromFirst([$dart$core.int index]) {
        if (index < 0) {
            return null;
        } else {
            ElementEntry entry = this;
            {
                $dart$core.Object element$140;
                Iterator iterator$139 = ($package$measure(Integer.instance(0), index) as List).iterator();
                while ((element$140 = iterator$139.next()) is !Finished) {
                    Integer i = element$140 as Integer;
                    {
                        $dart$core.bool doElse$141 = true;
                        {
                            ElementEntry tmp$142 = entry.next;
                            if (!(tmp$142 == null)) {
                                ElementEntry next;
                                next = tmp$142;
                                doElse$141 = false;
                                entry = next;
                            }
                        }
                        if (doElse$141) {
                            return null;
                        }
                    }
                }
            }
            return entry.element;
        }
    }
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(next);
    $dart$core.Object get last {
        ElementEntry entry = this;
        while (true) {
            ElementEntry next;
            {
                ElementEntry tmp$143 = entry.next;
                if (tmp$143 == null) {
                    break;
                }
                next = tmp$143;
            }
            entry = next;
        }
        return entry.element;
    }
    $dart$core.int get size {
        $dart$core.int count = 1;
        ElementEntry entry = this;
        while (true) {
            ElementEntry next;
            {
                ElementEntry tmp$144 = entry.next;
                if (tmp$144 == null) {
                    break;
                }
                next = tmp$144;
            }
            entry = next;
            count = Integer.nativeValue(Integer.instance(count).successor);
        }
        return count;
    }
    Iterator iterator() => new ElementEntry$$anonymous$34_(this);
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential measure([Integer from, $dart$core.int length]) => Sequence.$measure(this, from, length);
    Sequential span([Integer from, Integer to]) => Sequence.$span(this, from, to);
    Sequential spanFrom([Integer from]) => Sequence.$spanFrom(this, from);
    Sequential spanTo([Integer to]) => Sequence.$spanTo(this, to);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class GroupEntry {
    GroupEntry([$dart$core.Object this.group, ElementEntry this.elements, GroupEntry this.next]) {}
    $dart$core.Object group;
    ElementEntry elements;
    GroupEntry next;
    GroupEntry get([$dart$core.Object group]) {
        GroupEntry entry = this;
        while (true) {
            GroupEntry e;
            {
                GroupEntry tmp$147 = entry;
                if (tmp$147 == null) {
                    break;
                }
                e = tmp$147;
            }
            if (group.equals(e.group)) {
                return e;
            }
            entry = e.next;
        }
        return null;
    }
}
abstract class Iterator {
    $dart$core.Object next();
}
$dart$core.Object $package$largest([$dart$core.Object x, $dart$core.Object y]) => (($dart$core.Object $lhs$) => $lhs$ == null ? y : $lhs$)((x as Comparable).largerThan(y) ? x : null);

$dart$core.Object largest([$dart$core.Object x, $dart$core.Object y]) => $package$largest(x, y);

class List$iterator$$anonymous$0_ implements Iterator {
    List $outer$ceylon$language$List;
    List$iterator$$anonymous$0_([List this.$outer$ceylon$language$List]) {
        index = 0;
        size = $outer$ceylon$language$List.size;
    }
    $dart$core.int index;
    $dart$core.int size;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? List.$getElement(this.$outer$ceylon$language$List, (() {
        $dart$core.int tmp$5 = index;
        index = Integer.nativeValue(Integer.instance(index).successor);
        return tmp$5;
    })()) : $lhs$)(index >= size ? $package$finished : null);
    $dart$core.String toString() => $outer$ceylon$language$List.toString() + ".iterator()";
}
class List$collect$list_ implements List {
    List $outer$ceylon$language$List;
    Callable $capture$List$collect$collecting;
    List$collect$list_([List this.$outer$ceylon$language$List, Callable this.$capture$List$collect$collecting]) {}
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int get size => $outer$ceylon$language$List.size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index < size)) {
            return collecting.$delegate$(List.$getElement($outer$ceylon$language$List, index));
        } else {
            return null;
        }
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    List clone() => List.$clone(this);
    Iterator iterator() => List.$iterator(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Indexes$$anonymous$1_ implements Iterator {
    List$Indexes $outer$ceylon$language$List$Indexes;
    List$Indexes$$anonymous$1_([List$Indexes this.$outer$ceylon$language$List$Indexes]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$finished : $lhs$)(i < $outer$ceylon$language$List$Indexes.size ? (() {
        $dart$core.Object tmp$84 = Integer.instance(i);
        Integer.instance(i = Integer.nativeValue(Integer.instance(i).successor));
        return tmp$84;
    })() : null);
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Indexes.toString()) + ".iterator()";
}
class List$Indexes implements List {
    List $outer$ceylon$language$List;
    List$Indexes([List this.$outer$ceylon$language$List]) {}
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    Integer getFromFirst([$dart$core.int index]) => defines(Integer.instance(index)) ? Integer.instance(index) : null;
    List clone() => $package$measure(Integer.instance(0), size) as List;
    List measure([$dart$core.int from, $dart$core.int length]) => clone().measure(Integer.instance(from), length);
    List span([$dart$core.int from, $dart$core.int to]) => clone().span(Integer.instance(from), Integer.instance(to));
    List spanFrom([$dart$core.int from]) => clone().spanFrom(Integer.instance(from));
    List spanTo([$dart$core.int to]) => clone().spanTo(Integer.instance(to));
    $dart$core.String toString() => (() {
        $dart$core.bool doElse$82 = true;
        {
            $dart$core.int tmp$83 = lastIndex;
            if (!(tmp$83 == null)) {
                $dart$core.int endIndex;
                endIndex = tmp$83;
                doElse$82 = false;
                return ("{ 0, ... , " + Integer.instance(endIndex).toString()) + " }";
            }
        }
        if (doElse$82) {
            return "{}";
        }
    })();
    Iterator iterator() => new List$Indexes$$anonymous$1_(this);
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.int get size => List.$get$size(this);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Rest$$anonymous$2_ implements Iterator {
    List$Rest $outer$ceylon$language$List$Rest;
    List $capture$$o;
    List$Rest$$anonymous$2_([List$Rest this.$outer$ceylon$language$List$Rest, List this.$capture$$o]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() => (() {
        if (i < $outer$ceylon$language$List$Rest.size) {
            return List.$getElement($capture$$o, $outer$ceylon$language$List$Rest.from + (() {
                $dart$core.int tmp$85 = i;
                i = Integer.nativeValue(Integer.instance(i).successor);
                return tmp$85;
            })());
        } else {
            return $package$finished;
        }
    })();
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Rest.toString()) + ".iterator()";
}
class List$Rest implements List {
    List $outer$ceylon$language$List;
    List$Rest([List this.$outer$ceylon$language$List, $dart$core.int this.from]) {
        if (!(from >= 0)) {
            throw new AssertionError("Violated: from>=0");
        }
    }
    $dart$core.int from;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (index < 0) {
            return null;
        } else {
            return $outer$ceylon$language$List.getFromFirst(index + from);
        }
    })();
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = $outer$ceylon$language$List.size - from;
        return size > 0 ? size - 1 : null;
    })();
    List measure([$dart$core.int from, $dart$core.int length]) => $outer$ceylon$language$List.measure(Integer.instance(from + this.from), length);
    List span([$dart$core.int from, $dart$core.int to]) => $outer$ceylon$language$List.span(Integer.instance(from + this.from), Integer.instance(to + this.from));
    List spanFrom([$dart$core.int from]) => $outer$ceylon$language$List.spanFrom(Integer.instance(from + this.from));
    List spanTo([$dart$core.int to]) => $outer$ceylon$language$List.span(Integer.instance(this.from), Integer.instance(to + this.from));
    List clone() => $package$nothing as List;
    Iterator iterator() => (() {
        List o = $outer$ceylon$language$List;
        return new List$Rest$$anonymous$2_(this, o);
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.int get size => List.$get$size(this);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Sublist$$anonymous$3_ implements Iterator {
    List$Sublist $outer$ceylon$language$List$Sublist;
    Iterator $capture$$iter;
    List$Sublist$$anonymous$3_([List$Sublist this.$outer$ceylon$language$List$Sublist, Iterator this.$capture$$iter]) {
        i = 0;
    }
    $dart$core.int i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $capture$$iter.next() : $lhs$)((() {
        $dart$core.int tmp$86 = i;
        i = Integer.nativeValue(Integer.instance(i).successor);
        return tmp$86;
    })() > $outer$ceylon$language$List$Sublist.to ? $package$finished : null);
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Sublist.toString()) + ".iterator()";
}
class List$Sublist implements List {
    List $outer$ceylon$language$List;
    List$Sublist([List this.$outer$ceylon$language$List, $dart$core.int this.to]) {
        if (!(to >= 0)) {
            throw new AssertionError("Violated: to>=0");
        }
    }
    $dart$core.int to;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index <= to)) {
            return $outer$ceylon$language$List.getFromFirst(index);
        } else {
            return null;
        }
    })();
    $dart$core.int get lastIndex => (() {
        $dart$core.int endIndex = $outer$ceylon$language$List.size - 1;
        return endIndex >= 0 ? (($dart$core.int $lhs$) => $lhs$ == null ? to : $lhs$)(endIndex < to ? endIndex : null) : null;
    })();
    List measure([$dart$core.int from, $dart$core.int length]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.measure(Integer.instance(from), length) : $lhs$)(((from + length) - 1) > to ? $outer$ceylon$language$List.measure(Integer.instance(from), to) : null);
    List span([$dart$core.int from, $dart$core.int to]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.span(Integer.instance(from), Integer.instance(to)) : $lhs$)(to > this.to ? $outer$ceylon$language$List.span(Integer.instance(from), Integer.instance(this.to)) : null);
    List spanFrom([$dart$core.int from]) => $outer$ceylon$language$List.span(Integer.instance(from), Integer.instance(to));
    List spanTo([$dart$core.int to]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.spanTo(Integer.instance(to)) : $lhs$)(to > this.to ? $outer$ceylon$language$List.spanTo(Integer.instance(this.to)) : null);
    List clone() => $package$nothing as List;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$List.iterator();
        return new List$Sublist$$anonymous$3_(this, iter);
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.int get size => List.$get$size(this);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Repeat implements List {
    List $outer$ceylon$language$List;
    List$Repeat([List this.$outer$ceylon$language$List, $dart$core.int this.times]) {}
    $dart$core.int times;
    $dart$core.int get size => $outer$ceylon$language$List.size * times;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = this.size;
        return size > 0 ? size - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size = $outer$ceylon$language$List.size;
        return (() {
            if (index < (size * times)) {
                return $outer$ceylon$language$List.getFromFirst(Integer.nativeValue(Integer.instance(index).remainder(Integer.instance(size))));
            } else {
                return null;
            }
        })();
    })();
    List clone() => $package$nothing as List;
    Iterator iterator() => new CycledIterator($outer$ceylon$language$List, times);
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$List.toString()) + ").repeat(") + Integer.instance(times).toString()) + ")";
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Patch$$anonymous$4_ implements Iterator {
    List$Patch $outer$ceylon$language$List$Patch;
    Iterator $capture$$iter;
    Iterator $capture$$patchIter;
    List$Patch$$anonymous$4_([List$Patch this.$outer$ceylon$language$List$Patch, Iterator this.$capture$$iter, Iterator this.$capture$$patchIter]) {
        index = Integer.nativeValue(Integer.instance(1).negated);
    }
    $dart$core.int index;
    $dart$core.Object next() {
        if (Integer.instance(index = Integer.nativeValue(Integer.instance(index).successor)).equals(Integer.instance($outer$ceylon$language$List$Patch.from))) {{
                $dart$core.Object element$88;
                Iterator iterator$87 = ($package$measure(Integer.instance(0), $outer$ceylon$language$List$Patch.length) as List).iterator();
                while ((element$88 = iterator$87.next()) is !Finished) {
                    Integer skip = element$88 as Integer;
                    $capture$$iter.next();
                }
            }
        }
        return (() {
            if (((index - $outer$ceylon$language$List$Patch.from) >= 0) && ((index - $outer$ceylon$language$List$Patch.from) < $outer$ceylon$language$List$Patch.list.size)) {
                return $capture$$patchIter.next();
            } else {
                return $capture$$iter.next();
            }
        })();
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Patch.toString()) + ".iterator()";
}
class List$Patch implements List {
    List $outer$ceylon$language$List;
    List$Patch([List this.$outer$ceylon$language$List, List this.list, $dart$core.int this.from, $dart$core.int this.length]) {
        if (!(length >= 0)) {
            throw new AssertionError("Violated: length>=0");
        }
        if (!((from >= 0) && (from <= $outer$ceylon$language$List.size))) {
            throw new AssertionError("Violated: 0<=from<=outer.size");
        }
    }
    List list;
    $dart$core.int from;
    $dart$core.int length;
    $dart$core.int get size => ($outer$ceylon$language$List.size + list.size) - length;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = this.size;
        return size > 0 ? size - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (index < from) {
            return $outer$ceylon$language$List.getFromFirst(index);
        } else {
            return (() {
                if ((index - from) < list.size) {
                    return list.getFromFirst(index - from);
                } else {
                    return $outer$ceylon$language$List.getFromFirst((index - list.size) + length);
                }
            })();
        }
    })();
    List clone() => $package$nothing as List;
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$List.iterator();
        Iterator patchIter = list.iterator();
        return new List$Patch$$anonymous$4_(this, iter, patchIter);
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Reversed$$anonymous$5_ implements Iterator {
    List$Reversed $outer$ceylon$language$List$Reversed;
    List $capture$$outerList;
    List$Reversed$$anonymous$5_([List$Reversed this.$outer$ceylon$language$List$Reversed, List this.$capture$$outerList]) {
        index = $capture$$outerList.size - 1;
    }
    $dart$core.int index;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? List.$getElement($capture$$outerList, (() {
        $dart$core.int tmp$89 = index;
        index = Integer.nativeValue(Integer.instance(index).predecessor);
        return tmp$89;
    })()) : $lhs$)(index < 0 ? $package$finished : null);
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Reversed.toString()) + ".iterator()";
}
class List$Reversed implements List {
    List $outer$ceylon$language$List;
    List$Reversed([List this.$outer$ceylon$language$List]) {}
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int get size => $outer$ceylon$language$List.size;
    $dart$core.Object get first => $outer$ceylon$language$List.last;
    $dart$core.Object get last => $outer$ceylon$language$List.first;
    List get reversed => $outer$ceylon$language$List;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (size > 0) {
            return $outer$ceylon$language$List.getFromFirst((size - 1) - index);
        } else {
            return null;
        }
    })();
    List measure([$dart$core.int from, $dart$core.int length]) => (() {
        if ((size > 0) && (length > 0)) {
            return (() {
                $dart$core.int start = (size - 1) - from;
                return $outer$ceylon$language$List.span(Integer.instance(start), Integer.instance((start - length) + 1));
            })();
        } else {
            return $package$empty;
        }
    })();
    List span([$dart$core.int from, $dart$core.int to]) => $outer$ceylon$language$List.span(Integer.instance(to), Integer.instance(from));
    List spanFrom([$dart$core.int from]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if ((endIndex >= 0) && (from <= endIndex)) {
                return $outer$ceylon$language$List.span(Integer.instance(endIndex - from), Integer.instance(0));
            } else {
                return $package$empty;
            }
        })();
    })();
    List spanTo([$dart$core.int to]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if ((endIndex >= 0) && (to >= 0)) {
                return $outer$ceylon$language$List.span(Integer.instance(endIndex), Integer.instance(endIndex - to));
            } else {
                return $package$empty;
            }
        })();
    })();
    List clone() => $outer$ceylon$language$List.clone().reversed;
    Iterator iterator() => (() {
        List outerList = $outer$ceylon$language$List;
        return new List$Reversed$$anonymous$5_(this, outerList);
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$permutations$$anonymous$6_$$anonymous$7_ implements Iterator {
    List$permutations$$anonymous$6_ $outer$ceylon$language$List$permutations$$anonymous$6_;
    List $capture$$list;
    List$permutations$$anonymous$6_$$anonymous$7_([List$permutations$$anonymous$6_ this.$outer$ceylon$language$List$permutations$$anonymous$6_, List this.$capture$$list]) {
        length = $capture$$list.size;
        permutation = new Array($package$measure(Integer.instance(0), length) as Iterable);
        indexes = new Array($package$measure(Integer.instance(0), length) as Iterable);
        swaps = new Array($package$measure(Integer.instance(0), length) as Iterable);
        directions = new Array.ofSize(length, Integer.instance(1).negated);
        counter = length;
    }
    $dart$core.int length;
    Array permutation;
    Array indexes;
    Array swaps;
    Array directions;
    $dart$core.int counter;
    $dart$core.Object next() {
        while (counter > 0) {
            if (Integer.instance(counter).equals(Integer.instance(length))) {
                counter = Integer.nativeValue(Integer.instance(counter).predecessor);
                Sequential result = permutation.collect(new dart$Callable(([Integer i]) {
                    $dart$core.Object elem;
                    {
                        $dart$core.Object tmp$90 = $capture$$list.get(i);
                        if (tmp$90 == null) {
                            throw new AssertionError("Violated: exists elem = list[i]");
                        }
                        elem = tmp$90;
                    }
                    return elem;
                }));
                Sequence result$91;
                if (!(result is Sequence)) {
                    throw new AssertionError("Violated: nonempty result");
                }
                result$91 = result as Sequence;
                return result$91;
            } else {
                $dart$core.int swap;
                {
                    $dart$core.int tmp$92 = Integer.nativeValue(swaps.get(Integer.instance(counter)) as Integer);
                    if (tmp$92 == null) {
                        throw new AssertionError("Violated: exists swap = swaps[counter]");
                    }
                    swap = tmp$92;
                }
                $dart$core.int dir;
                {
                    $dart$core.int tmp$93 = Integer.nativeValue(directions.get(Integer.instance(counter)) as Integer);
                    if (tmp$93 == null) {
                        throw new AssertionError("Violated: exists dir = directions[counter]");
                    }
                    dir = tmp$93;
                }
                if (swap > 0) {
                    $dart$core.int index;
                    {
                        $dart$core.int tmp$94 = Integer.nativeValue(indexes.get(Integer.instance(counter)) as Integer);
                        if (tmp$94 == null) {
                            throw new AssertionError("Violated: exists index = indexes[counter]");
                        }
                        index = tmp$94;
                    }
                    $dart$core.int otherIndex = index + dir;
                    $dart$core.int swapIndex;
                    {
                        $dart$core.int tmp$95 = Integer.nativeValue(permutation.get(Integer.instance(otherIndex)) as Integer);
                        if (tmp$95 == null) {
                            throw new AssertionError("Violated: exists swapIndex = permutation[otherIndex]");
                        }
                        swapIndex = tmp$95;
                    }
                    permutation.set(index, Integer.instance(swapIndex));
                    permutation.set(otherIndex, Integer.instance(counter));
                    indexes.set(swapIndex, Integer.instance(index));
                    indexes.set(counter, Integer.instance(otherIndex));
                    swaps.set(counter, Integer.instance(swap - 1));
                    counter = length;
                } else {
                    swaps.set(counter, Integer.instance(counter));
                    directions.set(counter, Integer.instance(dir).negated);
                    counter = Integer.nativeValue(Integer.instance(counter).predecessor);
                }
            }
        }
        return $package$finished;
    }
}
class List$permutations$$anonymous$6_ implements Iterable {
    List $outer$ceylon$language$List;
    List$permutations$$anonymous$6_([List this.$outer$ceylon$language$List]) {}
    Iterator iterator() => (() {
        List list = $outer$ceylon$language$List;
        return new List$permutations$$anonymous$6_$$anonymous$7_(this, list);
    })();
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class List implements Collection, Correspondence, Ranged {
    $dart$core.Object get first;
    static $dart$core.Object $get$first([final List $this]) => $this.getFromFirst(0);
    $dart$core.Object get last;
    static $dart$core.Object $get$last([final List $this]) => $this.getFromLast(0);
    $dart$core.Object get([Integer index]);
    static $dart$core.Object $get([final List $this, Integer index]) => $this.getFromFirst(Integer.nativeValue(index));
    $dart$core.Object getFromFirst([$dart$core.int index]);
    $dart$core.Object getFromLast([$dart$core.int index]);
    static $dart$core.Object $getFromLast([final List $this, $dart$core.int index]) => $this.getFromFirst(($this.size - 1) - index);
    $dart$core.Object getElement([$dart$core.int index]);
    static $dart$core.Object $getElement([final List $this, $dart$core.int index]) {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object tmp$1 = $this.getFromFirst(index);
                if (!(tmp$1 == null)) {
                    $dart$core.Object element;
                    element = tmp$1;
                    doElse$0 = false;
                    return element;
                }
            }
            if (doElse$0) {
                if (!true) {
                    throw new AssertionError("Violated: is Element null");
                }
                return null;
            }
        }
    }
    $dart$core.int get lastIndex;
    $dart$core.int get size;
    static $dart$core.int $get$size([final List $this]) => (($dart$core.int $lhs$) => $lhs$ == null ? Integer.nativeValue(Integer.instance(1).negated) : $lhs$)($this.lastIndex) + 1;
    $dart$core.bool defines([Integer index]);
    static $dart$core.bool $defines([final List $this, Integer index]) => (Integer.nativeValue(index) >= 0) && (Integer.nativeValue(index) < $this.size);
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final List $this, $dart$core.Object element]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                Integer index = element$3 as Integer;
                {
                    $dart$core.Object tmp$4 = $this.getFromFirst(Integer.nativeValue(index));
                    if (!(tmp$4 == null)) {
                        $dart$core.Object elem;
                        elem = tmp$4;
                        if (elem.equals(element)) {
                            return true;
                        }
                    }
                }
            }
            {
                return false;
            }
        }
    }
    List get rest;
    static List $get$rest([final List $this]) => new List$Rest($this, 1);
    List get keys;
    static List $get$keys([final List $this]) => new List$Indexes($this);
    List get reversed;
    static List $get$reversed([final List $this]) => new List$Reversed($this);
    List clone();
    static List $clone([final List $this]) => $this.sequence();
    Iterator iterator();
    static Iterator $iterator([final List $this]) {
        if ($this.size > 0) {
            return new List$iterator$$anonymous$0_($this);
        } else {
            return $package$emptyIterator;
        }
    }
    $dart$core.bool equals([$dart$core.Object that]);
    static $dart$core.bool $equals([final List $this, $dart$core.Object that]) {
        if (that is String) {
            $dart$core.String that$6;
            that$6 = String.nativeValue(that as String);
            return false;
        }
        {
            $dart$core.bool doElse$7 = true;
            if (that is List) {
                List that$8;
                that$8 = that as List;
                doElse$7 = false;
                if (Integer.instance(that$8.size).equals(Integer.instance($this.size))) {{
                        $dart$core.Object element$10;
                        Iterator iterator$9 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
                        while ((element$10 = iterator$9.next()) is !Finished) {
                            Integer index = element$10 as Integer;
                            $dart$core.Object x = $this.getFromFirst(Integer.nativeValue(index));
                            $dart$core.Object y = that$8.getFromFirst(Integer.nativeValue(index));
                            {
                                $dart$core.bool doElse$11 = true;
                                if (!(x == null)) {
                                    doElse$11 = false;
                                    {
                                        $dart$core.bool doElse$12 = true;
                                        if (!(y == null)) {
                                            doElse$12 = false;
                                            if (!x.equals(y)) {
                                                return false;
                                            }
                                        }
                                        if (doElse$12) {
                                            return false;
                                        }
                                    }
                                }
                                if (doElse$11) {
                                    if (!(y == null)) {
                                        return false;
                                    }
                                }
                            }
                        }
                        {
                            return true;
                        }
                    }
                } else {
                    return false;
                }
            }
            if (doElse$7) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode;
    static $dart$core.int $get$hash([final List $this]) {
        $dart$core.int hash = 1;
        {
            $dart$core.Object element$14;
            Iterator iterator$13 = $this.iterator();
            while ((element$14 = iterator$13.next()) is !Finished) {
                $dart$core.Object elem = element$14;
                hash = hash * 31;
                if (!(elem == null)) {
                    hash = hash + elem.hashCode;
                }
            }
        }
        return hash;
    }
    $dart$core.bool shorterThan([$dart$core.int length]);
    static $dart$core.bool $shorterThan([final List $this, $dart$core.int length]) => $this.size < length;
    $dart$core.bool longerThan([$dart$core.int length]);
    static $dart$core.bool $longerThan([final List $this, $dart$core.int length]) => $this.size > length;
    List repeat([$dart$core.int times]);
    static List $repeat([final List $this, $dart$core.int times]) => new List$Repeat($this, times);
    $dart$core.Object find([Callable selecting]);
    static $dart$core.Object $find([final List $this, Callable selecting]) {
        $dart$core.int index = 0;
        while (index < $this.size) {{
                $dart$core.Object tmp$15 = $this.getFromFirst((() {
                    $dart$core.int tmp$16 = index;
                    index = Integer.nativeValue(Integer.instance(index).successor);
                    return tmp$16;
                })());
                if (!(tmp$15 == null)) {
                    $dart$core.Object elem;
                    elem = tmp$15;
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        return elem;
                    }
                }
            }
        }
        return null;
    }
    $dart$core.Object findLast([Callable selecting]);
    static $dart$core.Object $findLast([final List $this, Callable selecting]) {
        $dart$core.int index = $this.size - 1;
        while (index >= 0) {{
                $dart$core.Object tmp$17 = $this.getFromFirst((() {
                    $dart$core.int tmp$18 = index;
                    index = Integer.nativeValue(Integer.instance(index).predecessor);
                    return tmp$18;
                })());
                if (!(tmp$17 == null)) {
                    $dart$core.Object elem;
                    elem = tmp$17;
                    if (Boolean.nativeValue(selecting.$delegate$(elem) as Boolean)) {
                        return elem;
                    }
                }
            }
        }
        return null;
    }
    List sublistFrom([$dart$core.int from]);
    static List $sublistFrom([final List $this, $dart$core.int from]) => ((List $lhs$) => $lhs$ == null ? new List$Rest($this, from) : $lhs$)(from < 0 ? $this : null);
    List sublistTo([$dart$core.int to]);
    static List $sublistTo([final List $this, $dart$core.int to]) => ((List $lhs$) => $lhs$ == null ? new List$Sublist($this, to) : $lhs$)(to < 0 ? $package$empty : null);
    List sublist([$dart$core.int from, $dart$core.int to]);
    static List $sublist([final List $this, $dart$core.int from, $dart$core.int to]) => $this.sublistTo(to).sublistFrom(from);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static List $patch([final List $this, List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = $this.size;
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = 0;
        }
        return ((List $lhs$) => $lhs$ == null ? $this : $lhs$)(((length as $dart$core.int) >= 0) && (((from as $dart$core.int) >= 0) && ((from as $dart$core.int) <= $this.size)) ? new List$Patch($this, list, from as $dart$core.int, length as $dart$core.int) : null);
    }
    $dart$core.bool startsWith([List sublist]);
    static $dart$core.bool $startsWith([final List $this, List sublist]) => $this.includesAt(0, sublist);
    $dart$core.bool endsWith([List sublist]);
    static $dart$core.bool $endsWith([final List $this, List sublist]) => $this.includesAt($this.size - sublist.size, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]);
    static $dart$core.bool $includesAt([final List $this, $dart$core.int index, List sublist]) {
        if (sublist.size > ($this.size - index)) {
            return false;
        }
        {
            $dart$core.Object element$20;
            Iterator iterator$19 = ($package$measure(Integer.instance(0), sublist.size) as List).iterator();
            while ((element$20 = iterator$19.next()) is !Finished) {
                Integer i = element$20 as Integer;
                $dart$core.Object x = $this.getFromFirst(index + Integer.nativeValue(i));
                $dart$core.Object y = sublist.getFromFirst(Integer.nativeValue(i));
                {
                    $dart$core.bool doElse$21 = true;
                    if (!(x == null)) {
                        doElse$21 = false;
                        {
                            $dart$core.bool doElse$22 = true;
                            if (!(y == null)) {
                                doElse$22 = false;
                                if (!x.equals(y)) {
                                    return false;
                                }
                            }
                            if (doElse$22) {
                                return false;
                            }
                        }
                    }
                    if (doElse$21) {
                        if (!(y == null)) {
                            return false;
                        }
                    }
                }
            }
            {
                return true;
            }
        }
    }
    $dart$core.bool includes([List sublist]);
    static $dart$core.bool $includes([final List $this, List sublist]) {
        if (sublist.empty) {
            return true;
        }
        {
            $dart$core.Object element$24;
            Iterator iterator$23 = ($package$measure(Integer.instance(0), ($this.size - sublist.size) + 1) as List).iterator();
            while ((element$24 = iterator$23.next()) is !Finished) {
                Integer index = element$24 as Integer;
                if ($this.includesAt(Integer.nativeValue(index), sublist)) {
                    return true;
                }
            }
        }
        return false;
    }
    Iterable inclusions([List sublist]);
    static Iterable $inclusions([final List $this, List sublist]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$25 = false;
        $dart$core.bool step$0$26() {
            if (step$0$expired$25) {
                return false;
            }
            step$0$expired$25 = true;
            return true;
        }

        Iterator iterator_1$27;
        $dart$core.bool step$1$Init$30() {
            if (iterator_1$27 != null) {
                return true;
            }
            if (!step$0$26()) {
                return false;
            }
            iterator_1$27 = ($package$measure(Integer.instance(0), ($this.size - sublist.size) + 1) as List).iterator();
            return true;
        }

        Integer index$28;
        $dart$core.bool step$1$31() {
            while (step$1$Init$30()) {
                $dart$core.Object next$29;
                if ((next$29 = iterator_1$27.next()) is !Finished) {
                    index$28 = next$29 as Integer;
                    return true;
                }
                iterator_1$27 = null;
            }
            return false;
        }

        $dart$core.bool step$2$32() {
            while (step$1$31()) {
                Integer index = index$28;
                if ($this.includesAt(Integer.nativeValue(index), sublist)) {
                    return true;
                }
            }
            return false;
        }

        $dart$core.Object step$3$33() {
            if (!step$2$32()) {
                return $package$finished;
            }
            Integer index = index$28;
            return index;
        }

        return new dart$Callable(step$3$33);
    }));
    $dart$core.int firstInclusion([List sublist]);
    static $dart$core.int $firstInclusion([final List $this, List sublist]) {{
            $dart$core.Object element$35;
            Iterator iterator$34 = ($package$measure(Integer.instance(0), ($this.size - sublist.size) + 1) as List).iterator();
            while ((element$35 = iterator$34.next()) is !Finished) {
                Integer index = element$35 as Integer;
                if ($this.includesAt(Integer.nativeValue(index), sublist)) {
                    return Integer.nativeValue(index);
                }
            }
            {
                return null;
            }
        }
    }
    $dart$core.int lastInclusion([List sublist]);
    static $dart$core.int $lastInclusion([final List $this, List sublist]) {{
            $dart$core.Object element$37;
            Iterator iterator$36 = ($package$measure(Integer.instance(0), ($this.size - sublist.size) + 1) as Sequential).reversed.iterator();
            while ((element$37 = iterator$36.next()) is !Finished) {
                Integer index = element$37 as Integer;
                if ($this.includesAt(Integer.nativeValue(index), sublist)) {
                    return Integer.nativeValue(index);
                }
            }
            {
                return null;
            }
        }
    }
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]);
    static $dart$core.bool $occursAt([final List $this, $dart$core.int index, $dart$core.Object element]) {
        $dart$core.Object elem = $this.getFromFirst(index);
        {
            $dart$core.bool doElse$38 = true;
            if (!(element == null)) {
                doElse$38 = false;
                return (() {
                    $dart$core.bool doElse$39 = true;
                    if (!(elem == null)) {
                        doElse$39 = false;
                        return elem.equals(element);
                    }
                    if (doElse$39) {
                        return false;
                    }
                })();
            }
            if (doElse$38) {
                return !(!(elem == null));
            }
        }
    }
    $dart$core.bool occurs([$dart$core.Object element]);
    static $dart$core.bool $occurs([final List $this, $dart$core.Object element]) {{
            $dart$core.Object element$41;
            Iterator iterator$40 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
            while ((element$41 = iterator$40.next()) is !Finished) {
                Integer index = element$41 as Integer;
                if ($this.occursAt(Integer.nativeValue(index), element)) {
                    return true;
                }
            }
            {
                return false;
            }
        }
    }
    Iterable occurrences([$dart$core.Object element]);
    static Iterable $occurrences([final List $this, $dart$core.Object element]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$42 = false;
        $dart$core.bool step$0$43() {
            if (step$0$expired$42) {
                return false;
            }
            step$0$expired$42 = true;
            return true;
        }

        Iterator iterator_1$44;
        $dart$core.bool step$1$Init$47() {
            if (iterator_1$44 != null) {
                return true;
            }
            if (!step$0$43()) {
                return false;
            }
            iterator_1$44 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
            return true;
        }

        Integer index$45;
        $dart$core.bool step$1$48() {
            while (step$1$Init$47()) {
                $dart$core.Object next$46;
                if ((next$46 = iterator_1$44.next()) is !Finished) {
                    index$45 = next$46 as Integer;
                    return true;
                }
                iterator_1$44 = null;
            }
            return false;
        }

        $dart$core.bool step$2$49() {
            while (step$1$48()) {
                Integer index = index$45;
                if ($this.occursAt(Integer.nativeValue(index), element)) {
                    return true;
                }
            }
            return false;
        }

        $dart$core.Object step$3$50() {
            if (!step$2$49()) {
                return $package$finished;
            }
            Integer index = index$45;
            return index;
        }

        return new dart$Callable(step$3$50);
    }));
    $dart$core.int firstOccurrence([$dart$core.Object element]);
    static $dart$core.int $firstOccurrence([final List $this, $dart$core.Object element]) {{
            $dart$core.Object element$52;
            Iterator iterator$51 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
            while ((element$52 = iterator$51.next()) is !Finished) {
                Integer index = element$52 as Integer;
                if ($this.occursAt(Integer.nativeValue(index), element)) {
                    return Integer.nativeValue(index);
                }
            }
            {
                return null;
            }
        }
    }
    $dart$core.int lastOccurrence([$dart$core.Object element]);
    static $dart$core.int $lastOccurrence([final List $this, $dart$core.Object element]) {{
            $dart$core.Object element$54;
            Iterator iterator$53 = ($package$measure(Integer.instance(0), $this.size) as Sequential).reversed.iterator();
            while ((element$54 = iterator$53.next()) is !Finished) {
                Integer index = element$54 as Integer;
                if ($this.occursAt(Integer.nativeValue(index), element)) {
                    return Integer.nativeValue(index);
                }
            }
            {
                return null;
            }
        }
    }
    Iterable indexesWhere([Callable selecting]);
    static Iterable $indexesWhere([final List $this, Callable selecting]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$55 = false;
        $dart$core.bool step$0$56() {
            if (step$0$expired$55) {
                return false;
            }
            step$0$expired$55 = true;
            return true;
        }

        Iterator iterator_1$57;
        $dart$core.bool step$1$Init$60() {
            if (iterator_1$57 != null) {
                return true;
            }
            if (!step$0$56()) {
                return false;
            }
            iterator_1$57 = ($package$measure(Integer.instance(0), $this.size) as List).iterator();
            return true;
        }

        Integer index$58;
        $dart$core.bool step$1$61() {
            while (step$1$Init$60()) {
                $dart$core.Object next$59;
                if ((next$59 = iterator_1$57.next()) is !Finished) {
                    index$58 = next$59 as Integer;
                    return true;
                }
                iterator_1$57 = null;
            }
            return false;
        }

        $dart$core.Object element$64;
        $dart$core.bool step$2$62() {
            while (step$1$61()) {
                Integer index = index$58;
                $dart$core.Object element;
                $dart$core.Object tmp$63 = $this.getFromFirst(Integer.nativeValue(index));
                if (!(!(tmp$63 == null))) {
                    continue;
                }
                element = tmp$63;
                if (!Boolean.nativeValue(selecting.$delegate$(element) as Boolean)) {
                    continue;
                }
                element$64 = element;
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$65() {
            if (!step$2$62()) {
                return $package$finished;
            }
            Integer index = index$58;
            $dart$core.Object element = element$64;
            return index;
        }

        return new dart$Callable(step$3$65);
    }));
    $dart$core.int firstIndexWhere([Callable selecting]);
    static $dart$core.int $firstIndexWhere([final List $this, Callable selecting]) {
        $dart$core.int index = 0;
        while (index < $this.size) {{
                $dart$core.Object tmp$66 = $this.getFromFirst(index);
                if (!(tmp$66 == null)) {
                    $dart$core.Object element;
                    element = tmp$66;
                    if (Boolean.nativeValue(selecting.$delegate$(element) as Boolean)) {
                        return index;
                    }
                }
            }
            index = Integer.nativeValue(Integer.instance(index).successor);
        }
        return null;
    }
    $dart$core.int lastIndexWhere([Callable selecting]);
    static $dart$core.int $lastIndexWhere([final List $this, Callable selecting]) {
        $dart$core.int index = $this.size;
        while (index > 0) {
            index = Integer.nativeValue(Integer.instance(index).predecessor);
            {
                $dart$core.Object tmp$67 = $this.getFromFirst(index);
                if (!(tmp$67 == null)) {
                    $dart$core.Object element;
                    element = tmp$67;
                    if (Boolean.nativeValue(selecting.$delegate$(element) as Boolean)) {
                        return index;
                    }
                }
            }
        }
        return null;
    }
    List trim([Callable trimming]);
    static List $trim([final List $this, Callable trimming]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            $dart$core.int from = Integer.nativeValue(Integer.instance(1).negated);
            $dart$core.int to = Integer.nativeValue(Integer.instance(1).negated);
            {
                $dart$core.bool doFail$68 = true;
                $dart$core.Object element$70;
                Iterator iterator$69 = $package$span(Integer.instance(0), Integer.instance(end)).iterator();
                while ((element$70 = iterator$69.next()) is !Finished) {
                    Integer index = element$70 as Integer;
                    {
                        $dart$core.Object tmp$71 = $this.getFromFirst(Integer.nativeValue(index));
                        if (!(tmp$71 == null)) {
                            $dart$core.Object elem;
                            elem = tmp$71;
                            if (!Boolean.nativeValue(trimming.$delegate$(elem) as Boolean)) {
                                from = Integer.nativeValue(index);
                                doFail$68 = false;
                                break;
                            }
                        }
                    }
                }
                if (doFail$68) {
                    return $package$empty;
                }
            }
            {
                $dart$core.bool doFail$72 = true;
                $dart$core.Object element$74;
                Iterator iterator$73 = $package$span(Integer.instance(end), Integer.instance(0)).iterator();
                while ((element$74 = iterator$73.next()) is !Finished) {
                    Integer index = element$74 as Integer;
                    {
                        $dart$core.Object tmp$75 = $this.getFromFirst(Integer.nativeValue(index));
                        if (!(tmp$75 == null)) {
                            $dart$core.Object elem;
                            elem = tmp$75;
                            if (!Boolean.nativeValue(trimming.$delegate$(elem) as Boolean)) {
                                to = Integer.nativeValue(index);
                                doFail$72 = false;
                                break;
                            }
                        }
                    }
                }
                if (doFail$72) {
                    return $package$empty;
                }
            }
            return $this.span(Integer.instance(from), Integer.instance(to));
        } else {
            return $package$empty;
        }
    }
    List trimLeading([Callable trimming]);
    static List $trimLeading([final List $this, Callable trimming]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            {
                $dart$core.Object element$77;
                Iterator iterator$76 = $package$span(Integer.instance(0), Integer.instance(end)).iterator();
                while ((element$77 = iterator$76.next()) is !Finished) {
                    Integer index = element$77 as Integer;
                    {
                        $dart$core.Object tmp$78 = $this.getFromFirst(Integer.nativeValue(index));
                        if (!(tmp$78 == null)) {
                            $dart$core.Object elem;
                            elem = tmp$78;
                            if (!Boolean.nativeValue(trimming.$delegate$(elem) as Boolean)) {
                                return $this.span(index, Integer.instance(end));
                            }
                        }
                    }
                }
            }
        }
        return $package$empty;
    }
    List trimTrailing([Callable trimming]);
    static List $trimTrailing([final List $this, Callable trimming]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            {
                $dart$core.Object element$80;
                Iterator iterator$79 = $package$span(Integer.instance(end), Integer.instance(0)).iterator();
                while ((element$80 = iterator$79.next()) is !Finished) {
                    Integer index = element$80 as Integer;
                    {
                        $dart$core.Object tmp$81 = $this.getFromFirst(Integer.nativeValue(index));
                        if (!(tmp$81 == null)) {
                            $dart$core.Object elem;
                            elem = tmp$81;
                            if (!Boolean.nativeValue(trimming.$delegate$(elem) as Boolean)) {
                                return $this.span(Integer.instance(0), index);
                            }
                        }
                    }
                }
            }
        }
        return $package$empty;
    }
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final List $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)), $this.spanFrom(Integer.instance(index))], null);
    List initial([$dart$core.int length]);
    static List $initial([final List $this, $dart$core.int length]) => $this.spanTo(Integer.instance(length - 1));
    List terminal([$dart$core.int length]);
    static List $terminal([final List $this, $dart$core.int length]) => $this.spanFrom(Integer.instance($this.size - length));
    List span([Integer from, Integer to]);
    static List $span([final List $this, Integer from, Integer to]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            if (Integer.nativeValue(from) <= Integer.nativeValue(to)) {
                return ((List $lhs$) => $lhs$ == null ? $package$empty : $lhs$)((Integer.nativeValue(to) >= 0) && (Integer.nativeValue(from) <= end) ? new ArraySequence(new Array($this.sublist(Integer.nativeValue(from), Integer.nativeValue(to)))) : null);
            } else {
                return ((List $lhs$) => $lhs$ == null ? $package$empty : $lhs$)((Integer.nativeValue(from) >= 0) && (Integer.nativeValue(to) <= end) ? new ArraySequence(new Array($this.sublist(Integer.nativeValue(to), Integer.nativeValue(from)).reversed)) : null);
            }
        } else {
            return $package$empty;
        }
    }
    List spanFrom([Integer from]);
    static List $spanFrom([final List $this, Integer from]) {
        if (Integer.nativeValue(from) <= 0) {
            return $this.clone();
        } else if (Integer.nativeValue(from) < $this.size) {
            return new ArraySequence(new Array($this.sublistFrom(Integer.nativeValue(from))));
        } else {
            return $package$empty;
        }
    }
    List spanTo([Integer to]);
    static List $spanTo([final List $this, Integer to]) {
        if (Integer.nativeValue(to) >= ($this.size - 1)) {
            return $this.clone();
        } else if (Integer.nativeValue(to) >= 0) {
            return new ArraySequence(new Array($this.sublistTo(Integer.nativeValue(to))));
        } else {
            return $package$empty;
        }
    }
    List measure([Integer from, $dart$core.int length]);
    static List $measure([final List $this, Integer from, $dart$core.int length]) => (() {
        if (length > 0) {
            return $this.span(from, Integer.instance((Integer.nativeValue(from) + length) - 1));
        } else {
            return $package$empty;
        }
    })();
    Sequential collect([Callable collecting]);
    static Sequential $collect([final List $this, Callable collecting]) {
        if ($this.empty) {
            return $package$empty;
        } else {
            final List$collect$list_ list = new List$collect$list_($this, collecting);
            return new ArraySequence(new Array(list));
        }
    }
    Iterable get permutations;
    static Iterable $get$permutations([final List $this]) => new List$permutations$$anonymous$6_($this);
}
class loop$$anonymous$0_$$anonymous$1_ implements Iterator {
    loop$$anonymous$0_ $outer$ceylon$language$loop$$anonymous$0_;
    loop$$anonymous$0_$$anonymous$1_([loop$$anonymous$0_ this.$outer$ceylon$language$loop$$anonymous$0_]) {
        current = $outer$ceylon$language$loop$$anonymous$0_.$capture$loop$$start;
    }
    $dart$core.Object current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object result$1 = current;
                if (!(result$1 is Finished)) {
                    $dart$core.Object result;
                    result = result$1;
                    doElse$0 = false;
                    current = $outer$ceylon$language$loop$$anonymous$0_.nextElement(result);
                    return result;
                }
            }
            if (doElse$0) {
                return $package$finished;
            }
        }
    }
}
class loop$$anonymous$0_ implements Iterable {
    $dart$core.Object $capture$loop$$start;
    Callable $capture$loop$next;
    loop$$anonymous$0_([$dart$core.Object this.$capture$loop$$start, Callable this.$capture$loop$next]) {}
    $dart$core.Object get first => $capture$loop$$start;
    $dart$core.bool get empty => false;
    $dart$core.Object nextElement([$dart$core.Object element]) => next.$delegate$(element);
    Iterator iterator() => new loop$$anonymous$0_$$anonymous$1_(this);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Callable $package$loop([$dart$core.Object first]) => new dart$Callable(([Callable next]) => (() {
    $dart$core.Object start = first;
    return new loop$$anonymous$0_(start, next);
})());

Callable loop([$dart$core.Object first]) => $package$loop(first);

class Map$keys$$anonymous$0_ implements Collection {
    Map $outer$ceylon$language$Map;
    Map$keys$$anonymous$0_([Map this.$outer$ceylon$language$Map]) {}
    $dart$core.bool contains([$dart$core.Object key]) => $outer$ceylon$language$Map.defines(key);
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([Entry x]) => x.key)).iterator();
    Collection clone() => this.sequence();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Map$items$$anonymous$2_ implements Collection {
    Map $outer$ceylon$language$Map;
    Map$items$$anonymous$2_([Map this.$outer$ceylon$language$Map]) {}
    $dart$core.bool contains([$dart$core.Object item]) {{
            $dart$core.Object element$7;
            Iterator iterator$6 = $outer$ceylon$language$Map.iterator();
            while ((element$7 = iterator$6.next()) is !Finished) {
                Entry e = element$7 as Entry;
                $dart$core.Object k = e.key;
                $dart$core.Object v = e.item;
                if (!(v == null)) {
                    if (v.equals(item)) {
                        return true;
                    }
                }
            }
            {
                return false;
            }
        }
    }
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([Entry e]) => e.item)).iterator();
    Collection clone() => this.sequence();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Map$mapItems$$anonymous$4_ implements Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$mapItems$mapping;
    Map$mapItems$$anonymous$4_([Map this.$outer$ceylon$language$Map, Callable this.$capture$Map$mapItems$mapping]) {}
    $dart$core.bool defines([$dart$core.Object key]) => $outer$ceylon$language$Map.defines(key);
    $dart$core.Object get([$dart$core.Object key]) {{
            $dart$core.bool doElse$17 = true;
            if (true) {
                if (defines(key)) {
                    doElse$17 = false;
                    $dart$core.Object item;
                    {
                        $dart$core.Object item$18 = $outer$ceylon$language$Map.get(key);
                        if (!true) {
                            throw new AssertionError("Violated: is Item item = outer[key]");
                        }
                        item = item$18;
                    }
                    return mapping.$delegate$(key, item);
                }
            }
            if (doElse$17) {
                return null;
            }
        }
    }
    Entry mapEntry([Entry entry]) => new Entry(entry.key, mapping.$delegate$(entry.key, entry.item));
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(mapEntry)).iterator();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    Map clone() => $outer$ceylon$language$Map.clone().mapItems(mapping);
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$filterKeys$$anonymous$5_ implements Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$filterKeys$filtering;
    Map$filterKeys$$anonymous$5_([Map this.$outer$ceylon$language$Map, Callable this.$capture$Map$filterKeys$filtering]) {}
    $dart$core.Object get([$dart$core.Object key]) => (() {
        $dart$core.bool doElse$19 = true;
        if (true) {
            if (Boolean.nativeValue(filtering.$delegate$(key) as Boolean)) {
                doElse$19 = false;
                return $outer$ceylon$language$Map.get(key);
            }
        }
        if (doElse$19) {
            return null;
        }
    })();
    $dart$core.bool defines([$dart$core.Object key]) => (() {
        $dart$core.bool doElse$20 = true;
        if (true) {
            if (Boolean.nativeValue(filtering.$delegate$(key) as Boolean)) {
                doElse$20 = false;
                return $outer$ceylon$language$Map.defines(key);
            }
        }
        if (doElse$20) {
            return false;
        }
    })();
    Iterator iterator() => $outer$ceylon$language$Map.filter($package$forKey(filtering)).iterator();
    Map clone() => $outer$ceylon$language$Map.clone().filterKeys(filtering);
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$patch$$anonymous$6_ implements Map {
    Map $outer$ceylon$language$Map;
    Map $capture$Map$patch$other;
    Map$patch$$anonymous$6_([Map this.$outer$ceylon$language$Map, Map this.$capture$Map$patch$other]) {}
    $dart$core.Object get([$dart$core.Object key]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $outer$ceylon$language$Map.get(key) : $lhs$)($capture$Map$patch$other.get(key));
    Map clone() => $outer$ceylon$language$Map.clone().patch($capture$Map$patch$other.clone());
    $dart$core.bool defines([$dart$core.Object key]) => $capture$Map$patch$other.defines(key) || $outer$ceylon$language$Map.defines(key);
    $dart$core.bool contains([$dart$core.Object entry]) => (() {
        $dart$core.bool doElse$21 = true;
        if (entry is Entry) {
            Entry entry$22;
            entry$22 = entry as Entry;
            doElse$21 = false;
            return $capture$Map$patch$other.contains(entry$22) || ((!$capture$Map$patch$other.defines(entry$22.key)) && $outer$ceylon$language$Map.contains(entry$22));
        }
        if (doElse$21) {
            return false;
        }
    })();
    $dart$core.int get size => $outer$ceylon$language$Map.size + $capture$Map$patch$other.keys.count($package$not((() {
        $dart$core.Function $capturedDelegate$ = $outer$ceylon$language$Map.defines;
        return new dart$Callable(([$dart$core.Object key]) {
            return Boolean.instance($capturedDelegate$(key));
        });
    })()));
    Iterator iterator() => new ChainedIterator($capture$Map$patch$other, $outer$ceylon$language$Map.filter($package$not((() {
        $dart$core.Function $capturedDelegate$ = $capture$Map$patch$other.contains;
        return new dart$Callable(([$dart$core.Object entry]) {
            return Boolean.instance($capturedDelegate$(entry));
        });
    })())));
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$coalescedMap$$anonymous$7_ implements Map {
    Map $outer$ceylon$language$Map;
    Map$coalescedMap$$anonymous$7_([Map this.$outer$ceylon$language$Map]) {}
    $dart$core.bool defines([$dart$core.Object key]) => !($outer$ceylon$language$Map.get(key) == null);
    $dart$core.Object get([$dart$core.Object key]) => $outer$ceylon$language$Map.get(key);
    Iterator iterator() => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$23 = false;
        $dart$core.bool step$0$24() {
            if (step$0$expired$23) {
                return false;
            }
            step$0$expired$23 = true;
            return true;
        }

        Iterator iterator_1$25;
        $dart$core.bool step$1$Init$28() {
            if (iterator_1$25 != null) {
                return true;
            }
            if (!step$0$24()) {
                return false;
            }
            iterator_1$25 = $outer$ceylon$language$Map.iterator();
            return true;
        }

        Entry entry$26;
        $dart$core.bool step$1$29() {
            while (step$1$Init$28()) {
                $dart$core.Object next$27;
                if ((next$27 = iterator_1$25.next()) is !Finished) {
                    entry$26 = next$27 as Entry;
                    return true;
                }
                iterator_1$25 = null;
            }
            return false;
        }

        $dart$core.Object it$32;
        $dart$core.bool step$2$30() {
            while (step$1$29()) {
                Entry entry = entry$26;
                $dart$core.Object it;
                $dart$core.Object tmp$31 = entry.item;
                if (!(!(tmp$31 == null))) {
                    continue;
                }
                it = tmp$31;
                it$32 = it;
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$33() {
            if (!step$2$30()) {
                return $package$finished;
            }
            Entry entry = entry$26;
            $dart$core.Object it = it$32;
            return new Entry(entry.key, it);
        }

        return new dart$Callable(step$3$33);
    })).iterator();
    Map clone() => $outer$ceylon$language$Map.clone().coalescedMap;
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Map implements Collection, Correspondence {
    $dart$core.Object get([$dart$core.Object key]);
    $dart$core.bool defines([$dart$core.Object key]);
    $dart$core.bool contains([$dart$core.Object entry]);
    static $dart$core.bool $contains([final Map $this, $dart$core.Object entry]) {{
            $dart$core.bool doElse$0 = true;
            if (entry is Entry) {
                Entry entry$1;
                entry$1 = entry as Entry;
                if ($this.defines(entry$1.key)) {
                    doElse$0 = false;
                    {
                        $dart$core.bool doElse$2 = true;
                        {
                            $dart$core.Object tmp$3 = $this.get(entry$1.key);
                            if (!(tmp$3 == null)) {
                                $dart$core.Object item;
                                item = tmp$3;
                                doElse$2 = false;
                                return (() {
                                    $dart$core.bool doElse$4 = true;
                                    {
                                        $dart$core.Object tmp$5 = entry$1.item;
                                        if (!(tmp$5 == null)) {
                                            $dart$core.Object entryItem;
                                            entryItem = tmp$5;
                                            doElse$4 = false;
                                            return item.equals(entryItem);
                                        }
                                    }
                                    if (doElse$4) {
                                        return false;
                                    }
                                })();
                            }
                        }
                        if (doElse$2) {
                            return !(!(entry$1.item == null));
                        }
                    }
                }
            }
            if (doElse$0) {
                return false;
            }
        }
    }
    Map clone();
    Collection get keys;
    static Collection $get$keys([final Map $this]) => new Map$keys$$anonymous$0_($this);
    Collection get items;
    static Collection $get$items([final Map $this]) => new Map$items$$anonymous$2_($this);
    $dart$core.bool equals([$dart$core.Object that]);
    static $dart$core.bool $equals([final Map $this, $dart$core.Object that]) {{
            $dart$core.bool doElse$8 = true;
            if (that is Map) {
                Map that$9;
                that$9 = that as Map;
                if (Integer.instance(that$9.size).equals(Integer.instance($this.size))) {
                    doElse$8 = false;
                    {
                        $dart$core.Object element$11;
                        Iterator iterator$10 = $this.iterator();
                        while ((element$11 = iterator$10.next()) is !Finished) {
                            Entry entry = element$11 as Entry;
                            $dart$core.Object thatItem = that$9.get(entry.key);
                            {
                                $dart$core.bool doElse$12 = true;
                                {
                                    $dart$core.Object tmp$13 = entry.item;
                                    if (!(tmp$13 == null)) {
                                        $dart$core.Object thisItem;
                                        thisItem = tmp$13;
                                        doElse$12 = false;
                                        {
                                            $dart$core.bool doElse$14 = true;
                                            if (!(thatItem == null)) {
                                                doElse$14 = false;
                                                if (!thatItem.equals(thisItem)) {
                                                    return false;
                                                }
                                            }
                                            if (doElse$14) {
                                                return false;
                                            }
                                        }
                                    }
                                }
                                if (doElse$12) {
                                    if (!(thatItem == null)) {
                                        return false;
                                    }
                                }
                            }
                        }
                        {
                            return true;
                        }
                    }
                }
            }
            if (doElse$8) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode;
    static $dart$core.int $get$hash([final Map $this]) {
        $dart$core.int hashCode = 0;
        {
            $dart$core.Object element$16;
            Iterator iterator$15 = $this.iterator();
            while ((element$16 = iterator$15.next()) is !Finished) {
                Entry elem = element$16 as Entry;
                hashCode = hashCode + elem.hashCode;
            }
        }
        return hashCode;
    }
    Map mapItems([Callable mapping]);
    static Map $mapItems([final Map $this, Callable mapping]) => new Map$mapItems$$anonymous$4_($this, mapping);
    Map filterKeys([Callable filtering]);
    static Map $filterKeys([final Map $this, Callable filtering]) => new Map$filterKeys$$anonymous$5_($this, filtering);
    Map patch([Map other]);
    static Map $patch([final Map $this, Map other]) => new Map$patch$$anonymous$6_($this, other);
    Map get coalescedMap;
    static Map $get$coalescedMap([final Map $this]) => new Map$coalescedMap$$anonymous$7_($this);
}
$dart$core.Object $package$max([Iterable values]) {
    Iterator it = values.iterator();
    {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.Object first$1 = it.next();
            if (!(first$1 is Finished)) {
                $dart$core.Object first;
                first = first$1;
                doElse$0 = false;
                $dart$core.Object max = first;
                while (true) {
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$2 = it.next();
                        if (val$2 is Finished) {
                            break;
                        }
                        val = val$2;
                    }
                    if ((val as Comparable).largerThan(max)) {
                        max = val;
                    }
                }
                return max;
            }
        }
        if (doElse$0) {
            if (!true) {
                throw new AssertionError("Violated: is Absent null");
            }
            return null;
        }
    }
}

$dart$core.Object max([Iterable values]) => $package$max(values);

class Measure$$anonymous$0_ implements Iterator {
    Measure $outer$ceylon$language$Measure;
    Measure$$anonymous$0_([Measure this.$outer$ceylon$language$Measure]) {
        count = 0;
        current = $outer$ceylon$language$Measure.first;
    }
    $dart$core.int count;
    $dart$core.Object current;
    $dart$core.Object next() {
        if (count >= $outer$ceylon$language$Measure.size) {
            return $package$finished;
        } else if ((() {
            Integer tmp$0 = Integer.instance(count);
            Integer.instance(count = Integer.nativeValue(Integer.instance(count).successor));
            return tmp$0;
        })().equals(Integer.instance(0))) {
            return current;
        } else {
            return current = (current as Enumerable).successor;
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Measure.string) + ").iterator()";
}
class Measure$By$$anonymous$1_ implements Iterator {
    Measure$By $outer$ceylon$language$Measure$By;
    Measure$By$$anonymous$1_([Measure$By this.$outer$ceylon$language$Measure$By]) {
        count = 0;
        current = $outer$ceylon$language$Measure$By.first;
    }
    $dart$core.int count;
    $dart$core.Object current;
    $dart$core.Object next() {
        if (count >= $outer$ceylon$language$Measure$By.size) {
            return $package$finished;
        } else {
            if ((() {
                Integer tmp$1 = Integer.instance(count);
                Integer.instance(count = Integer.nativeValue(Integer.instance(count).successor));
                return tmp$1;
            })().equals(Integer.instance(0))) {
                return current;
            } else {
                current = (current as Enumerable).neighbour($outer$ceylon$language$Measure$By.step);
                return current;
            }
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Measure$By.toString()) + ".iterator()";
}
class Measure$By implements Iterable {
    Measure $outer$ceylon$language$Measure;
    Measure$By([Measure this.$outer$ceylon$language$Measure, $dart$core.int this.step]) {}
    $dart$core.int step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Measure.size - 1) ~/ step);
    $dart$core.Object get first => $outer$ceylon$language$Measure.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Measure.string) + ").by(") + Integer.instance(step).toString()) + ")";
    Iterator iterator() => new Measure$By$$anonymous$1_(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Measure  extends Range {
    Measure([$dart$core.Object this.first, $dart$core.int this.size]) {
        if (!(size > 0)) {
            throw new AssertionError("Violated: size > 0");
        }
    }
    $dart$core.Object first;
    $dart$core.int size;
    $dart$core.String get string => (first.toString() + ":") + Integer.instance(size).toString();
    $dart$core.Object get last => (first as Enumerable).neighbour(size - 1);
    $dart$core.bool longerThan([$dart$core.int length]) => size > length;
    $dart$core.bool shorterThan([$dart$core.int length]) => size < length;
    $dart$core.int get lastIndex => size - 1;
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(size > 1 ? new Measure((first as Enumerable).successor, size - 1) : null);
    $dart$core.Object getFromFirst([$dart$core.int index]) => (($dart$core.Object $lhs$) => $lhs$ == null ? null : $lhs$)((index >= 0) && (index < size) ? (first as Enumerable).neighbour(index) : null);
    $dart$core.bool get increasing => true;
    $dart$core.bool get decreasing => false;
    Iterator iterator() => new Measure$$anonymous$0_(this);
    Iterable by([$dart$core.int step]) {
        if (!(step > 0)) {
            throw new AssertionError("Violated: step > 0");
        }
        return ((Iterable $lhs$) => $lhs$ == null ? new Measure$By(this, step) : $lhs$)(Integer.instance(step).equals(Integer.instance(1)) ? this : null);
    }
    Range shifted([$dart$core.int shift]) => ((Range $lhs$) => $lhs$ == null ? new Measure((first as Enumerable).neighbour(shift), size) : $lhs$)(Integer.instance(shift).equals(Integer.instance(0)) ? this : null);
    $dart$core.bool containsElement([$dart$core.Object x]) => ((x as Enumerable).offset(first) >= 0) && ((x as Enumerable).offset(first) < size);
    $dart$core.bool includes([List sublist]) {
        if (sublist.empty) {
            return true;
        } else {
            $dart$core.bool doElse$2 = true;
            if (sublist is Range) {
                Range sublist$3;
                sublist$3 = sublist as Range;
                doElse$2 = false;
                return includesRange(sublist$3);
            }
            if (doElse$2) {
                return List.$includes(this, sublist);
            }
        }
    }
    $dart$core.bool includesRange([Range range]) {{
            Range switch$4 = range;
            if (switch$4 is Measure) {
                Measure range$5;
                range$5 = range as Measure;
                $dart$core.int offset = (range$5.first as Enumerable).offset(first);
                return (offset >= 0) && (offset <= (size - range$5.size));
            } else if (switch$4 is Span) {
                Span range$6;
                range$6 = range as Span;
                if (range$6.decreasing) {
                    return false;
                } else {
                    $dart$core.int offset = (range$6.first as Enumerable).offset(first);
                    return (offset >= 0) && (offset <= (size - range$6.size));
                }
            } else {
                throw new AssertionError("Supposedly exhaustive switch was not exhaustive");
            }
        }
    }
    $dart$core.bool equals([$dart$core.Object that]) {{
            $dart$core.bool doElse$7 = true;
            if (that is Measure) {
                Measure that$8;
                that$8 = that as Measure;
                doElse$7 = false;
                return Integer.instance(that$8.size).equals(Integer.instance(size)) && that$8.first.equals(first);
            }
            if (doElse$7) {{
                    $dart$core.bool doElse$9 = true;
                    if (that is Span) {
                        Span that$10;
                        that$10 = that as Span;
                        doElse$9 = false;
                        return (that$10.increasing && that$10.first.equals(first)) && Integer.instance(that$10.size).equals(Integer.instance(size));
                    }
                    if (doElse$9) {
                        return List.$equals(this, that);
                    }
                }
            }
        }
    }
    Sequential measure([Integer from, $dart$core.int length]) {
        if (length <= 0) {
            return $package$empty;
        } else {
            $dart$core.int len = (($dart$core.int $lhs$) => $lhs$ == null ? size - Integer.nativeValue(from) : $lhs$)((Integer.nativeValue(from) + length) < size ? length : null);
            return new Measure((first as Enumerable).neighbour(Integer.nativeValue(from)), len);
        }
    }
    Sequential span([Integer from, Integer to]) {
        if (Integer.nativeValue(from) <= Integer.nativeValue(to)) {
            if ((Integer.nativeValue(to) < 0) || (Integer.nativeValue(from) >= size)) {
                return $package$empty;
            } else {
                $dart$core.int len = (($dart$core.int $lhs$) => $lhs$ == null ? size - Integer.nativeValue(from) : $lhs$)(Integer.nativeValue(to) < size ? (Integer.nativeValue(to) - Integer.nativeValue(from)) + 1 : null);
                return new Measure((first as Enumerable).neighbour(Integer.nativeValue(from)), len);
            }
        } else {
            if ((Integer.nativeValue(from) < 0) || (Integer.nativeValue(to) >= size)) {
                return $package$empty;
            } else {
                $dart$core.int len = (($dart$core.int $lhs$) => $lhs$ == null ? size - Integer.nativeValue(to) : $lhs$)(Integer.nativeValue(from) < size ? (Integer.nativeValue(from) - Integer.nativeValue(to)) + 1 : null);
                return (new Measure((first as Enumerable).neighbour(Integer.nativeValue(to)), len)).reversed;
            }
        }
    }
    Sequential spanFrom([Integer from]) {
        if (Integer.nativeValue(from) <= 0) {
            return this;
        } else if (Integer.nativeValue(from) < size) {
            return new Measure((first as Enumerable).neighbour(Integer.nativeValue(from)), size - Integer.nativeValue(from));
        } else {
            return $package$empty;
        }
    }
    Sequential spanTo([Integer to]) {
        if (Integer.nativeValue(to) < 0) {
            return $package$empty;
        } else if (Integer.nativeValue(to) < (size - 1)) {
            return new Measure(first, Integer.nativeValue(to));
        } else {
            return this;
        }
    }
    void each([Callable step]) {
        $dart$core.Object current = first;
        $dart$core.int count = 0;
        while ((() {
            $dart$core.int tmp$11 = count;
            count = Integer.nativeValue(Integer.instance(count).successor);
            return tmp$11;
        })() < size) {
            step.$delegate$((() {
                $dart$core.Object tmp$12 = current;
                current = (current as Enumerable).successor;
                return tmp$12;
            })());
        }
    }
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
$dart$core.Object $package$measure([$dart$core.Object first, $dart$core.int size]) => (($dart$core.Object $lhs$) => $lhs$ == null ? new Measure(first, size) : $lhs$)(size <= 0 ? $package$empty : null);

$dart$core.Object measure([$dart$core.Object first, $dart$core.int size]) => $package$measure(first, size);

$dart$core.Object $package$min([Iterable values]) {
    Iterator it = values.iterator();
    {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.Object first$1 = it.next();
            if (!(first$1 is Finished)) {
                $dart$core.Object first;
                first = first$1;
                doElse$0 = false;
                $dart$core.Object min = first;
                while (true) {
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$2 = it.next();
                        if (val$2 is Finished) {
                            break;
                        }
                        val = val$2;
                    }
                    if ((val as Comparable).smallerThan(min)) {
                        min = val;
                    }
                }
                return min;
            }
        }
        if (doElse$0) {
            if (!true) {
                throw new AssertionError("Violated: is Absent null");
            }
            return null;
        }
    }
}

$dart$core.Object min([Iterable values]) => $package$min(values);

Callable $package$not([Callable p]) => new dart$Callable(([$dart$core.Object val]) {
    return Boolean.instance((([$dart$core.Object val]) => !Boolean.nativeValue(p.$delegate$(val) as Boolean))(val));
});

Callable not([Callable p]) => $package$not(p);

$dart$core.Object get $package$nothing {
    if (!false) {
        throw new AssertionError("Violated: false");
    }
}

$dart$core.Object get nothing => $package$nothing;

abstract class Number implements Numeric, Comparable {
    $dart$core.Object get magnitude;
    static $dart$core.Object $get$magnitude([final Number $this]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $this : $lhs$)($this.negative ? $this.negated : null);
    $dart$core.int get sign;
    static $dart$core.int $get$sign([final Number $this]) {
        if ($this.positive) {
            return 1;
        } else if ($this.negative) {
            return Integer.nativeValue(Integer.instance(1).negated);
        } else {
            return 0;
        }
    }
    $dart$core.bool get positive;
    $dart$core.bool get negative;
    $dart$core.Object get fractionalPart;
    $dart$core.Object get wholePart;
    $dart$core.Object timesInteger([$dart$core.int integer]);
    $dart$core.Object plusInteger([$dart$core.int integer]);
    $dart$core.Object powerOfInteger([$dart$core.int integer]);
}
abstract class Numeric implements Invertible {
    $dart$core.Object times([$dart$core.Object other]);
    $dart$core.Object divided([$dart$core.Object other]);
}
abstract class Obtainable implements Usable {
    void obtain();
    void release([Throwable error]);
}
abstract class OptionalAnnotation implements ConstrainedAnnotation {
}
Callable $package$or([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object val]) {
    return Boolean.instance((([$dart$core.Object val]) => Boolean.nativeValue(p.$delegate$(val) as Boolean) || Boolean.nativeValue(q.$delegate$(val) as Boolean))(val));
});

Callable or([Callable p, Callable q]) => $package$or(p, q);

abstract class Ordinal {
    $dart$core.Object get successor;
    $dart$core.Object get predecessor;
}
class mapPairs$iterable_$iterator$iterator_ implements Iterator {
    mapPairs$iterable_ $outer$ceylon$language$mapPairs$iterable_;
    mapPairs$iterable_$iterator$iterator_([mapPairs$iterable_ this.$outer$ceylon$language$mapPairs$iterable_]) {
        firstIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$firstIterable.iterator();
        secondIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$secondIterable.iterator();
    }
    Iterator firstIter;
    Iterator secondIter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object first$1 = firstIter.next();
                if (!(first$1 is Finished)) {
                    $dart$core.Object first;
                    first = first$1;
                    {
                        $dart$core.Object second$2 = secondIter.next();
                        if (!(second$2 is Finished)) {
                            $dart$core.Object second;
                            second = second$2;
                            doElse$0 = false;
                            return $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$collecting.$delegate$(first, second);
                        }
                    }
                }
            }
            if (doElse$0) {
                return $package$finished;
            }
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$mapPairs$iterable_.toString()) + ".iterator()";
}
class mapPairs$iterable_ implements Iterable {
    Iterable $capture$mapPairs$firstIterable;
    Iterable $capture$mapPairs$secondIterable;
    Callable $capture$mapPairs$collecting;
    mapPairs$iterable_([Iterable this.$capture$mapPairs$firstIterable, Iterable this.$capture$mapPairs$secondIterable, Callable this.$capture$mapPairs$collecting]) {}
    Iterator iterator() {
        final mapPairs$iterable_$iterator$iterator_ iterator = new mapPairs$iterable_$iterator$iterator_(this);
        return iterator;
    }
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.int get size => Iterable.$get$size(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Iterable $package$mapPairs([Callable collecting, Iterable firstIterable, Iterable secondIterable]) {
    final mapPairs$iterable_ iterable = new mapPairs$iterable_(firstIterable, secondIterable, collecting);
    return iterable;
}

Iterable mapPairs([Callable collecting, Iterable firstIterable, Iterable secondIterable]) => $package$mapPairs(collecting, firstIterable, secondIterable);

Tuple $package$findPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) {
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    while (true) {
        $dart$core.Object first;
        {
            $dart$core.Object first$3 = firstIter.next();
            if (first$3 is Finished) {
                break;
            }
            first = first$3;
        }
        $dart$core.Object second;
        {
            $dart$core.Object second$4 = secondIter.next();
            if (second$4 is Finished) {
                break;
            }
            second = second$4;
        }
        if (Boolean.nativeValue(selecting.$delegate$(first, second) as Boolean)) {
            return new Tuple.$withList([first, second], null);
        }
    }
    return null;
}

Tuple findPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) => $package$findPair(selecting, firstIterable, secondIterable);

$dart$core.bool $package$everyPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) {
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    while (true) {
        $dart$core.Object first;
        {
            $dart$core.Object first$5 = firstIter.next();
            if (first$5 is Finished) {
                break;
            }
            first = first$5;
        }
        $dart$core.Object second;
        {
            $dart$core.Object second$6 = secondIter.next();
            if (second$6 is Finished) {
                break;
            }
            second = second$6;
        }
        if (!Boolean.nativeValue(selecting.$delegate$(first, second) as Boolean)) {
            return false;
        }
    }
    return true;
}

$dart$core.bool everyPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) => $package$everyPair(selecting, firstIterable, secondIterable);

$dart$core.bool $package$anyPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) {
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    while (true) {
        $dart$core.Object first;
        {
            $dart$core.Object first$7 = firstIter.next();
            if (first$7 is Finished) {
                break;
            }
            first = first$7;
        }
        $dart$core.Object second;
        {
            $dart$core.Object second$8 = secondIter.next();
            if (second$8 is Finished) {
                break;
            }
            second = second$8;
        }
        if (Boolean.nativeValue(selecting.$delegate$(first, second) as Boolean)) {
            return true;
        }
    }
    return false;
}

$dart$core.bool anyPair([Callable selecting, Iterable firstIterable, Iterable secondIterable]) => $package$anyPair(selecting, firstIterable, secondIterable);

$dart$core.Object $package$foldPairs([$dart$core.Object initial, Callable accumulating, Iterable firstIterable, Iterable secondIterable]) {
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    $dart$core.Object partial = initial;
    while (true) {
        $dart$core.Object first;
        {
            $dart$core.Object first$9 = firstIter.next();
            if (first$9 is Finished) {
                break;
            }
            first = first$9;
        }
        $dart$core.Object second;
        {
            $dart$core.Object second$10 = secondIter.next();
            if (second$10 is Finished) {
                break;
            }
            second = second$10;
        }
        partial = accumulating.$delegate$(partial, first, second);
    }
    return partial;
}

$dart$core.Object foldPairs([$dart$core.Object initial, Callable accumulating, Iterable firstIterable, Iterable secondIterable]) => $package$foldPairs(initial, accumulating, firstIterable, secondIterable);

$dart$core.bool $package$parseBoolean([$dart$core.String string]) {{
        $dart$core.String switch$0 = string;
        if (String.instance(switch$0).equals(String.instance("true"))) {
            return true;
        } else if (String.instance(switch$0).equals(String.instance("false"))) {
            return false;
        } else {
            return null;
        }
    }
}

$dart$core.bool parseBoolean([$dart$core.String string]) => $package$parseBoolean(string);

$dart$core.int $package$maximumIntegerExponent = Integer.nativeValue($package$smallest(Integer.instance(String.instance(Integer.instance($package$runtime.maxIntegerValue).toString()).size), Integer.instance(String.instance(Integer.instance($package$runtime.minIntegerValue).toString()).size - 1)) as Integer);

$dart$core.int get maximumIntegerExponent => $package$maximumIntegerExponent;

$dart$core.int $package$parseFloatExponent([$dart$core.String string]) {{
        $dart$core.String switch$0 = string;
        if (String.instance(switch$0).equals(String.instance("k"))) {
            return 3;
        } else if (String.instance(switch$0).equals(String.instance("M"))) {
            return 6;
        } else if (String.instance(switch$0).equals(String.instance("G"))) {
            return 9;
        } else if (String.instance(switch$0).equals(String.instance("T"))) {
            return 12;
        } else if (String.instance(switch$0).equals(String.instance("P"))) {
            return 15;
        } else if (String.instance(switch$0).equals(String.instance("m"))) {
            return Integer.nativeValue(Integer.instance(3).negated);
        } else if (String.instance(switch$0).equals(String.instance("u"))) {
            return Integer.nativeValue(Integer.instance(6).negated);
        } else if (String.instance(switch$0).equals(String.instance("n"))) {
            return Integer.nativeValue(Integer.instance(9).negated);
        } else if (String.instance(switch$0).equals(String.instance("p"))) {
            return Integer.nativeValue(Integer.instance(12).negated);
        } else if (String.instance(switch$0).equals(String.instance("f"))) {
            return Integer.nativeValue(Integer.instance(15).negated);
        } else {
            if (String.instance(String.instance(string).lowercased).startsWith(String.instance("e")) && String.instance(string).rest.every($package$digitOrSign)) {
                return $package$parseInteger(String.nativeValue(String.instance(string).rest));
            } else {
                return null;
            }
        }
    }
}

$dart$core.int parseFloatExponent([$dart$core.String string]) => $package$parseFloatExponent(string);

$dart$core.int $package$minRadix = 2;

$dart$core.int get minRadix => $package$minRadix;

$dart$core.int $package$maxRadix = 36;

$dart$core.int get maxRadix => $package$maxRadix;

$dart$core.int $package$parseInteger([$dart$core.String string, $dart$core.Object radix = $package$dart$default]) {
    if ($dart$core.identical(radix, $package$dart$default)) {
        radix = 10;
    }
    if (!(((radix as $dart$core.int) >= $package$minRadix) && ((radix as $dart$core.int) <= $package$maxRadix))) {
        throw new AssertionError("Violated: minRadix <= radix <= maxRadix");
    }
    $dart$core.int index = 0;
    $dart$core.int max = $package$runtime.minIntegerValue ~/ (radix as $dart$core.int);
    $dart$core.bool negative;
    {
        $dart$core.bool doElse$0 = true;
        {
            Character tmp$1 = String.instance(string).get(Integer.instance(index)) as Character;
            if (!(tmp$1 == null)) {
                Character char;
                char = tmp$1;
                doElse$0 = false;
                if (char.equals(new Character.$fromInt(45))) {
                    negative = true;
                    index = Integer.nativeValue(Integer.instance(index).successor);
                } else if (char.equals(new Character.$fromInt(43))) {
                    negative = false;
                    index = Integer.nativeValue(Integer.instance(index).successor);
                } else {
                    negative = false;
                }
            }
        }
        if (doElse$0) {
            return null;
        }
    }
    $dart$core.int limit = (($dart$core.int $lhs$) => $lhs$ == null ? Integer.nativeValue(Integer.instance($package$runtime.maxIntegerValue).negated) : $lhs$)(negative ? $package$runtime.minIntegerValue : null);
    $dart$core.int length = String.instance(string).size;
    $dart$core.int result = 0;
    $dart$core.int digitIndex = 0;
    while (index < length) {
        Character ch;
        {
            $dart$core.bool doElse$2 = true;
            {
                Character tmp$3 = String.instance(string).get(Integer.instance(index)) as Character;
                if (!(tmp$3 == null)) {
                    Character char;
                    char = tmp$3;
                    doElse$2 = false;
                    ch = char;
                }
            }
            if (doElse$2) {
                return null;
            }
        }
        if ((Integer.instance(index + 1).equals(Integer.instance(length)) && Integer.instance(radix as $dart$core.int).equals(Integer.instance(10))) && String.instance("kMGTP").contains(ch)) {{
                $dart$core.bool doElse$4 = true;
                {
                    $dart$core.int tmp$5 = $package$parseIntegerExponent(ch);
                    if (!(tmp$5 == null)) {
                        $dart$core.int exp;
                        exp = tmp$5;
                        doElse$4 = false;
                        $dart$core.int magnitude = Integer.nativeValue(Integer.instance(10).power(Integer.instance(exp)));
                        if ((limit ~/ magnitude) < result) {
                            result = result * magnitude;
                            break;
                        } else {
                            return null;
                        }
                    }
                }
                if (doElse$4) {
                    return null;
                }
            }
        } else {
            $dart$core.bool doElse$6 = true;
            {
                $dart$core.int tmp$7 = $package$parseDigit(ch, radix as $dart$core.int);
                if (!(tmp$7 == null)) {
                    $dart$core.int digit;
                    digit = tmp$7;
                    doElse$6 = false;
                    if (result < max) {
                        return null;
                    }
                    result = result * (radix as $dart$core.int);
                    if (result < (limit + digit)) {
                        return null;
                    }
                    result = result - digit;
                }
            }
            if (doElse$6) {
                return null;
            }
        }
        index = Integer.nativeValue(Integer.instance(index).successor);
        digitIndex = Integer.nativeValue(Integer.instance(digitIndex).successor);
    }
    if (Integer.instance(digitIndex).equals(Integer.instance(0))) {
        return null;
    } else {
        return (($dart$core.int $lhs$) => $lhs$ == null ? Integer.nativeValue(Integer.instance(result).negated) : $lhs$)(negative ? result : null);
    }
}

$dart$core.int parseInteger([$dart$core.String string, $dart$core.Object radix = $package$dart$default]) => $package$parseInteger(string, radix);

$dart$core.int $package$parseIntegerExponent([Character char]) {{
        Character switch$8 = char;
        if (switch$8.equals(new Character.$fromInt(80))) {
            return 15;
        } else if (switch$8.equals(new Character.$fromInt(84))) {
            return 12;
        } else if (switch$8.equals(new Character.$fromInt(71))) {
            return 9;
        } else if (switch$8.equals(new Character.$fromInt(77))) {
            return 6;
        } else if (switch$8.equals(new Character.$fromInt(107))) {
            return 3;
        } else {
            return null;
        }
    }
}

$dart$core.int parseIntegerExponent([Character char]) => $package$parseIntegerExponent(char);

$dart$core.int $package$aIntLower = (new Character.$fromInt(97)).integer;

$dart$core.int get aIntLower => $package$aIntLower;

$dart$core.int $package$aIntUpper = (new Character.$fromInt(65)).integer;

$dart$core.int get aIntUpper => $package$aIntUpper;

$dart$core.int $package$zeroInt = (new Character.$fromInt(48)).integer;

$dart$core.int get zeroInt => $package$zeroInt;

$dart$core.int $package$parseDigit([Character digit, $dart$core.int radix]) {
    $dart$core.int figure;
    $dart$core.int digitInt = digit.integer;
    if (((digitInt - $package$zeroInt) >= 0) && ((digitInt - $package$zeroInt) < 10)) {
        figure = digitInt - $package$zeroInt;
    } else if (((digitInt - $package$aIntLower) >= 0) && ((digitInt - $package$aIntLower) < 26)) {
        figure = (digitInt - $package$aIntLower) + 10;
    } else if (((digitInt - $package$aIntUpper) >= 0) && ((digitInt - $package$aIntUpper) < 26)) {
        figure = (digitInt - $package$aIntUpper) + 10;
    } else {
        return null;
    }
    return figure < radix ? figure : null;
}

$dart$core.int parseDigit([Character digit, $dart$core.int radix]) => $package$parseDigit(digit, radix);

$dart$core.Object $package$plus([$dart$core.Object x, $dart$core.Object y]) => (x as Summable).plus(y);

$dart$core.Object plus([$dart$core.Object x, $dart$core.Object y]) => $package$plus(x, y);

void $package$print([$dart$core.Object val]) => $package$process.writeLine($package$stringify(val));

void print([$dart$core.Object val]) => $package$print(val);

void $package$printAll([Iterable values, $dart$core.Object separator = $package$dart$default]) {
    if ($dart$core.identical(separator, $package$dart$default)) {
        separator = ", ";
    }
    $dart$core.bool first = true;
    values.each(new dart$Callable(([$dart$core.Object element]) {
        if (first) {
            first = false;
        } else {
            $package$process.write(separator as $dart$core.String);
        }
        $package$process.write($package$stringify(element));
    }));
    $package$process.write($package$operatingSystem.newline);
}

void printAll([Iterable values, $dart$core.Object separator = $package$dart$default]) => $package$printAll(values, separator);

$dart$core.String $package$stringify([$dart$core.Object val]) => (($dart$core.String $lhs$) => $lhs$ == null ? "<null>" : $lhs$)((($dart$core.Object $r$) => $r$ == null ? null : $r$.toString())(val));

$dart$core.String stringify([$dart$core.Object val]) => $package$stringify(val);

$dart$core.Object $package$product([Iterable values]) {
    $dart$core.Object product = values.first;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = values.rest.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            $dart$core.Object val = element$1;
            product = (product as Numeric).times(val);
        }
    }
    return product;
}

$dart$core.Object product([Iterable values]) => $package$product(values);

abstract class Range implements Sequence {
    Range() {}
    $dart$core.bool containsElement([$dart$core.Object element]);
    $dart$core.bool includesRange([Range range]);
    $dart$core.bool contains([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$0 = true;
        if (true) {
            doElse$0 = false;
            return containsElement(element);
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.bool occurs([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$1 = true;
        if (true) {
            doElse$1 = false;
            return containsElement(element);
        }
        if (doElse$1) {
            return false;
        }
    })();
    Range shifted([$dart$core.int shift]);
    $dart$core.bool get increasing;
    $dart$core.bool get decreasing;
    Range get coalesced => this;
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.Object get first => Sequence.$get$first(this);
    $dart$core.Object get last => Sequence.$get$last(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get size => Sequence.$get$size(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequential get rest => Sequence.$get$rest(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential measure([Integer from, $dart$core.int length]) => Sequence.$measure(this, from, length);
    Sequential span([Integer from, Integer to]) => Sequence.$span(this, from, to);
    Sequential spanFrom([Integer from]) => Sequence.$spanFrom(this, from);
    Sequential spanTo([Integer to]) => Sequence.$spanTo(this, to);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    Iterator iterator() => Iterable.$iterator(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Ranged implements Iterable {
    $dart$core.Object span([$dart$core.Object from, $dart$core.Object to]);
    $dart$core.Object spanFrom([$dart$core.Object from]);
    $dart$core.Object spanTo([$dart$core.Object to]);
    $dart$core.Object measure([$dart$core.Object from, $dart$core.int length]);
}
abstract class Resource {
    $dart$core.String get name;
    static $dart$core.String $get$name([final Resource $this]) {
        $dart$core.int pos = String.instance($this.uri).lastOccurrence(new Character.$fromInt(47));
        if (!(pos == null)) {
            return String.nativeValue(String.instance($this.uri).spanFrom(Integer.instance(pos + 1)));
        }
        return $this.uri;
    }
    $dart$core.int get size;
    $dart$core.String get uri;
    $dart$core.String textContent([$dart$core.Object encoding = $package$dart$default]);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Resource $this]) => ((("" + $package$className($this)) + "[") + $this.uri) + "]";
}
abstract class Scalable {
    $dart$core.Object scale([$dart$core.Object scalar]);
}
class Sequence$collect$list_ implements List {
    Sequence $outer$ceylon$language$Sequence;
    Callable $capture$Sequence$collect$collecting;
    Sequence$collect$list_([Sequence this.$outer$ceylon$language$Sequence, Callable this.$capture$Sequence$collect$collecting]) {}
    $dart$core.int get lastIndex => $outer$ceylon$language$Sequence.lastIndex;
    $dart$core.int get size => $outer$ceylon$language$Sequence.size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index < size)) {
            return collecting.$delegate$(Sequence.$getElement($outer$ceylon$language$Sequence, index));
        } else {
            return null;
        }
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    List clone() => List.$clone(this);
    Iterator iterator() => List.$iterator(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    List initial([$dart$core.int length]) => List.$initial(this, length);
    List terminal([$dart$core.int length]) => List.$terminal(this, length);
    List span([Integer from, Integer to]) => List.$span(this, from, to);
    List spanFrom([Integer from]) => List.$spanFrom(this, from);
    List spanTo([Integer to]) => List.$spanTo(this, to);
    List measure([Integer from, $dart$core.int length]) => List.$measure(this, from, length);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    Iterable get permutations => List.$get$permutations(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Sequence$Reverse$$anonymous$0_ implements Iterator {
    Sequence$Reverse $outer$ceylon$language$Sequence$Reverse;
    Sequence $capture$$outerList;
    Sequence$Reverse$$anonymous$0_([Sequence$Reverse this.$outer$ceylon$language$Sequence$Reverse, Sequence this.$capture$$outerList]) {
        index = $capture$$outerList.size - 1;
    }
    $dart$core.int index;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? Sequence.$getElement($capture$$outerList, (() {
        $dart$core.int tmp$8 = index;
        index = Integer.nativeValue(Integer.instance(index).predecessor);
        return tmp$8;
    })()) : $lhs$)(index < 0 ? $package$finished : null);
    $dart$core.String toString() => ("" + $outer$ceylon$language$Sequence$Reverse.toString()) + ".iterator()";
}
class Sequence$Reverse implements Sequence {
    Sequence $outer$ceylon$language$Sequence;
    Sequence$Reverse([Sequence this.$outer$ceylon$language$Sequence]) {}
    $dart$core.int get size => $outer$ceylon$language$Sequence.size;
    $dart$core.Object get first => $outer$ceylon$language$Sequence.last;
    $dart$core.Object get last => $outer$ceylon$language$Sequence.first;
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? $outer$ceylon$language$Sequence.span(Integer.instance(size - 2), Integer.instance(0)) : $lhs$)(Integer.instance(size).equals(Integer.instance(1)) ? $package$empty : null);
    Sequence get reversed => $outer$ceylon$language$Sequence;
    $dart$core.Object getFromFirst([$dart$core.int index]) => $outer$ceylon$language$Sequence.getFromFirst((size - 1) - index);
    Sequential measure([$dart$core.int from, $dart$core.int length]) => (() {
        if (length > 0) {
            return (() {
                $dart$core.int start = (size - 1) - from;
                return $outer$ceylon$language$Sequence.span(Integer.instance(start), Integer.instance((start - length) + 1));
            })();
        } else {
            return $package$empty;
        }
    })();
    Sequential span([$dart$core.int from, $dart$core.int to]) => $outer$ceylon$language$Sequence.span(Integer.instance(to), Integer.instance(from));
    Sequential spanFrom([$dart$core.int from]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if (from <= endIndex) {
                return $outer$ceylon$language$Sequence.span(Integer.instance(endIndex - from), Integer.instance(0));
            } else {
                return $package$empty;
            }
        })();
    })();
    Sequential spanTo([$dart$core.int to]) => (() {
        if (to >= 0) {
            return (() {
                $dart$core.int endIndex = size - 1;
                return $outer$ceylon$language$Sequence.span(Integer.instance(endIndex), Integer.instance(endIndex - to));
            })();
        } else {
            return $package$empty;
        }
    })();
    Iterator iterator() => (() {
        Sequence outerList = $outer$ceylon$language$Sequence;
        return new Sequence$Reverse$$anonymous$0_(this, outerList);
    })();
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Sequence$Repeat implements Sequence {
    Sequence $outer$ceylon$language$Sequence;
    Sequence$Repeat([Sequence this.$outer$ceylon$language$Sequence, $dart$core.int this.times]) {
        if (!(times > 0)) {
            throw new AssertionError("Violated: times>0");
        }
    }
    $dart$core.int times;
    $dart$core.Object get last => $outer$ceylon$language$Sequence.last;
    $dart$core.Object get first => $outer$ceylon$language$Sequence.first;
    $dart$core.int get size => $outer$ceylon$language$Sequence.size * times;
    Sequential get rest => sublistFrom(1).sequence();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size = $outer$ceylon$language$Sequence.size;
        return (() {
            if (index < (size * times)) {
                return $outer$ceylon$language$Sequence.getFromFirst(Integer.nativeValue(Integer.instance(index).remainder(Integer.instance(size))));
            } else {
                return null;
            }
        })();
    })();
    Iterator iterator() => new CycledIterator($outer$ceylon$language$Sequence, times);
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential measure([Integer from, $dart$core.int length]) => Sequence.$measure(this, from, length);
    Sequential span([Integer from, Integer to]) => Sequence.$span(this, from, to);
    Sequential spanFrom([Integer from]) => Sequence.$spanFrom(this, from);
    Sequential spanTo([Integer to]) => Sequence.$spanTo(this, to);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Sequence implements Sequential, Iterable {
    $dart$core.Object get first;
    $dart$core.Object get last;
    $dart$core.bool get empty;
    static $dart$core.bool $get$empty([final Sequence $this]) => false;
    $dart$core.int get size;
    $dart$core.int get lastIndex;
    static $dart$core.int $get$lastIndex([final Sequence $this]) => $this.size - 1;
    Range get keys;
    static Range $get$keys([final Sequence $this]) => $this.indexes();
    Range indexes();
    static Range $indexes([final Sequence $this]) => $package$span(Integer.instance(0), Integer.instance($this.lastIndex));
    Sequence sequence();
    static Sequence $sequence([final Sequence $this]) => $this;
    Sequential get rest;
    Sequence get reversed;
    static Sequence $get$reversed([final Sequence $this]) => new Sequence$Reverse($this);
    Sequential repeat([$dart$core.int times]);
    static Sequential $repeat([final Sequence $this, $dart$core.int times]) => ((Sequential $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(times > 0 ? new Sequence$Repeat($this, times) : null);
    Sequence clone();
    static Sequence $clone([final Sequence $this]) => $this;
    Sequence sort([Callable comparing]);
    static Sequence $sort([final Sequence $this, Callable comparing]) {
        Array array = new Array($this);
        array.sortInPlace(comparing);
        return new ArraySequence(array);
    }
    Sequence collect([Callable collecting]);
    static Sequence $collect([final Sequence $this, Callable collecting]) {
        final Sequence$collect$list_ list = new Sequence$collect$list_($this, collecting);
        return new ArraySequence(new Array(list));
    }
    Tuple withLeading([$dart$core.Object element]);
    static Tuple $withLeading([final Sequence $this, $dart$core.Object element]) => new Tuple.$withList([element], $this);
    Sequence withTrailing([$dart$core.Object element]);
    static Sequence $withTrailing([final Sequence $this, $dart$core.Object element]) => new JoinedSequence($this, new Singleton(element));
    Sequence append([Sequential elements]);
    static Sequence $append([final Sequence $this, Sequential elements]) => (() {
        $dart$core.bool doElse$0 = true;
        if (elements is Sequence) {
            Sequence elements$2;
            elements$2 = elements as Sequence;
            doElse$0 = false;
            return new JoinedSequence($this, elements$2);
        }
        if (doElse$0) {
            Empty elements$1;
            elements$1 = elements as Empty;
            return $this;
        }
    })();
    Sequence prepend([Sequential elements]);
    static Sequence $prepend([final Sequence $this, Sequential elements]) => (() {
        $dart$core.bool doElse$3 = true;
        if (elements is Sequence) {
            Sequence elements$5;
            elements$5 = elements as Sequence;
            doElse$3 = false;
            return new JoinedSequence(elements$5, $this);
        }
        if (doElse$3) {
            Empty elements$4;
            elements$4 = elements as Empty;
            return $this;
        }
    })();
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Sequence $this, $dart$core.Object element]) => List.$contains($this, element);
    $dart$core.bool shorterThan([$dart$core.int length]);
    static $dart$core.bool $shorterThan([final Sequence $this, $dart$core.int length]) => List.$shorterThan($this, length);
    $dart$core.bool longerThan([$dart$core.int length]);
    static $dart$core.bool $longerThan([final Sequence $this, $dart$core.int length]) => List.$longerThan($this, length);
    $dart$core.Object find([Callable selecting]);
    static $dart$core.Object $find([final Sequence $this, Callable selecting]) => List.$find($this, selecting);
    $dart$core.Object findLast([Callable selecting]);
    static $dart$core.Object $findLast([final Sequence $this, Callable selecting]) => List.$findLast($this, selecting);
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final Sequence $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)), $this.spanFrom(Integer.instance(index))], null);
    Sequential measure([Integer from, $dart$core.int length]);
    static Sequential $measure([final Sequence $this, Integer from, $dart$core.int length]) => $this.sublist(Integer.nativeValue(from), (Integer.nativeValue(from) + length) - 1).sequence();
    Sequential span([Integer from, Integer to]);
    static Sequential $span([final Sequence $this, Integer from, Integer to]) => $this.sublist(Integer.nativeValue(from), Integer.nativeValue(to)).sequence();
    Sequential spanFrom([Integer from]);
    static Sequential $spanFrom([final Sequence $this, Integer from]) => $this.sublistFrom(Integer.nativeValue(from)).sequence();
    Sequential spanTo([Integer to]);
    static Sequential $spanTo([final Sequence $this, Integer to]) => $this.sublistTo(Integer.nativeValue(to)).sequence();
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequence $this]) => (($dart$core.String $lhs$) => $lhs$ == null ? ("[" + $package$commaList($this)) + "]" : $lhs$)($this.empty ? "[]" : null);
    $dart$core.Object getElement([$dart$core.int index]);
    static $dart$core.Object $getElement([final Sequence $this, $dart$core.int index]) {{
            $dart$core.bool doElse$6 = true;
            {
                $dart$core.Object tmp$7 = $this.getFromFirst(index);
                if (!(tmp$7 == null)) {
                    $dart$core.Object element;
                    element = tmp$7;
                    doElse$6 = false;
                    return element;
                }
            }
            if (doElse$6) {
                if (!true) {
                    throw new AssertionError("Violated: is Element null");
                }
                return null;
            }
        }
    }
}
Sequence $package$sequence([Iterable elements]) {{
        $dart$core.bool doElse$9 = true;
        {
            Sequential tmp$10 = elements.sequence();
            if (tmp$10 is Sequence) {
                Sequence sequence;
                sequence = tmp$10 as Sequence;
                doElse$9 = false;
                return sequence;
            }
        }
        if (doElse$9) {
            if (!true) {
                throw new AssertionError("Violated: is Absent null");
            }
            return null as Sequence;
        }
    }
}

Sequence sequence([Iterable elements]) => $package$sequence(elements);

class JoinedSequence implements Sequence {
    JoinedSequence([Sequence this.firstSeq, Sequence this.secondSeq]) {}
    Sequence firstSeq;
    Sequence secondSeq;
    $dart$core.int get size => firstSeq.size + secondSeq.size;
    $dart$core.Object get first => firstSeq.first;
    $dart$core.Object get last => secondSeq.last;
    Sequential get rest => firstSeq.rest.append(secondSeq);
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int cutover = firstSeq.size;
        return (() {
            if (index < cutover) {
                return firstSeq.getFromFirst(index);
            } else {
                return secondSeq.getFromFirst(index - cutover);
            }
        })();
    })();
    Tuple slice([$dart$core.int index]) => (() {
        if (Integer.instance(index).equals(Integer.instance(firstSeq.size))) {
            return new Tuple.$withList([firstSeq, secondSeq], null);
        } else {
            return Sequence.$slice(this, index);
        }
    })();
    Sequential spanTo([$dart$core.int to]) => (() {
        if (Integer.instance(to).equals(Integer.instance(firstSeq.size - 1))) {
            return firstSeq;
        } else {
            return Sequence.$spanTo(this, Integer.instance(to));
        }
    })();
    Sequential spanFrom([$dart$core.int from]) => (() {
        if (Integer.instance(from).equals(Integer.instance(firstSeq.size))) {
            return secondSeq;
        } else {
            return Sequence.$spanFrom(this, Integer.instance(from));
        }
    })();
    Sequential measure([Integer from, $dart$core.int length]) {
        if (from.equals(Integer.instance(0)) && Integer.instance(length).equals(Integer.instance(firstSeq.size))) {
            return firstSeq;
        } else if (from.equals(Integer.instance(firstSeq.size)) && (length >= secondSeq.size)) {
            return secondSeq;
        } else {
            return Sequence.$measure(this, from, length);
        }
    }
    Sequential span([Integer from, Integer to]) {
        if ((Integer.nativeValue(from) <= 0) && to.equals(Integer.instance(firstSeq.size - 1))) {
            return firstSeq;
        } else if (from.equals(Integer.instance(firstSeq.size)) && (Integer.nativeValue(to) >= (size - 1))) {
            return secondSeq;
        } else {
            return Sequence.$span(this, from, to);
        }
    }
    Iterator iterator() => new ChainedIterator(firstSeq, secondSeq);
    $dart$core.bool equals([$dart$core.Object that]) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.String toString() => Sequence.$get$string(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    $dart$core.int get lastIndex => Sequence.$get$lastIndex(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class SequencedAnnotation implements ConstrainedAnnotation {
}
abstract class Sequential implements List, Ranged {
    $dart$core.int get size;
    Sequential get keys;
    static Sequential $get$keys([final Sequential $this]) => $package$measure(Integer.instance(0), $this.size) as Sequential;
    Sequential sequence();
    static Sequential $sequence([final Sequential $this]) => $this;
    Sequential get rest;
    Sequential get reversed;
    Sequential repeat([$dart$core.int times]);
    Sequential initial([$dart$core.int length]);
    static Sequential $initial([final Sequential $this, $dart$core.int length]) => $this.spanTo(Integer.instance(length - 1)) as Sequential;
    Sequential terminal([$dart$core.int length]);
    static Sequential $terminal([final Sequential $this, $dart$core.int length]) => $this.spanFrom(Integer.instance($this.size - length)) as Sequential;
    Sequential clone();
    static Sequential $clone([final Sequential $this]) => $this;
    Sequential trim([Callable trimming]);
    static Sequential $trim([final Sequential $this, Callable trimming]) => List.$trim($this, trimming).sequence();
    Sequential trimLeading([Callable trimming]);
    static Sequential $trimLeading([final Sequential $this, Callable trimming]) => List.$trimLeading($this, trimming).sequence();
    Sequential trimTrailing([Callable trimming]);
    static Sequential $trimTrailing([final Sequential $this, Callable trimming]) => List.$trimTrailing($this, trimming).sequence();
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final Sequential $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)) as Sequential, $this.spanFrom(Integer.instance(index)) as Sequential], null);
    Tuple withLeading([$dart$core.Object element]);
    Sequence withTrailing([$dart$core.Object element]);
    Sequential append([Sequential elements]);
    Sequential prepend([Sequential elements]);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequential $this]) => (($dart$core.String $lhs$) => $lhs$ == null ? ("[" + $package$commaList($this)) + "]" : $lhs$)($this.empty ? "[]" : null);
}
serialization$DeserializationContext $package$serialization$deserialization() => new serialization$DeserializationContextImpl();

serialization$DeserializationContext deserialization() => $package$deserialization();

abstract class serialization$DeserializationContext {
    void instance([$dart$core.Object instanceId, meta$model$ClassModel clazz]);
    void memberInstance([$dart$core.Object containerId, $dart$core.Object instanceId]);
    void attribute([$dart$core.Object instanceId, meta$declaration$ValueDeclaration attribute, $dart$core.Object attributeValueId]);
    void element([$dart$core.Object instanceId, $dart$core.int index, $dart$core.Object elementValueId]);
    void instanceValue([$dart$core.Object instanceId, $dart$core.Object instanceValue]);
    $dart$core.Object reconstruct([$dart$core.Object instanceId]);
}
abstract class serialization$Element implements serialization$ReachableReference {
    $dart$core.int get index;
}
abstract class serialization$Member implements serialization$ReachableReference {
    meta$declaration$ValueDeclaration get attribute;
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$Outer implements serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$References implements Iterable {
    $dart$core.Object get instance;
    Iterable get references;
}
serialization$SerializationContext $package$serialization$serialization() => new serialization$SerializationContextImpl();

serialization$SerializationContext serialization() => $package$serialization();

abstract class serialization$SerializationContext {
    serialization$References references([$dart$core.Object instance]);
}
abstract class Set implements Collection {
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Set $this, $dart$core.Object element]) => Collection.$contains($this, element);
    Set clone();
    $dart$core.bool superset([Set set]);
    static $dart$core.bool $superset([final Set $this, Set set]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = set.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object element = element$1;
                if (!$this.contains(element)) {
                    return false;
                }
            }
            {
                return true;
            }
        }
    }
    $dart$core.bool subset([Set set]);
    static $dart$core.bool $subset([final Set $this, Set set]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = $this.iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                $dart$core.Object element = element$3;
                if (!set.contains(element)) {
                    return false;
                }
            }
            {
                return true;
            }
        }
    }
    $dart$core.bool equals([$dart$core.Object that]);
    static $dart$core.bool $equals([final Set $this, $dart$core.Object that]) {
        if (that is Set) {
            Set that$4;
            that$4 = that as Set;
            if (Integer.instance(that$4.size).equals(Integer.instance($this.size))) {{
                    $dart$core.Object element$6;
                    Iterator iterator$5 = $this.iterator();
                    while ((element$6 = iterator$5.next()) is !Finished) {
                        $dart$core.Object element = element$6;
                        if (!that$4.contains(element)) {
                            return false;
                        }
                    }
                    {
                        return true;
                    }
                }
            }
        }
        return false;
    }
    $dart$core.int get hashCode;
    static $dart$core.int $get$hash([final Set $this]) {
        $dart$core.int hashCode = 0;
        {
            $dart$core.Object element$8;
            Iterator iterator$7 = $this.iterator();
            while ((element$8 = iterator$7.next()) is !Finished) {
                $dart$core.Object elem = element$8;
                hashCode = hashCode + elem.hashCode;
            }
        }
        return hashCode;
    }
    Set union([Set set]);
    Set intersection([Set set]);
    Set exclusiveUnion([Set set]);
    Set complement([Set set]);
}
class emptySet_ implements Set {
    emptySet_() {}
    Set union([Set set]) => set;
    Set intersection([Set set]) => this;
    Set exclusiveUnion([Set set]) => set;
    Set complement([Set set]) => this;
    $dart$core.bool subset([Set set]) => true;
    $dart$core.bool superset([Set set]) => set.empty;
    Set clone() => this;
    Iterator iterator() => $package$emptyIterator;
    $dart$core.int get size => 0;
    $dart$core.bool get empty => true;
    $dart$core.bool contains([$dart$core.Object element]) => false;
    $dart$core.bool containsAny([Iterable elements]) => false;
    $dart$core.bool containsEvery([Iterable elements]) => false;
    $dart$core.int count([Callable selecting]) => 0;
    $dart$core.bool any([Callable selecting]) => false;
    $dart$core.bool every([Callable selecting]) => true;
    $dart$core.Object find([Callable selecting]) => null;
    $dart$core.Object findLast([Callable selecting]) => null;
    Iterable skip([$dart$core.int skipping]) => this;
    Iterable take([$dart$core.int taking]) => this;
    Iterable by([$dart$core.int step]) => this;
    void each([Callable step]) {}
    $dart$core.bool equals([$dart$core.Object that]) => Set.$equals(this, that);
    $dart$core.int get hashCode => Set.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get first => Iterable.$get$first(this);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
}
final emptySet_ $package$emptySet = new emptySet_();

emptySet_ get emptySet => $package$emptySet;

Callable $package$shuffle([Callable f]) => $package$flatten(new dart$Callable(([$dart$core.Object secondArgs]) => $package$flatten(new dart$Callable(([$dart$core.Object firstArgs]) => $package$unflatten($package$unflatten(f).$delegate$(firstArgs) as Callable).$delegate$(secondArgs)))));

Callable shuffle([Callable f]) => $package$shuffle(f);

class Singleton$iterator$$anonymous$0_ implements Iterator {
    Singleton $outer$ceylon$language$Singleton;
    Singleton$iterator$$anonymous$0_([Singleton this.$outer$ceylon$language$Singleton]) {
        done = false;
    }
    $dart$core.bool done;
    $dart$core.Object next() {
        if (done) {
            return $package$finished;
        } else {
            done = true;
            return $outer$ceylon$language$Singleton.element;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Singleton.toString()) + ".iterator()";
}
class Singleton implements Sequence {
    Singleton([$dart$core.Object this.element]) {}
    $dart$core.Object element;
    $dart$core.Object get first => element;
    $dart$core.Object get last => element;
    $dart$core.int get lastIndex => 0;
    $dart$core.int get size => 1;
    Empty get rest => $package$empty;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (Integer.instance(index).equals(Integer.instance(0))) {
            return element;
        } else {
            return null;
        }
    })();
    Singleton get reversed => this;
    Singleton clone() => this;
    $dart$core.bool contains([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.Object tmp$1 = this.element;
            if (!(tmp$1 == null)) {
                $dart$core.Object e;
                e = tmp$1;
                doElse$0 = false;
                return e.equals(element);
            }
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.String toString() => ("[" + $package$stringify(element)) + "]";
    Iterator iterator() => new Singleton$iterator$$anonymous$0_(this);
    $dart$core.bool equals([$dart$core.Object that]) {{
            $dart$core.bool doElse$2 = true;
            if (that is List) {
                List that$3;
                that$3 = that as List;
                if (Integer.instance(that$3.size).equals(Integer.instance(1))) {
                    doElse$2 = false;
                    $dart$core.Object elem = that$3.first;
                    return (() {
                        $dart$core.bool doElse$4 = true;
                        if (!(element == null)) {
                            if (!(elem == null)) {
                                doElse$4 = false;
                                return elem.equals(element);
                            }
                        }
                        if (doElse$4) {
                            return (!(!(element == null))) && (!(!(elem == null)));
                        }
                    })();
                }
            }
            if (doElse$2) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode => 31 + (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)((($dart$core.Object $r$) => $r$ == null ? null : $r$.hashCode)(element));
    $dart$core.Object measure([Integer from, $dart$core.int length]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)((Integer.nativeValue(from) <= 0) && ((Integer.nativeValue(from) + length) > 0) ? this : null);
    $dart$core.Object span([Integer from, Integer to]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(((Integer.nativeValue(from) <= 0) && (Integer.nativeValue(to) >= 0)) || ((Integer.nativeValue(from) >= 0) && (Integer.nativeValue(to) <= 0)) ? this : null);
    $dart$core.Object spanTo([Integer to]) => (($dart$core.Object $lhs$) => $lhs$ == null ? this : $lhs$)(Integer.nativeValue(to) < 0 ? $package$empty : null);
    $dart$core.Object spanFrom([Integer from]) => (($dart$core.Object $lhs$) => $lhs$ == null ? this : $lhs$)(Integer.nativeValue(from) > 0 ? $package$empty : null);
    $dart$core.int count([Callable selecting]) => (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)(Boolean.nativeValue(selecting.$delegate$(element) as Boolean) ? 1 : null);
    Singleton map([Callable collecting]) => new Singleton(collecting.$delegate$(element));
    $dart$core.Object filter([Callable selecting]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(Boolean.nativeValue(selecting.$delegate$(element) as Boolean) ? this : null);
    Callable fold([$dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) => accumulating.$delegate$(initial, element));
    $dart$core.Object reduce([Callable accumulating]) => element;
    Singleton collect([Callable collecting]) => new Singleton(collecting.$delegate$(element));
    $dart$core.Object select([Callable selecting]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(Boolean.nativeValue(selecting.$delegate$(element) as Boolean) ? this : null);
    $dart$core.Object find([Callable selecting]) => (() {
        $dart$core.bool doElse$5 = true;
        if (!(element == null)) {
            if (Boolean.nativeValue(selecting.$delegate$(element) as Boolean)) {
                doElse$5 = false;
                return element;
            }
        }
        if (doElse$5) {
            return null;
        }
    })();
    $dart$core.Object findLast([Callable selecting]) => find(selecting);
    Singleton sort([Callable comparing]) => this;
    $dart$core.bool any([Callable selecting]) => Boolean.nativeValue(selecting.$delegate$(element) as Boolean);
    $dart$core.bool every([Callable selecting]) => Boolean.nativeValue(selecting.$delegate$(element) as Boolean);
    $dart$core.Object skip([$dart$core.int skipping]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(skipping < 1 ? this : null);
    $dart$core.Object take([$dart$core.int taking]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(taking > 0 ? this : null);
    $dart$core.Object get coalesced => (() {
        $dart$core.bool doElse$6 = true;
        if (!(element == null)) {
            doElse$6 = false;
            return new Singleton(element);
        }
        if (doElse$6) {
            return $package$empty;
        }
    })();
    Iterable chain([Iterable other]) => other.follow(element);
    void each([Callable step]) => step.$delegate$(element);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    $dart$core.bool includes([List sublist]) => List.$includes(this, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    $dart$core.bool occurs([$dart$core.Object element]) => List.$occurs(this, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
$dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (($dart$core.Object $lhs$) => $lhs$ == null ? y : $lhs$)((x as Comparable).smallerThan(y) ? x : null);

$dart$core.Object smallest([$dart$core.Object x, $dart$core.Object y]) => $package$smallest(x, y);

Sequential $package$sort([Iterable elements]) {
    Array array = new Array(elements);
    if (array.empty) {
        return $package$empty;
    } else {
        array.sortInPlace($package$byIncreasing(new dart$Callable($package$identity)));
        return new ArraySequence(array);
    }
}

Sequential sort([Iterable elements]) => $package$sort(elements);

class Span$iterator$$anonymous$0_ implements Iterator {
    Span $outer$ceylon$language$Span;
    Span$iterator$$anonymous$0_([Span this.$outer$ceylon$language$Span]) {
        firstTime = true;
        element = $outer$ceylon$language$Span.first;
    }
    $dart$core.bool firstTime;
    $dart$core.Object element;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object c$1 = element;
                if (!(c$1 is Finished)) {
                    $dart$core.Object c;
                    c = c$1;
                    doElse$0 = false;
                    $dart$core.Object result;
                    if (firstTime) {
                        firstTime = false;
                        result = c;
                    } else {
                        result = $outer$ceylon$language$Span.next(c);
                    }
                    if (Integer.instance((result as Enumerable).offset($outer$ceylon$language$Span.last)).equals(Integer.instance(0))) {
                        element = $package$finished;
                    } else {
                        element = result;
                    }
                    return result;
                }
            }
            if (doElse$0) {
                return element;
            }
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Span.toString()) + ").iterator()";
}
class Span$By$iterator$$anonymous$1_ implements Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$1_([Span$By this.$outer$ceylon$language$Span$By]) {
        count = 0;
        current = $outer$ceylon$language$Span$By.first;
    }
    $dart$core.int count;
    $dart$core.Object current;
    $dart$core.Object next() {
        if ((count = Integer.nativeValue(Integer.instance(count).successor)) > $outer$ceylon$language$Span$By.size) {
            return $package$finished;
        } else {
            $dart$core.Object result = current;
            current = (current as Enumerable).neighbour($outer$ceylon$language$Span$By.step);
            return result;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By$iterator$$anonymous$2_ implements Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$2_([Span$By this.$outer$ceylon$language$Span$By]) {
        current = $outer$ceylon$language$Span$By.first;
        firstTime = true;
    }
    $dart$core.Object current;
    $dart$core.bool firstTime;
    $dart$core.Object next() {
        if (firstTime) {
            firstTime = false;
            return current;
        } else {{
                $dart$core.Object c$11 = current;
                if (true) {
                    $dart$core.Object c;
                    c = c$11;
                    $dart$core.Object r = $outer$ceylon$language$Span$By.$outer$ceylon$language$Span.nextStep(c, $outer$ceylon$language$Span$By.step);
                    if (!$outer$ceylon$language$Span$By.$outer$ceylon$language$Span.containsElement(r)) {
                        current = $package$finished;
                    } else {
                        current = r;
                    }
                }
            }
            return current;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By implements Iterable {
    Span $outer$ceylon$language$Span;
    Span$By([Span this.$outer$ceylon$language$Span, $dart$core.int this.step]) {}
    $dart$core.int step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Span.size - 1) ~/ step);
    $dart$core.Object get first => $outer$ceylon$language$Span.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Span.toString()) + ").by(") + Integer.instance(step).toString()) + ")";
    Iterator iterator() {
        if ($outer$ceylon$language$Span.recursive) {
            return new Span$By$iterator$$anonymous$1_(this);
        } else {
            return new Span$By$iterator$$anonymous$2_(this);
        }
    }
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
    $dart$core.bool get empty => Iterable.$get$empty(this);
    $dart$core.bool longerThan([$dart$core.int length]) => Iterable.$longerThan(this, length);
    $dart$core.bool shorterThan([$dart$core.int length]) => Iterable.$shorterThan(this, length);
    $dart$core.Object get last => Iterable.$get$last(this);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    Sequential sequence() => Iterable.$sequence(this);
    $dart$core.Object indexes() => Iterable.$indexes(this);
    Iterable get rest => Iterable.$get$rest(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    void each([Callable step]) => Iterable.$each(this, step);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    $dart$core.Object find([Callable selecting]) => Iterable.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Iterable.$findLast(this, selecting);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential sort([Callable comparing]) => Iterable.$sort(this, comparing);
    Sequential collect([Callable collecting]) => Iterable.$collect(this, collecting);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.int count([Callable selecting]) => Iterable.$count(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable repeat([$dart$core.int times]) => Iterable.$repeat(this, times);
    Iterable by([$dart$core.int step]) => Iterable.$by(this, step);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Span  extends Range {
    Span([$dart$core.Object this.first, $dart$core.Object this.last]) {
        recursive = ((first as Enumerable).offsetSign((first as Enumerable).successor) > 0) && (((last as Enumerable).predecessor as Enumerable).offsetSign(last) > 0);
    }
    $dart$core.Object first;
    $dart$core.Object last;
    $dart$core.String toString() => (first.toString() + "..") + last.toString();
    $dart$core.bool get increasing => (last as Enumerable).offsetSign(first) >= 0;
    $dart$core.bool get decreasing => !increasing;
    $dart$core.bool recursive;
    $dart$core.Object next([$dart$core.Object x]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (x as Enumerable).predecessor : $lhs$)(increasing ? (x as Enumerable).successor : null);
    $dart$core.Object nextStep([$dart$core.Object x, $dart$core.int step]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (x as Enumerable).neighbour(Integer.nativeValue(Integer.instance(step).negated)) : $lhs$)(increasing ? (x as Enumerable).neighbour(step) : null);
    $dart$core.Object fromFirst([$dart$core.int offset]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (first as Enumerable).neighbour(Integer.nativeValue(Integer.instance(offset).negated)) : $lhs$)(increasing ? (first as Enumerable).neighbour(offset) : null);
    $dart$core.bool afterLast([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(last) < 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(last) > 0 : null);
    $dart$core.bool beforeLast([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(last) > 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(last) < 0 : null);
    $dart$core.bool beforeFirst([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(first) > 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(first) < 0 : null);
    $dart$core.bool afterFirst([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(first) < 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(first) > 0 : null);
    $dart$core.int get size {
        $dart$core.int lastIndex = Integer.nativeValue(Integer.instance((last as Enumerable).offset(first)).magnitude);
        if (lastIndex < $package$runtime.maxIntegerValue) {
            return lastIndex + 1;
        } else {
            if (!false) {
                throw new AssertionError("Violated: false");
            }
        }
    }
    $dart$core.bool longerThan([$dart$core.int length]) => (() {
        if (length < 1) {
            return true;
        } else {
            return (() {
                if (recursive) {
                    return size > length;
                } else {
                    return beforeLast(fromFirst(length - 1));
                }
            })();
        }
    })();
    $dart$core.bool shorterThan([$dart$core.int length]) => (() {
        if (length < 1) {
            return true;
        } else {
            return (() {
                if (recursive) {
                    return size < length;
                } else {
                    return afterLast(fromFirst(length - 1));
                }
            })();
        }
    })();
    $dart$core.int get lastIndex => size - 1;
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? $package$span(next(first), last) : $lhs$)(first.equals(last) ? $package$empty : null);
    $dart$core.Object getFromFirst([$dart$core.int index]) {
        if (index < 0) {
            return null;
        } else if (recursive) {
            return index < size ? fromFirst(index) : null;
        } else {
            $dart$core.Object result = fromFirst(index);
            return !afterLast(result) ? result : null;
        }
    }
    Iterator iterator() => new Span$iterator$$anonymous$0_(this);
    Iterable by([$dart$core.int step]) {
        if (!(step > 0)) {
            throw new AssertionError("Violated: step > 0");
        }
        return ((Iterable $lhs$) => $lhs$ == null ? new Span$By(this, step) : $lhs$)(Integer.instance(step).equals(Integer.instance(1)) ? this : null);
    }
    Range shifted([$dart$core.int shift]) => ((Range $lhs$) => $lhs$ == null ? new Span((first as Enumerable).neighbour(shift), (last as Enumerable).neighbour(shift)) : $lhs$)(Integer.instance(shift).equals(Integer.instance(0)) ? this : null);
    $dart$core.bool containsElement([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (!afterLast(x)) && (!beforeFirst(x)) : $lhs$)(recursive ? (x as Enumerable).offset(first) <= (last as Enumerable).offset(first) : null);
    $dart$core.int count([Callable selecting]) {
        $dart$core.Object element = first;
        $dart$core.int count = 0;
        while (containsElement(element)) {
            if (Boolean.nativeValue(selecting.$delegate$(element) as Boolean)) {
                count = Integer.nativeValue(Integer.instance(count).successor);
            }
            element = next(element);
        }
        return count;
    }
    $dart$core.bool includes([List sublist]) {
        if (sublist.empty) {
            return true;
        } else {
            $dart$core.bool doElse$2 = true;
            if (sublist is Range) {
                Range sublist$3;
                sublist$3 = sublist as Range;
                doElse$2 = false;
                return includesRange(sublist$3);
            }
            if (doElse$2) {
                return List.$includes(this, sublist);
            }
        }
    }
    $dart$core.bool includesRange([Range range]) {{
            Range switch$4 = range;
            if (switch$4 is Span) {
                Span range$5;
                range$5 = range as Span;
                if (recursive) {
                    return ((range$5.first as Enumerable).offset(first) < size) && ((range$5.last as Enumerable).offset(first) < size);
                } else {
                    return (Boolean.instance(increasing).equals(Boolean.instance(range$5.increasing)) && (!range$5.afterFirst(first))) && (!range$5.beforeLast(last));
                }
            } else if (switch$4 is Measure) {
                Measure range$6;
                range$6 = range as Measure;
                if (decreasing) {
                    return false;
                } else {
                    $dart$core.int offset = (range$6.first as Enumerable).offset(first);
                    return (offset >= 0) && (offset <= (size - range$6.size));
                }
            } else {
                throw new AssertionError("Supposedly exhaustive switch was not exhaustive");
            }
        }
    }
    $dart$core.bool equals([$dart$core.Object that]) {{
            $dart$core.bool doElse$7 = true;
            if (that is Span) {
                Span that$8;
                that$8 = that as Span;
                doElse$7 = false;
                return that$8.first.equals(first) && that$8.last.equals(last);
            }
            if (doElse$7) {{
                    $dart$core.bool doElse$9 = true;
                    if (that is Measure) {
                        Measure that$10;
                        that$10 = that as Measure;
                        doElse$9 = false;
                        return (increasing && that$10.first.equals(first)) && Integer.instance(that$10.size).equals(Integer.instance(size));
                    }
                    if (doElse$9) {
                        return List.$equals(this, that);
                    }
                }
            }
        }
    }
    Sequential measure([Integer from, $dart$core.int length]) => ((Sequential $lhs$) => $lhs$ == null ? span(from, Integer.instance((Integer.nativeValue(from) + length) - 1)) : $lhs$)(length <= 0 ? $package$empty : null);
    Sequential span([Integer from, Integer to]) {
        if (Integer.nativeValue(from) <= Integer.nativeValue(to)) {
            if ((Integer.nativeValue(to) < 0) || (!longerThan(Integer.nativeValue(from)))) {
                return $package$empty;
            } else {
                return $package$span((($dart$core.Object $lhs$) => $lhs$ == null ? first : $lhs$)(this.get(from)), (($dart$core.Object $lhs$) => $lhs$ == null ? last : $lhs$)(this.get(to)));
            }
        } else {
            if ((Integer.nativeValue(from) < 0) || (!longerThan(Integer.nativeValue(to)))) {
                return $package$empty;
            } else {
                Range range = $package$span((($dart$core.Object $lhs$) => $lhs$ == null ? first : $lhs$)(this.get(to)), (($dart$core.Object $lhs$) => $lhs$ == null ? last : $lhs$)(this.get(from)));
                return range.reversed;
            }
        }
    }
    Sequential spanFrom([Integer from]) {
        if (Integer.nativeValue(from) <= 0) {
            return this;
        } else if (longerThan(Integer.nativeValue(from))) {
            $dart$core.Object first;
            {
                $dart$core.Object tmp$12 = this.get(from);
                if (tmp$12 == null) {
                    throw new AssertionError("Violated: exists first = this[from]");
                }
                first = tmp$12;
            }
            return $package$span(first, last);
        } else {
            return $package$empty;
        }
    }
    Sequential spanTo([Integer to]) {
        if (Integer.nativeValue(to) < 0) {
            return $package$empty;
        } else if (longerThan(Integer.nativeValue(to) + 1)) {
            $dart$core.Object last;
            {
                $dart$core.Object tmp$13 = this.get(to);
                if (tmp$13 == null) {
                    throw new AssertionError("Violated: exists last = this[to]");
                }
                last = tmp$13;
            }
            return $package$span(first, last);
        } else {
            return this;
        }
    }
    void each([Callable step]) {
        $dart$core.Object current = first;
        while (true) {
            step.$delegate$(current);
            if (Integer.instance((current as Enumerable).offset(last)).equals(Integer.instance(0))) {
                break;
            } else {
                current = next(current);
            }
        }
    }
    $dart$core.int get hashCode => List.$get$hash(this);
    $dart$core.bool get empty => Sequence.$get$empty(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence clone() => Sequence.$clone(this);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Tuple withLeading([$dart$core.Object element]) => Sequence.$withLeading(this, element);
    Sequence withTrailing([$dart$core.Object element]) => Sequence.$withTrailing(this, element);
    Sequence append([Sequential elements]) => Sequence.$append(this, elements);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => List.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist]) => List.$inclusions(this, sublist);
    $dart$core.int firstInclusion([List sublist]) => List.$firstInclusion(this, sublist);
    $dart$core.int lastInclusion([List sublist]) => List.$lastInclusion(this, sublist);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => List.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element]) => List.$occurrences(this, element);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => List.$firstOccurrence(this, element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => List.$lastOccurrence(this, element);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Iterable get permutations => List.$get$permutations(this);
    Iterable get exceptLast => Iterable.$get$exceptLast(this);
    Iterable map([Callable collecting]) => Iterable.$map(this, collecting);
    Iterable flatMap([Callable collecting]) => Iterable.$flatMap(this, collecting);
    Iterable filter([Callable selecting]) => Iterable.$filter(this, selecting);
    Iterable narrow() => Iterable.$narrow(this);
    Callable fold([$dart$core.Object initial]) => Iterable.$fold(this, initial);
    $dart$core.Object reduce([Callable accumulating]) => Iterable.$reduce(this, accumulating);
    Callable scan([$dart$core.Object initial]) => Iterable.$scan(this, initial);
    Entry locate([Callable selecting]) => Iterable.$locate(this, selecting);
    Entry locateLast([Callable selecting]) => Iterable.$locateLast(this, selecting);
    Iterable locations([Callable selecting]) => Iterable.$locations(this, selecting);
    $dart$core.Object max([Callable comparing]) => Iterable.$max(this, comparing);
    Callable spread([Callable method]) => Iterable.$spread(this, method);
    Sequential select([Callable selecting]) => Iterable.$select(this, selecting);
    $dart$core.bool any([Callable selecting]) => Iterable.$any(this, selecting);
    $dart$core.bool every([Callable selecting]) => Iterable.$every(this, selecting);
    Iterable skip([$dart$core.int skipping]) => Iterable.$skip(this, skipping);
    Iterable take([$dart$core.int taking]) => Iterable.$take(this, taking);
    Iterable skipWhile([Callable skipping]) => Iterable.$skipWhile(this, skipping);
    Iterable takeWhile([Callable taking]) => Iterable.$takeWhile(this, taking);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Iterable.$defaultNullElements(this, defaultValue);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
Range $package$span([$dart$core.Object first, $dart$core.Object last]) => new Span(first, last);

Range span([$dart$core.Object first, $dart$core.Object last]) => $package$span(first, last);

$dart$core.Object $package$sum([Iterable values]) {
    Iterator it = values.iterator();
    $dart$core.Object first;
    {
        $dart$core.Object first$0 = it.next();
        if (first$0 is Finished) {
            throw new AssertionError("Violated: !is Finished first = it.next()");
        }
        first = first$0;
    }
    $dart$core.Object sum = first;
    while (true) {
        $dart$core.Object val;
        {
            $dart$core.Object val$1 = it.next();
            if (val$1 is Finished) {
                break;
            }
            val = val$1;
        }
        sum = (sum as Summable).plus(val);
    }
    return sum;
}

$dart$core.Object sum([Iterable values]) => $package$sum(values);

abstract class Summable {
    $dart$core.Object plus([$dart$core.Object other]);
}
$dart$core.Object $package$times([$dart$core.Object x, $dart$core.Object y]) => (x as Numeric).times(y);

$dart$core.Object times([$dart$core.Object x, $dart$core.Object y]) => $package$times(x, y);

Tuple $package$unzip([Iterable tuples]) => new Tuple.$withList([tuples.map(new dart$Callable(([Tuple tuple]) => tuple.first)), tuples.map(new dart$Callable(([Tuple tuple]) => tuple.rest))], null);

Tuple unzip([Iterable tuples]) => $package$unzip(tuples);

Tuple $package$unzipPairs([Iterable pairs]) => new Tuple.$withList([pairs.map(new dart$Callable(([Tuple pair]) => pair.get(Integer.instance(0)))), pairs.map(new dart$Callable(([Tuple pair]) => pair.get(Integer.instance(1))))], null);

Tuple unzipPairs([Iterable pairs]) => $package$unzipPairs(pairs);

abstract class Usable {
}
Iterable $package$zipPairs([Iterable firstElements, Iterable secondElements]) => $package$mapPairs(new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => new Tuple.$withList([first, second], null)), firstElements, secondElements);

Iterable zipPairs([Iterable firstElements, Iterable secondElements]) => $package$zipPairs(firstElements, secondElements);

