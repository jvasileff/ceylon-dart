
import "dart:core" as $dart$core;
import "dart:io" as $dart$io;
import "dart:math" as $dart$math;
import "dart:mirrors" as $dart$mirrors;
import "source/ceylon/language/module.dart";

Callable $package$and([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object $0]) => Boolean.instance((([$dart$core.Object val]) => Boolean.nativeValue(p.f(val) as Boolean) && Boolean.nativeValue(q.f(val) as Boolean))($0)));

Callable and([Callable p, Callable q]) => $package$and(p, q);

abstract class Annotated {
    $dart$core.bool annotated();
}
abstract class Annotation {
}
class AnnotationAnnotation implements OptionalAnnotation {
    AnnotationAnnotation() {}
}
AnnotationAnnotation $package$annotation() => new AnnotationAnnotation();

AnnotationAnnotation annotation() => $package$annotation();

class SharedAnnotation implements OptionalAnnotation {
    SharedAnnotation() {}
}
SharedAnnotation $package$shared() => new SharedAnnotation();

SharedAnnotation shared() => $package$shared();

class VariableAnnotation implements OptionalAnnotation {
    VariableAnnotation() {}
}
VariableAnnotation $package$variable() => new VariableAnnotation();

VariableAnnotation variable() => $package$variable();

class AbstractAnnotation implements OptionalAnnotation {
    AbstractAnnotation() {}
}
AbstractAnnotation $package$abstract() => new AbstractAnnotation();

AbstractAnnotation abstract() => $package$abstract();

class FinalAnnotation implements OptionalAnnotation {
    FinalAnnotation() {}
}
FinalAnnotation $package$$final() => new FinalAnnotation();

FinalAnnotation $final() => $package$$final();

class SealedAnnotation implements OptionalAnnotation {
    SealedAnnotation() {}
}
SealedAnnotation $package$sealed() => new SealedAnnotation();

SealedAnnotation sealed() => $package$sealed();

class ActualAnnotation implements OptionalAnnotation {
    ActualAnnotation() {}
}
ActualAnnotation $package$actual() => new ActualAnnotation();

ActualAnnotation actual() => $package$actual();

class FormalAnnotation implements OptionalAnnotation {
    FormalAnnotation() {}
}
FormalAnnotation $package$formal() => new FormalAnnotation();

FormalAnnotation formal() => $package$formal();

class DefaultAnnotation implements OptionalAnnotation {
    DefaultAnnotation() {}
}
DefaultAnnotation $package$$default() => new DefaultAnnotation();

DefaultAnnotation $default() => $package$$default();

class LateAnnotation implements OptionalAnnotation {
    LateAnnotation() {}
}
LateAnnotation $package$late() => new LateAnnotation();

LateAnnotation late() => $package$late();

class NativeAnnotation implements OptionalAnnotation {
    NativeAnnotation([Sequential backends]) {
        this.backends = backends;
    }
    Sequential backends;
}
NativeAnnotation $package$native([Sequential backends]) => new NativeAnnotation(backends);

NativeAnnotation native([Sequential backends]) => $package$native(backends);

class DocAnnotation implements OptionalAnnotation {
    DocAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
}
DocAnnotation $package$doc([$dart$core.String description]) => new DocAnnotation(description);

DocAnnotation doc([$dart$core.String description]) => $package$doc(description);

class SeeAnnotation implements SequencedAnnotation {
    SeeAnnotation([Sequential programElements]) {
        this.programElements = programElements;
    }
    Sequential programElements;
}
SeeAnnotation $package$see([Sequential programElements]) => new SeeAnnotation(programElements);

SeeAnnotation see([Sequential programElements]) => $package$see(programElements);

class AuthorsAnnotation implements OptionalAnnotation {
    AuthorsAnnotation([Sequential authors]) {
        this.authors = authors;
    }
    Sequential authors;
}
AuthorsAnnotation $package$by([Sequential authors]) => new AuthorsAnnotation(authors);

AuthorsAnnotation by([Sequential authors]) => $package$by(authors);

class ThrownExceptionAnnotation implements SequencedAnnotation {
    ThrownExceptionAnnotation([meta$declaration$Declaration type, $dart$core.String when]) {
        this.type = type;
        this.when = when;
    }
    meta$declaration$Declaration type;
    $dart$core.String when;
}
ThrownExceptionAnnotation $package$throws([meta$declaration$Declaration type, $dart$core.Object when = $package$dart$default]) {
    if ($dart$core.identical(when, $package$dart$default)) {
        when = "";
    }
    return new ThrownExceptionAnnotation(type, when as $dart$core.String);
}

ThrownExceptionAnnotation throws([meta$declaration$Declaration type, $dart$core.Object when = $package$dart$default]) => $package$throws(type, when);

class DeprecationAnnotation implements OptionalAnnotation {
    DeprecationAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
    $dart$core.String get reason => !String.instance(description).empty ? description : null;
}
DeprecationAnnotation $package$deprecated([$dart$core.Object reason = $package$dart$default]) {
    if ($dart$core.identical(reason, $package$dart$default)) {
        reason = "";
    }
    return new DeprecationAnnotation(reason as $dart$core.String);
}

DeprecationAnnotation deprecated([$dart$core.Object reason = $package$dart$default]) => $package$deprecated(reason);

class TagsAnnotation implements OptionalAnnotation {
    TagsAnnotation([Sequential tags]) {
        this.tags = tags;
    }
    Sequential tags;
}
TagsAnnotation $package$tagged([Sequential tags]) => new TagsAnnotation(tags);

TagsAnnotation tagged([Sequential tags]) => $package$tagged(tags);

class LicenseAnnotation implements OptionalAnnotation {
    LicenseAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
}
LicenseAnnotation $package$license([$dart$core.String description]) => new LicenseAnnotation(description);

LicenseAnnotation license([$dart$core.String description]) => $package$license(description);

class OptionalImportAnnotation implements OptionalAnnotation {
    OptionalImportAnnotation() {}
}
OptionalImportAnnotation $package$optional() => new OptionalImportAnnotation();

OptionalImportAnnotation optional() => $package$optional();

class SuppressWarningsAnnotation implements OptionalAnnotation {
    SuppressWarningsAnnotation([Sequential _$warnings]) {
        this._$warnings = _$warnings;
    }
    Sequential _$warnings;
}
SuppressWarningsAnnotation $package$suppressWarnings([Sequential warnings]) => new SuppressWarningsAnnotation(warnings);

SuppressWarningsAnnotation suppressWarnings([Sequential warnings]) => $package$suppressWarnings(warnings);

class SerializableAnnotation implements OptionalAnnotation {
    SerializableAnnotation() {}
}
SerializableAnnotation $package$serializable() => new SerializableAnnotation();

SerializableAnnotation serializable() => $package$serializable();

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

$dart$core.Object $package$apply([Callable f, $dart$core.Object args]) => $package$unflatten(f).f(args);

$dart$core.Object apply([Callable f, $dart$core.Object args]) => $package$apply(f, args);

Array $package$arrayOfSize([$dart$core.int size, $dart$core.Object element]) => new Array.ofSize(size, element);

Array arrayOfSize([$dart$core.int size, $dart$core.Object element]) => $package$arrayOfSize(size, element);

class ArraySequence implements Sequence {
    ArraySequence([Array _$array]) {
        this._$array = _$array;
        if (!(!this._$array.empty)) {
            throw new AssertionError("Violated: !array.empty");
        }
    }
    Array _$array;
    $dart$core.Object getFromFirst([$dart$core.int index]) => _$array.getFromFirst(index);
    $dart$core.bool contains([$dart$core.Object element]) => _$array.contains(element);
    $dart$core.int get size => _$array.size;
    Iterator iterator() => _$array.iterator();
    $dart$core.Object get first {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object tmp$1 = _$array.first;
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
                $dart$core.Object tmp$3 = _$array.last;
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
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(_$array.spanFrom(Integer.instance(1))) : $lhs$)(Integer.instance(size).equals(Integer.instance(1)) ? $package$empty : null);
    Sequence clone() => new ArraySequence(_$array.clone());
    void each([Callable step]) => _$array.each(step);
    $dart$core.int count([Callable selecting]) => _$array.count(selecting);
    $dart$core.bool every([Callable selecting]) => _$array.every(selecting);
    $dart$core.bool any([Callable selecting]) => _$array.any(selecting);
    $dart$core.Object find([Callable selecting]) => _$array.find(selecting);
    $dart$core.Object findLast([Callable selecting]) => _$array.findLast(selecting);
    $dart$core.Object reduce([Callable accumulating]) {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$4 = _$array.reduce(accumulating);
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
            Sequential tmp$5 = _$array.collect(collecting);
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
            Sequential tmp$6 = _$array.sort(comparing);
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
            return new ArraySequence(_$array.measure(Integer.instance(0), length + Integer.nativeValue(from)));
        } else {
            return new ArraySequence(_$array.measure(from, length));
        }
    }
    Sequential span([Integer from, Integer to]) {
        if (Integer.nativeValue(from) <= Integer.nativeValue(to)) {
            return ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(_$array.span(from, to)) : $lhs$)((Integer.nativeValue(to) < 0) || (Integer.nativeValue(from) > lastIndex) ? $package$empty : null);
        } else {
            return ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(_$array.span(from, to)) : $lhs$)((Integer.nativeValue(from) < 0) || (Integer.nativeValue(to) > lastIndex) ? $package$empty : null);
        }
    }
    Sequential spanFrom([Integer from]) => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(_$array.spanFrom(from)) : $lhs$)(Integer.nativeValue(from) > lastIndex ? $package$empty : null);
    Sequential spanTo([Integer to]) => ((Sequential $lhs$) => $lhs$ == null ? new ArraySequence(_$array.spanTo(to)) : $lhs$)(Integer.nativeValue(to) < 0 ? $package$empty : null);
    $dart$core.int firstOccurrence([$dart$core.Object element]) => _$array.firstOccurrence(element);
    $dart$core.int lastOccurrence([$dart$core.Object element]) => _$array.lastOccurrence(element);
    $dart$core.bool occurs([$dart$core.Object element]) => _$array.occurs(element);
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
Callable $package$byDecreasing([Callable comparable]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) => (comparable.f(y) as Comparable).compare(comparable.f(x)));

Callable byDecreasing([Callable comparable]) => $package$byDecreasing(comparable);

Comparison $package$decreasing([$dart$core.Object x, $dart$core.Object y]) => (y as Comparable).compare(x);

Comparison decreasing([$dart$core.Object x, $dart$core.Object y]) => $package$decreasing(x, y);

Comparison $package$decreasingKey([Entry x, Entry y]) => (y.key as Comparable).compare(x.key);

Comparison decreasingKey([Entry x, Entry y]) => $package$decreasingKey(x, y);

Comparison $package$decreasingItem([Entry x, Entry y]) => (y.item as Comparable).compare(x.item);

Comparison decreasingItem([Entry x, Entry y]) => $package$decreasingItem(x, y);

Callable $package$byIncreasing([Callable comparable]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) => (comparable.f(x) as Comparable).compare(comparable.f(y)));

Callable byIncreasing([Callable comparable]) => $package$byIncreasing(comparable);

Comparison $package$increasing([$dart$core.Object x, $dart$core.Object y]) => (x as Comparable).compare(y);

Comparison increasing([$dart$core.Object x, $dart$core.Object y]) => $package$increasing(x, y);

Comparison $package$increasingKey([Entry x, Entry y]) => (x.key as Comparable).compare(y.key);

Comparison increasingKey([Entry x, Entry y]) => $package$increasingKey(x, y);

Comparison $package$increasingItem([Entry x, Entry y]) => (x.item as Comparable).compare(y.item);

Comparison increasingItem([Entry x, Entry y]) => $package$increasingItem(x, y);

Callable $package$byItem([Callable comparing]) => new dart$Callable(([Entry x, Entry y]) => comparing.f(x.item, y.item) as Comparison);

Callable byItem([Callable comparing]) => $package$byItem(comparing);

Callable $package$byKey([Callable comparing]) => new dart$Callable(([Entry x, Entry y]) => comparing.f(x.key, y.key) as Comparison);

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
            {
                return true;
            }
        }
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
            {
                return false;
            }
        }
    }
}
class ChainedIterator implements Iterator {
    ChainedIterator([Iterable _$first, Iterable _$second]) {
        this._$first = _$first;
        this._$second = _$second;
        _$iter = this._$first.iterator();
        _$more = true;
    }
    Iterable _$first;
    Iterable _$second;
    Iterator _$iter;
    $dart$core.bool _$more;
    $dart$core.Object next() {
        $dart$core.Object element = _$iter.next();
        if (_$more && (element is Finished)) {
            _$iter = _$second.iterator();
            _$more = false;
            return _$iter.next();
        } else {
            return element;
        }
    }
    $dart$core.String toString() => ((("" + _$first.toString()) + ".chain(") + _$second.toString()) + ").iterator()";
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
Callable $package$comparing([Sequential comparators]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = comparators.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Callable compare = element$1 as Callable;
            Comparison comparison = compare.f(x, y) as Comparison;
            if (!comparison.equals($package$equal)) {
                return comparison;
            }
        }
        {
            return $package$equal;
        }
    }
});

Callable comparing([Sequential comparators]) => $package$comparing(comparators);

abstract class Comparison {
    Comparison([$dart$core.String string]) {
        this.string = string;
    }
    $dart$core.String string;
    Comparison get reversed;
    $dart$core.bool equals([$dart$core.Object other]) => (() {
        $dart$core.bool doElse$0 = true;
        if (other != null) {
            doElse$0 = false;
            return $dart$core.identical(this, other);
        }
        if (doElse$0) {
            return false;
        }
    })();
}
class equal_  extends Comparison {
    equal_() : super("equal") {}
    Comparison get reversed => this;
}
final equal_ $package$equal = new equal_();

equal_ get equal => $package$equal;

class smaller_  extends Comparison {
    smaller_() : super("smaller") {}
    Comparison get reversed => $package$larger;
}
final smaller_ $package$smaller = new smaller_();

smaller_ get smaller => $package$smaller;

class larger_  extends Comparison {
    larger_() : super("larger") {}
    Comparison get reversed => $package$smaller;
}
final larger_ $package$larger = new larger_();

larger_ get larger => $package$larger;

Callable $package$compose([Callable x, Callable y]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => x.f(y.s(args))));

Callable compose([Callable x, Callable y]) => $package$compose(x, y);

Sequential $package$concatenate([Sequential iterables]) => functionIterable(new dart$Callable(() {
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
})).sequence();

Sequential concatenate([Sequential iterables]) => $package$concatenate(iterables);

abstract class ConstrainedAnnotation implements Annotation {
}
class Contextual$Using implements Obtainable {
    Contextual $outer$ceylon$language$Contextual;
    Contextual$Using([Contextual this.$outer$ceylon$language$Contextual, $dart$core.Object _$newValue]) {
        this._$newValue = _$newValue;
        _$previous = null;
    }
    $dart$core.Object _$newValue;
    $dart$core.Object _$previous;
    void obtain() {
        _$previous = $outer$ceylon$language$Contextual._$val;
        {
            $dart$core.bool doElse$1 = true;
            if (_$newValue is Callable) {
                Callable newValue$2;
                newValue$2 = _$newValue as Callable;
                doElse$1 = false;
                _$val = newValue$2.f();
            }
            if (doElse$1) {
                _$val = _$newValue;
            }
        }
    }
    void release([Throwable error]) {{
            $dart$core.bool doElse$3 = true;
            {
                $dart$core.Object tmp$4 = _$previous;
                if (!(tmp$4 == null)) {
                    $dart$core.Object p;
                    p = tmp$4;
                    doElse$3 = false;
                    _$val = p;
                }
            }
            if (doElse$3) {
                _$val = null;
            }
        }
    }
}
class Contextual {
    Contextual() {
        _$val = null;
    }
    $dart$core.Object _$val;
    $dart$core.Object get() {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$0 = _$val;
            if (tmp$0 == null) {
                throw new AssertionError("Violated: exists result = val");
            }
            result = tmp$0;
        }
        return result;
    }
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
                    if (!Boolean.nativeValue((comparing as Callable).f(first, second) as Boolean)) {
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

Callable $package$curry([Callable f]) => new dart$Callable(([$dart$core.Object first]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => $package$unflatten(f).f(new Tuple(first, args)))));

Callable curry([Callable f]) => $package$curry(f);

Callable $package$uncurry([Callable f]) => $package$flatten(new dart$Callable(([Tuple args]) => $package$unflatten(f.f(args.first) as Callable).f(args.rest)));

Callable uncurry([Callable f]) => $package$uncurry(f);

class CycledIterator implements Iterator {
    CycledIterator([Iterable _$iterable, $dart$core.int _$times]) {
        this._$iterable = _$iterable;
        this._$times = _$times;
        _$iter = $package$emptyIterator;
        _$count = 0;
    }
    Iterable _$iterable;
    $dart$core.int _$times;
    Iterator _$iter;
    $dart$core.int _$count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object next$1 = _$iter.next();
                if (!(next$1 is Finished)) {
                    $dart$core.Object next;
                    next = next$1;
                    doElse$0 = false;
                    return next;
                }
            }
            if (doElse$0) {
                if (_$count < _$times) {
                    _$count = Integer.nativeValue(Integer.instance(_$count).successor);
                    _$iter = _$iterable.iterator();
                } else {
                    _$iter = $package$emptyIterator;
                }
                return _$iter.next();
            }
        }
    }
    $dart$core.String toString() => ((("" + _$iterable.toString()) + ".repeat(") + Integer.instance(_$times).toString()) + ").iterator()";
}
class functionIterable$$anonymous$0_$$anonymous$1_ implements Iterator {
    functionIterable$$anonymous$0_ $outer$ceylon$language$functionIterable$$anonymous$0_;
    functionIterable$$anonymous$0_$$anonymous$1_([functionIterable$$anonymous$0_ this.$outer$ceylon$language$functionIterable$$anonymous$0_]) {
        _$n = $outer$ceylon$language$functionIterable$$anonymous$0_.$capture$functionIterable$f.f() as Callable;
    }
    Callable _$n;
    $dart$core.Object next() => _$n.f();
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

void $package$dartListCopyTo([List val, Array destination, $dart$core.Object sourcePosition = $package$dart$default, $dart$core.Object destinationPosition = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
    if ($dart$core.identical(sourcePosition, $package$dart$default)) {
        sourcePosition = 0;
    }
    if ($dart$core.identical(destinationPosition, $package$dart$default)) {
        destinationPosition = 0;
    }
    if ($dart$core.identical(length, $package$dart$default)) {
        length = Integer.nativeValue($package$smallest(Integer.instance(val.size - (sourcePosition as $dart$core.int)), Integer.instance(destination.size - (destinationPosition as $dart$core.int))) as Integer);
    }
    $dart$core.int i = destinationPosition as $dart$core.int;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = val.sublistFrom(sourcePosition as $dart$core.int).take(length as $dart$core.int).iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            $dart$core.Object c = element$1;
            destination.set((() {
                $dart$core.int tmp$2 = i;
                i = Integer.nativeValue(Integer.instance(i).successor);
                return tmp$2;
            })(), c);
        }
    }
}

void dartListCopyTo([List val, Array destination, $dart$core.Object sourcePosition = $package$dart$default, $dart$core.Object destinationPosition = $package$dart$default, $dart$core.Object length = $package$dart$default]) => $package$dartListCopyTo(val, destination, sourcePosition, destinationPosition, length);

$dart$core.String $package$dartStringJoin([$dart$core.String val, Iterable objects]) {
    $dart$core.String result = "";
    $dart$core.bool first = true;
    {
        $dart$core.Object element$4;
        Iterator iterator$3 = objects.iterator();
        while ((element$4 = iterator$3.next()) is !Finished) {
            $dart$core.Object el = element$4;
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

$dart$core.String dartStringJoin([$dart$core.String val, Iterable objects]) => $package$dartStringJoin(val, objects);

Iterable $package$dartStringLines([$dart$core.String val]) => String.instance(val).split((() {
    Character $r = new Character.$fromInt(10);
    return new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($r.equals($0)));
})(), true, false).map(new dart$Callable(([String s]) => s.trimTrailing((() {
    Character $r = new Character.$fromInt(13);
    return new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($r.equals($0)));
})())));

Iterable dartStringLines([$dart$core.String val]) => $package$dartStringLines(val);

Iterable $package$dartStringLinesWithBreaks([$dart$core.String val]) => String.instance(val).split((() {
    Character $r = new Character.$fromInt(10);
    return new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($r.equals($0)));
})(), false, false).partition(2).map(new dart$Callable(([Sequence lineWithBreak]) => (() {
    $dart$core.String line = String.nativeValue(lineWithBreak.get(Integer.instance(0)) as String);
    $dart$core.String br = String.nativeValue(lineWithBreak.get(Integer.instance(1)) as String);
    return (() {
        $dart$core.bool doElse$5 = true;
        if (!(br == null)) {
            doElse$5 = false;
            return String.instance(line + br);
        }
        if (doElse$5) {
            $dart$core.Object br$6;
            br$6 = String.instance(br);
            return String.instance(line);
        }
    })();
})()));

Iterable dartStringLinesWithBreaks([$dart$core.String val]) => $package$dartStringLinesWithBreaks(val);

class dartStringSplit$$anonymous$2_$iterator$$anonymous$3_ implements Iterator {
    dartStringSplit$$anonymous$2_ $outer$ceylon$language$dartStringSplit$$anonymous$2_;
    dartStringSplit$$anonymous$2_$iterator$$anonymous$3_([dartStringSplit$$anonymous$2_ this.$outer$ceylon$language$dartStringSplit$$anonymous$2_]) {
        _$seq = String.instance($outer$ceylon$language$dartStringSplit$$anonymous$2_.$capture$dartStringSplit$val).sequence();
        _$it = _$seq.iterator();
        _$index = 0;
        _$first = true;
        _$lastWasSeparator = false;
        _$peeked = false;
        _$peekedWasSeparator = false;
        _$eof = false;
        _$peekSeparator();
    }
    Sequential _$seq;
    Iterator _$it;
    $dart$core.int _$index;
    $dart$core.bool _$first;
    $dart$core.bool _$lastWasSeparator;
    $dart$core.bool _$peeked;
    $dart$core.bool _$peekedWasSeparator;
    $dart$core.bool _$eof;
    $dart$core.bool _$peekSeparator() {
        if (!_$peeked) {
            _$peeked = true;
            {
                $dart$core.bool doElse$7 = true;
                {
                    $dart$core.Object next$8 = _$it.next();
                    if (!(next$8 is Finished)) {
                        Character next;
                        next = next$8 as Character;
                        doElse$7 = false;
                        _$peekedWasSeparator = Boolean.nativeValue(($outer$ceylon$language$dartStringSplit$$anonymous$2_.$capture$dartStringSplit$splitting as Callable).f(next) as Boolean);
                    }
                }
                if (doElse$7) {
                    _$eof = true;
                    _$peekedWasSeparator = false;
                }
            }
        }
        return _$peekedWasSeparator;
    }
    void _$eatChar() {
        _$peeked = false;
        _$peekSeparator();
        _$index = Integer.nativeValue(Integer.instance(_$index).successor);
    }
    $dart$core.bool _$eatSeparator() {
        $dart$core.bool result = _$peekSeparator();
        if (result) {
            _$eatChar();
        }
        return result;
    }
    $dart$core.String _$substring([$dart$core.int start, $dart$core.int end]) => String.nativeValue(new String(_$seq.measure(Integer.instance(start), end - start) as Iterable));
    $dart$core.Object next() {
        if (!_$eof) {
            $dart$core.int start = _$index;
            if (((_$first && Integer.instance(start).equals(Integer.instance(0))) || _$lastWasSeparator) && _$peekSeparator()) {
                _$first = false;
                _$lastWasSeparator = false;
                return String.instance("");
            }
            if (_$eatSeparator()) {
                if ($outer$ceylon$language$dartStringSplit$$anonymous$2_.$capture$dartStringSplit$groupSeparators as $dart$core.bool) {
                    while (_$eatSeparator()) {}
                }
                if (!($outer$ceylon$language$dartStringSplit$$anonymous$2_.$capture$dartStringSplit$discardSeparators as $dart$core.bool)) {
                    _$lastWasSeparator = true;
                    return String.instance(_$substring(start, _$index));
                }
                start = _$index;
            }
            while ((!_$eof) && (!_$peekSeparator())) {
                _$eatChar();
            }
            _$lastWasSeparator = false;
            return String.instance(_$substring(start, _$index));
        } else if (_$lastWasSeparator) {
            _$lastWasSeparator = false;
            return String.instance("");
        } else {
            return $package$finished;
        }
    }
}
class dartStringSplit$$anonymous$2_ implements Iterable {
    $dart$core.String $capture$dartStringSplit$val;
    Callable $capture$dartStringSplit$splitting;
    $dart$core.Object $capture$dartStringSplit$groupSeparators;
    $dart$core.Object $capture$dartStringSplit$discardSeparators;
    dartStringSplit$$anonymous$2_([$dart$core.String this.$capture$dartStringSplit$val, Callable this.$capture$dartStringSplit$splitting, $dart$core.Object this.$capture$dartStringSplit$groupSeparators, $dart$core.Object this.$capture$dartStringSplit$discardSeparators]) {}
    Iterator iterator() => new dartStringSplit$$anonymous$2_$iterator$$anonymous$3_(this);
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
Iterable $package$dartStringSplit([$dart$core.String val, $dart$core.Object splitting = $package$dart$default, $dart$core.Object discardSeparators = $package$dart$default, $dart$core.Object groupSeparators = $package$dart$default]) {
    if ($dart$core.identical(splitting, $package$dart$default)) {
        splitting = new dart$Callable(([Character ch]) => Boolean.instance(ch.whitespace));
    }
    if ($dart$core.identical(discardSeparators, $package$dart$default)) {
        discardSeparators = true;
    }
    if ($dart$core.identical(groupSeparators, $package$dart$default)) {
        groupSeparators = true;
    }
    return (() {
        if (String.instance(val).empty) {
            return new Singleton(String.instance(val));
        } else {
            return new dartStringSplit$$anonymous$2_(val, splitting, groupSeparators, discardSeparators);
        }
    })();
}

Iterable dartStringSplit([$dart$core.String val, $dart$core.Object splitting = $package$dart$default, $dart$core.Object discardSeparators = $package$dart$default, $dart$core.Object groupSeparators = $package$dart$default]) => $package$dartStringSplit(val, splitting, discardSeparators, groupSeparators);

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
    static Tuple $withLeading([final Empty $this, $dart$core.Object element]) => new Tuple.$withList([element]);
    Tuple withTrailing([$dart$core.Object element]);
    static Tuple $withTrailing([final Empty $this, $dart$core.Object element]) => new Tuple.$withList([element]);
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
    static Tuple $slice([final Empty $this, $dart$core.int index]) => new Tuple.$withList([$this, $this]);
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
        return new Tuple.$withList([element]);
    }
    if (doElse$0) {
        return $package$empty;
    }
})();

$dart$core.Object emptyOrSingleton([$dart$core.Object element]) => $package$emptyOrSingleton(element);

class Entry {
    Entry([$dart$core.Object key, $dart$core.Object item]) {
        this.key = key;
        this.item = item;
    }
    $dart$core.Object key;
    $dart$core.Object item;
    Tuple get pair => new Tuple.$withList([key, item]);
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
    $dart$core.int get hashCode => ((31 + key.hashCode) * 31) + (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)((($dart$core.Object $r) => $r == null ? null : $r.hashCode)(item));
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

Callable $package$forItem([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.f(entry.item));

Callable forItem([Callable resulting]) => $package$forItem(resulting);

Callable $package$forKey([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.f(entry.key));

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

void $package$noop([Sequential arguments]) {}

void noop([Sequential arguments]) => $package$noop(arguments);

$dart$core.bool $package$identical([$dart$core.Object x, $dart$core.Object y]) => $dart$core.identical(x, y);

$dart$core.bool identical([$dart$core.Object x, $dart$core.Object y]) => $package$identical(x, y);

abstract class impl$BaseIterable implements Iterable {
    impl$BaseIterable() {}
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
abstract class impl$BaseIterator implements Iterator {
    impl$BaseIterator() {}
}
abstract class impl$BaseMap implements Map {
    impl$BaseMap() {}
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
abstract class impl$BaseList implements List {
    impl$BaseList() {}
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
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
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
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
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
class impl$ElementImpl implements serialization$Element {
    impl$ElementImpl([$dart$core.int index]) {
        this.index = index;
    }
    $dart$core.int index;
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getAnything(instance, this);
    }
    $dart$core.String toString() => ("Element [index=" + Integer.instance(index).toString()) + "]";
    $dart$core.int get hashCode => index;
    $dart$core.bool equals([$dart$core.Object other]) {{
            $dart$core.bool doElse$0 = true;
            if (other is impl$ElementImpl) {
                impl$ElementImpl other$1;
                other$1 = other as impl$ElementImpl;
                doElse$0 = false;
                return $dart$core.identical(this, other$1) || Integer.instance(index).equals(Integer.instance(other$1.index));
            }
            if (doElse$0) {
                return false;
            }
        }
    }
}
class impl$MemberImpl implements serialization$Member {
    impl$MemberImpl([meta$declaration$ValueDeclaration attribute]) {
        this.attribute = attribute;
    }
    meta$declaration$ValueDeclaration attribute;
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getAnything(instance, this);
    }
    $dart$core.String toString() => ("Member [attribute=" + attribute.toString()) + "]";
    $dart$core.int get hashCode => attribute.hashCode;
    $dart$core.bool equals([$dart$core.Object other]) {{
            $dart$core.bool doElse$0 = true;
            if (other is impl$MemberImpl) {
                impl$MemberImpl other$1;
                other$1 = other as impl$MemberImpl;
                doElse$0 = false;
                return $dart$core.identical(this, other$1) || attribute.equals(other$1.attribute);
            }
            if (doElse$0) {
                return false;
            }
        }
    }
}
class impl$outerImpl_ implements serialization$Outer {
    impl$outerImpl_() {}
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getObject(instance, this);
    }
    $dart$core.String toString() => "Outer";
}
final impl$outerImpl_ $package$impl$outerImpl = new impl$outerImpl_();

impl$outerImpl_ get impl$outerImpl => $package$impl$outerImpl;

void $package$impl$$rethrow([Throwable x]) {
    throw x;
}

void impl$$rethrow([Throwable x]) => $package$impl$$rethrow(x);

$dart$core.double $package$infinity = 1.0 / 0.0;

$dart$core.double get infinity => $package$infinity;

class InitializationError  extends AssertionError {
    InitializationError([$dart$core.String _$description]) : super(_$description) {
        this._$description = _$description;
    }
    $dart$core.String _$description;
}
abstract class Integral implements Number, Enumerable {
    $dart$core.Object remainder([$dart$core.Object other]);
    $dart$core.bool get zero;
    $dart$core.bool get unit;
    $dart$core.bool divides([$dart$core.Object other]);
    static $dart$core.bool $divides([final Integral $this, $dart$core.Object other]) => ((other as Integral).remainder($this) as Integral).zero;
}
class interleave$$anonymous$0_$$anonymous$1_ implements Iterator {
    interleave$$anonymous$0_ $outer$ceylon$language$interleave$$anonymous$0_;
    interleave$$anonymous$0_$$anonymous$1_([interleave$$anonymous$0_ this.$outer$ceylon$language$interleave$$anonymous$0_]) {
        _$iterators = $outer$ceylon$language$interleave$$anonymous$0_.$capture$interleave$iterables.collect(new dart$Callable(([Iterable it]) => it.iterator()));
        _$which = 0;
    }
    Sequence _$iterators;
    $dart$core.int _$which;
    $dart$core.Object next() {
        Iterator iter;
        {
            Iterator tmp$18 = _$iterators.get(Integer.instance(_$which)) as Iterator;
            if (tmp$18 == null) {
                throw new AssertionError("Violated: exists iter = iterators[which]");
            }
            iter = tmp$18;
        }
        {
            $dart$core.bool doElse$19 = true;
            {
                $dart$core.Object next$20 = iter.next();
                if (!(next$20 is Finished)) {
                    $dart$core.Object next;
                    next = next$20;
                    doElse$19 = false;
                    if ((_$which = Integer.nativeValue(Integer.instance(_$which).successor)) >= _$iterators.size) {
                        _$which = 0;
                    }
                    return next;
                }
            }
            if (doElse$19) {
                return $package$finished;
            }
        }
    }
}
class interleave$$anonymous$0_ implements Iterable {
    Sequence $capture$interleave$iterables;
    interleave$$anonymous$0_([Sequence this.$capture$interleave$iterables]) {}
    $dart$core.int get size => (() {
        Iterable arg$0$0 = functionIterable(new dart$Callable(() {
            $dart$core.bool step$0$expired$1 = false;
            $dart$core.bool step$0$2() {
                if (step$0$expired$1) {
                    return false;
                }
                step$0$expired$1 = true;
                return true;
            }

            Iterator iterator_1$3;
            $dart$core.bool step$1$Init$6() {
                if (iterator_1$3 != null) {
                    return true;
                }
                if (!step$0$2()) {
                    return false;
                }
                iterator_1$3 = $capture$interleave$iterables.iterator();
                return true;
            }

            Iterable it$4;
            $dart$core.bool step$1$7() {
                while (step$1$Init$6()) {
                    $dart$core.Object next$5;
                    if ((next$5 = iterator_1$3.next()) is !Finished) {
                        it$4 = next$5 as Iterable;
                        return true;
                    }
                    iterator_1$3 = null;
                }
                return false;
            }

            $dart$core.Object step$2$8() {
                if (!step$1$7()) {
                    return $package$finished;
                }
                Iterable it = it$4;
                return Integer.instance(it.size);
            }

            return new dart$Callable(step$2$8);
        }));
        return Integer.nativeValue($package$min(arg$0$0) as Integer);
    })() * $capture$interleave$iterables.size;
    $dart$core.bool get empty => (() {
        Iterable arg$9$0 = functionIterable(new dart$Callable(() {
            $dart$core.bool step$0$expired$10 = false;
            $dart$core.bool step$0$11() {
                if (step$0$expired$10) {
                    return false;
                }
                step$0$expired$10 = true;
                return true;
            }

            Iterator iterator_1$12;
            $dart$core.bool step$1$Init$15() {
                if (iterator_1$12 != null) {
                    return true;
                }
                if (!step$0$11()) {
                    return false;
                }
                iterator_1$12 = $capture$interleave$iterables.iterator();
                return true;
            }

            Iterable it$13;
            $dart$core.bool step$1$16() {
                while (step$1$Init$15()) {
                    $dart$core.Object next$14;
                    if ((next$14 = iterator_1$12.next()) is !Finished) {
                        it$13 = next$14 as Iterable;
                        return true;
                    }
                    iterator_1$12 = null;
                }
                return false;
            }

            $dart$core.Object step$2$17() {
                if (!step$1$16()) {
                    return $package$finished;
                }
                Iterable it = it$13;
                return Boolean.instance(it.empty);
            }

            return new dart$Callable(step$2$17);
        }));
        return $package$any(arg$9$0);
    })();
    Iterator iterator() => new interleave$$anonymous$0_$$anonymous$1_(this);
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
Iterable $package$interleave([Sequence iterables]) => new interleave$$anonymous$0_(iterables);

Iterable interleave([Sequence iterables]) => $package$interleave(iterables);

abstract class Invertible implements Summable {
    $dart$core.Object get negated;
    $dart$core.Object minus([$dart$core.Object other]);
    static $dart$core.Object $minus([final Invertible $this, $dart$core.Object other]) => $this.plus((other as Invertible).negated);
}
class Iterable$exceptLast$$anonymous$2_$$anonymous$3_ implements Iterator {
    Iterable$exceptLast$$anonymous$2_ $outer$ceylon$language$Iterable$exceptLast$$anonymous$2_;
    Iterator $capture$$iter;
    Iterable$exceptLast$$anonymous$2_$$anonymous$3_([Iterable$exceptLast$$anonymous$2_ this.$outer$ceylon$language$Iterable$exceptLast$$anonymous$2_, Iterator this.$capture$$iter]) {
        _$current = $capture$$iter.next();
    }
    $dart$core.Object _$current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$13 = true;
            {
                $dart$core.Object next$14 = $capture$$iter.next();
                if (!(next$14 is Finished)) {
                    $dart$core.Object next;
                    next = next$14;
                    doElse$13 = false;
                    $dart$core.Object result = _$current;
                    _$current = next;
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
        _$returnInitial = true;
        _$partial = $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
    }
    $dart$core.bool _$returnInitial;
    $dart$core.Object _$partial;
    $dart$core.Object next() {
        if (_$returnInitial) {
            _$returnInitial = false;
            return $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
        } else {
            $dart$core.bool doElse$48 = true;
            {
                $dart$core.Object element$49 = $capture$$iter.next();
                if (!(element$49 is Finished)) {
                    $dart$core.Object element;
                    element = element$49;
                    doElse$48 = false;
                    _$partial = $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$accumulating.f(_$partial, element);
                    return _$partial;
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
        _$i = 0;
    }
    $dart$core.int _$i;
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
                    if (Boolean.nativeValue($outer$ceylon$language$Iterable$locations$$anonymous$6_.$capture$Iterable$locations$selecting.f(next) as Boolean)) {
                        doElse$58 = false;
                        return new Entry((() {
                            $dart$core.Object tmp$59 = Integer.instance(_$i);
                            Integer.instance(_$i = Integer.nativeValue(Integer.instance(_$i).successor));
                            return tmp$59;
                        })(), next);
                    }
                }
                if (doElse$58) {
                    _$i = Integer.nativeValue(Integer.instance(_$i).successor);
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
            $dart$core.int tmp$78 = i;
            i = Integer.nativeValue(Integer.instance(i).successor);
            return tmp$78;
        })() < $capture$Iterable$skip$skipping) && (!(iter.next() is Finished))) {}
        return iter;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable.toString() + ".iterator()";
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
        _$i = 0;
    }
    $dart$core.int _$i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter.next() : $lhs$)((_$i = Integer.nativeValue(Integer.instance(_$i).successor)) > $outer$ceylon$language$Iterable$take$$anonymous$10_.$capture$Iterable$take$taking ? $package$finished : null);
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
        _$first = true;
    }
    $dart$core.bool _$first;
    $dart$core.Object next() {
        if (_$first) {
            _$first = false;
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
                $dart$core.Object elem$79 = iter.next();
                if (elem$79 is Finished) {
                    break;
                }
                elem = elem$79;
            }
            if (!Boolean.nativeValue($capture$Iterable$skipWhile$skipping.f(elem) as Boolean)) {
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
        _$alive = true;
    }
    $dart$core.bool _$alive;
    $dart$core.Object next() {
        if (_$alive) {{
                $dart$core.Object next$80 = $capture$$iter.next();
                if (!(next$80 is Finished)) {
                    $dart$core.Object next;
                    next = next$80;
                    if (Boolean.nativeValue($outer$ceylon$language$Iterable$takeWhile$$anonymous$14_.$capture$Iterable$takeWhile$taking.f(next) as Boolean)) {
                        return next;
                    } else {
                        _$alive = false;
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
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").repeat(") + Integer.instance($capture$Iterable$repeat$times).toString()) + ")";
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
    $dart$core.String toString() => $outer$ceylon$language$Iterable$by$$anonymous$17_.toString() + ".iterator()";
}
class Iterable$by$$anonymous$17_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$by$step;
    Iterable$by$$anonymous$17_([Iterable this.$outer$ceylon$language$Iterable, $dart$core.int this.$capture$Iterable$by$step]) {}
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").by(") + Integer.instance($capture$Iterable$by$step).toString()) + ")";
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
        _$i = 0;
    }
    $dart$core.int _$i;
    $dart$core.Object next() => (() {
        $dart$core.bool doElse$98 = true;
        {
            $dart$core.Object next$99 = $capture$$iter.next();
            if (!(next$99 is Finished)) {
                $dart$core.Object next;
                next = next$99;
                doElse$98 = false;
                return new Entry((() {
                    $dart$core.Object tmp$100 = Integer.instance(_$i);
                    Integer.instance(_$i = Integer.nativeValue(Integer.instance(_$i).successor));
                    return tmp$100;
                })(), next);
            }
        }
        if (doElse$98) {
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
        _$previous = $capture$$iter.next();
    }
    $dart$core.Object _$previous;
    $dart$core.Object next() {{
            $dart$core.bool doElse$101 = true;
            {
                $dart$core.Object head$102 = _$previous;
                if (!(head$102 is Finished)) {
                    $dart$core.Object head;
                    head = head$102;
                    {
                        $dart$core.Object tip$103 = $capture$$iter.next();
                        if (!(tip$103 is Finished)) {
                            $dart$core.Object tip;
                            tip = tip$103;
                            doElse$101 = false;
                            _$previous = tip;
                            return new Tuple.$withList([head, tip]);
                        }
                    }
                }
            }
            if (doElse$101) {
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
            $dart$core.bool doElse$104 = true;
            {
                $dart$core.Object next$105 = $capture$$iter.next();
                if (!(next$105 is Finished)) {
                    $dart$core.Object next;
                    next = next$105;
                    doElse$104 = false;
                    Array array = $package$arrayOfSize($outer$ceylon$language$Iterable$partition$$anonymous$23_.$capture$Iterable$partition$length, next);
                    $dart$core.int index = 0;
                    while ((index = Integer.nativeValue(Integer.instance(index).successor)) < $outer$ceylon$language$Iterable$partition$$anonymous$23_.$capture$Iterable$partition$length) {{
                            $dart$core.bool doElse$106 = true;
                            {
                                $dart$core.Object current$107 = $capture$$iter.next();
                                if (!(current$107 is Finished)) {
                                    $dart$core.Object current;
                                    current = current$107;
                                    doElse$106 = false;
                                    array.set(index, current);
                                }
                            }
                            if (doElse$106) {
                                return new ArraySequence(array.spanTo(Integer.instance(index - 1)));
                            }
                        }
                    }
                    return new ArraySequence(array);
                }
            }
            if (doElse$104) {
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
        _$iter = $package$emptyIterator;
    }
    Iterator _$iter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$121 = true;
            {
                $dart$core.Object next$122 = _$iter.next();
                if (!(next$122 is Finished)) {
                    $dart$core.Object next;
                    next = next$122;
                    doElse$121 = false;
                    return next;
                }
            }
            if (doElse$121) {
                _$iter = $outer$ceylon$language$Iterable$cycled$$anonymous$26_._$orig.iterator();
                return _$iter.next();
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$cycled$$anonymous$26_.toString() + ".iterator()";
}
class Iterable$cycled$$anonymous$26_ implements Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$cycled$$anonymous$26_([Iterable this.$outer$ceylon$language$Iterable]) {}
    Iterable get _$orig => $outer$ceylon$language$Iterable;
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Iterable.toString()) + ").cycled";
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
        _$current = $capture$$iter.next();
        _$count = 0;
    }
    $dart$core.Object _$current;
    $dart$core.int _$count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$123 = true;
            {
                $dart$core.Object curr$124 = _$current;
                if (!(curr$124 is Finished)) {
                    $dart$core.Object curr;
                    curr = curr$124;
                    doElse$123 = false;
                    if (Integer.instance(($outer$ceylon$language$Iterable$interpose$$anonymous$28_.$capture$Iterable$interpose$step as $dart$core.int) + 1).divides(Integer.instance(_$count = Integer.nativeValue(Integer.instance(_$count).successor)))) {
                        return $outer$ceylon$language$Iterable$interpose$$anonymous$28_.$capture$Iterable$interpose$element;
                    } else {
                        _$current = $capture$$iter.next();
                        return curr;
                    }
                }
            }
            if (doElse$123) {
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
        _$it = $capture$$elements.iterator();
        _$count = 0;
        _$store = (() {
            $dart$core.int arg$125$0 = 16;
            $dart$core.Object arg$125$1 = null;
            return new Array.ofSize(arg$125$0, arg$125$1);
        })();
    }
    Iterator _$it;
    $dart$core.int _$count;
    Array _$store;
    $dart$core.int _$hash([$dart$core.Object element, $dart$core.int size]) => (() {
        $dart$core.bool doElse$126 = true;
        if (!(element == null)) {
            doElse$126 = false;
            return Integer.nativeValue(Integer.instance(element.hashCode).magnitude.remainder(Integer.instance(size)));
        }
        if (doElse$126) {
            return 0;
        }
    })();
    Array _$rebuild([Array store]) {
        Array newStore = (() {
            $dart$core.int arg$127$0 = store.size * 2;
            $dart$core.Object arg$127$1 = null;
            return new Array.ofSize(arg$127$0, arg$127$1);
        })();
        {
            $dart$core.Object element$129;
            Iterator iterator$128 = store.iterator();
            while ((element$129 = iterator$128.next()) is !Finished) {
                ElementEntry entries = element$129 as ElementEntry;
                ElementEntry entry = entries;
                while (true) {
                    ElementEntry e;
                    {
                        ElementEntry tmp$130 = entry;
                        if (tmp$130 == null) {
                            break;
                        }
                        e = tmp$130;
                    }
                    $dart$core.int index = _$hash(e.element, newStore.size);
                    newStore.set(index, new ElementEntry(e.element, newStore.get(Integer.instance(index)) as ElementEntry));
                    entry = e.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.Object next() {
        while (true) {{
                $dart$core.Object element = _$it.next();
                if (element is Finished) {
                    Finished element$131;
                    element$131 = element as Finished;
                    return element$131;
                } else {
                    $dart$core.int index = _$hash(element, _$store.size);
                    ElementEntry entry = _$store.get(Integer.instance(index)) as ElementEntry;
                    {
                        $dart$core.bool doElse$132 = true;
                        if (!(entry == null)) {
                            if (entry.has(element)) {
                                doElse$132 = false;
                            }
                        }
                        if (doElse$132) {
                            _$store.set(index, new ElementEntry(element, entry));
                            _$count = Integer.nativeValue(Integer.instance(_$count).successor);
                            if (_$count > (_$store.size * 2)) {
                                _$store = _$rebuild(_$store);
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
        _$index = 0;
        _$entry = null;
    }
    $dart$core.int _$index;
    GroupEntry _$entry;
    $dart$core.Object next() {{
            $dart$core.bool doElse$144 = true;
            {
                GroupEntry tmp$145 = _$entry;
                if (!(tmp$145 == null)) {
                    GroupEntry e;
                    e = tmp$145;
                    doElse$144 = false;
                    _$entry = e.next;
                    return new Entry(e.group, e.elements);
                }
            }
            if (doElse$144) {
                while (true) {
                    if (_$index >= $outer$ceylon$language$Iterable$group$$anonymous$32_._$store.size) {
                        return $package$finished;
                    } else {
                        _$entry = $outer$ceylon$language$Iterable$group$$anonymous$32_._$store.get((() {
                            Integer tmp$146 = Integer.instance(_$index);
                            Integer.instance(_$index = Integer.nativeValue(Integer.instance(_$index).successor));
                            return tmp$146;
                        })()) as GroupEntry;
                        {
                            GroupEntry tmp$147 = _$entry;
                            if (!(tmp$147 == null)) {
                                GroupEntry e;
                                e = tmp$147;
                                _$entry = e.next;
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
        _$store = (() {
            $dart$core.int arg$133$0 = 16;
            $dart$core.Object arg$133$1 = null;
            return new Array.ofSize(arg$133$0, arg$133$1);
        })();
        _$count = 0;
        {
            $dart$core.Object element$135;
            Iterator iterator$134 = $outer$ceylon$language$Iterable.iterator();
            while ((element$135 = iterator$134.next()) is !Finished) {
                $dart$core.Object element = element$135;
                $dart$core.Object group = $capture$Iterable$group$grouping.f(element);
                $dart$core.int index = _$hash(group, _$store.size);
                GroupEntry newEntry;
                {
                    $dart$core.bool doElse$136 = true;
                    {
                        GroupEntry tmp$137 = _$store.get(Integer.instance(index)) as GroupEntry;
                        if (!(tmp$137 == null)) {
                            GroupEntry entries;
                            entries = tmp$137;
                            doElse$136 = false;
                            {
                                $dart$core.bool doElse$138 = true;
                                {
                                    GroupEntry tmp$139 = entries.get(group);
                                    if (!(tmp$139 == null)) {
                                        GroupEntry entry;
                                        entry = tmp$139;
                                        doElse$138 = false;
                                        entry.elements = new ElementEntry(element, entry.elements);
                                        continue;
                                    }
                                }
                                if (doElse$138) {
                                    newEntry = new GroupEntry(group, new ElementEntry(element), entries);
                                }
                            }
                        }
                    }
                    if (doElse$136) {
                        newEntry = new GroupEntry(group, new ElementEntry(element));
                    }
                }
                _$store.set(index, newEntry);
                _$count = Integer.nativeValue(Integer.instance(_$count).successor);
                if (_$count > (_$store.size * 2)) {
                    _$store = _$rebuild(_$store);
                }
            }
        }
    }
    Array _$store;
    $dart$core.int _$hash([$dart$core.Object group, $dart$core.int size]) => Integer.nativeValue(Integer.instance(group.hashCode).magnitude.remainder(Integer.instance(size)));
    Array _$rebuild([Array store]) {
        Array newStore = (() {
            $dart$core.int arg$140$0 = store.size * 2;
            $dart$core.Object arg$140$1 = null;
            return new Array.ofSize(arg$140$0, arg$140$1);
        })();
        {
            $dart$core.Object element$142;
            Iterator iterator$141 = store.iterator();
            while ((element$142 = iterator$141.next()) is !Finished) {
                GroupEntry groups = element$142 as GroupEntry;
                GroupEntry group = groups;
                while (true) {
                    GroupEntry g;
                    {
                        GroupEntry tmp$143 = group;
                        if (tmp$143 == null) {
                            break;
                        }
                        g = tmp$143;
                    }
                    $dart$core.int index = _$hash(g.group, newStore.size);
                    newStore.set(index, new GroupEntry(g.group, g.elements, newStore.get(Integer.instance(index)) as GroupEntry));
                    group = g.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.int _$count;
    $dart$core.int get size => _$count;
    Iterator iterator() => new Iterable$group$$anonymous$32_$$anonymous$33_(this);
    Map clone() => this;
    GroupEntry _$group([$dart$core.Object key]) => ((GroupEntry $r) => $r == null ? null : $r.get(key))(_$store.get(Integer.instance(_$hash(key, _$store.size))) as GroupEntry);
    $dart$core.bool defines([$dart$core.Object key]) => !(_$group(key) == null);
    Sequence get([$dart$core.Object key]) => ((GroupEntry $r) => $r == null ? null : $r.elements)(_$group(key));
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
                step.f(element);
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
            return collecting.f(elem);
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
                if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                partial = accumulating.f(partial, elem);
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
                        partial = accumulating.f(partial, next);
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                        if ((comparing.f(val, max) as Comparison).equals($package$larger)) {
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
    Callable spread([Callable method]);
    static Callable $spread([final Iterable $this, Callable method]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$64 = false;
        $dart$core.bool step$0$65() {
            if (step$0$expired$64) {
                return false;
            }
            step$0$expired$64 = true;
            return true;
        }

        Iterator iterator_1$66;
        $dart$core.bool step$1$Init$69() {
            if (iterator_1$66 != null) {
                return true;
            }
            if (!step$0$65()) {
                return false;
            }
            iterator_1$66 = $this.iterator();
            return true;
        }

        $dart$core.Object elem$67;
        $dart$core.bool step$1$70() {
            while (step$1$Init$69()) {
                $dart$core.Object next$68;
                if ((next$68 = iterator_1$66.next()) is !Finished) {
                    elem$67 = next$68;
                    return true;
                }
                iterator_1$66 = null;
            }
            return false;
        }

        $dart$core.Object step$2$71() {
            if (!step$1$70()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$67;
            return (method.f(elem) as Callable).s(args);
        }

        return new dart$Callable(step$2$71);
    }))));
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
            $dart$core.Object element$73;
            Iterator iterator$72 = $this.iterator();
            while ((element$73 = iterator$72.next()) is !Finished) {
                $dart$core.Object elem = element$73;
                if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
                    count = Integer.nativeValue(Integer.instance(count).successor);
                }
            }
        }
        return count;
    }
    $dart$core.bool any([Callable selecting]);
    static $dart$core.bool $any([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$75;
            Iterator iterator$74 = $this.iterator();
            while ((element$75 = iterator$74.next()) is !Finished) {
                $dart$core.Object e = element$75;
                if (Boolean.nativeValue(selecting.f(e) as Boolean)) {
                    return true;
                }
            }
        }
        return false;
    }
    $dart$core.bool every([Callable selecting]);
    static $dart$core.bool $every([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$77;
            Iterator iterator$76 = $this.iterator();
            while ((element$77 = iterator$76.next()) is !Finished) {
                $dart$core.Object e = element$77;
                if (!Boolean.nativeValue(selecting.f(e) as Boolean)) {
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

        $dart$core.Object elem$84;
        $dart$core.bool step$1$87() {
            while (step$1$Init$86()) {
                $dart$core.Object next$85;
                if ((next$85 = iterator_1$83.next()) is !Finished) {
                    elem$84 = next$85;
                    return true;
                }
                iterator_1$83 = null;
            }
            return false;
        }

        $dart$core.Object step$2$88() {
            if (!step$1$87()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$84;
            return (($dart$core.Object $lhs$) => $lhs$ == null ? defaultValue : $lhs$)(elem);
        }

        return new dart$Callable(step$2$88);
    }));
    Iterable get coalesced;
    static Iterable $get$coalesced([final Iterable $this]) => functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$89 = false;
        $dart$core.bool step$0$90() {
            if (step$0$expired$89) {
                return false;
            }
            step$0$expired$89 = true;
            return true;
        }

        Iterator iterator_1$91;
        $dart$core.bool step$1$Init$94() {
            if (iterator_1$91 != null) {
                return true;
            }
            if (!step$0$90()) {
                return false;
            }
            iterator_1$91 = $this.iterator();
            return true;
        }

        $dart$core.Object e$92;
        $dart$core.bool step$1$95() {
            while (step$1$Init$94()) {
                $dart$core.Object next$93;
                if ((next$93 = iterator_1$91.next()) is !Finished) {
                    e$92 = next$93;
                    return true;
                }
                iterator_1$91 = null;
            }
            return false;
        }

        $dart$core.bool step$2$96() {
            while (step$1$95()) {
                $dart$core.Object e = e$92;
                if (!(!(e == null))) {
                    continue;
                }
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$97() {
            if (!step$2$96()) {
                return $package$finished;
            }
            $dart$core.Object e = e$92;
            return e;
        }

        return new dart$Callable(step$3$97);
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
        $dart$core.bool step$0$expired$108 = false;
        $dart$core.bool step$0$109() {
            if (step$0$expired$108) {
                return false;
            }
            step$0$expired$108 = true;
            return true;
        }

        Iterator iterator_1$110;
        $dart$core.bool step$1$Init$113() {
            if (iterator_1$110 != null) {
                return true;
            }
            if (!step$0$109()) {
                return false;
            }
            iterator_1$110 = $this.iterator();
            return true;
        }

        $dart$core.Object x$111;
        $dart$core.bool step$1$114() {
            while (step$1$Init$113()) {
                $dart$core.Object next$112;
                if ((next$112 = iterator_1$110.next()) is !Finished) {
                    x$111 = next$112;
                    return true;
                }
                iterator_1$110 = null;
            }
            return false;
        }

        Iterator iterator_2$115;
        $dart$core.bool step$2$Init$118() {
            if (iterator_2$115 != null) {
                return true;
            }
            if (!step$1$114()) {
                return false;
            }
            $dart$core.Object x = x$111;
            iterator_2$115 = other.iterator();
            return true;
        }

        $dart$core.Object y$116;
        $dart$core.bool step$2$119() {
            while (step$2$Init$118()) {
                $dart$core.Object x = x$111;
                $dart$core.Object next$117;
                if ((next$117 = iterator_2$115.next()) is !Finished) {
                    y$116 = next$117;
                    return true;
                }
                iterator_2$115 = null;
            }
            return false;
        }

        $dart$core.Object step$3$120() {
            if (!step$2$119()) {
                return $package$finished;
            }
            $dart$core.Object x = x$111;
            $dart$core.Object y = y$116;
            return new Tuple.$withList([x, y]);
        }

        return new dart$Callable(step$3$120);
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
$dart$core.String $package$commaList([Iterable elements]) => (() {
    Iterable arg$148$0 = functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$149 = false;
        $dart$core.bool step$0$150() {
            if (step$0$expired$149) {
                return false;
            }
            step$0$expired$149 = true;
            return true;
        }

        Iterator iterator_1$151;
        $dart$core.bool step$1$Init$154() {
            if (iterator_1$151 != null) {
                return true;
            }
            if (!step$0$150()) {
                return false;
            }
            iterator_1$151 = elements.iterator();
            return true;
        }

        $dart$core.Object e$152;
        $dart$core.bool step$1$155() {
            while (step$1$Init$154()) {
                $dart$core.Object next$153;
                if ((next$153 = iterator_1$151.next()) is !Finished) {
                    e$152 = next$153;
                    return true;
                }
                iterator_1$151 = null;
            }
            return false;
        }

        $dart$core.Object step$2$156() {
            if (!step$1$155()) {
                return $package$finished;
            }
            $dart$core.Object e = e$152;
            return String.instance($package$stringify(e));
        }

        return new dart$Callable(step$2$156);
    }));
    return String.instance(", ").join(arg$148$0);
})();

$dart$core.String commaList([Iterable elements]) => $package$commaList(elements);

class ElementEntry$$anonymous$34_ implements Iterator {
    ElementEntry $outer$ceylon$language$ElementEntry;
    ElementEntry$$anonymous$34_([ElementEntry this.$outer$ceylon$language$ElementEntry]) {
        _$entry = $outer$ceylon$language$ElementEntry;
    }
    ElementEntry _$entry;
    $dart$core.Object next() {{
            $dart$core.bool doElse$166 = true;
            {
                ElementEntry tmp$167 = _$entry;
                if (!(tmp$167 == null)) {
                    ElementEntry e;
                    e = tmp$167;
                    doElse$166 = false;
                    _$entry = e.next;
                    return e.element;
                }
            }
            if (doElse$166) {
                return $package$finished;
            }
        }
    }
}
class ElementEntry implements Sequence {
    ElementEntry([$dart$core.Object element, $dart$core.Object next = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(next, $package$dart$default)) {
            next = null;
        }
        return [element, next];
    })());
    ElementEntry.$s([$dart$core.List a]) : this.$w(a[0], a[1]);
    ElementEntry.$w([$dart$core.Object element, ElementEntry next]) {
        this.element = element;
        this.next = next;
    }
    $dart$core.Object element;
    ElementEntry next;
    $dart$core.Object get first => element;
    $dart$core.bool has([$dart$core.Object element]) {
        ElementEntry entry = this;
        while (true) {
            ElementEntry e;
            {
                ElementEntry tmp$159 = entry;
                if (tmp$159 == null) {
                    break;
                }
                e = tmp$159;
            }
            {
                $dart$core.bool doElse$157 = true;
                if (!(element == null)) {
                    doElse$157 = false;
                    {
                        $dart$core.Object tmp$158 = e.element;
                        if (!(tmp$158 == null)) {
                            $dart$core.Object ee;
                            ee = tmp$158;
                            if (element.equals(ee)) {
                                return true;
                            }
                        }
                    }
                }
                if (doElse$157) {
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
                $dart$core.Object element$161;
                Iterator iterator$160 = ($package$measure(Integer.instance(0), index) as List).iterator();
                while ((element$161 = iterator$160.next()) is !Finished) {
                    Integer i = element$161 as Integer;
                    {
                        $dart$core.bool doElse$162 = true;
                        {
                            ElementEntry tmp$163 = entry.next;
                            if (!(tmp$163 == null)) {
                                ElementEntry next;
                                next = tmp$163;
                                doElse$162 = false;
                                entry = next;
                            }
                        }
                        if (doElse$162) {
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
                ElementEntry tmp$164 = entry.next;
                if (tmp$164 == null) {
                    break;
                }
                next = tmp$164;
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
                ElementEntry tmp$165 = entry.next;
                if (tmp$165 == null) {
                    break;
                }
                next = tmp$165;
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
    GroupEntry([$dart$core.Object group, ElementEntry elements, $dart$core.Object next = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(next, $package$dart$default)) {
            next = null;
        }
        return [group, elements, next];
    })());
    GroupEntry.$s([$dart$core.List a]) : this.$w(a[0], a[1], a[2]);
    GroupEntry.$w([$dart$core.Object group, ElementEntry elements, GroupEntry next]) {
        this.group = group;
        this.elements = elements;
        this.next = next;
    }
    $dart$core.Object group;
    ElementEntry elements;
    GroupEntry next;
    GroupEntry get([$dart$core.Object group]) {
        GroupEntry entry = this;
        while (true) {
            GroupEntry e;
            {
                GroupEntry tmp$168 = entry;
                if (tmp$168 == null) {
                    break;
                }
                e = tmp$168;
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
        _$index = 0;
        _$size = $outer$ceylon$language$List.size;
    }
    $dart$core.int _$index;
    $dart$core.int _$size;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? List.$_$getElement(this.$outer$ceylon$language$List, (() {
        $dart$core.int tmp$5 = _$index;
        _$index = Integer.nativeValue(Integer.instance(_$index).successor);
        return tmp$5;
    })()) : $lhs$)(_$index >= _$size ? $package$finished : null);
    $dart$core.String toString() => $outer$ceylon$language$List.toString() + ".iterator()";
}
class List$collect$list_ implements List {
    List $outer$ceylon$language$List;
    Callable $capture$List$collect$collecting;
    List$collect$list_([List this.$outer$ceylon$language$List, Callable this.$capture$List$collect$collecting]) {
        size = $outer$ceylon$language$List.size;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index < size)) {
            return $capture$List$collect$collecting.f(List.$_$getElement($outer$ceylon$language$List, index));
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
        _$i = 0;
    }
    $dart$core.int _$i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$finished : $lhs$)(_$i < $outer$ceylon$language$List$Indexes.size ? (() {
        $dart$core.Object tmp$84 = Integer.instance(_$i);
        Integer.instance(_$i = Integer.nativeValue(Integer.instance(_$i).successor));
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
    List measure([Integer from, $dart$core.int length]) => clone().measure(from, length);
    List span([Integer from, Integer to]) => clone().span(from, to);
    List spanFrom([Integer from]) => clone().spanFrom(from);
    List spanTo([Integer to]) => clone().spanTo(to);
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
        _$i = 0;
    }
    $dart$core.int _$i;
    $dart$core.Object next() => (() {
        if (_$i < $outer$ceylon$language$List$Rest.size) {
            return List.$_$getElement($capture$$o, $outer$ceylon$language$List$Rest._$from + (() {
                $dart$core.int tmp$85 = _$i;
                _$i = Integer.nativeValue(Integer.instance(_$i).successor);
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
    List$Rest([List this.$outer$ceylon$language$List, $dart$core.int _$from]) {
        this._$from = _$from;
        if (!(this._$from >= 0)) {
            throw new AssertionError("Violated: from>=0");
        }
    }
    $dart$core.int _$from;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (index < 0) {
            return null;
        } else {
            return $outer$ceylon$language$List.getFromFirst(index + _$from);
        }
    })();
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = $outer$ceylon$language$List.size - _$from;
        return size > 0 ? size - 1 : null;
    })();
    List measure([Integer from, $dart$core.int length]) => $outer$ceylon$language$List.measure(Integer.instance(Integer.nativeValue(from) + this._$from), length);
    List span([Integer from, Integer to]) => $outer$ceylon$language$List.span(Integer.instance(Integer.nativeValue(from) + this._$from), Integer.instance(Integer.nativeValue(to) + this._$from));
    List spanFrom([Integer from]) => $outer$ceylon$language$List.spanFrom(Integer.instance(Integer.nativeValue(from) + this._$from));
    List spanTo([Integer to]) => $outer$ceylon$language$List.span(Integer.instance(this._$from), Integer.instance(Integer.nativeValue(to) + this._$from));
    List clone() => new List$Rest($outer$ceylon$language$List.clone(), _$from);
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
        _$i = 0;
    }
    $dart$core.int _$i;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? $capture$$iter.next() : $lhs$)((() {
        $dart$core.int tmp$86 = _$i;
        _$i = Integer.nativeValue(Integer.instance(_$i).successor);
        return tmp$86;
    })() > $outer$ceylon$language$List$Sublist._$to ? $package$finished : null);
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Sublist.toString()) + ".iterator()";
}
class List$Sublist implements List {
    List $outer$ceylon$language$List;
    List$Sublist([List this.$outer$ceylon$language$List, $dart$core.int _$to]) {
        this._$to = _$to;
        if (!(this._$to >= 0)) {
            throw new AssertionError("Violated: to>=0");
        }
    }
    $dart$core.int _$to;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index <= _$to)) {
            return $outer$ceylon$language$List.getFromFirst(index);
        } else {
            return null;
        }
    })();
    $dart$core.int get lastIndex => (() {
        $dart$core.int endIndex = $outer$ceylon$language$List.size - 1;
        return endIndex >= 0 ? (($dart$core.int $lhs$) => $lhs$ == null ? _$to : $lhs$)(endIndex < _$to ? endIndex : null) : null;
    })();
    List measure([Integer from, $dart$core.int length]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.measure(from, length) : $lhs$)(((Integer.nativeValue(from) + length) - 1) > _$to ? $outer$ceylon$language$List.measure(from, _$to) : null);
    List span([Integer from, Integer to]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.span(from, to) : $lhs$)(Integer.nativeValue(to) > this._$to ? $outer$ceylon$language$List.span(from, Integer.instance(this._$to)) : null);
    List spanFrom([Integer from]) => $outer$ceylon$language$List.span(from, Integer.instance(_$to));
    List spanTo([Integer to]) => ((List $lhs$) => $lhs$ == null ? $outer$ceylon$language$List.spanTo(to) : $lhs$)(Integer.nativeValue(to) > this._$to ? $outer$ceylon$language$List.spanTo(Integer.instance(this._$to)) : null);
    List clone() => new List$Sublist($outer$ceylon$language$List.clone(), _$to);
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
    List$Repeat([List this.$outer$ceylon$language$List, $dart$core.int _$times]) {
        this._$times = _$times;
    }
    $dart$core.int _$times;
    $dart$core.int get size => $outer$ceylon$language$List.size * _$times;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = this.size;
        return size > 0 ? size - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size = $outer$ceylon$language$List.size;
        return (() {
            if (index < (size * _$times)) {
                return $outer$ceylon$language$List.getFromFirst(Integer.nativeValue(Integer.instance(index).remainder(Integer.instance(size))));
            } else {
                return null;
            }
        })();
    })();
    List clone() => new List$Repeat($outer$ceylon$language$List.clone(), _$times);
    Iterator iterator() => new CycledIterator($outer$ceylon$language$List, _$times);
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$List.toString()) + ").repeat(") + Integer.instance(_$times).toString()) + ")";
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
        _$index = Integer.nativeValue(Integer.instance(1).negated);
    }
    $dart$core.int _$index;
    $dart$core.Object next() {
        if (Integer.instance(_$index = Integer.nativeValue(Integer.instance(_$index).successor)).equals(Integer.instance($outer$ceylon$language$List$Patch._$from))) {{
                $dart$core.Object element$88;
                Iterator iterator$87 = ($package$measure(Integer.instance(0), $outer$ceylon$language$List$Patch._$length) as List).iterator();
                while ((element$88 = iterator$87.next()) is !Finished) {
                    Integer skip = element$88 as Integer;
                    $capture$$iter.next();
                }
            }
        }
        return (() {
            if (((_$index - $outer$ceylon$language$List$Patch._$from) >= 0) && ((_$index - $outer$ceylon$language$List$Patch._$from) < $outer$ceylon$language$List$Patch._$list.size)) {
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
    List$Patch([List this.$outer$ceylon$language$List, List _$list, $dart$core.int _$from, $dart$core.int _$length]) {
        this._$list = _$list;
        this._$from = _$from;
        this._$length = _$length;
        if (!(this._$length >= 0)) {
            throw new AssertionError("Violated: length>=0");
        }
        if (!((this._$from >= 0) && (this._$from <= $outer$ceylon$language$List.size))) {
            throw new AssertionError("Violated: 0<=from<=outer.size");
        }
    }
    List _$list;
    $dart$core.int _$from;
    $dart$core.int _$length;
    $dart$core.int get size => ($outer$ceylon$language$List.size + _$list.size) - _$length;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size = this.size;
        return size > 0 ? size - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (index < _$from) {
            return $outer$ceylon$language$List.getFromFirst(index);
        } else {
            return (() {
                if ((index - _$from) < _$list.size) {
                    return _$list.getFromFirst(index - _$from);
                } else {
                    return $outer$ceylon$language$List.getFromFirst((index - _$list.size) + _$length);
                }
            })();
        }
    })();
    List clone() => new List$Patch($outer$ceylon$language$List.clone(), _$list.clone(), _$from, _$length);
    Iterator iterator() => (() {
        Iterator iter = $outer$ceylon$language$List.iterator();
        Iterator patchIter = _$list.iterator();
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
        _$index = $capture$$outerList.size - 1;
    }
    $dart$core.int _$index;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? List.$_$getElement($capture$$outerList, (() {
        $dart$core.int tmp$89 = _$index;
        _$index = Integer.nativeValue(Integer.instance(_$index).predecessor);
        return tmp$89;
    })()) : $lhs$)(_$index < 0 ? $package$finished : null);
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
    List measure([Integer from, $dart$core.int length]) => (() {
        if ((size > 0) && (length > 0)) {
            return (() {
                $dart$core.int start = (size - 1) - Integer.nativeValue(from);
                return $outer$ceylon$language$List.span(Integer.instance(start), Integer.instance((start - length) + 1));
            })();
        } else {
            return $package$empty;
        }
    })();
    List span([Integer from, Integer to]) => $outer$ceylon$language$List.span(to, from);
    List spanFrom([Integer from]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if ((endIndex >= 0) && (Integer.nativeValue(from) <= endIndex)) {
                return $outer$ceylon$language$List.span(Integer.instance(endIndex - Integer.nativeValue(from)), Integer.instance(0));
            } else {
                return $package$empty;
            }
        })();
    })();
    List spanTo([Integer to]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if ((endIndex >= 0) && (Integer.nativeValue(to) >= 0)) {
                return $outer$ceylon$language$List.span(Integer.instance(endIndex), Integer.instance(endIndex - Integer.nativeValue(to)));
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
        _$length = $capture$$list.size;
        _$permutation = new Array($package$measure(Integer.instance(0), _$length) as Iterable);
        _$indexes = new Array($package$measure(Integer.instance(0), _$length) as Iterable);
        _$swaps = new Array($package$measure(Integer.instance(0), _$length) as Iterable);
        _$directions = new Array.ofSize(_$length, Integer.instance(1).negated);
        _$counter = _$length;
    }
    $dart$core.int _$length;
    Array _$permutation;
    Array _$indexes;
    Array _$swaps;
    Array _$directions;
    $dart$core.int _$counter;
    $dart$core.Object next() {
        while (_$counter > 0) {
            if (Integer.instance(_$counter).equals(Integer.instance(_$length))) {
                _$counter = Integer.nativeValue(Integer.instance(_$counter).predecessor);
                Sequential result = _$permutation.collect(new dart$Callable(([Integer i]) {
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
                    $dart$core.int tmp$92 = Integer.nativeValue(_$swaps.get(Integer.instance(_$counter)) as Integer);
                    if (tmp$92 == null) {
                        throw new AssertionError("Violated: exists swap = swaps[counter]");
                    }
                    swap = tmp$92;
                }
                $dart$core.int dir;
                {
                    $dart$core.int tmp$93 = Integer.nativeValue(_$directions.get(Integer.instance(_$counter)) as Integer);
                    if (tmp$93 == null) {
                        throw new AssertionError("Violated: exists dir = directions[counter]");
                    }
                    dir = tmp$93;
                }
                if (swap > 0) {
                    $dart$core.int index;
                    {
                        $dart$core.int tmp$94 = Integer.nativeValue(_$indexes.get(Integer.instance(_$counter)) as Integer);
                        if (tmp$94 == null) {
                            throw new AssertionError("Violated: exists index = indexes[counter]");
                        }
                        index = tmp$94;
                    }
                    $dart$core.int otherIndex = index + dir;
                    $dart$core.int swapIndex;
                    {
                        $dart$core.int tmp$95 = Integer.nativeValue(_$permutation.get(Integer.instance(otherIndex)) as Integer);
                        if (tmp$95 == null) {
                            throw new AssertionError("Violated: exists swapIndex = permutation[otherIndex]");
                        }
                        swapIndex = tmp$95;
                    }
                    _$permutation.set(index, Integer.instance(swapIndex));
                    _$permutation.set(otherIndex, Integer.instance(_$counter));
                    _$indexes.set(swapIndex, Integer.instance(index));
                    _$indexes.set(_$counter, Integer.instance(otherIndex));
                    _$swaps.set(_$counter, Integer.instance(swap - 1));
                    _$counter = _$length;
                } else {
                    _$swaps.set(_$counter, Integer.instance(_$counter));
                    _$directions.set(_$counter, Integer.instance(dir).negated);
                    _$counter = Integer.nativeValue(Integer.instance(_$counter).predecessor);
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
    static $dart$core.Object $_$getElement([final List $this, $dart$core.int index]) {{
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(elem) as Boolean)) {
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
                if (!Boolean.nativeValue(selecting.f(element) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(element) as Boolean)) {
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
                    if (Boolean.nativeValue(selecting.f(element) as Boolean)) {
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
                            if (!Boolean.nativeValue(trimming.f(elem) as Boolean)) {
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
                            if (!Boolean.nativeValue(trimming.f(elem) as Boolean)) {
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
                            if (!Boolean.nativeValue(trimming.f(elem) as Boolean)) {
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
                            if (!Boolean.nativeValue(trimming.f(elem) as Boolean)) {
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
    static Tuple $slice([final List $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)), $this.spanFrom(Integer.instance(index))]);
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
        _$current = $outer$ceylon$language$loop$$anonymous$0_.$capture$loop$$start;
    }
    $dart$core.Object _$current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object result$1 = _$current;
                if (!(result$1 is Finished)) {
                    $dart$core.Object result;
                    result = result$1;
                    doElse$0 = false;
                    _$current = $outer$ceylon$language$loop$$anonymous$0_._$nextElement(result);
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
    $dart$core.Object _$nextElement([$dart$core.Object element]) => $capture$loop$next.f(element);
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
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).key)).iterator();
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
class Map$items$$anonymous$1_ implements Collection {
    Map $outer$ceylon$language$Map;
    Map$items$$anonymous$1_([Map this.$outer$ceylon$language$Map]) {}
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
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).item)).iterator();
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
class Map$mapItems$$anonymous$2_ implements Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$mapItems$mapping;
    Map$mapItems$$anonymous$2_([Map this.$outer$ceylon$language$Map, Callable this.$capture$Map$mapItems$mapping]) {}
    $dart$core.bool defines([$dart$core.Object key]) => $outer$ceylon$language$Map.defines(key);
    $dart$core.Object get([$dart$core.Object key]) {{
            $dart$core.bool doElse$17 = true;
            if (key != null) {
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
                    return $capture$Map$mapItems$mapping.f(key, item);
                }
            }
            if (doElse$17) {
                return null;
            }
        }
    }
    Entry _$mapEntry([Entry entry]) => new Entry(entry.key, $capture$Map$mapItems$mapping.f(entry.key, entry.item));
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(_$mapEntry)).iterator();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    Map clone() => $outer$ceylon$language$Map.clone().mapItems($capture$Map$mapItems$mapping);
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
class Map$filterKeys$$anonymous$3_ implements Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$filterKeys$filtering;
    Map$filterKeys$$anonymous$3_([Map this.$outer$ceylon$language$Map, Callable this.$capture$Map$filterKeys$filtering]) {}
    $dart$core.Object get([$dart$core.Object key]) => (() {
        $dart$core.bool doElse$19 = true;
        if (key != null) {
            if (Boolean.nativeValue($capture$Map$filterKeys$filtering.f(key) as Boolean)) {
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
        if (key != null) {
            if (Boolean.nativeValue($capture$Map$filterKeys$filtering.f(key) as Boolean)) {
                doElse$20 = false;
                return $outer$ceylon$language$Map.defines(key);
            }
        }
        if (doElse$20) {
            return false;
        }
    })();
    Iterator iterator() => $outer$ceylon$language$Map.filter($package$forKey($capture$Map$filterKeys$filtering)).iterator();
    Map clone() => $outer$ceylon$language$Map.clone().filterKeys($capture$Map$filterKeys$filtering);
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
class Map$patch$$anonymous$4_ implements Map {
    Map $outer$ceylon$language$Map;
    Map $capture$Map$patch$other;
    Map$patch$$anonymous$4_([Map this.$outer$ceylon$language$Map, Map this.$capture$Map$patch$other]) {}
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
    $dart$core.int get size => $outer$ceylon$language$Map.size + $capture$Map$patch$other.keys.count($package$not(new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($outer$ceylon$language$Map.defines($0)))));
    Iterator iterator() => new ChainedIterator($capture$Map$patch$other, $outer$ceylon$language$Map.filter($package$not(new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($capture$Map$patch$other.contains($0))))));
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
class Map$coalescedMap$$anonymous$5_ implements Map {
    Map $outer$ceylon$language$Map;
    Map$coalescedMap$$anonymous$5_([Map this.$outer$ceylon$language$Map]) {}
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
    static Collection $get$items([final Map $this]) => new Map$items$$anonymous$1_($this);
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
    static Map $mapItems([final Map $this, Callable mapping]) => new Map$mapItems$$anonymous$2_($this, mapping);
    Map filterKeys([Callable filtering]);
    static Map $filterKeys([final Map $this, Callable filtering]) => new Map$filterKeys$$anonymous$3_($this, filtering);
    Map patch([Map other]);
    static Map $patch([final Map $this, Map other]) => new Map$patch$$anonymous$4_($this, other);
    Map get coalescedMap;
    static Map $get$coalescedMap([final Map $this]) => new Map$coalescedMap$$anonymous$5_($this);
}
class emptyMap_ implements Map {
    emptyMap_() {}
    $dart$core.Object get([$dart$core.Object key]) => null;
    Collection get keys => $package$emptySet;
    Collection get items => $package$emptySet;
    Map clone() => this;
    Iterator iterator() => $package$emptyIterator;
    $dart$core.int get size => 0;
    $dart$core.bool get empty => true;
    $dart$core.bool defines([$dart$core.Object index]) => false;
    $dart$core.bool contains([$dart$core.Object element]) => false;
    $dart$core.bool containsAny([Iterable elements]) => false;
    $dart$core.bool containsEvery([Iterable elements]) => false;
    Map mapItems([Callable mapping]) => $package$emptyMap;
    $dart$core.int count([Callable selecting]) => 0;
    $dart$core.bool any([Callable selecting]) => false;
    $dart$core.bool every([Callable selecting]) => true;
    $dart$core.Object find([Callable selecting]) => null;
    $dart$core.Object findLast([Callable selecting]) => null;
    Iterable skip([$dart$core.int skipping]) => this;
    Iterable take([$dart$core.int taking]) => this;
    Iterable by([$dart$core.int step]) => this;
    void each([Callable step]) {}
    $dart$core.bool equals([$dart$core.Object that]) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hash(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
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
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
final emptyMap_ $package$emptyMap = new emptyMap_();

emptyMap_ get emptyMap => $package$emptyMap;

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
        _$count = 0;
        _$current = $outer$ceylon$language$Measure.first;
    }
    $dart$core.int _$count;
    $dart$core.Object _$current;
    $dart$core.Object next() {
        if (_$count >= $outer$ceylon$language$Measure.size) {
            return $package$finished;
        } else if ((() {
            Integer tmp$0 = Integer.instance(_$count);
            Integer.instance(_$count = Integer.nativeValue(Integer.instance(_$count).successor));
            return tmp$0;
        })().equals(Integer.instance(0))) {
            return _$current;
        } else {
            return _$current = (_$current as Enumerable).successor;
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Measure.toString()) + ").iterator()";
}
class Measure$By$$anonymous$1_ implements Iterator {
    Measure$By $outer$ceylon$language$Measure$By;
    Measure$By$$anonymous$1_([Measure$By this.$outer$ceylon$language$Measure$By]) {
        _$count = 0;
        _$current = $outer$ceylon$language$Measure$By.first;
    }
    $dart$core.int _$count;
    $dart$core.Object _$current;
    $dart$core.Object next() {
        if (_$count >= $outer$ceylon$language$Measure$By.size) {
            return $package$finished;
        } else {
            if ((() {
                Integer tmp$1 = Integer.instance(_$count);
                Integer.instance(_$count = Integer.nativeValue(Integer.instance(_$count).successor));
                return tmp$1;
            })().equals(Integer.instance(0))) {
                return _$current;
            } else {
                _$current = (_$current as Enumerable).neighbour($outer$ceylon$language$Measure$By._$step);
                return _$current;
            }
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Measure$By.toString()) + ".iterator()";
}
class Measure$By implements Iterable {
    Measure $outer$ceylon$language$Measure;
    Measure$By([Measure this.$outer$ceylon$language$Measure, $dart$core.int _$step]) {
        this._$step = _$step;
    }
    $dart$core.int _$step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Measure.size - 1) ~/ _$step);
    $dart$core.Object get first => $outer$ceylon$language$Measure.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Measure.toString()) + ").by(") + Integer.instance(_$step).toString()) + ")";
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
    Measure([$dart$core.Object first, $dart$core.int size]) {
        this.first = first;
        this.size = size;
        if (!(this.size > 0)) {
            throw new AssertionError("Violated: size > 0");
        }
    }
    $dart$core.Object first;
    $dart$core.int size;
    $dart$core.String toString() => (first.toString() + ":") + Integer.instance(size).toString();
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
            step.f((() {
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

abstract class meta$declaration$AliasDeclaration implements meta$declaration$NestableDeclaration, meta$declaration$GenericDeclaration {
    meta$declaration$OpenType get extendedType;
}
abstract class meta$declaration$AnnotatedDeclaration implements meta$declaration$Declaration, Annotated {
    Sequential annotations();
}
abstract class meta$declaration$CallableConstructorDeclaration implements meta$declaration$FunctionalDeclaration, meta$declaration$ConstructorDeclaration {
    $dart$core.bool get abstract;
    $dart$core.bool get defaultConstructor;
    meta$declaration$ClassDeclaration get container;
    $dart$core.Object invoke([$dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    $dart$core.Object memberInvoke([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    meta$model$CallableConstructor apply([Sequential typeArguments]);
    meta$model$MemberClassCallableConstructor memberApply([meta$model$Type containerType, Sequential typeArguments]);
}
abstract class meta$declaration$ClassDeclaration implements meta$declaration$ClassOrInterfaceDeclaration {
    $dart$core.bool get annotation;
    Sequential get parameterDeclarations;
    meta$declaration$FunctionOrValueDeclaration getParameterDeclaration([$dart$core.String name]);
    $dart$core.bool get abstract;
    $dart$core.bool get serializable;
    $dart$core.bool get anonymous;
    meta$declaration$ValueDeclaration get objectValue;
    $dart$core.bool get $final;
    meta$model$Class classApply([Sequential typeArguments]);
    meta$model$MemberClass memberClassApply([meta$model$Type containerType, Sequential typeArguments]);
    $dart$core.Object instantiate([$dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $instantiate([final meta$declaration$ClassDeclaration $this, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        if ($dart$core.identical(typeArguments, $package$dart$default)) {
            typeArguments = $package$empty;
        }
        return $this.classApply(typeArguments as Sequential).apply(arguments);
    }
    $dart$core.Object memberInstantiate([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $memberInstantiate([final meta$declaration$ClassDeclaration $this, $dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        if ($dart$core.identical(typeArguments, $package$dart$default)) {
            typeArguments = $package$empty;
        }
        return $this.memberClassApply(throw new AssertionError("Meta expressions unsupported at 'ClassDeclaration.ceylon: 103:54-103:62'"), typeArguments as Sequential).bind(container).apply(arguments);
    }
    $dart$core.Object getConstructorDeclaration([$dart$core.String name]);
    Sequential constructorDeclarations();
    Sequential annotatedConstructorDeclarations();
}
abstract class meta$declaration$ClassWithInitializerDeclaration implements meta$declaration$ClassDeclaration {
    Empty constructorDeclarations();
    static Empty $constructorDeclarations([final meta$declaration$ClassWithInitializerDeclaration $this]) => $package$empty;
    $dart$core.Object getConstructorDeclaration([$dart$core.String name]);
    static $dart$core.Object $getConstructorDeclaration([final meta$declaration$ClassWithInitializerDeclaration $this, $dart$core.String name]) => null;
    Empty annotatedConstructorDeclarations();
    static Empty $annotatedConstructorDeclarations([final meta$declaration$ClassWithInitializerDeclaration $this]) => $package$empty;
}
abstract class meta$declaration$ClassWithConstructorsDeclaration implements meta$declaration$ClassDeclaration {
    $dart$core.Object instantiate([$dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $instantiate([final meta$declaration$ClassWithConstructorsDeclaration $this, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        throw new meta$model$IncompatibleTypeException("class has constructors");
    }
    $dart$core.Object memberInstantiate([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $memberInstantiate([final meta$declaration$ClassWithConstructorsDeclaration $this, $dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        throw new meta$model$IncompatibleTypeException("class has constructors");
    }
}
abstract class meta$declaration$ClassOrInterfaceDeclaration implements meta$declaration$NestableDeclaration, meta$declaration$GenericDeclaration {
    meta$declaration$OpenClassType get extendedType;
    Sequential get satisfiedTypes;
    Sequential get caseTypes;
    $dart$core.bool get isAlias;
    Sequential memberDeclarations();
    Sequential declaredMemberDeclarations();
    Sequential annotatedMemberDeclarations();
    Sequential annotatedDeclaredMemberDeclarations();
    $dart$core.Object getMemberDeclaration([$dart$core.String name]);
    $dart$core.Object getDeclaredMemberDeclaration([$dart$core.String name]);
    meta$model$ClassOrInterface apply([Sequential typeArguments]);
    $dart$core.Object memberApply([meta$model$Type containerType, Sequential typeArguments]);
}
abstract class meta$declaration$ConstructorDeclaration implements meta$declaration$NestableDeclaration {
}
abstract class meta$declaration$Contained {
    meta$declaration$Package get containingPackage;
    meta$declaration$Module get containingModule;
    $dart$core.Object get container;
    $dart$core.bool get toplevel;
}
abstract class meta$declaration$Declaration {
    $dart$core.String get name;
    $dart$core.String get qualifiedName;
}
abstract class meta$declaration$FunctionalDeclaration implements meta$declaration$GenericDeclaration {
    $dart$core.bool get annotation;
    Sequential get parameterDeclarations;
    meta$declaration$FunctionOrValueDeclaration getParameterDeclaration([$dart$core.String name]);
    $dart$core.Object apply([Sequential typeArguments]);
    $dart$core.Object memberApply([meta$model$Type containerType, Sequential typeArguments]);
    $dart$core.Object invoke([$dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $invoke([final meta$declaration$FunctionalDeclaration $this, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        if ($dart$core.identical(typeArguments, $package$dart$default)) {
            typeArguments = $package$empty;
        }
        return ($this.apply(typeArguments as Sequential) as meta$model$Applicable).apply(arguments);
    }
    $dart$core.Object memberInvoke([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
}
abstract class meta$declaration$FunctionDeclaration implements meta$declaration$FunctionOrValueDeclaration, meta$declaration$FunctionalDeclaration {
    meta$model$Function apply([Sequential typeArguments]);
    meta$model$Method memberApply([meta$model$Type containerType, Sequential typeArguments]);
}
abstract class meta$declaration$FunctionOrValueDeclaration implements meta$declaration$NestableDeclaration {
    $dart$core.bool get parameter;
    $dart$core.bool get defaulted;
    $dart$core.bool get variadic;
}
abstract class meta$declaration$GenericDeclaration {
    Sequential get typeParameterDeclarations;
    meta$declaration$TypeParameter getTypeParameterDeclaration([$dart$core.String name]);
}
abstract class meta$declaration$InterfaceDeclaration implements meta$declaration$ClassOrInterfaceDeclaration {
    meta$model$Interface interfaceApply([Sequential typeArguments]);
    meta$model$MemberInterface memberInterfaceApply([meta$model$Type containerType, Sequential typeArguments]);
}
abstract class meta$declaration$Module implements meta$declaration$AnnotatedDeclaration {
    $dart$core.String get version;
    Sequential get members;
    Sequential get dependencies;
    meta$declaration$Package findPackage([$dart$core.String name]);
    meta$declaration$Package findImportedPackage([$dart$core.String name]);
    Resource resourceByPath([$dart$core.String path]);
}
abstract class meta$declaration$Import implements Annotated {
    $dart$core.String get name;
    $dart$core.String get version;
    $dart$core.bool get shared;
    $dart$core.bool get optional;
    meta$declaration$Module get container;
}
abstract class meta$declaration$Package implements meta$declaration$AnnotatedDeclaration {
    meta$declaration$Module get container;
    $dart$core.bool get shared;
    Sequential members();
    Sequential annotatedMembers();
    $dart$core.Object getMember([$dart$core.String name]);
    meta$declaration$ValueDeclaration getValue([$dart$core.String name]);
    meta$declaration$ClassOrInterfaceDeclaration getClassOrInterface([$dart$core.String name]);
    meta$declaration$FunctionDeclaration getFunction([$dart$core.String name]);
    meta$declaration$AliasDeclaration getAlias([$dart$core.String name]);
}
abstract class meta$declaration$NestableDeclaration implements meta$declaration$AnnotatedDeclaration, meta$declaration$TypedDeclaration, meta$declaration$Contained {
    $dart$core.bool get actual;
    $dart$core.bool get formal;
    $dart$core.bool get $default;
    $dart$core.bool get shared;
}
class meta$declaration$nothingType_ implements meta$declaration$OpenType {
    meta$declaration$nothingType_() {}
    $dart$core.String toString() => "Nothing";
}
final meta$declaration$nothingType_ $package$meta$declaration$nothingType = new meta$declaration$nothingType_();

meta$declaration$nothingType_ get meta$declaration$nothingType => $package$meta$declaration$nothingType;

abstract class meta$declaration$OpenClassOrInterfaceType implements meta$declaration$OpenType {
    meta$declaration$ClassOrInterfaceDeclaration get declaration;
    meta$declaration$OpenClassType get extendedType;
    Sequential get satisfiedTypes;
    Map get typeArguments;
}
abstract class meta$declaration$OpenClassType implements meta$declaration$OpenClassOrInterfaceType {
    meta$declaration$ClassDeclaration get declaration;
}
abstract class meta$declaration$OpenInterfaceType implements meta$declaration$OpenClassOrInterfaceType {
    meta$declaration$InterfaceDeclaration get declaration;
}
abstract class meta$declaration$OpenIntersection implements meta$declaration$OpenType {
    List get satisfiedTypes;
}
abstract class meta$declaration$OpenType {
}
abstract class meta$declaration$OpenTypeVariable implements meta$declaration$OpenType {
    meta$declaration$TypeParameter get declaration;
}
abstract class meta$declaration$OpenUnion implements meta$declaration$OpenType {
    List get caseTypes;
}
abstract class meta$declaration$ReferenceDeclaration implements meta$declaration$ValueDeclaration {
}
abstract class meta$declaration$SetterDeclaration implements meta$declaration$NestableDeclaration {
    meta$declaration$ValueDeclaration get variable;
    $dart$core.bool get actual;
    static $dart$core.bool $get$actual([final meta$declaration$SetterDeclaration $this]) => $this.variable.actual;
    $dart$core.bool get formal;
    static $dart$core.bool $get$formal([final meta$declaration$SetterDeclaration $this]) => $this.variable.formal;
    $dart$core.bool get $default;
    static $dart$core.bool $get$$default([final meta$declaration$SetterDeclaration $this]) => $this.variable.$default;
    $dart$core.bool get shared;
    static $dart$core.bool $get$shared([final meta$declaration$SetterDeclaration $this]) => $this.variable.shared;
    meta$declaration$Package get containingPackage;
    static meta$declaration$Package $get$containingPackage([final meta$declaration$SetterDeclaration $this]) => $this.variable.containingPackage;
    meta$declaration$Module get containingModule;
    static meta$declaration$Module $get$containingModule([final meta$declaration$SetterDeclaration $this]) => $this.variable.containingModule;
    $dart$core.Object get container;
    static $dart$core.Object $get$container([final meta$declaration$SetterDeclaration $this]) => $this.variable.container;
    $dart$core.bool get toplevel;
    static $dart$core.bool $get$toplevel([final meta$declaration$SetterDeclaration $this]) => $this.variable.toplevel;
}
abstract class meta$declaration$TypedDeclaration {
    meta$declaration$OpenType get openType;
}
abstract class meta$declaration$TypeParameter implements meta$declaration$Declaration {
    meta$declaration$NestableDeclaration get container;
    $dart$core.bool get defaulted;
    meta$declaration$OpenType get defaultTypeArgument;
    meta$declaration$Variance get variance;
    Sequential get satisfiedTypes;
    Sequential get caseTypes;
}
abstract class meta$declaration$ValueableDeclaration {
    $dart$core.Object apply();
    $dart$core.Object memberApply([meta$model$Type containerType]);
    $dart$core.Object get();
    static $dart$core.Object $get([final meta$declaration$ValueableDeclaration $this]) => ($this.apply() as meta$model$Gettable).get();
    $dart$core.Object memberGet([$dart$core.Object container]);
}
abstract class meta$declaration$ValueConstructorDeclaration implements meta$declaration$ValueableDeclaration, meta$declaration$ConstructorDeclaration {
    meta$declaration$ClassDeclaration get container;
    meta$model$ValueConstructor apply();
    meta$model$MemberClassValueConstructor memberApply([meta$model$Type containerType]);
    $dart$core.Object get();
    static $dart$core.Object $get([final meta$declaration$ValueConstructorDeclaration $this]) => $this.apply().get();
    $dart$core.Object memberGet([$dart$core.Object container]);
    static $dart$core.Object $memberGet([final meta$declaration$ValueConstructorDeclaration $this, $dart$core.Object container]) => $this.memberApply(throw new AssertionError("Meta expressions unsupported at 'ValueConstructorDeclaration.ceylon: 35:44-35:52'")).bind(container).get();
}
abstract class meta$declaration$ValueDeclaration implements meta$declaration$FunctionOrValueDeclaration, meta$declaration$NestableDeclaration, meta$declaration$ValueableDeclaration {
    $dart$core.bool get late;
    $dart$core.bool get variable;
    $dart$core.bool get objectValue;
    meta$declaration$ClassDeclaration get objectClass;
    meta$model$Value apply();
    meta$model$Attribute memberApply([meta$model$Type containerType]);
    $dart$core.Object get();
    static $dart$core.Object $get([final meta$declaration$ValueDeclaration $this]) => $this.apply().get();
    $dart$core.Object memberGet([$dart$core.Object container]);
    static $dart$core.Object $memberGet([final meta$declaration$ValueDeclaration $this, $dart$core.Object container]) => $this.memberApply(throw new AssertionError("Meta expressions unsupported at 'ValueDeclaration.ceylon: 81:55-81:63'")).bind(container).get();
    void set([$dart$core.Object newValue]);
    static void $set([final meta$declaration$ValueDeclaration $this, $dart$core.Object newValue]) => $this.apply().setIfAssignable(newValue);
    void memberSet([$dart$core.Object container, $dart$core.Object newValue]);
    meta$declaration$SetterDeclaration get setter;
}
abstract class meta$declaration$Variance {
}
class meta$declaration$invariant_ implements meta$declaration$Variance {
    meta$declaration$invariant_() {}
    $dart$core.String toString() => "Invariant";
}
final meta$declaration$invariant_ $package$meta$declaration$invariant = new meta$declaration$invariant_();

meta$declaration$invariant_ get meta$declaration$invariant => $package$meta$declaration$invariant;

class meta$declaration$covariant_ implements meta$declaration$Variance {
    meta$declaration$covariant_() {}
    $dart$core.String toString() => "Covariant";
}
final meta$declaration$covariant_ $package$meta$declaration$covariant = new meta$declaration$covariant_();

meta$declaration$covariant_ get meta$declaration$covariant => $package$meta$declaration$covariant;

class meta$declaration$contravariant_ implements meta$declaration$Variance {
    meta$declaration$contravariant_() {}
    $dart$core.String toString() => "Contravariant";
}
final meta$declaration$contravariant_ $package$meta$declaration$contravariant = new meta$declaration$contravariant_();

meta$declaration$contravariant_ get meta$declaration$contravariant => $package$meta$declaration$contravariant;

abstract class meta$model$Applicable implements Callable {
    $dart$core.Object apply([Sequential arguments]);
    $dart$core.Object namedApply([Iterable arguments]);
}
abstract class meta$model$Attribute implements meta$model$ValueModel, meta$model$Member {
    meta$declaration$ValueDeclaration get declaration;
    meta$model$Value bind([$dart$core.Object container]);
}
abstract class meta$model$CallableConstructor implements meta$model$FunctionModel, meta$model$Applicable {
    meta$declaration$CallableConstructorDeclaration get declaration;
    meta$model$ClassModel get type;
    meta$model$ClassModel get container;
}
abstract class meta$model$Class implements meta$model$ClassModel, meta$model$Applicable {
    $dart$core.Object get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
}
abstract class meta$model$ClassModel implements meta$model$ClassOrInterface {
    meta$declaration$ClassDeclaration get declaration;
    $dart$core.Object get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
    Sequential get constructors;
    Sequential get declaredConstructors;
}
abstract class meta$model$ClassOrInterface implements meta$model$Model, meta$model$Generic, meta$model$Type {
    meta$declaration$ClassOrInterfaceDeclaration get declaration;
    meta$model$ClassModel get extendedType;
    Sequential get satisfiedTypes;
    Sequential get caseValues;
    meta$model$Member getClassOrInterface([$dart$core.String name, Sequential types]);
    meta$model$Member getDeclaredClassOrInterface([$dart$core.String name, Sequential types]);
    meta$model$MemberClass getClass([$dart$core.String name, Sequential types]);
    meta$model$MemberClass getDeclaredClass([$dart$core.String name, Sequential types]);
    meta$model$MemberInterface getInterface([$dart$core.String name, Sequential types]);
    meta$model$MemberInterface getDeclaredInterface([$dart$core.String name, Sequential types]);
    meta$model$Method getMethod([$dart$core.String name, Sequential types]);
    meta$model$Method getDeclaredMethod([$dart$core.String name, Sequential types]);
    meta$model$Attribute getAttribute([$dart$core.String name]);
    meta$model$Attribute getDeclaredAttribute([$dart$core.String name]);
    Sequential getDeclaredAttributes([Sequential annotationTypes]);
    Sequential getAttributes([Sequential annotationTypes]);
    Sequential getDeclaredMethods([Sequential annotationTypes]);
    Sequential getMethods([Sequential annotationTypes]);
    Sequential getDeclaredClasses([Sequential annotationTypes]);
    Sequential getClasses([Sequential annotationTypes]);
    Sequential getDeclaredInterfaces([Sequential annotationTypes]);
    Sequential getInterfaces([Sequential annotationTypes]);
}
abstract class meta$model$Constructor implements meta$model$ConstructorModel, meta$model$Applicable {
    meta$declaration$ConstructorDeclaration get declaration;
    meta$model$Class get container;
}
abstract class meta$model$ConstructorModel implements meta$model$Functional, meta$model$Declared {
    meta$model$ClassModel get container;
}
abstract class meta$model$Declared {
    meta$declaration$Declaration get declaration;
    $dart$core.Object get container;
}
abstract class meta$model$Function implements meta$model$FunctionModel, meta$model$Applicable {
    meta$declaration$FunctionDeclaration get declaration;
}
abstract class meta$model$Functional {
    Sequential get parameterTypes;
}
abstract class meta$model$FunctionModel implements meta$model$Model, meta$model$Generic, meta$model$Functional {
    $dart$core.Object get declaration;
    meta$model$Type get type;
}
abstract class meta$model$Generic {
    Map get typeArguments;
    Sequential get typeArgumentList;
}
abstract class meta$model$Gettable {
    $dart$core.Object get();
    void set([$dart$core.Object newValue]);
    void setIfAssignable([$dart$core.Object newValue]);
}
class meta$model$IncompatibleTypeException  extends Exception {
    meta$model$IncompatibleTypeException([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
abstract class meta$model$Interface implements meta$model$InterfaceModel {
}
abstract class meta$model$InterfaceModel implements meta$model$ClassOrInterface {
    meta$declaration$InterfaceDeclaration get declaration;
}
abstract class meta$model$IntersectionType implements meta$model$Type {
    List get satisfiedTypes;
}
class meta$model$InvocationException  extends Exception {
    meta$model$InvocationException([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
abstract class meta$model$Member implements meta$model$Qualified {
    meta$model$Type get declaringType;
}
abstract class meta$model$MemberClass implements meta$model$ClassModel, meta$model$Member {
    meta$model$Class bind([$dart$core.Object container]);
    $dart$core.Object get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
}
abstract class meta$model$MemberClassCallableConstructor implements meta$model$FunctionModel, meta$model$Qualified {
    meta$declaration$CallableConstructorDeclaration get declaration;
    meta$model$MemberClass get type;
    meta$model$ClassModel get container;
    meta$model$CallableConstructor bind([$dart$core.Object container]);
}
abstract class meta$model$MemberClassConstructor implements meta$model$ConstructorModel, meta$model$Qualified {
    meta$model$MemberClass get container;
}
abstract class meta$model$MemberClassValueConstructor implements meta$model$ValueModel, meta$model$Qualified {
    meta$declaration$ValueConstructorDeclaration get declaration;
    meta$model$MemberClass get type;
    meta$model$ClassModel get container;
    meta$model$ValueConstructor bind([$dart$core.Object container]);
}
abstract class meta$model$MemberInterface implements meta$model$InterfaceModel, meta$model$Member {
    meta$model$Interface bind([$dart$core.Object container]);
}
abstract class meta$model$Method implements meta$model$FunctionModel, meta$model$Member {
    meta$declaration$FunctionDeclaration get declaration;
    meta$model$Function bind([$dart$core.Object container]);
}
abstract class meta$model$Model implements meta$model$Declared {
    meta$model$Type get container;
    meta$declaration$NestableDeclaration get declaration;
}
class meta$model$MutationException  extends Exception {
    meta$model$MutationException([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
class meta$model$nothingType_ implements meta$model$Type {
    meta$model$nothingType_() {}
    $dart$core.String toString() => "Nothing";
    $dart$core.bool typeOf([$dart$core.Object instance]) => false;
    $dart$core.bool exactly([meta$model$Type type]) => type.equals($package$meta$model$nothingType);
    $dart$core.bool supertypeOf([meta$model$Type type]) => exactly(type);
    $dart$core.bool subtypeOf([meta$model$Type type]) => true;
    meta$model$Type union([meta$model$Type type]) => type;
    meta$model$Type intersection([meta$model$Type type]) => this;
}
final meta$model$nothingType_ $package$meta$model$nothingType = new meta$model$nothingType_();

meta$model$nothingType_ get meta$model$nothingType => $package$meta$model$nothingType;

abstract class meta$model$Qualified implements Callable {
    $dart$core.Object bind([$dart$core.Object container]);
}
class meta$model$StorageException  extends Exception {
    meta$model$StorageException([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
abstract class meta$model$Type {
    $dart$core.bool typeOf([$dart$core.Object instance]);
    $dart$core.bool supertypeOf([meta$model$Type type]);
    $dart$core.bool subtypeOf([meta$model$Type type]);
    static $dart$core.bool $subtypeOf([final meta$model$Type $this, meta$model$Type type]) => type.supertypeOf($this);
    $dart$core.bool exactly([meta$model$Type type]);
    meta$model$Type union([meta$model$Type other]);
    meta$model$Type intersection([meta$model$Type other]);
}
class meta$model$TypeApplicationException  extends Exception {
    meta$model$TypeApplicationException([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
abstract class meta$model$UnionType implements meta$model$Type {
    List get caseTypes;
}
abstract class meta$model$Value implements meta$model$ValueModel, meta$model$Gettable {
    meta$declaration$ValueDeclaration get declaration;
}
abstract class meta$model$ValueConstructor implements meta$model$ValueModel, meta$model$Gettable {
    meta$declaration$ValueConstructorDeclaration get declaration;
    meta$model$Class get type;
    meta$model$Class get container;
}
abstract class meta$model$ValueModel implements meta$model$Model {
    $dart$core.Object get declaration;
    meta$model$Type get type;
}
$dart$core.Object $package$meta$optionalAnnotation([meta$model$Class annotationType, $dart$core.Object programElement]) {
    return $package$meta$annotations(annotationType, programElement);
}

$dart$core.Object meta$optionalAnnotation([meta$model$Class annotationType, $dart$core.Object programElement]) => $package$meta$optionalAnnotation(annotationType, programElement);

Sequential $package$meta$sequencedAnnotations([meta$model$Class annotationType, $dart$core.Object programElement]) {
    return $package$meta$annotations(annotationType, programElement) as Sequential;
}

Sequential meta$sequencedAnnotations([meta$model$Class annotationType, $dart$core.Object programElement]) => $package$meta$sequencedAnnotations(annotationType, programElement);

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

Callable $package$not([Callable p]) => new dart$Callable(([$dart$core.Object $0]) => Boolean.instance((([$dart$core.Object val]) => !Boolean.nativeValue(p.f(val) as Boolean))($0)));

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
class operatingSystem_ {
    operatingSystem_() {}
    $dart$core.String get version => "Unknown";
    $dart$core.String get newline => "\n";
}
final operatingSystem_ $package$operatingSystem = new operatingSystem_();

operatingSystem_ get operatingSystem => $package$operatingSystem;

abstract class OptionalAnnotation implements ConstrainedAnnotation {
}
Callable $package$or([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object $0]) => Boolean.instance((([$dart$core.Object val]) => Boolean.nativeValue(p.f(val) as Boolean) || Boolean.nativeValue(q.f(val) as Boolean))($0)));

Callable or([Callable p, Callable q]) => $package$or(p, q);

abstract class Ordinal {
    $dart$core.Object get successor;
    $dart$core.Object get predecessor;
}
class OverflowException  extends Exception {
    OverflowException([$dart$core.Object _$message = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(_$message, $package$dart$default)) {
            _$message = "Numeric overflow";
        }
        return [_$message];
    })());
    OverflowException.$s([$dart$core.List a]) : this.$w(a[0]);
    OverflowException.$w([$dart$core.String _$message]) : super(_$message) {
        this._$message = _$message;
    }
    $dart$core.String _$message;
}
class mapPairs$iterable_$iterator$iterator_ implements Iterator {
    mapPairs$iterable_ $outer$ceylon$language$mapPairs$iterable_;
    mapPairs$iterable_$iterator$iterator_([mapPairs$iterable_ this.$outer$ceylon$language$mapPairs$iterable_]) {
        _$firstIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$firstIterable.iterator();
        _$secondIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$secondIterable.iterator();
    }
    Iterator _$firstIter;
    Iterator _$secondIter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object first$1 = _$firstIter.next();
                if (!(first$1 is Finished)) {
                    $dart$core.Object first;
                    first = first$1;
                    {
                        $dart$core.Object second$2 = _$secondIter.next();
                        if (!(second$2 is Finished)) {
                            $dart$core.Object second;
                            second = second$2;
                            doElse$0 = false;
                            return $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$collecting.f(first, second);
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
        if (Boolean.nativeValue(selecting.f(first, second) as Boolean)) {
            return new Tuple.$withList([first, second]);
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
        if (!Boolean.nativeValue(selecting.f(first, second) as Boolean)) {
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
        if (Boolean.nativeValue(selecting.f(first, second) as Boolean)) {
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
        partial = accumulating.f(partial, first, second);
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

$dart$core.double $package$parseFloat([$dart$core.String string]) {
    $dart$core.int sign;
    $dart$core.String unsignedPart;
    if (String.instance(string).startsWith(String.instance("-"))) {
        sign = Integer.nativeValue(Integer.instance(1).negated);
        unsignedPart = String.nativeValue(String.instance(string).spanFrom(Integer.instance(1)));
    } else if (String.instance(string).startsWith(String.instance("+"))) {
        sign = 1;
        unsignedPart = String.nativeValue(String.instance(string).spanFrom(Integer.instance(1)));
    } else {
        sign = 1;
        unsignedPart = string;
    }
    $dart$core.String wholePart;
    $dart$core.String fractionalPart;
    $dart$core.String rest;
    {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.int tmp$1 = String.instance(unsignedPart).firstOccurrence(new Character.$fromInt(46));
            if (!(tmp$1 == null)) {
                $dart$core.int dot;
                dot = tmp$1;
                doElse$0 = false;
                wholePart = String.nativeValue(String.instance(unsignedPart).spanTo(Integer.instance(dot - 1)));
                $dart$core.String afterWholePart = String.nativeValue(String.instance(unsignedPart).spanFrom(Integer.instance(dot + 1)));
                {
                    $dart$core.bool doElse$2 = true;
                    {
                        $dart$core.int tmp$3 = String.instance(afterWholePart).firstIndexWhere(new dart$Callable(([$dart$core.Object $r]) => Boolean.instance(($r as Character).letter)));
                        if (!(tmp$3 == null)) {
                            $dart$core.int mag;
                            mag = tmp$3;
                            doElse$2 = false;
                            fractionalPart = String.nativeValue(String.instance(afterWholePart).spanTo(Integer.instance(mag - 1)));
                            rest = String.nativeValue(String.instance(afterWholePart).spanFrom(Integer.instance(mag)));
                        }
                    }
                    if (doElse$2) {
                        fractionalPart = afterWholePart;
                        rest = null;
                    }
                }
            }
        }
        if (doElse$0) {{
                $dart$core.bool doElse$4 = true;
                {
                    $dart$core.int tmp$5 = String.instance(unsignedPart).firstIndexWhere(new dart$Callable(([$dart$core.Object $r]) => Boolean.instance(($r as Character).letter)));
                    if (!(tmp$5 == null)) {
                        $dart$core.int mag;
                        mag = tmp$5;
                        doElse$4 = false;
                        wholePart = String.nativeValue(String.instance(unsignedPart).spanTo(Integer.instance(mag - 1)));
                        rest = String.nativeValue(String.instance(unsignedPart).spanFrom(Integer.instance(mag)));
                    }
                }
                if (doElse$4) {
                    wholePart = unsignedPart;
                    rest = null;
                }
            }
            fractionalPart = "0";
        }
    }
    if ((!String.instance(wholePart).every(new dart$Callable(([$dart$core.Object $r]) => Boolean.instance(($r as Character).digit)))) || (!String.instance(fractionalPart).every(new dart$Callable(([$dart$core.Object $r]) => Boolean.instance(($r as Character).digit))))) {
        return null;
    }
    {
        $dart$core.int tmp$6 = $package$parseInteger(wholePart);
        if (!(tmp$6 == null)) {
            $dart$core.int whole;
            whole = tmp$6;
            {
                $dart$core.int tmp$7 = $package$parseInteger(fractionalPart);
                if (!(tmp$7 == null)) {
                    $dart$core.int fractional;
                    fractional = tmp$7;
                    $dart$core.int shift = String.instance(fractionalPart).size;
                    $dart$core.int exponent;
                    {
                        $dart$core.bool doElse$8 = true;
                        if (!(rest == null)) {
                            doElse$8 = false;
                            {
                                $dart$core.bool doElse$10 = true;
                                {
                                    $dart$core.int tmp$11 = $package$parseFloatExponent(rest);
                                    if (!(tmp$11 == null)) {
                                        $dart$core.int magnitude;
                                        magnitude = tmp$11;
                                        doElse$10 = false;
                                        exponent = magnitude - shift;
                                    }
                                }
                                if (doElse$10) {
                                    return null;
                                }
                            }
                        }
                        if (doElse$8) {
                            $dart$core.Object rest$9;
                            rest$9 = String.instance(rest);
                            exponent = Integer.nativeValue(Integer.instance(shift).negated);
                        }
                    }
                    $dart$core.int numerator = (whole * Integer.nativeValue(Integer.instance(10).power(Integer.instance(shift)))) + fractional;
                    $dart$core.double signedNumerator = (($dart$core.double $lhs$) => $lhs$ == null ? Integer.instance(sign * numerator).float : $lhs$)(Integer.instance(numerator).zero ? Integer.instance(0).float * Integer.instance(sign).float : null);
                    $dart$core.int exponentMagnitude = Integer.nativeValue(Integer.instance(exponent).magnitude);
                    if (Integer.instance(exponentMagnitude).equals(Integer.instance(0))) {
                        return signedNumerator;
                    } else if (exponentMagnitude < $package$maximumIntegerExponent) {
                        $dart$core.int scale = Integer.nativeValue(Integer.instance(10).power(Integer.instance(exponentMagnitude)));
                        return (($dart$core.double $lhs$) => $lhs$ == null ? signedNumerator * Integer.instance(scale).float : $lhs$)(exponent < 0 ? signedNumerator / Integer.instance(scale).float : null);
                    } else {
                        return signedNumerator * Float.nativeValue(Float.instance(10.0).power(Float.instance(Integer.instance(exponent).float)));
                    }
                }
            }
        }
    }
    return null;
}

$dart$core.double parseFloat([$dart$core.String string]) => $package$parseFloat(string);

$dart$core.int $package$maximumIntegerExponent = Integer.nativeValue($package$smallest(Integer.instance(String.instance(Integer.instance($package$runtime.maxIntegerValue).toString()).size), Integer.instance(String.instance(Integer.instance($package$runtime.minIntegerValue).toString()).size - 1)) as Integer);

$dart$core.int get maximumIntegerExponent => $package$maximumIntegerExponent;

$dart$core.int $package$parseFloatExponent([$dart$core.String string]) {{
        $dart$core.String switch$12 = string;
        if (String.instance(switch$12).equals(String.instance("k"))) {
            return 3;
        } else if (String.instance(switch$12).equals(String.instance("M"))) {
            return 6;
        } else if (String.instance(switch$12).equals(String.instance("G"))) {
            return 9;
        } else if (String.instance(switch$12).equals(String.instance("T"))) {
            return 12;
        } else if (String.instance(switch$12).equals(String.instance("P"))) {
            return 15;
        } else if (String.instance(switch$12).equals(String.instance("m"))) {
            return Integer.nativeValue(Integer.instance(3).negated);
        } else if (String.instance(switch$12).equals(String.instance("u"))) {
            return Integer.nativeValue(Integer.instance(6).negated);
        } else if (String.instance(switch$12).equals(String.instance("n"))) {
            return Integer.nativeValue(Integer.instance(9).negated);
        } else if (String.instance(switch$12).equals(String.instance("p"))) {
            return Integer.nativeValue(Integer.instance(12).negated);
        } else if (String.instance(switch$12).equals(String.instance("f"))) {
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

Callable $package$digitOrSign = $package$or(new dart$Callable(([$dart$core.Object $r]) => Boolean.instance(($r as Character).digit)), (() {
    String $r = String.instance("+-");
    return new dart$Callable(([$dart$core.Object $0]) => Boolean.instance($r.contains($0)));
})());

Callable get digitOrSign => $package$digitOrSign;

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

$dart$core.String $package$stringify([$dart$core.Object val]) => (($dart$core.String $lhs$) => $lhs$ == null ? "<null>" : $lhs$)((($dart$core.Object $r) => $r == null ? null : $r.toString())(val));

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
        if (element != null) {
            doElse$0 = false;
            return containsElement(element);
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.bool occurs([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$1 = true;
        if (element != null) {
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
    Sequence$collect$list_([Sequence this.$outer$ceylon$language$Sequence, Callable this.$capture$Sequence$collect$collecting]) {
        size = $outer$ceylon$language$Sequence.size;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$Sequence.lastIndex;
    $dart$core.int size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if ((index >= 0) && (index < size)) {
            return $capture$Sequence$collect$collecting.f(Sequence.$_$getElement($outer$ceylon$language$Sequence, index));
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
        _$index = $capture$$outerList.size - 1;
    }
    $dart$core.int _$index;
    $dart$core.Object next() => (($dart$core.Object $lhs$) => $lhs$ == null ? Sequence.$_$getElement($capture$$outerList, (() {
        $dart$core.int tmp$8 = _$index;
        _$index = Integer.nativeValue(Integer.instance(_$index).predecessor);
        return tmp$8;
    })()) : $lhs$)(_$index < 0 ? $package$finished : null);
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
    Sequential measure([Integer from, $dart$core.int length]) => (() {
        if (length > 0) {
            return (() {
                $dart$core.int start = (size - 1) - Integer.nativeValue(from);
                return $outer$ceylon$language$Sequence.span(Integer.instance(start), Integer.instance((start - length) + 1));
            })();
        } else {
            return $package$empty;
        }
    })();
    Sequential span([Integer from, Integer to]) => $outer$ceylon$language$Sequence.span(to, from);
    Sequential spanFrom([Integer from]) => (() {
        $dart$core.int endIndex = size - 1;
        return (() {
            if (Integer.nativeValue(from) <= endIndex) {
                return $outer$ceylon$language$Sequence.span(Integer.instance(endIndex - Integer.nativeValue(from)), Integer.instance(0));
            } else {
                return $package$empty;
            }
        })();
    })();
    Sequential spanTo([Integer to]) => (() {
        if (Integer.nativeValue(to) >= 0) {
            return (() {
                $dart$core.int endIndex = size - 1;
                return $outer$ceylon$language$Sequence.span(Integer.instance(endIndex), Integer.instance(endIndex - Integer.nativeValue(to)));
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
    Sequence$Repeat([Sequence this.$outer$ceylon$language$Sequence, $dart$core.int _$times]) {
        this._$times = _$times;
        if (!(this._$times > 0)) {
            throw new AssertionError("Violated: times>0");
        }
    }
    $dart$core.int _$times;
    $dart$core.Object get last => $outer$ceylon$language$Sequence.last;
    $dart$core.Object get first => $outer$ceylon$language$Sequence.first;
    $dart$core.int get size => $outer$ceylon$language$Sequence.size * _$times;
    Sequential get rest => sublistFrom(1).sequence();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size = $outer$ceylon$language$Sequence.size;
        return (() {
            if (index < (size * _$times)) {
                return $outer$ceylon$language$Sequence.getFromFirst(Integer.nativeValue(Integer.instance(index).remainder(Integer.instance(size))));
            } else {
                return null;
            }
        })();
    })();
    Iterator iterator() => new CycledIterator($outer$ceylon$language$Sequence, _$times);
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
    static Tuple $slice([final Sequence $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)), $this.spanFrom(Integer.instance(index))]);
    Sequential measure([Integer from, $dart$core.int length]);
    static Sequential $measure([final Sequence $this, Integer from, $dart$core.int length]) => $this.sublist(Integer.nativeValue(from), (Integer.nativeValue(from) + length) - 1).sequence();
    Sequential span([Integer from, Integer to]);
    static Sequential $span([final Sequence $this, Integer from, Integer to]) => $this.sublist(Integer.nativeValue(from), Integer.nativeValue(to)).sequence();
    Sequential spanFrom([Integer from]);
    static Sequential $spanFrom([final Sequence $this, Integer from]) => $this.sublistFrom(Integer.nativeValue(from)).sequence();
    Sequential spanTo([Integer to]);
    static Sequential $spanTo([final Sequence $this, Integer to]) => $this.sublistTo(Integer.nativeValue(to)).sequence();
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequence $this]) => Sequential.$get$string($this);
    static $dart$core.Object $_$getElement([final Sequence $this, $dart$core.int index]) {{
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
            return null;
        }
    }
}

Sequence sequence([Iterable elements]) => $package$sequence(elements);

class JoinedSequence implements Sequence {
    JoinedSequence([Sequence _$firstSeq, Sequence _$secondSeq]) {
        this._$firstSeq = _$firstSeq;
        this._$secondSeq = _$secondSeq;
    }
    Sequence _$firstSeq;
    Sequence _$secondSeq;
    $dart$core.int get size => _$firstSeq.size + _$secondSeq.size;
    $dart$core.Object get first => _$firstSeq.first;
    $dart$core.Object get last => _$secondSeq.last;
    Sequential get rest => _$firstSeq.rest.append(_$secondSeq);
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int cutover = _$firstSeq.size;
        return (() {
            if (index < cutover) {
                return _$firstSeq.getFromFirst(index);
            } else {
                return _$secondSeq.getFromFirst(index - cutover);
            }
        })();
    })();
    Tuple slice([$dart$core.int index]) => (() {
        if (Integer.instance(index).equals(Integer.instance(_$firstSeq.size))) {
            return new Tuple.$withList([_$firstSeq, _$secondSeq]);
        } else {
            return Sequence.$slice(this, index);
        }
    })();
    Sequential spanTo([Integer to]) => (() {
        if (to.equals(Integer.instance(_$firstSeq.size - 1))) {
            return _$firstSeq;
        } else {
            return Sequence.$spanTo(this, to);
        }
    })();
    Sequential spanFrom([Integer from]) => (() {
        if (from.equals(Integer.instance(_$firstSeq.size))) {
            return _$secondSeq;
        } else {
            return Sequence.$spanFrom(this, from);
        }
    })();
    Sequential measure([Integer from, $dart$core.int length]) {
        if (from.equals(Integer.instance(0)) && Integer.instance(length).equals(Integer.instance(_$firstSeq.size))) {
            return _$firstSeq;
        } else if (from.equals(Integer.instance(_$firstSeq.size)) && (length >= _$secondSeq.size)) {
            return _$secondSeq;
        } else {
            return Sequence.$measure(this, from, length);
        }
    }
    Sequential span([Integer from, Integer to]) {
        if ((Integer.nativeValue(from) <= 0) && to.equals(Integer.instance(_$firstSeq.size - 1))) {
            return _$firstSeq;
        } else if (from.equals(Integer.instance(_$firstSeq.size)) && (Integer.nativeValue(to) >= (size - 1))) {
            return _$secondSeq;
        } else {
            return Sequence.$span(this, from, to);
        }
    }
    Iterator iterator() => new ChainedIterator(_$firstSeq, _$secondSeq);
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
    static Tuple $slice([final Sequential $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo(Integer.instance(index - 1)), $this.spanFrom(Integer.instance(index))]);
    Tuple withLeading([$dart$core.Object element]);
    Sequence withTrailing([$dart$core.Object element]);
    Sequential append([Sequential elements]);
    Sequential prepend([Sequential elements]);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequential $this]) => (($dart$core.String $lhs$) => $lhs$ == null ? ("[" + $package$commaList($this)) + "]" : $lhs$)($this.empty ? "[]" : null);
}
serialization$DeserializationContext $package$serialization$deserialization() => new serialization$DeserializationContextImpl();

serialization$DeserializationContext serialization$deserialization() => $package$serialization$deserialization();

abstract class serialization$DeserializationContext {
    void instance([$dart$core.Object instanceId, meta$model$ClassModel clazz]);
    void memberInstance([$dart$core.Object containerId, $dart$core.Object instanceId]);
    void attribute([$dart$core.Object instanceId, meta$declaration$ValueDeclaration attribute, $dart$core.Object attributeValueId]);
    void element([$dart$core.Object instanceId, $dart$core.int index, $dart$core.Object elementValueId]);
    void instanceValue([$dart$core.Object instanceId, $dart$core.Object instanceValue]);
    $dart$core.Object reconstruct([$dart$core.Object instanceId]);
}
class serialization$DeserializationContextImpl implements serialization$DeserializationContext {
    serialization$DeserializationContextImpl() {
        _$instances = new serialization$NativeMap();
        memberTypeCache = new serialization$NativeMap();
    }
    serialization$NativeMap _$instances;
    serialization$NativeMap memberTypeCache;
    $dart$core.Object leakInstance([$dart$core.Object id]) => _$instances.get(id);
    void attribute([$dart$core.Object instanceId, meta$declaration$ValueDeclaration attribute, $dart$core.Object attributeValueId]) {
        _$attributeOrElement(instanceId, new impl$MemberImpl(attribute), attributeValueId);
    }
    serialization$DeserializationException alreadyComplete([$dart$core.Object instanceId]) => new serialization$DeserializationException(("instance referred to by id " + instanceId.toString()) + " already complete.");
    void _$attributeOrElement([$dart$core.Object instanceId, serialization$ReachableReference attributeOrIndex, $dart$core.Object attributeValueId]) {
        serialization$Partial referring;
        {
            $dart$core.Object r = _$instances.get(instanceId);
            if (r == null) {
                serialization$PartialImpl p = new serialization$PartialImpl(instanceId);
                _$instances.put(instanceId, p);
                referring = p;
            } else if (r is serialization$Partial) {
                serialization$Partial r$0;
                r$0 = r as serialization$Partial;
                referring = r$0;
                if (referring.instantiated) {
                    throw alreadyComplete(instanceId);
                }
            } else {
                throw alreadyComplete(instanceId);
            }
        }
        referring.addState(attributeOrIndex, attributeValueId);
    }
    void element([$dart$core.Object instanceId, $dart$core.int index, $dart$core.Object elementValueId]) {
        _$attributeOrElement(instanceId, new impl$ElementImpl(index), elementValueId);
    }
    void instance([$dart$core.Object instanceId, meta$model$ClassModel clazz]) {
        if (!clazz.declaration.serializable) {
            throw new serialization$DeserializationException(("not serializable: " + clazz.toString()) + "");
        }
        _$getOrCreatePartial(instanceId).clazz = clazz;
    }
    serialization$Partial _$getOrCreatePartial([$dart$core.Object instanceId]) {
        serialization$Partial partial;
        {
            $dart$core.Object r = _$instances.get(instanceId);
            if (r == null) {
                serialization$PartialImpl p = new serialization$PartialImpl(instanceId);
                _$instances.put(instanceId, p);
                partial = p;
            } else if (r is serialization$Partial) {
                serialization$Partial r$1;
                r$1 = r as serialization$Partial;
                partial = r$1;
            } else {
                throw alreadyComplete(instanceId);
            }
        }
        return partial;
    }
    void memberInstance([$dart$core.Object containerId, $dart$core.Object instanceId]) {
        $dart$core.Object container;
        {
            $dart$core.Object r = _$instances.get(containerId);
            if (r == null) {
                serialization$PartialImpl p = new serialization$PartialImpl(containerId);
                _$instances.put(containerId, p);
                container = p;
            } else {
                container = r;
            }
        }
        _$getOrCreatePartial(instanceId).container = container;
    }
    void instanceValue([$dart$core.Object instanceId, $dart$core.Object instanceValue]) {
        _$instances.put(instanceId, instanceValue);
    }
    $dart$core.Object reconstruct([$dart$core.Object instanceId]) {
        serialization$NativeDeque deque = new serialization$NativeDeque();
        $dart$core.Object root = _$instances.get(instanceId);
        if (!(!(root == null))) {
            if (_$instances.contains(instanceId)) {
                $dart$core.Object r;
                {
                    $dart$core.Object r$2 = null;
                    if (!true) {
                        throw new AssertionError("Violated: is Instance r=null");
                    }
                    r = r$2;
                }
                return r;
            } else {
                throw new serialization$DeserializationException(("unknown id: " + instanceId.toString()) + ".");
            }
        }
        deque.pushFront(_$instances.get(instanceId));
        while (!deque.empty) {
            $dart$core.Object r = deque.popFront();
            {
                $dart$core.Object switch$3 = r;
                if (switch$3 == null) {
                    if (!false) {
                        throw new AssertionError("Violated: false");
                    }
                } else if (switch$3 is serialization$Partial) {
                    serialization$Partial r$4;
                    r$4 = r as serialization$Partial;
                    if (r$4.member) {{
                            $dart$core.Object container$5 = r$4.container;
                            if (container$5 is serialization$Partial) {
                                serialization$Partial container;
                                container = container$5 as serialization$Partial;
                                if (!container.instantiated) {
                                    deque.pushFront(r$4);
                                    deque.pushFront(container);
                                    continue;
                                }
                            }
                        }
                    }
                    r$4.instantiate();
                    {
                        $dart$core.Object element$7;
                        Iterator iterator$6 = r$4.refersTo.iterator();
                        while ((element$7 = iterator$6.next()) is !Finished) {
                            $dart$core.Object referredId = element$7;
                            if (!(referredId != null)) {
                                throw new AssertionError("Violated: is Id referredId");
                            }
                            $dart$core.Object referred = _$instances.get(referredId);
                            if (referred is serialization$Partial) {
                                serialization$Partial referred$8;
                                referred$8 = referred as serialization$Partial;
                                if (!referred$8.instantiated) {
                                    deque.pushFront(referred$8);
                                }
                            }
                        }
                    }
                } else {}
            }
        }
        deque.pushFront(_$instances.get(instanceId));
        while (!deque.empty) {{
                $dart$core.Object r = deque.popFront();
                if (r is serialization$Partial) {
                    serialization$Partial r$9;
                    r$9 = r as serialization$Partial;
                    if (r$9.member) {{
                            $dart$core.Object container$10 = r$9.container;
                            if (container$10 is serialization$Partial) {
                                serialization$Partial container;
                                container = container$10 as serialization$Partial;
                                if (!container.initialized) {
                                    deque.pushFront(r$9);
                                    deque.pushFront(container);
                                    continue;
                                }
                            }
                        }
                    }
                    if (!r$9.initialized) {{
                            $dart$core.Object element$12;
                            Iterator iterator$11 = r$9.refersTo.iterator();
                            while ((element$12 = iterator$11.next()) is !Finished) {
                                $dart$core.Object referredId = element$12;
                                if (!(referredId != null)) {
                                    throw new AssertionError("Violated: is Id referredId");
                                }
                                $dart$core.Object referred = _$instances.get(referredId);
                                if (referred is serialization$Partial) {
                                    serialization$Partial referred$13;
                                    referred$13 = referred as serialization$Partial;
                                    if (!referred$13.initialized) {
                                        deque.pushFront(referred$13);
                                    }
                                }
                            }
                        }
                        if (r$9.member) {{
                                $dart$core.Object container$14 = r$9.container;
                                if (container$14 is serialization$Partial) {
                                    serialization$Partial container;
                                    container = container$14 as serialization$Partial;
                                    if (!container.initialized) {
                                        deque.pushFront(container);
                                    }
                                }
                            }
                        }
                        r$9.initialize(this);
                    }
                } else {}
            }
        }
        {
            $dart$core.Object r = _$instances.get(instanceId);
            if (r is serialization$Partial) {
                serialization$Partial r$15;
                r$15 = r as serialization$Partial;
                $dart$core.Object result = r$15.instance();
                {
                    $dart$core.bool doElse$16 = true;
                    if (true) {
                        doElse$16 = false;
                        _$instances.put(instanceId, result);
                        return result;
                    }
                    if (doElse$16) {
                        throw new serialization$DeserializationException(((((("instance with id " + instanceId.toString()) + " has class ") + $package$meta$type(result).toString()) + " not assignable to given type ") + $package$meta$typeLiteral().toString()) + "");
                    }
                }
            } else {{
                    $dart$core.bool doElse$17 = true;
                    if (true) {
                        doElse$17 = false;
                        return r;
                    }
                    if (doElse$17) {
                        throw new serialization$DeserializationException(((((("instance with id " + instanceId.toString()) + " has class ") + $package$meta$type(r).toString()) + " not assignable to given type ") + $package$meta$typeLiteral().toString()) + "");
                    }
                }
            }
        }
    }
}
class serialization$DeserializationException  extends Exception {
    serialization$DeserializationException([$dart$core.String _$message, $dart$core.Object _$cause = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(_$cause, $package$dart$default)) {
            _$cause = null;
        }
        return [_$message, _$cause];
    })());
    serialization$DeserializationException.$s([$dart$core.List a]) : this.$w(a[0], a[1]);
    serialization$DeserializationException.$w([$dart$core.String _$message, Throwable _$cause]) : super(_$message, _$cause) {
        this._$message = _$message;
        this._$cause = _$cause;
    }
    $dart$core.String _$message;
    Throwable _$cause;
}
abstract class serialization$Element implements serialization$ReachableReference {
    $dart$core.int get index;
}
abstract class serialization$Member implements serialization$ReachableReference {
    meta$declaration$ValueDeclaration get attribute;
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$UninitializedLateValue {
    serialization$UninitializedLateValue() {}
}
class serialization$uninitializedLateValue_  extends serialization$UninitializedLateValue {
    serialization$uninitializedLateValue_() {}
}
final serialization$uninitializedLateValue_ $package$serialization$uninitializedLateValue = new serialization$uninitializedLateValue_();

serialization$uninitializedLateValue_ get serialization$uninitializedLateValue => $package$serialization$uninitializedLateValue;

abstract class serialization$Outer implements serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$Partial {
    serialization$Partial([$dart$core.Object id]) {
        this.id = id;
        clazz = null;
        container = null;
        instance_ = null;
        state = new serialization$NativeMap();
    }
    $dart$core.Object id;
    meta$model$ClassModel clazz;
    $dart$core.Object container;
    $dart$core.Object instance_;
    serialization$NativeMap state;
    void addState([serialization$ReachableReference attrOrIndex, $dart$core.Object partialOrComplete]) {
        serialization$NativeMap s;
        {
            serialization$NativeMap tmp$0 = state;
            if (tmp$0 == null) {
                throw new AssertionError("Violated: exists s=state");
            }
            s = tmp$0;
        }
        s.put(attrOrIndex, partialOrComplete);
    }
    void instantiate();
    void initialize([serialization$DeserializationContextImpl context]);
    $dart$core.bool get instantiated => !(instance_ == null);
    $dart$core.bool get initialized => !(!(state == null));
    $dart$core.bool get member => !(container == null);
    $dart$core.Object instance() {
        if (!(instantiated && initialized)) {
            throw new AssertionError("Violated: instantiated && initialized");
        }
        return instance_;
    }
    Iterable get refersTo {
        serialization$NativeMap s;
        {
            serialization$NativeMap tmp$1 = state;
            if (tmp$1 == null) {
                throw new AssertionError("Violated: exists s=state");
            }
            s = tmp$1;
        }
        return s.items;
    }
}
abstract class serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$References implements Iterable {
    $dart$core.Object get instance;
    Iterable get references;
}
class ReferencesImpl$iterator$$anonymous$0_  extends impl$BaseIterator {
    serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl;
    $dart$core.Object $capture$serialization$ReferencesImpl$iterator$$$instance;
    ReferencesImpl$iterator$$anonymous$0_([serialization$ReferencesImpl this.$outer$ceylon$language$serialization$ReferencesImpl, $dart$core.Object this.$capture$serialization$ReferencesImpl$iterator$$$instance]) {
        _$it = $outer$ceylon$language$serialization$ReferencesImpl.references.iterator();
    }
    Iterator _$it;
    $dart$core.Object next() {
        $dart$core.Object next = _$it.next();
        {
            $dart$core.bool doElse$1 = true;
            if (next is Finished) {
                Finished next$2;
                next$2 = next as Finished;
                doElse$1 = false;
                return $package$finished;
            }
            if (doElse$1) {
                return new Entry(next, (next as serialization$ReachableReference).referred($outer$ceylon$language$serialization$ReferencesImpl.instance));
            }
        }
    }
}
class ReferencesImpl$references$$anonymous$1_  extends impl$BaseIterable {
    serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl;
    ReferencesImpl$references$$anonymous$1_([serialization$ReferencesImpl this.$outer$ceylon$language$serialization$ReferencesImpl]) {}
    Iterator iterator() {
        return $package$impl$reach.references($outer$ceylon$language$serialization$ReferencesImpl.instance);
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
class serialization$ReferencesImpl  extends impl$BaseIterable implements serialization$References {
    serialization$ReferencesImpl([$dart$core.Object instance]) {
        this.instance = instance;
    }
    $dart$core.Object instance;
    Iterator iterator() {{
            $dart$core.bool doElse$0 = true;
            if (!(instance == null)) {
                doElse$0 = false;
                return new ReferencesImpl$iterator$$anonymous$0_(this, instance);
            }
            if (doElse$0) {
                return $package$emptyIterator;
            }
        }
    }
    Iterable get references {
        return new ReferencesImpl$references$$anonymous$1_(this);
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
serialization$SerializationContext $package$serialization$serialization() => new serialization$SerializationContextImpl();

serialization$SerializationContext serialization$serialization() => $package$serialization$serialization();

abstract class serialization$SerializationContext {
    serialization$References references([$dart$core.Object instance]);
}
class serialization$SerializationContextImpl implements serialization$SerializationContext {
    serialization$SerializationContextImpl() {}
    serialization$References references([$dart$core.Object instance]) {
        if ($package$meta$classDeclaration(instance).serializable) {
            return new serialization$ReferencesImpl(instance);
        } else {
            throw new AssertionError(("instance of non-serializable class: " + $package$meta$type(instance).toString()) + "");
        }
    }
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

Callable $package$shuffle([Callable f]) => $package$flatten(new dart$Callable(([$dart$core.Object secondArgs]) => $package$flatten(new dart$Callable(([$dart$core.Object firstArgs]) => $package$unflatten($package$unflatten(f).f(firstArgs) as Callable).f(secondArgs)))));

Callable shuffle([Callable f]) => $package$shuffle(f);

class Singleton$iterator$$anonymous$0_ implements Iterator {
    Singleton $outer$ceylon$language$Singleton;
    Singleton$iterator$$anonymous$0_([Singleton this.$outer$ceylon$language$Singleton]) {
        _$done = false;
    }
    $dart$core.bool _$done;
    $dart$core.Object next() {
        if (_$done) {
            return $package$finished;
        } else {
            _$done = true;
            return $outer$ceylon$language$Singleton._$element;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Singleton.toString()) + ".iterator()";
}
class Singleton implements Sequence {
    Singleton([$dart$core.Object _$element]) {
        this._$element = _$element;
    }
    $dart$core.Object _$element;
    $dart$core.Object get first => _$element;
    $dart$core.Object get last => _$element;
    $dart$core.int get lastIndex => 0;
    $dart$core.int get size => 1;
    Empty get rest => $package$empty;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        if (Integer.instance(index).equals(Integer.instance(0))) {
            return _$element;
        } else {
            return null;
        }
    })();
    Singleton get reversed => this;
    Singleton clone() => this;
    $dart$core.bool contains([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.Object tmp$1 = this._$element;
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
    $dart$core.String toString() => ("[" + $package$stringify(_$element)) + "]";
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
                        if (!(_$element == null)) {
                            if (!(elem == null)) {
                                doElse$4 = false;
                                return elem.equals(_$element);
                            }
                        }
                        if (doElse$4) {
                            return (!(!(_$element == null))) && (!(!(elem == null)));
                        }
                    })();
                }
            }
            if (doElse$2) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode => 31 + (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)((($dart$core.Object $r) => $r == null ? null : $r.hashCode)(_$element));
    $dart$core.Object measure([Integer from, $dart$core.int length]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)((Integer.nativeValue(from) <= 0) && ((Integer.nativeValue(from) + length) > 0) ? this : null);
    $dart$core.Object span([Integer from, Integer to]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(((Integer.nativeValue(from) <= 0) && (Integer.nativeValue(to) >= 0)) || ((Integer.nativeValue(from) >= 0) && (Integer.nativeValue(to) <= 0)) ? this : null);
    $dart$core.Object spanTo([Integer to]) => (($dart$core.Object $lhs$) => $lhs$ == null ? this : $lhs$)(Integer.nativeValue(to) < 0 ? $package$empty : null);
    $dart$core.Object spanFrom([Integer from]) => (($dart$core.Object $lhs$) => $lhs$ == null ? this : $lhs$)(Integer.nativeValue(from) > 0 ? $package$empty : null);
    $dart$core.int count([Callable selecting]) => (($dart$core.int $lhs$) => $lhs$ == null ? 0 : $lhs$)(Boolean.nativeValue(selecting.f(_$element) as Boolean) ? 1 : null);
    Singleton map([Callable collecting]) => new Singleton(collecting.f(_$element));
    $dart$core.Object filter([Callable selecting]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(Boolean.nativeValue(selecting.f(_$element) as Boolean) ? this : null);
    Callable fold([$dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) => accumulating.f(initial, _$element));
    $dart$core.Object reduce([Callable accumulating]) => _$element;
    Singleton collect([Callable collecting]) => new Singleton(collecting.f(_$element));
    $dart$core.Object select([Callable selecting]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(Boolean.nativeValue(selecting.f(_$element) as Boolean) ? this : null);
    $dart$core.Object find([Callable selecting]) => (() {
        $dart$core.bool doElse$5 = true;
        if (!(_$element == null)) {
            if (Boolean.nativeValue(selecting.f(_$element) as Boolean)) {
                doElse$5 = false;
                return _$element;
            }
        }
        if (doElse$5) {
            return null;
        }
    })();
    $dart$core.Object findLast([Callable selecting]) => find(selecting);
    Singleton sort([Callable comparing]) => this;
    $dart$core.bool any([Callable selecting]) => Boolean.nativeValue(selecting.f(_$element) as Boolean);
    $dart$core.bool every([Callable selecting]) => Boolean.nativeValue(selecting.f(_$element) as Boolean);
    $dart$core.Object skip([$dart$core.int skipping]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(skipping < 1 ? this : null);
    $dart$core.Object take([$dart$core.int taking]) => (($dart$core.Object $lhs$) => $lhs$ == null ? $package$empty : $lhs$)(taking > 0 ? this : null);
    $dart$core.Object get coalesced => (() {
        $dart$core.bool doElse$6 = true;
        if (!(_$element == null)) {
            doElse$6 = false;
            return new Singleton(_$element);
        }
        if (doElse$6) {
            return $package$empty;
        }
    })();
    Iterable chain([Iterable other]) => other.follow(_$element);
    void each([Callable step]) => step.f(_$element);
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
        _$firstTime = true;
        _$element = $outer$ceylon$language$Span.first;
    }
    $dart$core.bool _$firstTime;
    $dart$core.Object _$element;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object c$1 = _$element;
                if (!(c$1 is Finished)) {
                    $dart$core.Object c;
                    c = c$1;
                    doElse$0 = false;
                    $dart$core.Object result;
                    if (_$firstTime) {
                        _$firstTime = false;
                        result = c;
                    } else {
                        result = $outer$ceylon$language$Span._$next(c);
                    }
                    if (Integer.instance((result as Enumerable).offset($outer$ceylon$language$Span.last)).equals(Integer.instance(0))) {
                        this._$element = $package$finished;
                    } else {
                        this._$element = result;
                    }
                    return result;
                }
            }
            if (doElse$0) {
                return _$element;
            }
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Span.toString()) + ").iterator()";
}
class Span$By$iterator$$anonymous$1_ implements Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$1_([Span$By this.$outer$ceylon$language$Span$By]) {
        _$count = 0;
        _$current = $outer$ceylon$language$Span$By.first;
    }
    $dart$core.int _$count;
    $dart$core.Object _$current;
    $dart$core.Object next() {
        if ((_$count = Integer.nativeValue(Integer.instance(_$count).successor)) > $outer$ceylon$language$Span$By.size) {
            return $package$finished;
        } else {
            $dart$core.Object result = _$current;
            _$current = (_$current as Enumerable).neighbour($outer$ceylon$language$Span$By._$step);
            return result;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By$iterator$$anonymous$2_ implements Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$2_([Span$By this.$outer$ceylon$language$Span$By]) {
        _$current = $outer$ceylon$language$Span$By.first;
        _$firstTime = true;
    }
    $dart$core.Object _$current;
    $dart$core.bool _$firstTime;
    $dart$core.Object next() {
        if (_$firstTime) {
            _$firstTime = false;
            return _$current;
        } else {{
                $dart$core.Object c$11 = _$current;
                if (c$11 != null) {
                    $dart$core.Object c;
                    c = c$11;
                    $dart$core.Object r = $outer$ceylon$language$Span$By.$outer$ceylon$language$Span._$nextStep(c, $outer$ceylon$language$Span$By._$step);
                    if (!$outer$ceylon$language$Span$By.$outer$ceylon$language$Span.containsElement(r)) {
                        _$current = $package$finished;
                    } else {
                        _$current = r;
                    }
                }
            }
            return _$current;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By implements Iterable {
    Span $outer$ceylon$language$Span;
    Span$By([Span this.$outer$ceylon$language$Span, $dart$core.int _$step]) {
        this._$step = _$step;
    }
    $dart$core.int _$step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Span.size - 1) ~/ _$step);
    $dart$core.Object get first => $outer$ceylon$language$Span.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Span.toString()) + ").by(") + Integer.instance(_$step).toString()) + ")";
    Iterator iterator() {
        if ($outer$ceylon$language$Span._$recursive) {
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
    Span([$dart$core.Object first, $dart$core.Object last]) {
        this.first = first;
        this.last = last;
        increasing = (this.last as Enumerable).offsetSign(this.first) >= 0;
        _$recursive = ((this.first as Enumerable).offsetSign((this.first as Enumerable).successor) > 0) && (((this.last as Enumerable).predecessor as Enumerable).offsetSign(this.last) > 0);
    }
    $dart$core.Object first;
    $dart$core.Object last;
    $dart$core.String toString() => (first.toString() + "..") + last.toString();
    $dart$core.bool increasing;
    $dart$core.bool get decreasing => !increasing;
    $dart$core.bool _$recursive;
    $dart$core.Object _$next([$dart$core.Object x]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (x as Enumerable).predecessor : $lhs$)(increasing ? (x as Enumerable).successor : null);
    $dart$core.Object _$nextStep([$dart$core.Object x, $dart$core.int step]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (x as Enumerable).neighbour(Integer.nativeValue(Integer.instance(step).negated)) : $lhs$)(increasing ? (x as Enumerable).neighbour(step) : null);
    $dart$core.Object _$fromFirst([$dart$core.int offset]) => (($dart$core.Object $lhs$) => $lhs$ == null ? (first as Enumerable).neighbour(Integer.nativeValue(Integer.instance(offset).negated)) : $lhs$)(increasing ? (first as Enumerable).neighbour(offset) : null);
    $dart$core.bool _$afterLast([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(last) < 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(last) > 0 : null);
    $dart$core.bool _$beforeLast([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(last) > 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(last) < 0 : null);
    $dart$core.bool _$beforeFirst([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(first) > 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(first) < 0 : null);
    $dart$core.bool _$afterFirst([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (x as Enumerable).offsetSign(first) < 0 : $lhs$)(increasing ? (x as Enumerable).offsetSign(first) > 0 : null);
    $dart$core.int get size {
        $dart$core.int lastIndex = Integer.nativeValue(Integer.instance((last as Enumerable).offset(first)).magnitude);
        if (lastIndex < $package$runtime.maxIntegerValue) {
            return lastIndex + 1;
        } else {
            throw new OverflowException("size of range");
        }
    }
    $dart$core.bool longerThan([$dart$core.int length]) => (() {
        if (length < 1) {
            return true;
        } else {
            return (() {
                if (_$recursive) {
                    return size > length;
                } else {
                    return _$beforeLast(_$fromFirst(length - 1));
                }
            })();
        }
    })();
    $dart$core.bool shorterThan([$dart$core.int length]) => (() {
        if (length < 1) {
            return true;
        } else {
            return (() {
                if (_$recursive) {
                    return size < length;
                } else {
                    return _$afterLast(_$fromFirst(length - 1));
                }
            })();
        }
    })();
    $dart$core.int get lastIndex => size - 1;
    Sequential get rest => ((Sequential $lhs$) => $lhs$ == null ? $package$span(_$next(first), last) : $lhs$)(first.equals(last) ? $package$empty : null);
    Sequence get reversed => ((Sequence $lhs$) => $lhs$ == null ? $package$span(last, first) : $lhs$)(_$recursive ? Sequence.$get$reversed(this) : null);
    $dart$core.Object getFromFirst([$dart$core.int index]) {
        if (index < 0) {
            return null;
        } else if (_$recursive) {
            return index < size ? _$fromFirst(index) : null;
        } else {
            $dart$core.Object result = _$fromFirst(index);
            return !_$afterLast(result) ? result : null;
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
    $dart$core.bool containsElement([$dart$core.Object x]) => (($dart$core.bool $lhs$) => $lhs$ == null ? (!_$afterLast(x)) && (!_$beforeFirst(x)) : $lhs$)(_$recursive ? (x as Enumerable).offset(first) <= (last as Enumerable).offset(first) : null);
    $dart$core.int count([Callable selecting]) {
        $dart$core.Object element = first;
        $dart$core.int count = 0;
        while (containsElement(element)) {
            if (Boolean.nativeValue(selecting.f(element) as Boolean)) {
                count = Integer.nativeValue(Integer.instance(count).successor);
            }
            element = _$next(element);
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
                if (_$recursive) {
                    return ((range$5.first as Enumerable).offset(first) < size) && ((range$5.last as Enumerable).offset(first) < size);
                } else {
                    return (Boolean.instance(increasing).equals(Boolean.instance(range$5.increasing)) && (!range$5._$afterFirst(first))) && (!range$5._$beforeLast(last));
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
            step.f(current);
            if (Integer.instance((current as Enumerable).offset(last)).equals(Integer.instance(0))) {
                break;
            } else {
                current = _$next(current);
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

class StringBuilder implements List {
    StringBuilder() {
        _$delegate = new DartStringBuffer();
    }
    DartStringBuffer _$delegate;
    $dart$core.int get size => String.instance(_$delegate.toString()).size;
    $dart$core.int get lastIndex => (() {
        if (!empty) {
            return size - 1;
        } else {
            return null;
        }
    })();
    $dart$core.String toString() => _$delegate.toString();
    Iterator iterator() => String.instance(toString()).iterator();
    $dart$core.String substring([$dart$core.int index, $dart$core.int length]) => String.nativeValue(String.instance(toString()).measure(Integer.instance(index), length));
    Character getFromFirst([$dart$core.int index]) => String.instance(toString()).getFromFirst(index);
    StringBuilder append([$dart$core.String string]) {
        _$delegate.write(String.instance(string));
        return this;
    }
    StringBuilder appendAll([Iterable strings]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = strings.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                String s = element$1 as String;
                append(String.nativeValue(s));
            }
        }
        return this;
    }
    StringBuilder prepend([$dart$core.String string]) {
        $dart$core.String newString = string + this.toString();
        clear();
        _$delegate.write(String.instance(newString));
        return this;
    }
    StringBuilder prependAll([Iterable strings]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = strings.iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                String s = element$3 as String;
                prepend(String.nativeValue(s));
            }
        }
        return this;
    }
    StringBuilder appendCharacter([Character character]) {
        _$delegate.write(character);
        return this;
    }
    StringBuilder prependCharacter([Character character]) {
        prepend(character.toString());
        return this;
    }
    StringBuilder appendNewline() => appendCharacter(new Character.$fromInt(10));
    StringBuilder appendSpace() => appendCharacter(new Character.$fromInt(32));
    StringBuilder clear() {
        _$delegate.clear();
        return this;
    }
    StringBuilder insert([$dart$core.int index, $dart$core.String string]) {
        if (!(index >= 0)) {
            throw new AssertionError("Violated: index >= 0");
        }
        if (!(index < size)) {
            throw new AssertionError("Violated: index < size");
        }
        $dart$core.String oldString = this.toString();
        clear();
        _$delegate.write(String.instance((String.nativeValue(String.instance(oldString).spanTo(Integer.instance(index - 1))) + string) + String.nativeValue(String.instance(oldString).spanFrom(Integer.instance(index)))));
        return this;
    }
    StringBuilder insertCharacter([$dart$core.int index, Character character]) => insert(index, character.toString());
    StringBuilder replace([$dart$core.int index, $dart$core.int length, $dart$core.String string]) {
        if (!(index > 0)) {
            throw new AssertionError("Violated: index > 0");
        }
        if (!(index <= size)) {
            throw new AssertionError("Violated: index <= size");
        }
        if (!((index + length) <= size)) {
            throw new AssertionError("Violated: index + length <= size");
        }
        if (!String.instance(string).empty) {
            $dart$core.String oldString = this.toString();
            clear();
            _$delegate.write(String.instance((String.nativeValue(String.instance(oldString).spanTo(Integer.instance(index - 1))) + string) + String.nativeValue(String.instance(oldString).spanFrom(Integer.instance(index + length)))));
        }
        return this;
    }
    StringBuilder delete([$dart$core.int index, $dart$core.int length]) {
        if (!(index >= 0)) {
            throw new AssertionError("Violated: index >= 0");
        }
        if (!(index < size)) {
            throw new AssertionError("Violated: index < size");
        }
        if (!((index + length) <= size)) {
            throw new AssertionError("Violated: index + length <= size");
        }
        $dart$core.String oldString = this.toString();
        clear();
        _$delegate.write(String.instance(String.nativeValue(String.instance(oldString).spanTo(Integer.instance(index - 1))) + String.nativeValue(String.instance(oldString).spanFrom(Integer.instance(index + length)))));
        return this;
    }
    StringBuilder deleteInitial([$dart$core.int length]) {
        if (!(length <= size)) {
            throw new AssertionError("Violated: length <= size");
        }
        if (length > 0) {
            return delete(0, length);
        } else {
            return this;
        }
    }
    StringBuilder deleteTerminal([$dart$core.int length]) {
        if (!(length <= size)) {
            throw new AssertionError("Violated: length <= size");
        }
        if (length > 0) {
            return delete(size - length, length);
        } else {
            return this;
        }
    }
    StringBuilder reverseInPlace() {
        $dart$core.String oldString = this.toString();
        clear();
        _$delegate.write(String.instance(oldString).reversed);
        return this;
    }
    $dart$core.bool equals([$dart$core.Object that]) => (() {
        $dart$core.bool doElse$4 = true;
        if (that is StringBuilder) {
            StringBuilder that$5;
            that$5 = that as StringBuilder;
            doElse$4 = false;
            return _$delegate.equals(that$5._$delegate);
        }
        if (doElse$4) {
            return false;
        }
    })();
    $dart$core.int get hashCode => _$delegate.hashCode;
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

Tuple $package$unzip([Iterable tuples]) => new Tuple.$withList([tuples.map(new dart$Callable(([Tuple tuple]) => tuple.first)), tuples.map(new dart$Callable(([Tuple tuple]) => tuple.rest))]);

Tuple unzip([Iterable tuples]) => $package$unzip(tuples);

Tuple $package$unzipPairs([Iterable pairs]) => new Tuple.$withList([pairs.map(new dart$Callable(([Tuple pair]) => pair.get(Integer.instance(0)))), pairs.map(new dart$Callable(([Tuple pair]) => pair.get(Integer.instance(1))))]);

Tuple unzipPairs([Iterable pairs]) => $package$unzipPairs(pairs);

Tuple $package$unzipEntries([Iterable entries]) => new Tuple.$withList([entries.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).key)), entries.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).item))]);

Tuple unzipEntries([Iterable entries]) => $package$unzipEntries(entries);

abstract class Usable {
}
Iterable $package$zipEntries([Iterable keys, Iterable items]) => $package$mapPairs(new dart$Callable(([$dart$core.Object $0, $dart$core.Object $1]) => new Entry($0, $1)), keys, items);

Iterable zipEntries([Iterable keys, Iterable items]) => $package$zipEntries(keys, items);

Iterable $package$zipPairs([Iterable firstElements, Iterable secondElements]) => $package$mapPairs(new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => new Tuple.$withList([first, second])), firstElements, secondElements);

Iterable zipPairs([Iterable firstElements, Iterable secondElements]) => $package$zipPairs(firstElements, secondElements);

Iterable $package$zip([Iterable heads, Iterable tails]) => $package$mapPairs(new dart$Callable(([$dart$core.Object $0, $dart$core.Object $1]) => new Tuple($0, $1)), heads, tails);

Iterable zip([Iterable heads, Iterable tails]) => $package$zip(heads, tails);

