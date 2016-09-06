import "dart:core" as $dart$core;
import "dart:math" as $dart$math;
import "dart:async" as $dart$async;
import "dart:collection" as $dart$collection;
import "build/modules-dart/main/ceylon/collection/1.3.0/ceylon.collection-1.3.0.dart" as $ceylon$collection;
import "build/modules-dart/main/ceylon/interop/dart/1.3.0/ceylon.interop.dart-1.3.0.dart" as $ceylon$interop$dart;
import "build/modules-dart/main/ceylon/dart/runtime/core/1.3.0/ceylon.dart.runtime.core-1.3.0.dart" as $ceylon$dart$runtime$core;
import "build/modules-dart/main/ceylon/dart/runtime/model/1.3.0/ceylon.dart.runtime.model-1.3.0.dart" as $ceylon$dart$runtime$model;
import "build/modules-dart/main/ceylon/dart/runtime/structures/1.3.0/ceylon.dart.runtime.structures-1.3.0.dart" as $ceylon$dart$runtime$structures;
import "source/ceylon/language/module.dart";

Callable $package$and([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean((([$dart$core.Object val]) => $dartBool(p.f(val) as Boolean) && $dartBool(q.f(val) as Boolean))($0)));

Callable and([Callable p, Callable q]) => $package$and(p, q);

abstract class Annotated {
    $dart$core.bool annotated();
}
abstract class Annotation {
}
class AnnotationAnnotation implements dart$$Basic, OptionalAnnotation {
    AnnotationAnnotation() {}
}
AnnotationAnnotation $package$annotation() => new AnnotationAnnotation();

AnnotationAnnotation annotation() => $package$annotation();

class SharedAnnotation implements dart$$Basic, OptionalAnnotation {
    SharedAnnotation() {}
}
SharedAnnotation $package$shared() => new SharedAnnotation();

SharedAnnotation shared() => $package$shared();

class VariableAnnotation implements dart$$Basic, OptionalAnnotation {
    VariableAnnotation() {}
}
VariableAnnotation $package$variable() => new VariableAnnotation();

VariableAnnotation variable() => $package$variable();

class AbstractAnnotation implements dart$$Basic, OptionalAnnotation {
    AbstractAnnotation() {}
}
AbstractAnnotation $package$abstract() => new AbstractAnnotation();

AbstractAnnotation abstract() => $package$abstract();

class FinalAnnotation implements dart$$Basic, OptionalAnnotation {
    FinalAnnotation() {}
}
FinalAnnotation $package$$final() => new FinalAnnotation();

FinalAnnotation $final() => $package$$final();

class SealedAnnotation implements dart$$Basic, OptionalAnnotation {
    SealedAnnotation() {}
}
SealedAnnotation $package$sealed() => new SealedAnnotation();

SealedAnnotation sealed() => $package$sealed();

class ActualAnnotation implements dart$$Basic, OptionalAnnotation {
    ActualAnnotation() {}
}
ActualAnnotation $package$actual() => new ActualAnnotation();

ActualAnnotation actual() => $package$actual();

class FormalAnnotation implements dart$$Basic, OptionalAnnotation {
    FormalAnnotation() {}
}
FormalAnnotation $package$formal() => new FormalAnnotation();

FormalAnnotation formal() => $package$formal();

class DefaultAnnotation implements dart$$Basic, OptionalAnnotation {
    DefaultAnnotation() {}
}
DefaultAnnotation $package$$default() => new DefaultAnnotation();

DefaultAnnotation $default() => $package$$default();

class LateAnnotation implements dart$$Basic, OptionalAnnotation {
    LateAnnotation() {}
}
LateAnnotation $package$late() => new LateAnnotation();

LateAnnotation late() => $package$late();

class NativeAnnotation implements dart$$Basic, OptionalAnnotation {
    NativeAnnotation([Sequential backends]) {
        this.backends = backends;
    }
    Sequential backends;
}
NativeAnnotation $package$native([Sequential backends]) => new NativeAnnotation(backends);

NativeAnnotation native([Sequential backends]) => $package$native(backends);

class DocAnnotation implements dart$$Basic, OptionalAnnotation {
    DocAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
}
DocAnnotation $package$doc([$dart$core.String description]) => new DocAnnotation(description);

DocAnnotation doc([$dart$core.String description]) => $package$doc(description);

class SeeAnnotation implements dart$$Basic, SequencedAnnotation {
    SeeAnnotation([Sequential programElements]) {
        this.programElements = programElements;
    }
    Sequential programElements;
}
SeeAnnotation $package$see([Sequential programElements]) => new SeeAnnotation(programElements);

SeeAnnotation see([Sequential programElements]) => $package$see(programElements);

class AuthorsAnnotation implements dart$$Basic, OptionalAnnotation {
    AuthorsAnnotation([Sequential authors]) {
        this.authors = authors;
    }
    Sequential authors;
}
AuthorsAnnotation $package$by([Sequential authors]) => new AuthorsAnnotation(authors);

AuthorsAnnotation by([Sequential authors]) => $package$by(authors);

class ThrownExceptionAnnotation implements dart$$Basic, SequencedAnnotation {
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

class DeprecationAnnotation implements dart$$Basic, OptionalAnnotation {
    DeprecationAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
    $dart$core.String get reason => !$ceylonString(description).empty ? description : null;
}
DeprecationAnnotation $package$deprecated([$dart$core.Object reason = $package$dart$default]) {
    if ($dart$core.identical(reason, $package$dart$default)) {
        reason = "";
    }
    return new DeprecationAnnotation(reason as $dart$core.String);
}

DeprecationAnnotation deprecated([$dart$core.Object reason = $package$dart$default]) => $package$deprecated(reason);

class TagsAnnotation implements dart$$Basic, OptionalAnnotation {
    TagsAnnotation([Sequential tags]) {
        this.tags = tags;
    }
    Sequential tags;
}
TagsAnnotation $package$tagged([Sequential tags]) => new TagsAnnotation(tags);

TagsAnnotation tagged([Sequential tags]) => $package$tagged(tags);

class AliasesAnnotation implements dart$$Basic, OptionalAnnotation {
    AliasesAnnotation([Sequential aliases]) {
        this.aliases = aliases;
    }
    Sequential aliases;
}
AliasesAnnotation $package$aliased([Sequential aliases]) => new AliasesAnnotation(aliases);

AliasesAnnotation aliased([Sequential aliases]) => $package$aliased(aliases);

class LicenseAnnotation implements dart$$Basic, OptionalAnnotation {
    LicenseAnnotation([$dart$core.String description]) {
        this.description = description;
    }
    $dart$core.String description;
}
LicenseAnnotation $package$license([$dart$core.String description]) => new LicenseAnnotation(description);

LicenseAnnotation license([$dart$core.String description]) => $package$license(description);

class OptionalImportAnnotation implements dart$$Basic, OptionalAnnotation {
    OptionalImportAnnotation() {}
}
OptionalImportAnnotation $package$optional() => new OptionalImportAnnotation();

OptionalImportAnnotation optional() => $package$optional();

class SuppressWarningsAnnotation implements dart$$Basic, OptionalAnnotation {
    SuppressWarningsAnnotation([Sequential warnings]) {
        this.warnings = warnings;
    }
    Sequential warnings;
}
SuppressWarningsAnnotation $package$suppressWarnings([Sequential warnings]) => new SuppressWarningsAnnotation(warnings);

SuppressWarningsAnnotation suppressWarnings([Sequential warnings]) => $package$suppressWarnings(warnings);

class SerializableAnnotation implements dart$$Basic, OptionalAnnotation {
    SerializableAnnotation() {}
}
SerializableAnnotation $package$serializable() => new SerializableAnnotation();

SerializableAnnotation serializable() => $package$serializable();

class SmallAnnotation implements dart$$Basic, OptionalAnnotation {
    SmallAnnotation() {}
}
SmallAnnotation $package$small() => new SmallAnnotation();

SmallAnnotation small() => $package$small();

class SinceAnnotation implements dart$$Basic, OptionalAnnotation {
    SinceAnnotation([$dart$core.String version]) {
        this.version = version;
    }
    $dart$core.String version;
}
SinceAnnotation $package$since([$dart$core.String version]) => new SinceAnnotation(version);

SinceAnnotation since([$dart$core.String version]) => $package$since(version);

$dart$core.bool $package$any([Iterable values]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val;
            {
                val = element$1 as Boolean;
            }
            if ($dartBool(val)) {
                return true;
            }
        }
    }
    return false;
}

$dart$core.bool any([Iterable values]) => $package$any(values);

$dart$core.Object $package$apply([Callable f, $dart$core.Object args]) => f.s(args);

$dart$core.Object apply([Callable f, $dart$core.Object args]) => $package$apply(f, args);

class Array implements dart$$Basic, SearchableList, Ranged, IndexedCorrespondenceMutator {
    void _$init$Array([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.int $ofSize$size, $dart$core.Object $ofSize$element, Iterable $$elements]) {
        if (0 != ($bitmap & 4)) {
            _list = new $dart$core.List.from(new $ceylon$interop$dart.DartIterable($$elements));
        }
        if (0 != ($bitmap & 2)) {
            if ($ofSize$size > $package$runtime.maxArraySize) {
                throw new AssertionError(("array size must be no larger than " + $package$runtime.maxArraySize.toString()) + "");
            }
            _list = new $dart$core.List.filled($dartInt($package$largest($ceylonInteger($ofSize$size), $ceylonInteger(0)) as Integer), $ofSize$element);
        }
        if (0 != ($bitmap & 1)) {
            this._list = $withList$list;
        }
    }
    Array([Iterable elements]) : this.$d(4, null, null, null, elements);
    Array.$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.int $ofSize$size, $dart$core.Object $ofSize$element, Iterable $$elements]) {
        _$init$Array($bitmap | 4, $withList$list, $ofSize$size, $ofSize$element, $$elements);
    }
    Array.ofSize([$dart$core.int size, $dart$core.Object element]) : this.ofSize$d(2, null, size, element);
    Array.ofSize$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.int $ofSize$size, $dart$core.Object $ofSize$element]) {
        _$init$Array($bitmap | 2, $withList$list, $ofSize$size, $ofSize$element);
    }
    Array.withList([$dart$core.List list]) : this.withList$d(1, list);
    Array.withList$d([$dart$core.int $bitmap, $dart$core.List $withList$list]) {
        _$init$Array($bitmap | 1, $withList$list);
    }
    $dart$core.List _list;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (index >= 0) && (index < size) ? _list[index] : null;
    $dart$core.int get lastIndex => !_list.isEmpty ? _list.length - 1 : null;
    $dart$core.int get size => _list.length;
    $dart$core.bool get empty => _list.isEmpty;
    Array clone() => new Array.withList(_list.toList());
    void set([$dart$core.int index, $dart$core.Object element]) {
        if ((index < 0) || (index > (size - 1))) {
            throw new AssertionError("Index out of bounds");
        }
        _list[index] = element;
    }
    void swap([$dart$core.int i, $dart$core.int j]) {
        if ((i < 0) || (j < 0)) {
            throw new AssertionError("array index may not be negative");
        }
        if ((i >= size) || (j >= size)) {
            throw new AssertionError(("array index must be less than size of array " + size.toString()) + "");
        }
        $dart$core.Object oldI = _list[i];
        _list[i] = _list[j];
        _list[j] = oldI;
    }
    void reverseInPlace() {{
            $dart$core.Object element$1;
            Iterator iterator$0 = ($package$measure($ceylonInteger(0), size ~/ 2) as List).iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                Integer index;
                {
                    index = element$1 as Integer;
                }
                $dart$core.int otherIndex = (size - $dartInt(index)) - 1;
                $dart$core.Object x = _list[$dartInt(index)];
                _list[$dartInt(index)] = _list[otherIndex];
                _list[otherIndex] = x;
            }
        }
    }
    void move([$dart$core.int from, $dart$core.int to]) {
        if ((from < 0) || (to < 0)) {
            throw new AssertionError("array index may not be negative");
        }
        if ((from >= size) || (to >= size)) {
            throw new AssertionError(("array index must be less than size of array " + size.toString()) + "");
        }
        if (from == to) {
            return;
        }
        $dart$core.int len;
        $dart$core.int srcPos;
        $dart$core.int destPos;
        if (from > to) {
            len = from - to;
            srcPos = to;
            destPos = to + 1;
        } else {
            len = to - from;
            srcPos = from + 1;
            destPos = from;
        }
        $dart$core.Object x = _list[from];
        _list.setRange(destPos, destPos + len, _list, srcPos);
        _list[to] = x;
    }
    void copyTo([Array destination, $dart$core.Object sourcePosition = $package$dart$default, $dart$core.Object destinationPosition = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(sourcePosition, $package$dart$default)) {
            sourcePosition = 0;
        }
        if ($dart$core.identical(destinationPosition, $package$dart$default)) {
            destinationPosition = 0;
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = $dartInt($package$smallest($ceylonInteger(size - (sourcePosition as $dart$core.int)), $ceylonInteger(destination.size - (destinationPosition as $dart$core.int))) as Integer);
        }
        Array source = $package$identical(this, destination) ? this.clone() : this;
        $dart$core.int i = destinationPosition as $dart$core.int;
        {
            $dart$core.Object element$3;
            Iterator iterator$2 = source.sublistFrom(sourcePosition as $dart$core.int).take(length as $dart$core.int).iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                $dart$core.Object c;
                {
                    c = element$3;
                }
                destination.set((() {
                    $dart$core.int tmp$4 = i;
                    i = $dartInt($ceylonInteger(i).successor);
                    return tmp$4;
                })(), c);
            }
        }
    }
    Array span([Integer from, Integer to]) => new Array(List.$span(this, from, to));
    Array spanFrom([Integer from]) => new Array(List.$spanFrom(this, from));
    Array spanTo([Integer to]) => new Array(List.$spanTo(this, to));
    Array measure([Integer from, $dart$core.int length]) => new Array(List.$measure(this, from, length));
    Sequential sort([Callable comparing]) {
        $dart$core.List result = _list.toList();
        result.sort($ceylon$interop$dart.dartComparator(comparing));
        return new ArraySequence(new Array.withList(result));
    }
    void sortInPlace([Callable comparing]) {
        _list.sort($ceylon$interop$dart.dartComparator(comparing));
    }
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    $dart$core.String toString() => Collection.$get$string(this);
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => SearchableList.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurrences(this, element, from, length);
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurs(this, element, from, length);
    $dart$core.int firstOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$firstOccurrence(this, element, from, length);
    $dart$core.int lastOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$lastOccurrence(this, element, from, length);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => SearchableList.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$inclusions(this, sublist, from);
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$includes(this, sublist, from);
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$firstInclusion(this, sublist, from);
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$lastInclusion(this, sublist, from);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
Array $package$arrayOfSize([$dart$core.int size, $dart$core.Object element]) => new Array.ofSize(size, element);

Array arrayOfSize([$dart$core.int size, $dart$core.Object element]) => $package$arrayOfSize(size, element);

class ArraySequence implements dart$$Object, Sequence {
    ArraySequence([Array array]) {
        this._array = array;
        if (!(!this._array.empty)) {
            throw new AssertionError("Violated: !array.empty");
        }
    }
    Array _array;
    $dart$core.Object getFromFirst([$dart$core.int index]) => _array.getFromFirst(index);
    $dart$core.bool contains([$dart$core.Object element]) => _array.contains(element);
    $dart$core.int get size => _array.size;
    Iterator iterator() => _array.iterator();
    $dart$core.Object get first {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object tmp$1 = _array.first;
                if (!(null == tmp$1)) {
                    $dart$core.Object first$s1;
                    first$s1 = tmp$1;
                    doElse$0 = false;
                    return first$s1;
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
                $dart$core.Object tmp$3 = _array.last;
                if (!(null == tmp$3)) {
                    $dart$core.Object last$s1;
                    last$s1 = tmp$3;
                    doElse$2 = false;
                    return last$s1;
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
    Sequential get rest => size == 1 ? $package$empty : new ArraySequence(_array.spanFrom($ceylonInteger(1)));
    Sequence clone() => new ArraySequence(_array.clone());
    void each([Callable step]) {
        _array.each(step);
    }
    $dart$core.int count([Callable selecting]) => _array.count(selecting);
    $dart$core.bool every([Callable selecting]) => _array.every(selecting);
    $dart$core.bool any([Callable selecting]) => _array.any(selecting);
    $dart$core.Object find([Callable selecting]) => _array.find(selecting);
    $dart$core.Object findLast([Callable selecting]) => _array.findLast(selecting);
    $dart$core.Object reduce([Callable accumulating]) {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$4 = _array.reduce(accumulating);
            if (null == tmp$4) {
                throw new AssertionError("Violated: exists result = array.reduce(accumulating)");
            }
            result = tmp$4;
        }
        return result;
    }
    Sequence collect([Callable collecting]) {
        Sequence sequence$s1;
        {
            Sequential tmp$5 = _array.collect(collecting);
            if (!(tmp$5 is Sequence)) {
                throw new AssertionError("Violated: nonempty sequence = array.collect(collecting)");
            }
            sequence$s1 = tmp$5 as Sequence;
        }
        return sequence$s1;
    }
    Sequence sort([Callable comparing]) {
        Sequence sequence$s1;
        {
            Sequential tmp$6 = _array.sort(comparing);
            if (!(tmp$6 is Sequence)) {
                throw new AssertionError("Violated: nonempty sequence = array.sort(comparing)");
            }
            sequence$s1 = tmp$6 as Sequence;
        }
        return sequence$s1;
    }
    Sequential measure([Integer from, $dart$core.int length]) {
        if ((($dartInt(from) > lastIndex) || (length <= 0)) || (($dartInt(from) + length) <= 0)) {
            return $package$empty;
        } else {
            return new ArraySequence(_array.measure(from, length));
        }
    }
    Sequential span([Integer from, Integer to]) {
        if ($dartInt(from) <= $dartInt(to)) {
            return ($dartInt(to) < 0) || ($dartInt(from) > lastIndex) ? $package$empty : new ArraySequence(_array.span(from, to));
        } else {
            return ($dartInt(from) < 0) || ($dartInt(to) > lastIndex) ? $package$empty : new ArraySequence(_array.span(from, to));
        }
    }
    $dart$core.Object spanFrom([Integer from]) {
        if ($dartInt(from) <= 0) {
            return this;
        } else if ($dartInt(from) < size) {
            return new ArraySequence(_array.spanFrom(from));
        } else {
            return $package$empty;
        }
    }
    $dart$core.Object spanTo([Integer to]) {
        if ($dartInt(to) >= lastIndex) {
            return this;
        } else if ($dartInt(to) >= 0) {
            return new ArraySequence(_array.spanTo(to));
        } else {
            return $package$empty;
        }
    }
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class AssertionError  extends Throwable {
    AssertionError([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
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
    static $dart$core.Object $set$bit(final Binary $this, $dart$core.int index) => true;
    $dart$core.Object clear([$dart$core.int index]);
    static $dart$core.Object $clear([final Binary $this, $dart$core.int index]) => $this.set(index, false);
    $dart$core.Object flip([$dart$core.int index]);
}
abstract class Boolean implements dart$$Basic {
    Boolean() {}
}
class true_  extends Boolean {
    true_() {}
    $dart$core.String toString() => "true";
    $dart$core.int get hashCode => 1231;
}
final true_ $package$$true = new true_();

true_ get $true => $package$$true;

class false_  extends Boolean {
    false_() {}
    $dart$core.String toString() => "false";
    $dart$core.int get hashCode => 1237;
}
final false_ $package$$false = new false_();

false_ get $false => $package$$false;

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

class Byte implements dart$$Object, Binary, Invertible, Enumerable {
    Byte([$dart$core.int congruent]) {
        this._congruent = congruent;
        unsigned = $dartInt($ceylonInteger(this._congruent).and($ceylonInteger(255)));
    }
    $dart$core.int _congruent;
    $dart$core.int unsigned;
    $dart$core.bool get even => $ceylonInteger(unsigned).even;
    $dart$core.bool get zero => $ceylonInteger(unsigned).zero;
    $dart$core.bool get unit => $ceylonInteger(unsigned).unit;
    $dart$core.int get signed => unsigned >= 128 ? unsigned - 256 : unsigned;
    Byte operator -() => $ceylonInteger(-unsigned).byte;
    Byte operator +(Byte other) => $ceylonInteger(unsigned + other.unsigned).byte;
    Byte and([Byte other]) => $ceylonInteger(unsigned).and($ceylonInteger(other.unsigned)).byte;
    Byte flip([$dart$core.int index]) => (index >= 0) && (index <= 7) ? $ceylonInteger(unsigned).flip(index).byte : this;
    $dart$core.bool get([$dart$core.int index]) => (index >= 0) && (index <= 7) ? $ceylonInteger(unsigned).get(index) : false;
    Byte get not => $ceylonInteger(unsigned).not.byte;
    Byte or([Byte other]) => $ceylonInteger(unsigned).or($ceylonInteger(other.unsigned)).byte;
    Byte leftLogicalShift([$dart$core.int shift]) => $ceylonInteger(unsigned).leftLogicalShift($dartInt($ceylonInteger(shift).and($ceylonInteger(7)))).byte;
    Byte rightArithmeticShift([$dart$core.int shift]) => $ceylonInteger(signed).rightArithmeticShift($dartInt($ceylonInteger(shift).and($ceylonInteger(7)))).byte;
    Byte rightLogicalShift([$dart$core.int shift]) => $ceylonInteger(unsigned).rightLogicalShift($dartInt($ceylonInteger(shift).and($ceylonInteger(7)))).byte;
    Byte set([$dart$core.int index, $dart$core.Object bit = $package$dart$default]) {
        if ($dart$core.identical(bit, $package$dart$default)) {
            bit = Binary.$set$bit(this, index);
        }
        return $ceylonInteger(unsigned).set(index, bit).byte;
    }
    Byte xor([Byte other]) => $ceylonInteger(unsigned).xor($ceylonInteger(other.unsigned)).byte;
    Byte get predecessor => $ceylonInteger(unsigned - 1).byte;
    Byte get successor => $ceylonInteger(unsigned + 1).byte;
    Byte neighbour([$dart$core.int offset]) => $ceylonInteger(unsigned + offset).byte;
    $dart$core.int offset([Byte other]) => $dartInt($ceylonInteger(unsigned - other.unsigned).and($ceylonInteger(255)));
    $dart$core.int offsetSign([Byte other]) => unsigned == other.unsigned ? 0 : 1;
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$0 = true;
        if (that is Byte) {
            Byte that$1;
            that$1 = that as Byte;
            doElse$0 = false;
            return unsigned == that$1.unsigned;
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.int get hashCode => signed;
    $dart$core.String toString() => unsigned.toString();
    $dart$core.Object operator -($dart$core.Object other) => Invertible.$minus(this, other);
}
abstract class Category {
    $dart$core.bool contains([$dart$core.Object element]);
    $dart$core.bool containsEvery([Iterable elements]);
    static $dart$core.bool $containsEvery([final Category $this, Iterable elements]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = elements.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$1;
                }
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
                $dart$core.Object element;
                {
                    element = element$3;
                }
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
class ChainedIterator implements dart$$Basic, Iterator {
    ChainedIterator([Iterable first, Iterable second]) {
        this._first = first;
        this._second = second;
        _iter = this._first.iterator();
        _more = true;
    }
    Iterable _first;
    Iterable _second;
    Iterator _iter;
    $dart$core.bool _more;
    $dart$core.Object next() {
        $dart$core.Object element = _iter.next();
        if (_more && (element is Finished)) {
            _iter = _second.iterator();
            _more = false;
            return _iter.next();
        } else {
            return element;
        }
    }
    $dart$core.String toString() => ((("" + _first.toString()) + ".chain(") + _second.toString()) + ").iterator()";
}
Set $package$wsChars = (() {
    Iterable arg$0$0 = new LazyIterable(27, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return $ceylonInteger(9);
        case 1 :
        return $ceylonInteger(10);
        case 2 :
        return $ceylonInteger(11);
        case 3 :
        return $ceylonInteger(12);
        case 4 :
        return $ceylonInteger(13);
        case 5 :
        return $ceylonInteger(32);
        case 6 :
        return $ceylonInteger(133);
        case 7 :
        return $ceylonInteger(5760);
        case 8 :
        return $ceylonInteger(6158);
        case 9 :
        return $ceylonInteger(8232);
        case 10 :
        return $ceylonInteger(8233);
        case 11 :
        return $ceylonInteger(8287);
        case 12 :
        return $ceylonInteger(12288);
        case 13 :
        return $ceylonInteger(28);
        case 14 :
        return $ceylonInteger(29);
        case 15 :
        return $ceylonInteger(30);
        case 16 :
        return $ceylonInteger(31);
        case 17 :
        return $ceylonInteger(8192);
        case 18 :
        return $ceylonInteger(8193);
        case 19 :
        return $ceylonInteger(8194);
        case 20 :
        return $ceylonInteger(8195);
        case 21 :
        return $ceylonInteger(8196);
        case 22 :
        return $ceylonInteger(8197);
        case 23 :
        return $ceylonInteger(8198);
        case 24 :
        return $ceylonInteger(8200);
        case 25 :
        return $ceylonInteger(8201);
        case 26 :
        return $ceylonInteger(8202);
        }
    }, null);
    return $package$set(arg$0$0, $package$dart$default);
})();

Set get wsChars => $package$wsChars;

Set $package$digitZeroChars = (() {
    Iterable arg$1$0 = new LazyIterable(41, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return $ceylonInteger(48);
        case 1 :
        return $ceylonInteger(1632);
        case 2 :
        return $ceylonInteger(1776);
        case 3 :
        return $ceylonInteger(1984);
        case 4 :
        return $ceylonInteger(2406);
        case 5 :
        return $ceylonInteger(2534);
        case 6 :
        return $ceylonInteger(2662);
        case 7 :
        return $ceylonInteger(2790);
        case 8 :
        return $ceylonInteger(2918);
        case 9 :
        return $ceylonInteger(3046);
        case 10 :
        return $ceylonInteger(3174);
        case 11 :
        return $ceylonInteger(3302);
        case 12 :
        return $ceylonInteger(3430);
        case 13 :
        return $ceylonInteger(3664);
        case 14 :
        return $ceylonInteger(3792);
        case 15 :
        return $ceylonInteger(3872);
        case 16 :
        return $ceylonInteger(4160);
        case 17 :
        return $ceylonInteger(4240);
        case 18 :
        return $ceylonInteger(6112);
        case 19 :
        return $ceylonInteger(6160);
        case 20 :
        return $ceylonInteger(6470);
        case 21 :
        return $ceylonInteger(6608);
        case 22 :
        return $ceylonInteger(6784);
        case 23 :
        return $ceylonInteger(6800);
        case 24 :
        return $ceylonInteger(6992);
        case 25 :
        return $ceylonInteger(7088);
        case 26 :
        return $ceylonInteger(7232);
        case 27 :
        return $ceylonInteger(7248);
        case 28 :
        return $ceylonInteger(42528);
        case 29 :
        return $ceylonInteger(43216);
        case 30 :
        return $ceylonInteger(43264);
        case 31 :
        return $ceylonInteger(43472);
        case 32 :
        return $ceylonInteger(43600);
        case 33 :
        return $ceylonInteger(44016);
        case 34 :
        return $ceylonInteger(65296);
        case 35 :
        return $ceylonInteger(66720);
        case 36 :
        return $ceylonInteger(69734);
        case 37 :
        return $ceylonInteger(69872);
        case 38 :
        return $ceylonInteger(69942);
        case 39 :
        return $ceylonInteger(70096);
        case 40 :
        return $ceylonInteger(71360);
        }
    }, null);
    return $package$set(arg$1$0, $package$dart$default);
})();

Set get digitZeroChars => $package$digitZeroChars;

abstract class BaseCharacter implements dart$$Object, Comparable {
    BaseCharacter([$dart$core.int integer]) {
        this.integer = integer;
        if ((this.integer > 1114111) || (this.integer < 0)) {
            throw new OverflowException(("" + this.integer.toString()) + " is not a possible Unicode code point");
        }
    }
    $dart$core.int integer;
    $dart$core.String toString() => (new $dart$core.String.fromCharCode(integer)).toString();
    Character get lowercased => $package$characterFromInteger(($ceylon$interop$dart.dartString($ceylonString(toString()).lowercased).runes.elementAt(0) as $dart$core.num).toInt());
    Character get uppercased => $package$characterFromInteger(($ceylon$interop$dart.dartString($ceylonString(toString()).uppercased).runes.elementAt(0) as $dart$core.num).toInt());
    Character get titlecased => uppercased;
    $dart$core.bool get lowercase => !(uppercased == this);
    $dart$core.bool get uppercase => !(lowercased == this);
    $dart$core.bool get titlecase => uppercase;
    $dart$core.bool get digit {
        $dart$core.int check = $dartInt($ceylonInteger(integer).and($ceylonInteger(4294967280)));
        if ($package$digitZeroChars.contains($ceylonInteger(check))) {
            return $dartInt($ceylonInteger(integer).and($ceylonInteger(15))) <= 9;
        } else if ($package$digitZeroChars.contains($ceylonInteger(check).or($ceylonInteger(6)))) {
            return $dartInt($ceylonInteger(integer).and($ceylonInteger(15))) >= 6;
        } else {
            return (integer >= 120782) && (integer <= 120831);
        }
    }
    $dart$core.bool get letter => lowercase || uppercase;
    $dart$core.bool get whitespace => $package$wsChars.contains($ceylonInteger(integer));
    $dart$core.bool get control => $dartBool($package$nothing as Boolean);
    Comparison compare([BaseCharacter other]) => $ceylonInteger(integer).compare($ceylonInteger(other.integer));
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$2 = true;
        if (that is Character) {
            Character that$3;
            that$3 = that as Character;
            doElse$2 = false;
            return integer == that$3.integer;
        }
        if (doElse$2) {
            return false;
        }
    })();
    $dart$core.int get hashCode => integer;
    Character get predecessor => $package$characterFromInteger(integer - 1);
    Character get successor => $package$characterFromInteger(integer + 1);
    Character neighbour([$dart$core.int offset]) => $package$characterFromInteger(integer + offset);
    $dart$core.int offset([Character other]) => integer - other.integer;
    $dart$core.int offsetSign([Character other]) => $ceylonInteger(offset(other)).sign;
    $dart$core.bool operator >(BaseCharacter other) => integer > other.integer;
    $dart$core.bool operator <(BaseCharacter other) => integer < other.integer;
    $dart$core.bool operator >=(BaseCharacter other) => integer >= other.integer;
    $dart$core.bool operator <=(BaseCharacter other) => integer <= other.integer;
}
$dart$core.String $package$className([$dart$core.Object obj]) => (() {
    $dart$core.bool doElse$0 = true;
    if (!(null == obj)) {
        doElse$0 = false;
        return $ceylon$interop$dart.runtimeType(obj).toString();
    }
    if (doElse$0) {
        return "null_";
    }
})();

$dart$core.String className([$dart$core.Object obj]) => $package$className(obj);

class Collection$permutations$$anonymous$0_$$anonymous$5_ implements dart$$Basic, Iterator {
    Collection$permutations$$anonymous$0_ $outer$ceylon$language$Collection$permutations$$anonymous$0_;
    Collection$permutations$$anonymous$0_$$anonymous$5_([Collection$permutations$$anonymous$0_ $outer$ceylon$language$Collection$permutations$$anonymous$0_]) {
        this.$outer$ceylon$language$Collection$permutations$$anonymous$0_ = $outer$ceylon$language$Collection$permutations$$anonymous$0_;
        _elements = new Array($outer$ceylon$language$Collection$permutations$$anonymous$0_._multiset);
        _size = _elements.size;
        _initial = true;
    }
    Array _elements;
    $dart$core.int _size;
    $dart$core.bool _initial;
    $dart$core.Object next() {
        if (_initial) {
            _initial = false;
        } else {
            $dart$core.bool doElse$5 = true;
            {
                Entry tmp$6 = _elements.paired.locateLast(new dart$Callable(([Tuple $_0]) => (() {
                    $dart$core.int m;
                    $dart$core.Object $_$s1;
                    $dart$core.int n;
                    $dart$core.Object $__$s1;
                    {
                        Tuple d$7 = $_0;
                        Entry d$8 = d$7.getFromFirst(0) as Entry;
                        m = $dartInt(d$8.key as Integer);
                        $_$s1 = d$8.item;
                        Entry d$9 = d$7.getFromFirst(1) as Entry;
                        n = $dartInt(d$9.key as Integer);
                        $__$s1 = d$9.item;
                    }
                    return $ceylonBoolean(m < n);
                })()));
                if (!(null == tmp$6)) {
                    $dart$core.int i;
                    $dart$core.int key;
                    $dart$core.Object $_;
                    Entry $__;
                    Entry d$10 = tmp$6;
                    i = $dartInt(d$10.key as Integer);
                    Sequential d$11 = d$10.item as Sequential;
                    Entry d$12 = d$11.getFromFirst(0) as Entry;
                    key = $dartInt(d$12.key as Integer);
                    $_ = d$12.item;
                    $__ = d$11.getFromFirst(1) as Entry;
                    doElse$5 = false;
                    $dart$core.int j;
                    {
                        $dart$core.int tmp$13 = _elements.lastIndexWhere(new dart$Callable(([Entry $_0]) => (() {
                            $dart$core.int k;
                            $dart$core.Object $_$s1;
                            {
                                Entry d$14 = $_0;
                                k = $dartInt(d$14.key as Integer);
                                $_$s1 = d$14.item;
                            }
                            return $ceylonBoolean(k > key);
                        })()));
                        if (null == tmp$13) {
                            throw new AssertionError("Violated: exists j = elements.lastIndexWhere( (k->_) => k > key)");
                        }
                        j = tmp$13;
                    }
                    _elements.swap(i, j);
                    {
                        $dart$core.Object element$16;
                        Iterator iterator$15 = ($package$measure($ceylonInteger(0), ((_size - i) - 1) ~/ 2) as List).iterator();
                        while ((element$16 = iterator$15.next()) is !Finished) {
                            Integer k;
                            {
                                k = element$16 as Integer;
                            }
                            _elements.swap((i + 1) + $dartInt(k), (_size - 1) - $dartInt(k));
                        }
                    }
                }
            }
            if (doElse$5) {
                return $package$finished;
            }
        }
        return (() {
            $dart$core.bool doElse$17 = true;
            {
                Sequential tmp$18 = _elements.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).item)).sequence();
                if (tmp$18 is Sequence) {
                    Sequence permutation;
                    permutation = tmp$18 as Sequence;
                    doElse$17 = false;
                    return permutation;
                }
            }
            if (doElse$17) {
                return $package$finished;
            }
        })();
    }
}
class Collection$permutations$$anonymous$0_ implements dart$$Basic, Iterable {
    Collection $outer$ceylon$language$Collection;
    Collection$permutations$$anonymous$0_([Collection $outer$ceylon$language$Collection]) {
        this.$outer$ceylon$language$Collection = $outer$ceylon$language$Collection;
        _multiset = $outer$ceylon$language$Collection.indexed.group(new dart$Callable(([Entry $_0]) => (() {
            $dart$core.int $_;
            $dart$core.Object item;
            {
                Entry d$2 = $_0;
                $_ = $dartInt(d$2.key as Integer);
                item = d$2.item;
            }
            return (($dart$core.Object $lhs$) => null == $lhs$ ? $package$nullElement : $lhs$)(item);
        })())).items.sort(new dart$Callable(([Sequence x, Sequence y]) => ((x.first as Entry).key as Integer).compare((y.first as Entry).key as Integer))).indexed.flatMap(new dart$Callable(([Entry $_0]) => (() {
            $dart$core.int index;
            Sequence entries;
            {
                Entry d$3 = $_0;
                index = $dartInt(d$3.key as Integer);
                entries = d$3.item as Sequence;
            }
            return entries.map(new dart$Callable(([Entry $_0]) => (() {
                $dart$core.int $_;
                $dart$core.Object item;
                {
                    Entry d$4 = $_0;
                    $_ = $dartInt(d$4.key as Integer);
                    item = d$4.item;
                }
                return new Entry($ceylonInteger(index), item);
            })()));
        })()));
    }
    Iterable _multiset;
    $dart$core.bool get empty => _multiset.empty;
    Iterator iterator() => new Collection$permutations$$anonymous$0_$$anonymous$5_(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Collection$combinations$$anonymous$8_$$anonymous$9_ implements dart$$Basic, Iterator {
    Collection$combinations$$anonymous$8_ $outer$ceylon$language$Collection$combinations$$anonymous$8_;
    Collection$combinations$$anonymous$8_$$anonymous$9_([Collection$combinations$$anonymous$8_ $outer$ceylon$language$Collection$combinations$$anonymous$8_]) {
        this.$outer$ceylon$language$Collection$combinations$$anonymous$8_ = $outer$ceylon$language$Collection$combinations$$anonymous$8_;
        _elements = $outer$ceylon$language$Collection$combinations$$anonymous$8_._distinctElements.sequence();
        _size = _elements.size;
        if (!($outer$ceylon$language$Collection$combinations$$anonymous$8_.$capture$Collection$combinations$length <= _size)) {
            throw new AssertionError("Violated: length <= size");
        }
        _selection = new Array($package$measure($ceylonInteger(0), $outer$ceylon$language$Collection$combinations$$anonymous$8_.$capture$Collection$combinations$length) as Iterable);
        _done = _elements.empty;
    }
    Sequential _elements;
    $dart$core.int _size;
    Array _selection;
    $dart$core.bool _done;
    $dart$core.Object next() {
        if (_done) {
            return $package$finished;
        }
        Sequential current = _selection.collect(new dart$Callable(([Integer i]) {{
                $dart$core.bool doElse$19 = true;
                {
                    $dart$core.Object tmp$20 = _elements.getFromFirst($dartInt(i));
                    if (!(null == tmp$20)) {
                        $dart$core.Object e;
                        e = tmp$20;
                        doElse$19 = false;
                        return e;
                    }
                }
                if (doElse$19) {
                    if (!true) {
                        throw new AssertionError("Violated: is Element null");
                    }
                    return null;
                }
            }
        }));
        Sequence current$21;
        if (!(current is Sequence)) {
            throw new AssertionError("Violated: nonempty current");
        }
        current$21 = current as Sequence;
        $dart$core.int i = $outer$ceylon$language$Collection$combinations$$anonymous$8_.$capture$Collection$combinations$length - 1;
        while (true) {
            if (i < 0) {
                _done = true;
                break;
            }
            $dart$core.int s;
            {
                $dart$core.int tmp$22 = $dartInt(_selection.getFromFirst(i) as Integer);
                if (null == tmp$22) {
                    throw new AssertionError("Violated: exists s = selection.getFromFirst(i)");
                }
                s = tmp$22;
            }
            if (s == ((_size - $outer$ceylon$language$Collection$combinations$$anonymous$8_.$capture$Collection$combinations$length) + i)) {
                i = $dartInt($ceylonInteger(i).predecessor);
            } else {
                $dart$core.int j = s;
                while (i < $outer$ceylon$language$Collection$combinations$$anonymous$8_.$capture$Collection$combinations$length) {
                    _selection.set((() {
                        $dart$core.int tmp$23 = i;
                        i = $dartInt($ceylonInteger(i).successor);
                        return tmp$23;
                    })(), $ceylonInteger(j = $dartInt($ceylonInteger(j).successor)));
                }
                break;
            }
        }
        return current$21;
    }
}
class Collection$combinations$$anonymous$8_ implements dart$$Basic, Iterable {
    Collection $outer$ceylon$language$Collection;
    $dart$core.int $capture$Collection$combinations$length;
    Collection$combinations$$anonymous$8_([Collection $outer$ceylon$language$Collection, $dart$core.int $capture$Collection$combinations$length]) {
        this.$outer$ceylon$language$Collection = $outer$ceylon$language$Collection;
        this.$capture$Collection$combinations$length = $capture$Collection$combinations$length;
        _distinctElements = $outer$ceylon$language$Collection.distinct;
    }
    Iterable _distinctElements;
    $dart$core.bool get empty => $outer$ceylon$language$Collection.empty;
    Iterator iterator() => new Collection$combinations$$anonymous$8_$$anonymous$9_(this);
    $dart$core.bool contains([$dart$core.Object element]) => Iterable.$contains(this, element);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class Collection implements Iterable {
    Collection clone();
    $dart$core.bool get empty;
    static $dart$core.bool $get$empty([final Collection $this]) => $this.size == 0;
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Collection $this, $dart$core.Object element]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = $this.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$1;
                }
                if (!(null == elem)) {
                    if (elem == element) {
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
    static $dart$core.String $get$string([final Collection $this]) => $this.empty ? "{}" : ("{ " + $package$commaList($this)) + " }";
    Iterable get permutations;
    static Iterable $get$permutations([final Collection $this]) => new Collection$permutations$$anonymous$0_($this);
    Iterable combinations([$dart$core.int length]);
    static Iterable $combinations([final Collection $this, $dart$core.int length]) {
        if (!(length > 0)) {
            throw new AssertionError("Violated: length>0");
        }
        return new Collection$combinations$$anonymous$8_($this, length);
    }
}
class nullElement_ implements dart$$Basic {
    nullElement_() {}
}
final nullElement_ $package$nullElement = new nullElement_();

nullElement_ get nullElement => $package$nullElement;

abstract class Comparable {
    Comparison compare([$dart$core.Object other]);
    $dart$core.bool operator >($dart$core.Object other);
    static $dart$core.bool $largerThan([final Comparable $this, $dart$core.Object other]) => $dart$core.identical($this.compare(other), $package$larger);
    $dart$core.bool operator <($dart$core.Object other);
    static $dart$core.bool $smallerThan([final Comparable $this, $dart$core.Object other]) => $dart$core.identical($this.compare(other), $package$smaller);
    $dart$core.bool operator >=($dart$core.Object other);
    static $dart$core.bool $notSmallerThan([final Comparable $this, $dart$core.Object other]) => !$dart$core.identical($this.compare(other), $package$smaller);
    $dart$core.bool operator <=($dart$core.Object other);
    static $dart$core.bool $notLargerThan([final Comparable $this, $dart$core.Object other]) => !$dart$core.identical($this.compare(other), $package$larger);
}
Callable $package$comparing([Sequential comparators]) => new dart$Callable(([$dart$core.Object x, $dart$core.Object y]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = comparators.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Callable compare;
            {
                compare = element$1 as Callable;
            }
            Comparison comparison = compare.f(x, y) as Comparison;
            if (!(comparison == $package$equal)) {
                return comparison;
            }
        }
        {
            return $package$equal;
        }
    }
});

Callable comparing([Sequential comparators]) => $package$comparing(comparators);

abstract class Comparison implements dart$$Basic {
    Comparison([$dart$core.String string]) {
        this.string = string;
    }
    $dart$core.String string;
    $dart$core.String toString() => string;
    Comparison get reversed;
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

Sequential $package$concatenate([Sequential iterables]) => dart$functionIterable(new dart$Callable(() {
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

    Iterable it$4;
    $dart$core.bool step$1$6() {
        while (step$1$Init$5()) {
            $dart$core.Object next$3;
            if ((next$3 = iterator_1$2.next()) is !Finished) {
                Iterable it;
                {
                    it = next$3 as Iterable;
                }
                it$4 = it;
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
        Iterable it = it$4;
        iterator_2$7 = it.iterator();
        return true;
    }

    $dart$core.Object val$9;
    $dart$core.bool step$2$11() {
        while (step$2$Init$10()) {
            Iterable it = it$4;
            $dart$core.Object next$8;
            if ((next$8 = iterator_2$7.next()) is !Finished) {
                $dart$core.Object val;
                {
                    val = next$8;
                }
                val$9 = val;
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
        Iterable it = it$4;
        $dart$core.Object val = val$9;
        return val;
    }

    return new dart$Callable(step$3$12);
})).sequence();

Sequential concatenate([Sequential iterables]) => $package$concatenate(iterables);

abstract class ConstrainedAnnotation implements Annotation {
}
class Contextual$Using implements dart$$Basic, Obtainable {
    Contextual $outer$ceylon$language$Contextual;
    Contextual$Using([Contextual $outer$ceylon$language$Contextual, $dart$core.Object newValue]) {
        this.$outer$ceylon$language$Contextual = $outer$ceylon$language$Contextual;
        this._newValue = newValue;
        _previous = null;
    }
    $dart$core.Object _newValue;
    $dart$core.Object _previous;
    void obtain() {
        _previous = $outer$ceylon$language$Contextual._val;
        {
            $dart$core.bool doElse$1 = true;
            if (_newValue is Callable) {
                Callable newValue$2;
                newValue$2 = _newValue as Callable;
                doElse$1 = false;
                $outer$ceylon$language$Contextual._val = newValue$2.f();
            }
            if (doElse$1) {
                $outer$ceylon$language$Contextual._val = _newValue;
            }
        }
    }
    void release([Throwable error]) {{
            $dart$core.bool doElse$3 = true;
            {
                $dart$core.Object tmp$4 = _previous;
                if (!(null == tmp$4)) {
                    $dart$core.Object p;
                    p = tmp$4;
                    doElse$3 = false;
                    $outer$ceylon$language$Contextual._val = p;
                }
            }
            if (doElse$3) {
                $outer$ceylon$language$Contextual._val = null;
            }
        }
    }
}
class Contextual implements dart$$Basic {
    Contextual() {
        _val = null;
    }
    $dart$core.Object _val;
    $dart$core.Object get() {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$0 = _val;
            if (null == tmp$0) {
                throw new AssertionError("Violated: exists result = val");
            }
            result = tmp$0;
        }
        return result;
    }
    Contextual$Using $new$Contextual$Using([$dart$core.Object newValue]) => new Contextual$Using(this, newValue);
}
class Correspondence$keys$$anonymous$0_ implements dart$$Basic, Category {
    Correspondence $outer$ceylon$language$Correspondence;
    Correspondence$keys$$anonymous$0_([Correspondence $outer$ceylon$language$Correspondence]) {
        this.$outer$ceylon$language$Correspondence = $outer$ceylon$language$Correspondence;
    }
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
                $dart$core.Object key;
                {
                    key = element$1;
                }
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
                $dart$core.Object key;
                {
                    key = element$3;
                }
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
    static Iterable $getAll([final Correspondence $this, Iterable keys]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object key$8;
        $dart$core.bool step$1$10() {
            while (step$1$Init$9()) {
                $dart$core.Object next$7;
                if ((next$7 = iterator_1$6.next()) is !Finished) {
                    $dart$core.Object key;
                    {
                        key = next$7;
                    }
                    key$8 = key;
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
            $dart$core.Object key = key$8;
            return $this.get(key);
        }

        return new dart$Callable(step$2$11);
    }));
}
abstract class CorrespondenceMutator {
}
abstract class IndexedCorrespondenceMutator implements CorrespondenceMutator {
    void set([$dart$core.int index, $dart$core.Object item]);
}
abstract class KeyedCorrespondenceMutator implements CorrespondenceMutator {
    void put([$dart$core.Object key, $dart$core.Object item]);
}
$dart$core.bool $package$corresponding([Iterable firstIterable, Iterable secondIterable, $dart$core.Object comparing = $package$dart$default]) {
    if ($dart$core.identical(comparing, $package$dart$default)) {
        comparing = new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => (() {
            $dart$core.bool doElse$0 = true;
            if (!(null == first)) {
                if (!(null == second)) {
                    doElse$0 = false;
                    return $ceylonBoolean(first == second);
                }
            }
            if (doElse$0) {
                return $ceylonBoolean((!(!(null == first))) && (!(!(null == second))));
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
                    if (!$dartBool((comparing as Callable).f(first, second) as Boolean)) {
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

Comparison $package$compareCorresponding([Iterable firstIterable, Iterable secondIterable, Callable comparing]) {
    Iterator firstIter = firstIterable.iterator();
    Iterator secondIter = secondIterable.iterator();
    while (true) {
        $dart$core.Object first = firstIter.next();
        $dart$core.Object second = secondIter.next();
        {
            $dart$core.bool doElse$2 = true;
            if (!(first is Finished)) {
                if (!(second is Finished)) {
                    doElse$2 = false;
                    Comparison comp = comparing.f(first, second) as Comparison;
                    if (!(comp == $package$equal)) {
                        return comp;
                    }
                }
            }
            if (doElse$2) {
                $dart$core.bool firstFinished = first is Finished;
                $dart$core.bool secondFinished = second is Finished;
                return firstFinished && (!secondFinished) ? $package$smaller : (!firstFinished) && secondFinished ? $package$larger : $package$equal;
            }
        }
    }
}

Comparison compareCorresponding([Iterable firstIterable, Iterable secondIterable, Callable comparing]) => $package$compareCorresponding(firstIterable, secondIterable, comparing);

$dart$core.int $package$count([Iterable values]) {
    $dart$core.int count = 0;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val;
            {
                val = element$1 as Boolean;
            }
            if ($dartBool(val)) {
                count = $dartInt($ceylonInteger(count).successor);
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

class CycledIterator implements dart$$Basic, Iterator {
    CycledIterator([Iterable iterable, $dart$core.int times]) {
        this._iterable = iterable;
        this._times = times;
        _iter = $package$emptyIterator;
        _count = 0;
    }
    Iterable _iterable;
    $dart$core.int _times;
    Iterator _iter;
    $dart$core.int _count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object next$1 = _iter.next();
                if (!(next$1 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$1;
                    doElse$0 = false;
                    return next$s1;
                }
            }
            if (doElse$0) {
                if (_count < _times) {
                    _count = $dartInt($ceylonInteger(_count).successor);
                    _iter = _iterable.iterator();
                } else {
                    _iter = $package$emptyIterator;
                }
                return _iter.next();
            }
        }
    }
    $dart$core.String toString() => ((("" + _iterable.toString()) + ".repeat(") + _times.toString()) + ").iterator()";
}
class dart$VariableBox implements dart$$Basic {
    dart$VariableBox([$dart$core.Object v]) {
        this.v = v;
    }
    $dart$core.Object v;
}
class dart$VariableBoxBool implements dart$$Basic {
    dart$VariableBoxBool([$dart$core.bool v]) {
        this.v = v;
    }
    $dart$core.bool v;
}
class dart$VariableBoxInt implements dart$$Basic {
    dart$VariableBoxInt([$dart$core.int v]) {
        this.v = v;
    }
    $dart$core.int v;
}
class dart$VariableBoxDouble implements dart$$Basic {
    dart$VariableBoxDouble([$dart$core.double v]) {
        this.v = v;
    }
    $dart$core.double v;
}
class dart$VariableBoxString implements dart$$Basic {
    dart$VariableBoxString([$dart$core.String v]) {
        this.v = v;
    }
    $dart$core.String v;
}
class functionIterable$$anonymous$0_$$anonymous$1_ implements dart$$Basic, Iterator {
    functionIterable$$anonymous$0_ $outer$ceylon$language$functionIterable$$anonymous$0_;
    functionIterable$$anonymous$0_$$anonymous$1_([functionIterable$$anonymous$0_ $outer$ceylon$language$functionIterable$$anonymous$0_]) {
        this.$outer$ceylon$language$functionIterable$$anonymous$0_ = $outer$ceylon$language$functionIterable$$anonymous$0_;
        next$c = $outer$ceylon$language$functionIterable$$anonymous$0_.$capture$dart$functionIterable$f.f() as Callable;
    }
    Callable next$c;
    $dart$core.Object next() {
        return next$c.f();
    }
}
class functionIterable$$anonymous$0_ implements dart$$Basic, Iterable {
    Callable $capture$dart$functionIterable$f;
    functionIterable$$anonymous$0_([Callable $capture$dart$functionIterable$f]) {
        this.$capture$dart$functionIterable$f = $capture$dart$functionIterable$f;
    }
    Iterator iterator() => new functionIterable$$anonymous$0_$$anonymous$1_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Iterable $package$dart$functionIterable([Callable f]) => new functionIterable$$anonymous$0_(f);

Iterable dart$functionIterable([Callable f]) => $package$dart$functionIterable(f);

Throwable $package$dart$wrapThrownObject([$dart$core.Object thrown]) => (() {
    $dart$core.bool doElse$0 = true;
    if (thrown is Throwable) {
        Throwable thrown$1;
        thrown$1 = thrown as Throwable;
        doElse$0 = false;
        return thrown$1;
    }
    if (doElse$0) {
        return new Exception(thrown.toString());
    }
})();

Throwable dart$wrapThrownObject([$dart$core.Object thrown]) => $package$dart$wrapThrownObject(thrown);

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
class empty_ implements dart$$Object, Empty {
    empty_() {}
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
    $dart$core.String toString() => Empty.$get$string(this);
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
    Empty trim([Callable trimming]) => Empty.$trim(this, trimming);
    Empty trimLeading([Callable trimming]) => Empty.$trimLeading(this, trimming);
    Empty trimTrailing([Callable trimming]) => Empty.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => Empty.$slice(this, index);
    void each([Callable step]) => Empty.$each(this, step);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
final empty_ $package$empty = new empty_();

empty_ get empty => $package$empty;

class emptyIterator_ implements dart$$Basic, Iterator {
    emptyIterator_() {}
    Finished next() => $package$finished;
    $dart$core.String toString() => "empty.iterator()";
}
final emptyIterator_ $package$emptyIterator = new emptyIterator_();

emptyIterator_ get emptyIterator => $package$emptyIterator;

$dart$core.Object $package$emptyOrSingleton([$dart$core.Object element]) => (() {
    $dart$core.bool doElse$0 = true;
    if (!(null == element)) {
        doElse$0 = false;
        return new Tuple.$withList([element]);
    }
    if (doElse$0) {
        return $package$empty;
    }
})();

$dart$core.Object emptyOrSingleton([$dart$core.Object element]) => $package$emptyOrSingleton(element);

class Entry implements dart$$Object {
    Entry([$dart$core.Object key, $dart$core.Object item]) {
        this.key = key;
        this.item = item;
    }
    $dart$core.Object key;
    $dart$core.Object item;
    Tuple get pair => new Tuple.$withList([key, item]);
    Entry get coalesced => (() {
        $dart$core.bool doElse$0 = true;
        if (!(null == item)) {
            doElse$0 = false;
            return new Entry(key, item);
        }
        if (doElse$0) {
            return null;
        }
    })();
    $dart$core.bool operator ==($dart$core.Object that) {{
            $dart$core.bool doElse$1 = true;
            if (that is Entry) {
                Entry that$2;
                that$2 = that as Entry;
                doElse$1 = false;
                if (!(this.key == that$2.key)) {
                    return false;
                }
                {
                    $dart$core.bool doElse$3 = true;
                    {
                        $dart$core.Object tmp$4 = this.item;
                        if (!(null == tmp$4)) {
                            $dart$core.Object thisItem;
                            thisItem = tmp$4;
                            {
                                $dart$core.Object tmp$5 = that$2.item;
                                if (!(null == tmp$5)) {
                                    $dart$core.Object thatItem;
                                    thatItem = tmp$5;
                                    doElse$3 = false;
                                    return thisItem == thatItem;
                                }
                            }
                        }
                    }
                    if (doElse$3) {
                        return (!(!(null == this.item))) && (!(!(null == that$2.item)));
                    }
                }
            }
            if (doElse$1) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode => ((31 + key.hashCode) * 31) + (($dart$core.int $lhs$) => null == $lhs$ ? 0 : $lhs$)((($dart$core.Object $r) => null == $r ? null : $r.hashCode)(item));
    $dart$core.String toString() => ((("" + key.toString()) + "->") + $package$stringify(item)) + "";
}
abstract class Enumerable implements Ordinal {
    $dart$core.Object neighbour([$dart$core.int offset]);
    $dart$core.Object get successor;
    static $dart$core.Object $get$successor([final Enumerable $this]) => $this.neighbour(1);
    $dart$core.Object get predecessor;
    static $dart$core.Object $get$predecessor([final Enumerable $this]) => $this.neighbour(-1);
    $dart$core.int offset([$dart$core.Object other]);
    $dart$core.int offsetSign([$dart$core.Object other]);
    static $dart$core.int $offsetSign([final Enumerable $this, $dart$core.Object other]) => $ceylonInteger($this.offset(other)).sign;
}
$dart$core.bool $package$every([Iterable values]) {{
        $dart$core.Object element$1;
        Iterator iterator$0 = values.iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Boolean val;
            {
                val = element$1 as Boolean;
            }
            if (!$dartBool(val)) {
                return false;
            }
        }
    }
    return true;
}

$dart$core.bool every([Iterable values]) => $package$every(values);

class Exception  extends Throwable {
    Exception([$dart$core.Object description = $package$dart$default, $dart$core.Object cause = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(description, $package$dart$default)) {
            description = null;
        }
        if ($dart$core.identical(cause, $package$dart$default)) {
            cause = null;
        }
        return [description, cause];
    })());
    Exception.$s([$dart$core.List a]) : this.$w(a[0], a[1]);
    Exception.$w([$dart$core.String description, Throwable cause]) : super(description, cause) {
        this._description$1 = description;
        this._cause = cause;
    }
    $dart$core.String _description$1;
    Throwable _cause;
}
Iterable $package$expand([Iterable iterables]) => dart$functionIterable(new dart$Callable(() {
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

    Iterable it$4;
    $dart$core.bool step$1$6() {
        while (step$1$Init$5()) {
            $dart$core.Object next$3;
            if ((next$3 = iterator_1$2.next()) is !Finished) {
                Iterable it;
                {
                    it = next$3 as Iterable;
                }
                it$4 = it;
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
        Iterable it = it$4;
        iterator_2$7 = it.iterator();
        return true;
    }

    $dart$core.Object val$9;
    $dart$core.bool step$2$11() {
        while (step$2$Init$10()) {
            Iterable it = it$4;
            $dart$core.Object next$8;
            if ((next$8 = iterator_2$7.next()) is !Finished) {
                $dart$core.Object val;
                {
                    val = next$8;
                }
                val$9 = val;
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
        Iterable it = it$4;
        $dart$core.Object val = val$9;
        return val;
    }

    return new dart$Callable(step$3$12);
}));

Iterable expand([Iterable iterables]) => $package$expand(iterables);

abstract class Exponentiable implements Numeric {
    $dart$core.Object power([$dart$core.Object other]);
}
abstract class Finished implements dart$$Basic {
    Finished() {}
}
class finished_  extends Finished {
    finished_() {}
    $dart$core.String toString() => "finished";
}
final finished_ $package$finished = new finished_();

finished_ get finished => $package$finished;

class Float implements dart$$Object, Number, Exponentiable {
    Float([$dart$core.double float]) {
        this._float = float;
    }
    $dart$core.double _float;
    $dart$core.bool get undefined => $ceylon$interop$dart.dartDouble($dartDouble(this)).isNaN;
    $dart$core.bool get infinite => $ceylon$interop$dart.dartDouble($dartDouble(this)).isInfinite;
    $dart$core.bool get finite => $ceylon$interop$dart.dartDouble($dartDouble(this)).isFinite;
    $dart$core.int get sign => $dartDouble(this) > 0.0 ? 1 : $dartDouble(this) < 0.0 ? -1 : 0;
    $dart$core.bool get positive => $dartDouble(this) > 0.0;
    $dart$core.bool get negative => $dartDouble(this) < 0.0;
    $dart$core.bool get strictlyPositive => ($dartDouble(this) > 0.0) || ((1.0 / $dartDouble(this)) > 0.0);
    $dart$core.bool get strictlyNegative => ($dartDouble(this) < 0.0) || ((1.0 / $dartDouble(this)) < 0.0);
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$0 = true;
        if (that is Float) {
            $dart$core.double that$1;
            that$1 = $dartDouble(that as Float);
            doElse$0 = false;
            return $dartDouble(this) == that$1;
        }
        if (doElse$0) {
            return (() {
                $dart$core.bool doElse$2 = true;
                if (that is Integer) {
                    $dart$core.int that$3;
                    that$3 = $dartInt(that as Integer);
                    doElse$2 = false;
                    return ((that$3 < $package$twoFiftyThree) && (that$3 > (-$package$twoFiftyThree))) && (that$3.toDouble() == $dartDouble(this));
                }
                if (doElse$2) {
                    return false;
                }
            })();
        }
    })();
    $dart$core.int get hashCode => $ceylon$interop$dart.dartDouble(_float).hashCode;
    Comparison compare([Float other]) => $dartDouble(this) < $dartDouble(other) ? $package$smaller : $dartDouble(this) > $dartDouble(other) ? $package$larger : $package$equal;
    Float operator +(Float other) => $ceylonFloat($dartDouble(this) + $dartDouble(other));
    Float operator -(Float other) => $ceylonFloat($dartDouble(this) - $dartDouble(other));
    Float operator *(Float other) => $ceylonFloat($dartDouble(this) * $dartDouble(other));
    Float operator /(Float other) => $ceylonFloat($dartDouble(this) / $dartDouble(other));
    Float power([Float other]) => $ceylonFloat($dart$math.pow($ceylon$interop$dart.dartNumFromFloat($dartDouble(this)), $ceylon$interop$dart.dartNumFromFloat($dartDouble(other))).toDouble());
    Float get wholePart {
        $dart$core.double result = $ceylon$interop$dart.dartDouble($dartDouble(this)).truncateToDouble();
        if ((result == $dartDouble(this)) && ($ceylonFloat(result).sign == sign)) {
            return this;
        }
        return $ceylonFloat(result);
    }
    Float get fractionalPart => $ceylonFloat($ceylon$interop$dart.dartDouble($dartDouble(this)).remainder($ceylon$interop$dart.dartNumFromInteger(1)));
    Float get magnitude => $dartDouble(this) <= 0.0 ? $ceylonFloat(-$dartDouble(this)) : this;
    Float operator -() => $ceylonFloat(-$dartDouble(this));
    $dart$core.int get integer => $ceylon$interop$dart.dartDouble($dartDouble(this)).toInt();
    Float timesInteger([$dart$core.int integer]) => $ceylonFloat($dartDouble(this) * integer.toDouble());
    Float plusInteger([$dart$core.int integer]) => $ceylonFloat($dartDouble(this) + integer.toDouble());
    Float powerOfInteger([$dart$core.int integer]) => $ceylonFloat($dart$math.pow($ceylon$interop$dart.dartNumFromFloat($dartDouble(this)), $ceylon$interop$dart.dartNumFromInteger(integer)).toDouble());
    $dart$core.String toString() => _float.toString();
    $dart$core.bool operator >(Float other) => $dartDouble(this) > $dartDouble(other);
    $dart$core.bool operator <(Float other) => $dartDouble(this) < $dartDouble(other);
    $dart$core.bool operator >=(Float other) => $dartDouble(this) >= $dartDouble(other);
    $dart$core.bool operator <=(Float other) => $dartDouble(this) <= $dartDouble(other);
}
Callable $package$forItem([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.f(entry.item));

Callable forItem([Callable resulting]) => $package$forItem(resulting);

Callable $package$forKey([Callable resulting]) => new dart$Callable(([Entry entry]) => resulting.f(entry.key));

Callable forKey([Callable resulting]) => $package$forKey(resulting);

$dart$core.String $package$formatFloat([$dart$core.double float, $dart$core.Object minDecimalPlaces = $package$dart$default, $dart$core.Object maxDecimalPlaces = $package$dart$default, $dart$core.Object decimalSeparator = $package$dart$default, $dart$core.Object thousandsSeparator = $package$dart$default]) {
    if ($dart$core.identical(minDecimalPlaces, $package$dart$default)) {
        minDecimalPlaces = 1;
    }
    if ($dart$core.identical(maxDecimalPlaces, $package$dart$default)) {
        maxDecimalPlaces = 9;
    }
    if ($dart$core.identical(decimalSeparator, $package$dart$default)) {
        decimalSeparator = new Character.$fromInt(46);
    }
    if ($dart$core.identical(thousandsSeparator, $package$dart$default)) {
        thousandsSeparator = null;
    }
    if (!(null == thousandsSeparator)) {
        Character thousandsSeparator$0;
        thousandsSeparator$0 = thousandsSeparator as Character;
        if (!((!thousandsSeparator$0.digit) && (!(thousandsSeparator$0 == (new Character.$fromInt(45)))))) {
            throw new AssertionError("Violated: !thousandsSeparator.digit && !thousandsSeparator == '-'");
        }
        if (!(!(thousandsSeparator$0 == decimalSeparator))) {
            throw new AssertionError("Violated: thousandsSeparator != decimalSeparator");
        }
    }
    if (!((!(decimalSeparator as Character).digit) && (!((decimalSeparator as Character) == (new Character.$fromInt(45)))))) {
        throw new AssertionError("Violated: !decimalSeparator.digit && !decimalSeparator == '-'");
    }
    if ((maxDecimalPlaces as $dart$core.int) < 0) {
        maxDecimalPlaces = 0;
    }
    if ((minDecimalPlaces as $dart$core.int) < 0) {
        minDecimalPlaces = 0;
    }
    if ((maxDecimalPlaces as $dart$core.int) < (minDecimalPlaces as $dart$core.int)) {
        maxDecimalPlaces = minDecimalPlaces;
    }
    if ($ceylonFloat(float) == $ceylonInteger(0)) {
        if ((minDecimalPlaces as $dart$core.int) > 0) {
            return ((("0" + (decimalSeparator as Character).toString()) + "") + ("0" * (minDecimalPlaces as $dart$core.int))) + "";
        }
        return "0";
    } else if ($ceylonFloat(float).undefined || $ceylonFloat(float).infinite) {
        return float.toString();
    }
    $dart$core.int wholeDigitNumber = 0;
    $dart$core.String thousands = (($dart$core.String $lhs$) => null == $lhs$ ? "" : $lhs$)(((Character $r) => null == $r ? null : $r.toString())(thousandsSeparator as Character));
    StringBuilder result = new StringBuilder();
    $dart$core.double magnitude = float.abs();
    $dart$core.int decimalMoveRight = (() {
        $dart$core.Object arg$1$0 = $ceylonInteger(maxDecimalPlaces as $dart$core.int);
        $dart$core.Object arg$1$1 = $ceylonInteger(14 - $package$exponent(magnitude));
        return $dartInt($package$smallest(arg$1$0, arg$1$1) as Integer);
    })();
    $dart$core.double normalized = $package$scaleByPowerOfTen(magnitude, decimalMoveRight);
    $dart$core.int integer = $package$halfEven(normalized).toInt();
    $dart$core.int fractionalPartDigits = decimalMoveRight;
    $dart$core.bool emittedFractional = false;
    if ((minDecimalPlaces as $dart$core.int) > fractionalPartDigits) {
        if (fractionalPartDigits > 0) {
            result.append("0" * ((minDecimalPlaces as $dart$core.int) - fractionalPartDigits));
        } else {
            result.append("0" * (minDecimalPlaces as $dart$core.int));
        }
        emittedFractional = true;
    }
    while (fractionalPartDigits > (maxDecimalPlaces as $dart$core.int)) {
        integer = integer ~/ 10;
        fractionalPartDigits = $dartInt($ceylonInteger(fractionalPartDigits).predecessor);
    }
    while (fractionalPartDigits > 0) {
        $dart$core.int digit = integer.remainder(10);
        integer = integer ~/ 10;
        if (((!(digit == 0)) || emittedFractional) || (fractionalPartDigits <= (minDecimalPlaces as $dart$core.int))) {
            result.appendCharacter((new Character.$fromInt(48)).neighbour(digit));
            emittedFractional = true;
        }
        fractionalPartDigits = $dartInt($ceylonInteger(fractionalPartDigits).predecessor);
    }
    if (emittedFractional) {
        result.appendCharacter(decimalSeparator as Character);
    }
    if (integer == 0) {
        result.appendCharacter(new Character.$fromInt(48));
    } else {
        while ((() {
            $dart$core.int tmp$2 = fractionalPartDigits;
            fractionalPartDigits = $dartInt($ceylonInteger(fractionalPartDigits).successor);
            return tmp$2;
        })() < 0) {
            if ($ceylonInteger(3).divides((() {
                Integer tmp$3 = $ceylonInteger(wholeDigitNumber);
                $ceylonInteger(wholeDigitNumber = $dartInt($ceylonInteger(wholeDigitNumber).successor));
                return tmp$3;
            })()) && (!(wholeDigitNumber == 1))) {
                result.append(thousands);
            }
            result.appendCharacter(new Character.$fromInt(48));
        }
        while (!(integer == 0)) {
            if ($ceylonInteger(3).divides((() {
                Integer tmp$4 = $ceylonInteger(wholeDigitNumber);
                $ceylonInteger(wholeDigitNumber = $dartInt($ceylonInteger(wholeDigitNumber).successor));
                return tmp$4;
            })()) && (!(wholeDigitNumber == 1))) {
                result.append(thousands);
            }
            $dart$core.int digit = integer.remainder(10);
            integer = integer ~/ 10;
            result.appendCharacter((new Character.$fromInt(48)).neighbour(digit));
        }
    }
    if (float < 0.0) {
        result.appendCharacter(new Character.$fromInt(45));
    }
    return $dartString($ceylonString(result.toString()).reversed);
}

$dart$core.String formatFloat([$dart$core.double float, $dart$core.Object minDecimalPlaces = $package$dart$default, $dart$core.Object maxDecimalPlaces = $package$dart$default, $dart$core.Object decimalSeparator = $package$dart$default, $dart$core.Object thousandsSeparator = $package$dart$default]) => $package$formatFloat(float, minDecimalPlaces, maxDecimalPlaces, decimalSeparator, thousandsSeparator);

$dart$core.int $package$exponent([$dart$core.double f]) => (() {
    $dart$core.double l10;
    {
        l10 = $package$log10(f.abs());
    }
    return ($dartDouble($ceylonFloat(l10).fractionalPart) == 0.0) || (l10 > 0.0) ? $dartDouble($ceylonFloat(l10).wholePart).toInt() : $dartDouble($ceylonFloat(l10).wholePart).toInt() - 1;
})();

$dart$core.int exponent([$dart$core.double f]) => $package$exponent(f);

$dart$core.double $package$scaleByPowerOfTen([$dart$core.double float, $dart$core.int power]) {
    $dart$core.double doScale([$dart$core.double float, $dart$core.int power]) {
        $dart$core.double scale = (() {
            $dart$core.int magnitude;
            {
                magnitude = power.abs();
            }
            return magnitude <= 15 ? $dartInt($ceylonInteger(10).power($ceylonInteger(magnitude))).toDouble() : $dartDouble($ceylonFloat(10.0).powerOfInteger(magnitude));
        })();
        return power < 0 ? float / scale : float * scale;
    }

    $dart$core.double result = float;
    while (power > 0) {
        $dart$core.int amount = $dartInt($package$smallest($ceylonInteger(308), $ceylonInteger(power)) as Integer);
        result = doScale(result, amount);
        power = power - amount;
    }
    while (power < 0) {
        $dart$core.int amount = $dartInt($package$largest($ceylonInteger(-308), $ceylonInteger(power)) as Integer);
        result = doScale(result, amount);
        power = power - amount;
    }
    return result;
}

$dart$core.double scaleByPowerOfTen([$dart$core.double float, $dart$core.int power]) => $package$scaleByPowerOfTen(float, power);

$dart$core.double $package$twoFiftyTwo = $ceylonInteger(2).power($ceylonInteger(52)).float;

$dart$core.double get twoFiftyTwo => $package$twoFiftyTwo;

$dart$core.double $package$halfEven([$dart$core.double num]) {
    if (($ceylonFloat(num).infinite || $ceylonFloat(num).undefined) || ($dartDouble($ceylonFloat(num).fractionalPart) == 0.0)) {
        return num;
    }
    $dart$core.double result = num.abs();
    if (result >= $package$twoFiftyTwo) {
        return num;
    }
    result = ($package$twoFiftyTwo + result) - $package$twoFiftyTwo;
    return result * $ceylonInteger($ceylonFloat(num).sign).float;
}

$dart$core.double halfEven([$dart$core.double num]) => $package$halfEven(num);

$dart$core.double $package$log10([$dart$core.double num]) => $dart$math.log($ceylon$interop$dart.dartNumFromFloat(num)) / $dart$math.LN10;

$dart$core.double log10([$dart$core.double num]) => $package$log10(num);

$dart$core.String $package$formatInteger([$dart$core.int integer, $dart$core.Object radix = $package$dart$default, $dart$core.Object groupingSeparator = $package$dart$default]) {
    if ($dart$core.identical(radix, $package$dart$default)) {
        radix = 10;
    }
    if ($dart$core.identical(groupingSeparator, $package$dart$default)) {
        groupingSeparator = null;
    }
    if (!(((radix as $dart$core.int) >= $package$minRadix) && ((radix as $dart$core.int) <= $package$maxRadix))) {
        throw new AssertionError("Violated: minRadix <= radix <= maxRadix");
    }
    if (!(null == groupingSeparator)) {
        Character groupingSeparator$0;
        groupingSeparator$0 = groupingSeparator as Character;
        if (!(((!groupingSeparator$0.digit) && (!groupingSeparator$0.letter)) && (!(groupingSeparator$0 == (new Character.$fromInt(45)))))) {
            throw new AssertionError("Violated: !groupingSeparator.digit && !groupingSeparator.letter && !groupingSeparator == '-'");
        }
    }
    if (integer == 0) {
        return "0";
    }
    $dart$core.int groupingSize = !(!(null == (groupingSeparator as Character))) ? 0 : (radix as $dart$core.int) == 10 ? 3 : ((radix as $dart$core.int) == 2) || ((radix as $dart$core.int) == 16) ? 4 : 0;
    Character groupingChar = (() {
        $dart$core.bool doElse$1 = true;
        if (!(null == groupingSeparator)) {
            Character groupingSeparator$2;
            groupingSeparator$2 = groupingSeparator as Character;
            if (!(groupingSize == 0)) {
                doElse$1 = false;
                return groupingSeparator$2;
            }
        }
        if (doElse$1) {
            return new Character.$fromInt(88);
        }
    })();
    $dart$core.int digitNumber = 0;
    Iterable digits = $package$empty;
    $dart$core.int i = integer < 0 ? integer : -integer;
    while (!(i == 0)) {
        $dart$core.int d = -i.remainder(radix as $dart$core.int);
        Character c;
        if ((d >= 0) && (d < 10)) {
            c = $ceylonInteger(d + $package$zeroInt).character;
        } else if ((d >= 10) && (d < 36)) {
            c = $ceylonInteger((d - 10) + $package$aIntLower).character;
        } else {
            if (!false) {
                throw new AssertionError("Violated: false");
            }
        }
        if (((!(groupingSize == 0)) && $ceylonInteger(groupingSize).divides((() {
            Integer tmp$3 = $ceylonInteger(digitNumber);
            $ceylonInteger(digitNumber = $dartInt($ceylonInteger(digitNumber).successor));
            return tmp$3;
        })())) && (!(digitNumber == 1))) {
            digits = digits.follow(groupingChar);
        }
        digits = digits.follow(c);
        i = (i + d) ~/ (radix as $dart$core.int);
    }
    if (integer < 0) {
        digits = digits.follow(new Character.$fromInt(45));
    }
    return $dartString(new String(digits));
}

$dart$core.String formatInteger([$dart$core.int integer, $dart$core.Object radix = $package$dart$default, $dart$core.Object groupingSeparator = $package$dart$default]) => $package$formatInteger(integer, radix, groupingSeparator);

$dart$core.Object $package$identity([$dart$core.Object argument]) => argument;

$dart$core.Object identity([$dart$core.Object argument]) => $package$identity(argument);

void $package$noop([Sequential arguments]) {}

void noop([Sequential arguments]) => $package$noop(arguments);

$dart$core.bool $package$identical([$dart$core.Object x, $dart$core.Object y]) => $dart$core.identical(x, y);

$dart$core.bool identical([$dart$core.Object x, $dart$core.Object y]) => $package$identical(x, y);

$dart$core.int $package$identityHash([$dart$core.Object identifiable]) => $dart$core.identityHashCode(identifiable);

$dart$core.int identityHash([$dart$core.Object identifiable]) => $package$identityHash(identifiable);

abstract class impl$BaseIterable implements dart$$Object, Iterable {
    impl$BaseIterable() {}
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class impl$BaseIterator implements dart$$Object, Iterator {
    impl$BaseIterator() {}
}
abstract class impl$BaseMap implements dart$$Object, Map {
    impl$BaseMap() {}
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => Map.$getOrDefault(this, key, $default);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Map clone() => Map.$clone(this);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseList implements dart$$Object, SearchableList {
    impl$BaseList() {}
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => SearchableList.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurrences(this, element, from, length);
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurs(this, element, from, length);
    $dart$core.int firstOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$firstOccurrence(this, element, from, length);
    $dart$core.int lastOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$lastOccurrence(this, element, from, length);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => SearchableList.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$inclusions(this, sublist, from);
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$includes(this, sublist, from);
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$firstInclusion(this, sublist, from);
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$lastInclusion(this, sublist, from);
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseCharacterList implements dart$$Object, SearchableList {
    impl$BaseCharacterList() {}
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => SearchableList.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurrences(this, element, from, length);
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurs(this, element, from, length);
    $dart$core.int firstOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$firstOccurrence(this, element, from, length);
    $dart$core.int lastOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$lastOccurrence(this, element, from, length);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => SearchableList.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$inclusions(this, sublist, from);
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$includes(this, sublist, from);
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$firstInclusion(this, sublist, from);
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$lastInclusion(this, sublist, from);
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class impl$BaseSequence implements dart$$Object, Sequence {
    impl$BaseSequence() {}
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class impl$ElementImpl implements dart$$Basic, serialization$Element {
    impl$ElementImpl([$dart$core.int index]) {
        this.index = index;
    }
    $dart$core.int index;
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getAnything(instance, this);
    }
    $dart$core.String toString() => ("Element [index=" + index.toString()) + "]";
    $dart$core.int get hashCode => index;
    $dart$core.bool operator ==($dart$core.Object other) {{
            $dart$core.bool doElse$0 = true;
            if (other is impl$ElementImpl) {
                impl$ElementImpl other$1;
                other$1 = other as impl$ElementImpl;
                doElse$0 = false;
                return $dart$core.identical(this, other$1) || (index == other$1.index);
            }
            if (doElse$0) {
                return false;
            }
        }
    }
}
class impl$MemberImpl implements dart$$Basic, serialization$Member {
    void _$init$impl$MemberImpl([$dart$core.int $bitmap, meta$declaration$FunctionOrValueDeclaration $$attribute]) {
        if (0 != ($bitmap & 1)) {
            meta$declaration$ValueDeclaration attribute$0;
            if (!($$attribute is meta$declaration$ValueDeclaration)) {
                throw new AssertionError("Violated: is ValueDeclaration attribute");
            }
            attribute$0 = $$attribute as meta$declaration$ValueDeclaration;
            this.attribute = attribute$0;
        }
    }
    impl$MemberImpl([meta$declaration$FunctionOrValueDeclaration attribute]) : this.$d(1, attribute);
    impl$MemberImpl.$d([$dart$core.int $bitmap, meta$declaration$FunctionOrValueDeclaration $$attribute]) {
        _$init$impl$MemberImpl($bitmap | 1, $$attribute);
    }
    meta$declaration$ValueDeclaration attribute;
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getAnything(instance, this);
    }
    $dart$core.String toString() => ("Member [attribute=" + attribute.toString()) + "]";
    $dart$core.int get hashCode => attribute.hashCode;
    $dart$core.bool operator ==($dart$core.Object other) {{
            $dart$core.bool doElse$1 = true;
            if (other is impl$MemberImpl) {
                impl$MemberImpl other$2;
                other$2 = other as impl$MemberImpl;
                doElse$1 = false;
                return $dart$core.identical(this, other$2) || (attribute == other$2.attribute);
            }
            if (doElse$1) {
                return false;
            }
        }
    }
}
class impl$meta$ModuleImpl implements dart$$Basic, meta$declaration$Module {
    impl$meta$ModuleImpl([$ceylon$dart$runtime$model.Module delegate]) {
        this._delegate = delegate;
    }
    $ceylon$dart$runtime$model.Module _delegate;
    $dart$core.bool annotated() => $dartBool($package$nothing as Boolean);
    Sequential annotations() => $package$nothing as Sequential;
    Sequential get dependencies => $package$nothing as Sequential;
    meta$declaration$Package findImportedPackage([$dart$core.String name]) => (() {
        $dart$core.bool doElse$0 = true;
        {
            $ceylon$dart$runtime$model.Package tmp$1 = _delegate.findPackage(name);
            if (!(null == tmp$1)) {
                $ceylon$dart$runtime$model.Package p;
                p = tmp$1;
                doElse$0 = false;
                return new impl$meta$PackageImpl(p);
            }
        }
        if (doElse$0) {
            return null;
        }
    })();
    meta$declaration$Package findPackage([$dart$core.String name]) => (() {
        $dart$core.bool doElse$2 = true;
        {
            $ceylon$dart$runtime$model.Package tmp$3 = _delegate.findDirectPackage(name);
            if (!(null == tmp$3)) {
                $ceylon$dart$runtime$model.Package p;
                p = tmp$3;
                doElse$2 = false;
                return new impl$meta$PackageImpl(p);
            }
        }
        if (doElse$2) {
            return null;
        }
    })();
    Sequential get members => _delegate.packages.collect(new dart$Callable(([$ceylon$dart$runtime$model.Package $0]) => new impl$meta$PackageImpl($0)));
    $dart$core.String get name => _delegate.nameAsString;
    $dart$core.String get qualifiedName => _delegate.nameAsString;
    Resource resourceByPath([$dart$core.String path]) => $package$nothing as Resource;
    $dart$core.String get version => (($dart$core.String $lhs$) => null == $lhs$ ? "unknownVersion" : $lhs$)(_delegate.version);
    $dart$core.String toString() => ((("module " + name) + "/") + version) + "";
}
class impl$meta$PackageImpl implements dart$$Basic, meta$declaration$Package {
    impl$meta$PackageImpl([$ceylon$dart$runtime$model.Package delegate]) {
        this._delegate = delegate;
    }
    $ceylon$dart$runtime$model.Package _delegate;
    $dart$core.bool annotated() => $dartBool($package$nothing as Boolean);
    Sequential annotatedMembers() => $package$nothing as Sequential;
    Sequential annotations() => $package$nothing as Sequential;
    meta$declaration$Module get container => new impl$meta$ModuleImpl(_delegate.mod);
    meta$declaration$AliasDeclaration getAlias([$dart$core.String name]) => $package$nothing as meta$declaration$AliasDeclaration;
    meta$declaration$ClassOrInterfaceDeclaration getClassOrInterface([$dart$core.String name]) => $package$nothing as meta$declaration$ClassOrInterfaceDeclaration;
    meta$declaration$FunctionDeclaration getFunction([$dart$core.String name]) => $package$nothing as meta$declaration$FunctionDeclaration;
    $dart$core.Object getMember([$dart$core.String name]) => $package$nothing;
    meta$declaration$ValueDeclaration getValue([$dart$core.String name]) => $package$nothing as meta$declaration$ValueDeclaration;
    Sequential members() => _delegate.members.items.narrow().map(new dart$Callable(([$ceylon$dart$runtime$model.Class $0]) => new impl$meta$ClassWithConstructorsDeclarationImpl($0))).narrow().sequence();
    $dart$core.String get name => qualifiedName;
    $dart$core.String get qualifiedName => _delegate.qualifiedName;
    $dart$core.bool get shared => $dartBool($package$nothing as Boolean);
    $dart$core.String toString() => ("package " + name) + "";
}
class impl$meta$ClassWithConstructorsDeclarationImpl implements dart$$Basic, meta$declaration$ClassWithConstructorsDeclaration {
    impl$meta$ClassWithConstructorsDeclarationImpl([$ceylon$dart$runtime$model.Class delegate]) {
        this._delegate = delegate;
    }
    $ceylon$dart$runtime$model.Class _delegate;
    $dart$core.bool get abstract => _delegate.isAbstract;
    $dart$core.bool get actual => _delegate.isActual;
    $dart$core.bool annotated() => $dartBool($package$nothing as Boolean);
    Sequential annotatedConstructorDeclarations() => $package$nothing as Sequential;
    Sequential annotatedDeclaredMemberDeclarations() => $package$nothing as Sequential;
    Sequential annotatedMemberDeclarations() => $package$nothing as Sequential;
    $dart$core.bool get annotation => $dartBool($package$nothing as Boolean);
    Sequential annotations() => $package$nothing as Sequential;
    $dart$core.bool get anonymous => _delegate.isAnonymous;
    meta$model$ClassOrInterface apply([Sequential typeArguments]) => $package$nothing as meta$model$ClassOrInterface;
    Sequential get caseTypes => $package$nothing as Sequential;
    meta$model$Class classApply([Sequential typeArguments]) => $package$nothing as meta$model$Class;
    $dart$core.Object get container => $package$nothing;
    meta$declaration$Module get containingModule => new impl$meta$ModuleImpl(_delegate.mod);
    meta$declaration$Package get containingPackage => new impl$meta$PackageImpl(_delegate.pkg);
    Sequential declaredMemberDeclarations() => $package$nothing as Sequential;
    $dart$core.bool get $default => _delegate.isDefault;
    meta$declaration$CallableConstructorDeclaration get defaultConstructor => $package$nothing as meta$declaration$CallableConstructorDeclaration;
    meta$declaration$OpenClassType get extendedType => $package$nothing as meta$declaration$OpenClassType;
    $dart$core.bool get $final => _delegate.isFinal;
    $dart$core.bool get formal => _delegate.isFormal;
    $dart$core.Object getDeclaredMemberDeclaration([$dart$core.String name]) => $package$nothing;
    $dart$core.Object getMemberDeclaration([$dart$core.String name]) => $package$nothing;
    meta$declaration$FunctionOrValueDeclaration getParameterDeclaration([$dart$core.String name]) => $package$nothing as meta$declaration$FunctionOrValueDeclaration;
    meta$declaration$TypeParameter getTypeParameterDeclaration([$dart$core.String name]) => $package$nothing as meta$declaration$TypeParameter;
    $dart$core.bool get isAlias => _delegate.isAlias;
    $dart$core.Object memberApply([meta$model$Type containerType, Sequential typeArguments]) => $package$nothing;
    meta$model$MemberClass memberClassApply([meta$model$Type containerType, Sequential typeArguments]) => $package$nothing as meta$model$MemberClass;
    Sequential memberDeclarations() => $package$nothing as Sequential;
    $dart$core.String get name => _delegate.name;
    meta$declaration$ValueDeclaration get objectValue => $package$nothing as meta$declaration$ValueDeclaration;
    meta$declaration$OpenType get openType => $package$nothing as meta$declaration$OpenType;
    Sequential get parameterDeclarations => $package$nothing as Sequential;
    $dart$core.String get qualifiedName => _delegate.qualifiedName;
    Sequential get satisfiedTypes => $package$nothing as Sequential;
    $dart$core.bool get serializable => $dartBool($package$nothing as Boolean);
    $dart$core.bool get shared => _delegate.isShared;
    $dart$core.bool get toplevel => _delegate.isToplevel;
    Sequential get typeParameterDeclarations => $package$nothing as Sequential;
    Sequential constructorDeclarations() => $package$nothing as Sequential;
    $dart$core.Object getConstructorDeclaration([$dart$core.String name]) => $package$nothing;
    $dart$core.String toString() => ("class " + qualifiedName) + "";
    $dart$core.Object instantiate([$dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) => meta$declaration$ClassDeclaration.$instantiate(this, typeArguments, arguments);
    $dart$core.Object memberInstantiate([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) => meta$declaration$ClassDeclaration.$memberInstantiate(this, container, typeArguments, arguments);
}
class impl$outerImpl_ implements dart$$Basic, serialization$Outer {
    impl$outerImpl_() {}
    $dart$core.Object referred([$dart$core.Object instance]) {
        return $package$impl$reach.getObject(instance, this);
    }
    $dart$core.String toString() => "Outer";
}
final impl$outerImpl_ $package$impl$outerImpl = new impl$outerImpl_();

impl$outerImpl_ get impl$outerImpl => $package$impl$outerImpl;

class impl$reach_ implements dart$$Basic {
    impl$reach_() {}
    Iterator references([$dart$core.Object instance]) => $package$nothing as Iterator;
    $dart$core.Object getAnything([$dart$core.Object instance, serialization$ReachableReference ref]) => $package$nothing;
    $dart$core.Object getObject([$dart$core.Object instance, serialization$ReachableReference ref]) => $package$nothing;
    $dart$core.String toString() => "reach";
}
final impl$reach_ $package$impl$reach = new impl$reach_();

impl$reach_ get impl$reach => $package$impl$reach;

void $package$impl$$rethrow([Throwable x]) {
    throw x;
}

void impl$$rethrow([Throwable x]) => $package$impl$$rethrow(x);

$dart$core.double $package$infinity = 1.0 / 0.0;

$dart$core.double get infinity => $package$infinity;

class InitializationError  extends AssertionError {
    InitializationError([$dart$core.String description]) : super(description) {
        this._description$1 = description;
    }
    $dart$core.String _description$1;
}
$dart$core.int $package$twoFiftyThree = $dartInt($ceylonInteger(2).power($ceylonInteger(53)));

$dart$core.int get twoFiftyThree => $package$twoFiftyThree;

class Integer implements dart$$Object, Integral, Binary, Exponentiable {
    Integer([$dart$core.int integer]) {
        this._integer = integer;
    }
    $dart$core.int _integer;
    Character get character => $package$characterFromInteger($dartInt(this));
    $dart$core.bool divides([Integer other]) => $dartInt(other).remainder($dartInt(this)) == 0;
    Integer operator +(Integer other) => $ceylonInteger($dartInt(this) + $dartInt(other));
    Integer operator -(Integer other) => $ceylonInteger($dartInt(this) - $dartInt(other));
    Integer operator *(Integer other) => $ceylonInteger($dartInt(this) * $dartInt(other));
    Integer operator /(Integer other) => $ceylonInteger($dartInt(this) ~/ $dartInt(other));
    Integer operator %(Integer other) => $ceylonInteger($dartInt(this).remainder($dartInt(other)));
    Integer modulo([Integer modulus]) {
        if ($dartInt(modulus) < 0) {
            throw new AssertionError("modulus must be positive");
        }
        $dart$core.int result = $dartInt(this).remainder($dartInt(modulus));
        if (result < 0) {
            return $ceylonInteger(result + $dartInt(modulus));
        }
        return $ceylonInteger(result);
    }
    Integer power([Integer other]) => powerOfInteger($dartInt(other));
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$0 = true;
        if (that is Integer) {
            $dart$core.int that$1;
            that$1 = $dartInt(that as Integer);
            doElse$0 = false;
            return $dartInt(this) == that$1;
        }
        if (doElse$0) {
            return (() {
                $dart$core.bool doElse$2 = true;
                if (that is Float) {
                    $dart$core.double that$3;
                    that$3 = $dartDouble(that as Float);
                    doElse$2 = false;
                    return (($dartInt(this) < $package$twoFiftyThree) && ($dartInt(this) > (-$package$twoFiftyThree))) && ($dartInt(this).toDouble() == that$3);
                }
                if (doElse$2) {
                    return false;
                }
            })();
        }
    })();
    $dart$core.int get hashCode => $dartInt(this);
    Comparison compare([Integer other]) => $dartInt(this) < $dartInt(other) ? $package$smaller : $dartInt(this) > $dartInt(other) ? $package$larger : $package$equal;
    $dart$core.bool get([$dart$core.int index]) => $package$intGet($dartInt(this), index);
    Integer clear([$dart$core.int index]) => $ceylonInteger($package$intSet($dartInt(this), index, false));
    Integer flip([$dart$core.int index]) => $ceylonInteger($package$intFlip($dartInt(this), index));
    Integer set([$dart$core.int index, $dart$core.Object bit = $package$dart$default]) {
        if ($dart$core.identical(bit, $package$dart$default)) {
            bit = Binary.$set$bit(this, index);
        }
        return $ceylonInteger($package$intSet($dartInt(this), index, bit as $dart$core.bool));
    }
    Integer get not => $ceylonInteger($package$intNot($dartInt(this)));
    Integer or([Integer other]) => $ceylonInteger($package$intOr($dartInt(this), $dartInt(other)));
    Integer xor([Integer other]) => $ceylonInteger($package$intXor($dartInt(this), $dartInt(other)));
    Integer and([Integer other]) => $ceylonInteger($package$intAnd($dartInt(this), $dartInt(other)));
    Integer rightArithmeticShift([$dart$core.int shift]) => $ceylonInteger($package$intRightArithmeticShift($dartInt(this), shift));
    Integer rightLogicalShift([$dart$core.int shift]) => $ceylonInteger($package$intRightLogicalShift($dartInt(this), shift));
    Integer leftLogicalShift([$dart$core.int shift]) => $ceylonInteger($package$intLeftLogicalShift($dartInt(this), shift));
    $dart$core.double get float {
        if (($dartInt(this) <= (-$package$twoFiftyThree)) || ($dartInt(this) >= $package$twoFiftyThree)) {
            throw new OverflowException(toString() + " cannot be coerced into a 64 bit floating point value");
        }
        return nearestFloat;
    }
    $dart$core.double get nearestFloat => _integer.toDouble();
    Integer get predecessor => $ceylonInteger($dartInt(this) - 1);
    Integer get successor => $ceylonInteger($dartInt(this) + 1);
    Integer neighbour([$dart$core.int offset]) {
        $dart$core.int result = $dartInt(this) + offset;
        if (!((result >= $package$runtime.minIntegerValue) && (result <= $package$runtime.maxIntegerValue))) {
            throw new OverflowException(((("" + $dartInt(this).toString()) + " has no neighbour with offset ") + offset.toString()) + "");
        }
        return $ceylonInteger(result);
    }
    $dart$core.int offset([Integer other]) {
        $dart$core.int result = $dartInt(this) - $dartInt(other);
        if (!((result >= $package$runtime.minIntegerValue) && (result <= $package$runtime.maxIntegerValue))) {
            throw new OverflowException(((("offset from " + $dartInt(this).toString()) + " to ") + $dartInt(other).toString()) + " cannot be represented as an Integer.");
        }
        return result;
    }
    $dart$core.int offsetSign([Integer other]) => $ceylonInteger(offset(other)).sign;
    $dart$core.bool get unit => $dartInt(this) == 1;
    $dart$core.bool get zero => $dartInt(this) == 0;
    $dart$core.bool get even => $dartInt(this).remainder(2) == 0;
    Integer get magnitude => $ceylonInteger(_integer.abs());
    $dart$core.int get sign => $dartInt(this) > 0 ? 1 : $dartInt(this) < 0 ? -1 : 0;
    $dart$core.bool get negative => $dartInt(this) < 0;
    $dart$core.bool get positive => $dartInt(this) > 0;
    Integer get wholePart => this;
    Integer get fractionalPart => $ceylonInteger(0);
    Integer operator -() => $ceylonInteger(-$dartInt(this));
    Integer timesInteger([$dart$core.int integer]) => $ceylonInteger($dartInt(this) * integer);
    Integer plusInteger([$dart$core.int integer]) => $ceylonInteger($dartInt(this) + integer);
    Integer powerOfInteger([$dart$core.int integer]) => $ceylonInteger($package$intPow($dartInt(this), integer));
    $dart$core.String toString() => _integer.toString();
    $dart$core.bool operator >(Integer other) => $dartInt(this) > $dartInt(other);
    $dart$core.bool operator <(Integer other) => $dartInt(this) < $dartInt(other);
    $dart$core.bool operator >=(Integer other) => $dartInt(this) >= $dartInt(other);
    $dart$core.bool operator <=(Integer other) => $dartInt(this) <= $dartInt(other);
    Byte get byte => new Byte($dartInt(this));
}
abstract class Integral implements Number, Enumerable {
    $dart$core.Object operator %($dart$core.Object other);
    $dart$core.Object modulo([$dart$core.Object modulus]);
    static $dart$core.Object $modulo([final Integral $this, $dart$core.Object modulus]) {
        if (!(modulus as Number).positive) {
            throw new AssertionError(("modulus must be positive: " + modulus.toString()) + "");
        }
        $dart$core.Object result = $this % modulus;
        if ((result as Number).negative) {
            return (result as Summable) + modulus;
        }
        return result;
    }
    $dart$core.bool get zero;
    $dart$core.bool get unit;
    $dart$core.bool divides([$dart$core.Object other]);
    static $dart$core.bool $divides([final Integral $this, $dart$core.Object other]) => (((other as Integral) % $this) as Integral).zero;
}
class interleave$$anonymous$0_$$anonymous$1_ implements dart$$Basic, Iterator {
    interleave$$anonymous$0_ $outer$ceylon$language$interleave$$anonymous$0_;
    interleave$$anonymous$0_$$anonymous$1_([interleave$$anonymous$0_ $outer$ceylon$language$interleave$$anonymous$0_]) {
        this.$outer$ceylon$language$interleave$$anonymous$0_ = $outer$ceylon$language$interleave$$anonymous$0_;
        _iterators = $outer$ceylon$language$interleave$$anonymous$0_.$capture$interleave$iterables.collect(new dart$Callable(([Iterable it]) => it.iterator()));
        _which = 0;
    }
    Sequence _iterators;
    $dart$core.int _which;
    $dart$core.Object next() {
        Iterator iter;
        {
            Iterator tmp$18 = _iterators.getFromFirst(_which) as Iterator;
            if (null == tmp$18) {
                throw new AssertionError("Violated: exists iter = iterators[which]");
            }
            iter = tmp$18;
        }
        {
            $dart$core.bool doElse$19 = true;
            {
                $dart$core.Object next$20 = iter.next();
                if (!(next$20 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$20;
                    doElse$19 = false;
                    if ((_which = $dartInt($ceylonInteger(_which).successor)) >= _iterators.size) {
                        _which = 0;
                    }
                    return next$s1;
                }
            }
            if (doElse$19) {
                return $package$finished;
            }
        }
    }
}
class interleave$$anonymous$0_ implements dart$$Basic, Iterable {
    Sequence $capture$interleave$iterables;
    interleave$$anonymous$0_([Sequence $capture$interleave$iterables]) {
        this.$capture$interleave$iterables = $capture$interleave$iterables;
    }
    $dart$core.int get size => (() {
        Iterable arg$0$0 = dart$functionIterable(new dart$Callable(() {
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

            Iterable it$5;
            $dart$core.bool step$1$7() {
                while (step$1$Init$6()) {
                    $dart$core.Object next$4;
                    if ((next$4 = iterator_1$3.next()) is !Finished) {
                        Iterable it;
                        {
                            it = next$4 as Iterable;
                        }
                        it$5 = it;
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
                Iterable it = it$5;
                return $ceylonInteger(it.size);
            }

            return new dart$Callable(step$2$8);
        }));
        return $dartInt($package$min(arg$0$0) as Integer);
    })() * $capture$interleave$iterables.size;
    $dart$core.bool get empty => (() {
        Iterable arg$9$0 = dart$functionIterable(new dart$Callable(() {
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

            Iterable it$14;
            $dart$core.bool step$1$16() {
                while (step$1$Init$15()) {
                    $dart$core.Object next$13;
                    if ((next$13 = iterator_1$12.next()) is !Finished) {
                        Iterable it;
                        {
                            it = next$13 as Iterable;
                        }
                        it$14 = it;
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
                Iterable it = it$14;
                return $ceylonBoolean(it.empty);
            }

            return new dart$Callable(step$2$17);
        }));
        return $package$any(arg$9$0);
    })();
    Iterator iterator() => new interleave$$anonymous$0_$$anonymous$1_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Iterable $package$interleave([Sequence iterables]) => new interleave$$anonymous$0_(iterables);

Iterable interleave([Sequence iterables]) => $package$interleave(iterables);

abstract class Invertible implements Summable {
    $dart$core.Object operator -();
    $dart$core.Object operator -($dart$core.Object other);
    static $dart$core.Object $minus([final Invertible $this, $dart$core.Object other]) => $this + (-(other as Invertible));
}
class Iterable$exceptLast$$anonymous$2_$$anonymous$3_ implements dart$$Basic, Iterator {
    Iterable$exceptLast$$anonymous$2_ $outer$ceylon$language$Iterable$exceptLast$$anonymous$2_;
    Iterator $capture$$iter;
    Iterable$exceptLast$$anonymous$2_$$anonymous$3_([Iterable$exceptLast$$anonymous$2_ $outer$ceylon$language$Iterable$exceptLast$$anonymous$2_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$exceptLast$$anonymous$2_ = $outer$ceylon$language$Iterable$exceptLast$$anonymous$2_;
        this.$capture$$iter = $capture$$iter;
        _current = $capture$$iter.next();
    }
    $dart$core.Object _current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$13 = true;
            {
                $dart$core.Object next$14 = $capture$$iter.next();
                if (!(next$14 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$14;
                    doElse$13 = false;
                    $dart$core.Object result = _current;
                    _current = next$s1;
                    return result;
                }
            }
            if (doElse$13) {
                return $package$finished;
            }
        }
    }
}
class Iterable$exceptLast$$anonymous$2_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$exceptLast$$anonymous$2_([Iterable $outer$ceylon$language$Iterable]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
    }
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$exceptLast$$anonymous$2_$$anonymous$3_(this, iter);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$scan$$anonymous$4_$$anonymous$5_ implements dart$$Basic, Iterator {
    Iterable$scan$$anonymous$4_ $outer$ceylon$language$Iterable$scan$$anonymous$4_;
    Iterator $capture$$iter;
    Iterable$scan$$anonymous$4_$$anonymous$5_([Iterable$scan$$anonymous$4_ $outer$ceylon$language$Iterable$scan$$anonymous$4_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$scan$$anonymous$4_ = $outer$ceylon$language$Iterable$scan$$anonymous$4_;
        this.$capture$$iter = $capture$$iter;
        _returnInitial = true;
        _partial = $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
    }
    $dart$core.bool _returnInitial;
    $dart$core.Object _partial;
    $dart$core.Object next() {
        if (_returnInitial) {
            _returnInitial = false;
            return $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$initial;
        } else {
            $dart$core.bool doElse$48 = true;
            {
                $dart$core.Object element$49 = $capture$$iter.next();
                if (!(element$49 is Finished)) {
                    $dart$core.Object element;
                    element = element$49;
                    doElse$48 = false;
                    _partial = $outer$ceylon$language$Iterable$scan$$anonymous$4_.$capture$Iterable$scan$accumulating.f(_partial, element);
                    return _partial;
                }
            }
            if (doElse$48) {
                return $package$finished;
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$scan$$anonymous$4_.toString() + ".iterator()";
}
class Iterable$scan$$anonymous$4_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.Object $capture$Iterable$scan$initial;
    Callable $capture$Iterable$scan$accumulating;
    Iterable$scan$$anonymous$4_([Iterable $outer$ceylon$language$Iterable, $dart$core.Object $capture$Iterable$scan$initial, Callable $capture$Iterable$scan$accumulating]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$scan$initial = $capture$Iterable$scan$initial;
        this.$capture$Iterable$scan$accumulating = $capture$Iterable$scan$accumulating;
    }
    $dart$core.bool get empty => false;
    $dart$core.Object get first => $capture$Iterable$scan$initial;
    $dart$core.int get size => 1 + $outer$ceylon$language$Iterable.size;
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$scan$$anonymous$4_$$anonymous$5_(this, iter);
    })();
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$locations$$anonymous$6_$$anonymous$7_ implements dart$$Basic, Iterator {
    Iterable$locations$$anonymous$6_ $outer$ceylon$language$Iterable$locations$$anonymous$6_;
    Iterator $capture$$iter;
    Iterable$locations$$anonymous$6_$$anonymous$7_([Iterable$locations$$anonymous$6_ $outer$ceylon$language$Iterable$locations$$anonymous$6_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$locations$$anonymous$6_ = $outer$ceylon$language$Iterable$locations$$anonymous$6_;
        this.$capture$$iter = $capture$$iter;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() {
        while (true) {
            $dart$core.Object next$s1;
            {
                $dart$core.Object next$60 = $capture$$iter.next();
                if (next$60 is Finished) {
                    break;
                }
                next$s1 = next$60;
            }
            {
                $dart$core.bool doElse$58 = true;
                if (!(null == next$s1)) {
                    if ($dartBool($outer$ceylon$language$Iterable$locations$$anonymous$6_.$capture$Iterable$locations$selecting.f(next$s1) as Boolean)) {
                        doElse$58 = false;
                        return new Entry((() {
                            $dart$core.Object tmp$59 = $ceylonInteger(_i);
                            $ceylonInteger(_i = $dartInt($ceylonInteger(_i).successor));
                            return tmp$59;
                        })(), next$s1);
                    }
                }
                if (doElse$58) {
                    _i = $dartInt($ceylonInteger(_i).successor);
                }
            }
        }
        return $package$finished;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$locations$$anonymous$6_.toString() + ".iterator()";
}
class Iterable$locations$$anonymous$6_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$locations$selecting;
    Iterable$locations$$anonymous$6_([Iterable $outer$ceylon$language$Iterable, Callable $capture$Iterable$locations$selecting]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$locations$selecting = $capture$Iterable$locations$selecting;
    }
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$locations$$anonymous$6_$$anonymous$7_(this, iter);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$skip$$anonymous$9_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$skip$skipping;
    Iterable$skip$$anonymous$9_([Iterable $outer$ceylon$language$Iterable, $dart$core.int $capture$Iterable$skip$skipping]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$skip$skipping = $capture$Iterable$skip$skipping;
    }
    Iterator iterator() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        $dart$core.int i = 0;
        while (((() {
            $dart$core.int tmp$78 = i;
            i = $dartInt($ceylonInteger(i).successor);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$take$$anonymous$10_$iterator$$anonymous$11_ implements dart$$Basic, Iterator {
    Iterable$take$$anonymous$10_ $outer$ceylon$language$Iterable$take$$anonymous$10_;
    Iterator $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter;
    Iterable$take$$anonymous$10_$iterator$$anonymous$11_([Iterable$take$$anonymous$10_ $outer$ceylon$language$Iterable$take$$anonymous$10_, Iterator $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter]) {
        this.$outer$ceylon$language$Iterable$take$$anonymous$10_ = $outer$ceylon$language$Iterable$take$$anonymous$10_;
        this.$capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter = $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() => (_i = $dartInt($ceylonInteger(_i).successor)) > $outer$ceylon$language$Iterable$take$$anonymous$10_.$capture$Iterable$take$taking ? $package$finished : $capture$Iterable$take$$Iterable$take$$anonymous$10_$iterator$iter.next();
    $dart$core.String toString() => $outer$ceylon$language$Iterable$take$$anonymous$10_.toString() + ".iterator()";
}
class Iterable$take$$anonymous$10_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$take$taking;
    Iterable$take$$anonymous$10_([Iterable $outer$ceylon$language$Iterable, $dart$core.int $capture$Iterable$take$taking]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$take$taking = $capture$Iterable$take$taking;
    }
    Iterator iterator() {
        Iterator iter = $outer$ceylon$language$Iterable.iterator();
        return new Iterable$take$$anonymous$10_$iterator$$anonymous$11_(this, iter);
    }
    $dart$core.Object get first => $outer$ceylon$language$Iterable.first;
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_ implements dart$$Basic, Iterator {
    Iterable$skipWhile$$anonymous$12_ $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_;
    $dart$core.Object $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem;
    Iterator $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter;
    Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_([Iterable$skipWhile$$anonymous$12_ $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_, $dart$core.Object $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem, Iterator $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter]) {
        this.$outer$ceylon$language$Iterable$skipWhile$$anonymous$12_ = $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_;
        this.$capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem = $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem;
        this.$capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter = $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter;
        _first = true;
    }
    $dart$core.bool _first;
    $dart$core.Object next() {
        if (_first) {
            _first = false;
            return $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$$$elem;
        } else {
            return $capture$Iterable$skipWhile$Iterable$skipWhile$$anonymous$12_$iterator$iter.next();
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$skipWhile$$anonymous$12_.toString() + ".iterator()";
}
class Iterable$skipWhile$$anonymous$12_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$skipWhile$skipping;
    Iterable$skipWhile$$anonymous$12_([Iterable $outer$ceylon$language$Iterable, Callable $capture$Iterable$skipWhile$skipping]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$skipWhile$skipping = $capture$Iterable$skipWhile$skipping;
    }
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
            if (!$dartBool($capture$Iterable$skipWhile$skipping.f(elem) as Boolean)) {
                return new Iterable$skipWhile$$anonymous$12_$iterator$$anonymous$13_(this, elem, iter);
            }
        }
        return $package$emptyIterator;
    }
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$takeWhile$$anonymous$14_$$anonymous$15_ implements dart$$Basic, Iterator {
    Iterable$takeWhile$$anonymous$14_ $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_;
    Iterator $capture$$iter;
    Iterable$takeWhile$$anonymous$14_$$anonymous$15_([Iterable$takeWhile$$anonymous$14_ $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$takeWhile$$anonymous$14_ = $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_;
        this.$capture$$iter = $capture$$iter;
        _alive = true;
    }
    $dart$core.bool _alive;
    $dart$core.Object next() {
        if (_alive) {{
                $dart$core.Object next$80 = $capture$$iter.next();
                if (!(next$80 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$80;
                    if ($dartBool($outer$ceylon$language$Iterable$takeWhile$$anonymous$14_.$capture$Iterable$takeWhile$taking.f(next$s1) as Boolean)) {
                        return next$s1;
                    } else {
                        _alive = false;
                    }
                }
            }
        }
        return $package$finished;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$takeWhile$$anonymous$14_.toString() + ".iterator()";
}
class Iterable$takeWhile$$anonymous$14_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Callable $capture$Iterable$takeWhile$taking;
    Iterable$takeWhile$$anonymous$14_([Iterable $outer$ceylon$language$Iterable, Callable $capture$Iterable$takeWhile$taking]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$takeWhile$taking = $capture$Iterable$takeWhile$taking;
    }
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$takeWhile$$anonymous$14_$$anonymous$15_(this, iter);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$repeat$$anonymous$16_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$repeat$times;
    Iterable$repeat$$anonymous$16_([Iterable $outer$ceylon$language$Iterable, $dart$core.int $capture$Iterable$repeat$times]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$repeat$times = $capture$Iterable$repeat$times;
    }
    $dart$core.int get size => $capture$Iterable$repeat$times * $outer$ceylon$language$Iterable.size;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").repeat(") + $capture$Iterable$repeat$times.toString()) + ")";
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$by$$anonymous$17_$$anonymous$18_ implements dart$$Basic, Iterator {
    Iterable$by$$anonymous$17_ $outer$ceylon$language$Iterable$by$$anonymous$17_;
    Iterator $capture$$iter;
    Iterable$by$$anonymous$17_$$anonymous$18_([Iterable$by$$anonymous$17_ $outer$ceylon$language$Iterable$by$$anonymous$17_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$by$$anonymous$17_ = $outer$ceylon$language$Iterable$by$$anonymous$17_;
        this.$capture$$iter = $capture$$iter;
    }
    $dart$core.Object next() {
        $dart$core.Object next$s1 = $capture$$iter.next();
        $dart$core.int i = 0;
        while (((i = $dartInt($ceylonInteger(i).successor)) < $outer$ceylon$language$Iterable$by$$anonymous$17_.$capture$Iterable$by$step) && (!($capture$$iter.next() is Finished))) {}
        return next$s1;
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$by$$anonymous$17_.toString() + ".iterator()";
}
class Iterable$by$$anonymous$17_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$by$step;
    Iterable$by$$anonymous$17_([Iterable $outer$ceylon$language$Iterable, $dart$core.int $capture$Iterable$by$step]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$by$step = $capture$Iterable$by$step;
    }
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Iterable.toString()) + ").by(") + $capture$Iterable$by$step.toString()) + ")";
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$indexed$$anonymous$20_$$anonymous$21_ implements dart$$Basic, Iterator {
    Iterable$indexed$$anonymous$20_ $outer$ceylon$language$Iterable$indexed$$anonymous$20_;
    Iterator $capture$$iter;
    Iterable$indexed$$anonymous$20_$$anonymous$21_([Iterable$indexed$$anonymous$20_ $outer$ceylon$language$Iterable$indexed$$anonymous$20_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$indexed$$anonymous$20_ = $outer$ceylon$language$Iterable$indexed$$anonymous$20_;
        this.$capture$$iter = $capture$$iter;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() => (() {
        $dart$core.Object next$s1 = $capture$$iter.next();
        if ($dart$core.identical(next$s1, $package$finished)) {
            return $package$finished;
        } else {
            return new Entry((() {
                $dart$core.Object tmp$90 = $ceylonInteger(_i);
                $ceylonInteger(_i = $dartInt($ceylonInteger(_i).successor));
                return tmp$90;
            })(), next$s1);
        }
    })();
    $dart$core.String toString() => $outer$ceylon$language$Iterable$indexed$$anonymous$20_.toString() + ".iterator()";
}
class Iterable$indexed$$anonymous$20_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$indexed$$anonymous$20_([Iterable $outer$ceylon$language$Iterable]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
    }
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$indexed$$anonymous$20_$$anonymous$21_(this, iter);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$paired$$anonymous$22_$$anonymous$23_ implements dart$$Basic, Iterator {
    Iterable$paired$$anonymous$22_ $outer$ceylon$language$Iterable$paired$$anonymous$22_;
    Iterator $capture$$iter;
    Iterable$paired$$anonymous$22_$$anonymous$23_([Iterable$paired$$anonymous$22_ $outer$ceylon$language$Iterable$paired$$anonymous$22_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$paired$$anonymous$22_ = $outer$ceylon$language$Iterable$paired$$anonymous$22_;
        this.$capture$$iter = $capture$$iter;
        _previous = $capture$$iter.next();
    }
    $dart$core.Object _previous;
    $dart$core.Object next() {{
            $dart$core.bool doElse$91 = true;
            {
                $dart$core.Object head$92 = _previous;
                if (!(head$92 is Finished)) {
                    $dart$core.Object head;
                    head = head$92;
                    {
                        $dart$core.Object tip$93 = $capture$$iter.next();
                        if (!(tip$93 is Finished)) {
                            $dart$core.Object tip;
                            tip = tip$93;
                            doElse$91 = false;
                            _previous = tip;
                            return new Tuple.$withList([head, tip]);
                        }
                    }
                }
            }
            if (doElse$91) {
                return $package$finished;
            }
        }
    }
}
class Iterable$paired$$anonymous$22_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$paired$$anonymous$22_([Iterable $outer$ceylon$language$Iterable]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
    }
    $dart$core.int get size => (() {
        $dart$core.int size$s1;
        {
            size$s1 = $outer$ceylon$language$Iterable.size - 1;
        }
        return size$s1 < 0 ? 0 : size$s1;
    })();
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.size < 2;
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$paired$$anonymous$22_$$anonymous$23_(this, iter);
    })();
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$partition$$anonymous$24_$$anonymous$25_ implements dart$$Basic, Iterator {
    Iterable$partition$$anonymous$24_ $outer$ceylon$language$Iterable$partition$$anonymous$24_;
    Iterator $capture$$iter;
    Iterable$partition$$anonymous$24_$$anonymous$25_([Iterable$partition$$anonymous$24_ $outer$ceylon$language$Iterable$partition$$anonymous$24_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$partition$$anonymous$24_ = $outer$ceylon$language$Iterable$partition$$anonymous$24_;
        this.$capture$$iter = $capture$$iter;
    }
    $dart$core.Object next() {{
            $dart$core.bool doElse$94 = true;
            {
                $dart$core.Object next$95 = $capture$$iter.next();
                if (!(next$95 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$95;
                    doElse$94 = false;
                    Array array = new Array.ofSize($outer$ceylon$language$Iterable$partition$$anonymous$24_.$capture$Iterable$partition$length, next$s1);
                    $dart$core.int index = 0;
                    while ((index = $dartInt($ceylonInteger(index).successor)) < $outer$ceylon$language$Iterable$partition$$anonymous$24_.$capture$Iterable$partition$length) {{
                            $dart$core.bool doElse$96 = true;
                            {
                                $dart$core.Object current$97 = $capture$$iter.next();
                                if (!(current$97 is Finished)) {
                                    $dart$core.Object current;
                                    current = current$97;
                                    doElse$96 = false;
                                    array.set(index, current);
                                }
                            }
                            if (doElse$96) {
                                return new ArraySequence(array.spanTo($ceylonInteger(index - 1)));
                            }
                        }
                    }
                    return new ArraySequence(array);
                }
            }
            if (doElse$94) {
                return $package$finished;
            }
        }
    }
}
class Iterable$partition$$anonymous$24_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.int $capture$Iterable$partition$length;
    Iterable$partition$$anonymous$24_([Iterable $outer$ceylon$language$Iterable, $dart$core.int $capture$Iterable$partition$length]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$partition$length = $capture$Iterable$partition$length;
    }
    $dart$core.int get size => (() {
        $dart$core.int outerSize;
        {
            outerSize = $outer$ceylon$language$Iterable.size;
        }
        $dart$core.int quotient;
        {
            quotient = outerSize ~/ $capture$Iterable$partition$length;
        }
        return $ceylonInteger($capture$Iterable$partition$length).divides($ceylonInteger(outerSize)) ? quotient : quotient + 1;
    })();
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.empty;
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$partition$$anonymous$24_$$anonymous$25_(this, iter);
    })();
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$chain$$anonymous$26_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable $capture$Iterable$chain$other;
    Iterable$chain$$anonymous$26_([Iterable $outer$ceylon$language$Iterable, Iterable $capture$Iterable$chain$other]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$chain$other = $capture$Iterable$chain$other;
    }
    Iterator iterator() => new ChainedIterator($outer$ceylon$language$Iterable, $capture$Iterable$chain$other);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$cycled$$anonymous$27_$$anonymous$28_ implements dart$$Basic, Iterator {
    Iterable$cycled$$anonymous$27_ $outer$ceylon$language$Iterable$cycled$$anonymous$27_;
    Iterable$cycled$$anonymous$27_$$anonymous$28_([Iterable$cycled$$anonymous$27_ $outer$ceylon$language$Iterable$cycled$$anonymous$27_]) {
        this.$outer$ceylon$language$Iterable$cycled$$anonymous$27_ = $outer$ceylon$language$Iterable$cycled$$anonymous$27_;
        _iter = $package$emptyIterator;
    }
    Iterator _iter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$111 = true;
            {
                $dart$core.Object next$112 = _iter.next();
                if (!(next$112 is Finished)) {
                    $dart$core.Object next$s1;
                    next$s1 = next$112;
                    doElse$111 = false;
                    return next$s1;
                }
            }
            if (doElse$111) {
                _iter = $outer$ceylon$language$Iterable$cycled$$anonymous$27_._orig.iterator();
                return _iter.next();
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$cycled$$anonymous$27_.toString() + ".iterator()";
}
class Iterable$cycled$$anonymous$27_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$cycled$$anonymous$27_([Iterable $outer$ceylon$language$Iterable]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
    }
    Iterable get _orig => $outer$ceylon$language$Iterable;
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Iterable.toString()) + ").cycled";
    $dart$core.int get size {
        if (!false) {
            throw new AssertionError("Violated: false");
        }
    }
    Iterator iterator() => new Iterable$cycled$$anonymous$27_$$anonymous$28_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$interpose$$anonymous$29_$$anonymous$30_ implements dart$$Basic, Iterator {
    Iterable$interpose$$anonymous$29_ $outer$ceylon$language$Iterable$interpose$$anonymous$29_;
    Iterator $capture$$iter;
    Iterable$interpose$$anonymous$29_$$anonymous$30_([Iterable$interpose$$anonymous$29_ $outer$ceylon$language$Iterable$interpose$$anonymous$29_, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$Iterable$interpose$$anonymous$29_ = $outer$ceylon$language$Iterable$interpose$$anonymous$29_;
        this.$capture$$iter = $capture$$iter;
        _current = $capture$$iter.next();
        _count = 0;
    }
    $dart$core.Object _current;
    $dart$core.int _count;
    $dart$core.Object next() {{
            $dart$core.bool doElse$113 = true;
            {
                $dart$core.Object curr$114 = _current;
                if (!(curr$114 is Finished)) {
                    $dart$core.Object curr;
                    curr = curr$114;
                    doElse$113 = false;
                    if ($ceylonInteger(($outer$ceylon$language$Iterable$interpose$$anonymous$29_.$capture$Iterable$interpose$step as $dart$core.int) + 1).divides($ceylonInteger(_count = $dartInt($ceylonInteger(_count).successor)))) {
                        return $outer$ceylon$language$Iterable$interpose$$anonymous$29_.$capture$Iterable$interpose$element;
                    } else {
                        _current = $capture$$iter.next();
                        return curr;
                    }
                }
            }
            if (doElse$113) {
                return $package$finished;
            }
        }
    }
    $dart$core.String toString() => $outer$ceylon$language$Iterable$interpose$$anonymous$29_.toString() + ".iterator()";
}
class Iterable$interpose$$anonymous$29_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    $dart$core.Object $capture$Iterable$interpose$step;
    $dart$core.Object $capture$Iterable$interpose$element;
    Iterable$interpose$$anonymous$29_([Iterable $outer$ceylon$language$Iterable, $dart$core.Object $capture$Iterable$interpose$step, $dart$core.Object $capture$Iterable$interpose$element]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
        this.$capture$Iterable$interpose$step = $capture$Iterable$interpose$step;
        this.$capture$Iterable$interpose$element = $capture$Iterable$interpose$element;
    }
    $dart$core.int get size {
        $dart$core.int outerSize = $outer$ceylon$language$Iterable.size;
        return outerSize > 0 ? outerSize + ((outerSize - 1) ~/ ($capture$Iterable$interpose$step as $dart$core.int)) : 0;
    }
    $dart$core.bool get empty => $outer$ceylon$language$Iterable.empty;
    $dart$core.Object get first => $outer$ceylon$language$Iterable.first;
    $dart$core.Object get last => $outer$ceylon$language$Iterable.last;
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$Iterable.iterator();
        }
        return new Iterable$interpose$$anonymous$29_$$anonymous$30_(this, iter);
    })();
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Iterable$distinct$$anonymous$31_$$anonymous$32_ implements dart$$Basic, Iterator {
    Iterable$distinct$$anonymous$31_ $outer$ceylon$language$Iterable$distinct$$anonymous$31_;
    Iterable $capture$$elements;
    Iterable$distinct$$anonymous$31_$$anonymous$32_([Iterable$distinct$$anonymous$31_ $outer$ceylon$language$Iterable$distinct$$anonymous$31_, Iterable $capture$$elements]) {
        this.$outer$ceylon$language$Iterable$distinct$$anonymous$31_ = $outer$ceylon$language$Iterable$distinct$$anonymous$31_;
        this.$capture$$elements = $capture$$elements;
        _it = $capture$$elements.iterator();
        _count = 0;
        _store = (() {
            $dart$core.int arg$115$0 = 16;
            $dart$core.Object arg$115$1 = null;
            return new Array.ofSize(arg$115$0, arg$115$1);
        })();
    }
    Iterator _it;
    $dart$core.int _count;
    Array _store;
    $dart$core.int _hash([$dart$core.Object element, $dart$core.int size]) => (() {
        $dart$core.bool doElse$116 = true;
        if (!(null == element)) {
            doElse$116 = false;
            return element.hashCode.abs().remainder(size);
        }
        if (doElse$116) {
            return 0;
        }
    })();
    Array _rebuild([Array store]) {
        Array newStore = (() {
            $dart$core.int arg$117$0 = store.size * 2;
            $dart$core.Object arg$117$1 = null;
            return new Array.ofSize(arg$117$0, arg$117$1);
        })();
        {
            $dart$core.Object element$119;
            Iterator iterator$118 = store.iterator();
            while ((element$119 = iterator$118.next()) is !Finished) {
                ElementEntry entries;
                {
                    entries = element$119;
                }
                ElementEntry entry = entries;
                while (true) {
                    ElementEntry e;
                    {
                        ElementEntry tmp$122 = entry;
                        if (null == tmp$122) {
                            break;
                        }
                        e = tmp$122;
                    }
                    $dart$core.int index = (() {
                        $dart$core.Object arg$120$0 = e.element;
                        $dart$core.int arg$120$1 = newStore.size;
                        return _hash(arg$120$0, arg$120$1);
                    })();
                    newStore.set(index, (() {
                        ElementEntry arg$121$0 = newStore.getFromFirst(index) as ElementEntry;
                        $dart$core.Object arg$121$1 = e.element;
                        return new ElementEntry(arg$121$0, arg$121$1);
                    })());
                    entry = e.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.Object next() {
        while (true) {{
                $dart$core.Object element = _it.next();
                if (element is Finished) {
                    Finished element$123;
                    element$123 = element as Finished;
                    return element$123;
                } else {
                    $dart$core.int index = (() {
                        $dart$core.Object arg$124$0 = element;
                        $dart$core.int arg$124$1 = _store.size;
                        return _hash(arg$124$0, arg$124$1);
                    })();
                    ElementEntry entry = _store.getFromFirst(index) as ElementEntry;
                    {
                        $dart$core.bool doElse$125 = true;
                        if (!(null == entry)) {
                            if (entry.has(element)) {
                                doElse$125 = false;
                            }
                        }
                        if (doElse$125) {
                            _store.set(index, (() {
                                ElementEntry arg$126$0 = entry;
                                $dart$core.Object arg$126$1 = element;
                                return new ElementEntry(arg$126$0, arg$126$1);
                            })());
                            _count = $dartInt($ceylonInteger(_count).successor);
                            if (_count > (_store.size * 2)) {
                                _store = _rebuild(_store);
                            }
                            return element;
                        }
                    }
                }
            }
        }
    }
}
class Iterable$distinct$$anonymous$31_ implements dart$$Basic, Iterable {
    Iterable $outer$ceylon$language$Iterable;
    Iterable$distinct$$anonymous$31_([Iterable $outer$ceylon$language$Iterable]) {
        this.$outer$ceylon$language$Iterable = $outer$ceylon$language$Iterable;
    }
    Iterator iterator() => (() {
        Iterable elements;
        {
            elements = $outer$ceylon$language$Iterable;
        }
        return new Iterable$distinct$$anonymous$31_$$anonymous$32_(this, elements);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class Iterable implements Category {
    Iterator iterator();
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Iterable $this, $dart$core.Object element]) => $this.any(new dart$Callable(([$dart$core.Object e]) => (() {
        $dart$core.bool doElse$0 = true;
        if (!(null == e)) {
            doElse$0 = false;
            return $ceylonBoolean(e == element);
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
        $dart$core.int count$s1 = 0;
        {
            $dart$core.Object element$2;
            Iterator iterator$1 = $this.iterator();
            while ((element$2 = iterator$1.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$2;
                }
                if ((() {
                    $dart$core.int tmp$3 = count$s1;
                    count$s1 = $dartInt($ceylonInteger(count$s1).successor);
                    return tmp$3;
                })() == length) {
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
        $dart$core.int count$s1 = 0;
        {
            $dart$core.Object element$5;
            Iterator iterator$4 = $this.iterator();
            while ((element$5 = iterator$4.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$5;
                }
                if ((count$s1 = $dartInt($ceylonInteger(count$s1).successor)) == length) {
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
                    $dart$core.Object first$s1;
                    first$s1 = first$7;
                    doElse$6 = false;
                    return first$s1;
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
                $dart$core.Object x;
                {
                    x = element$9;
                }
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
                $dart$core.Object element;
                {
                    element = element$11;
                }
                if ((() {
                    $dart$core.int tmp$12 = current;
                    current = $dartInt($ceylonInteger(current).successor);
                    return tmp$12;
                })() == index) {
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
        Array array;
        {
            array = new Array($this);
        }
        return array.empty ? $package$empty : new ArraySequence(array);
    })();
    $dart$core.Object indexes();
    static $dart$core.Object $indexes([final Iterable $this]) => $package$measure($ceylonInteger(0), $this.size);
    Iterable get rest;
    static Iterable $get$rest([final Iterable $this]) => $this.skip(1);
    Iterable get exceptLast;
    static Iterable $get$exceptLast([final Iterable $this]) => new Iterable$exceptLast$$anonymous$2_($this);
    void each([Callable step]);
    static void $each([final Iterable $this, Callable step]) {{
            $dart$core.Object element$16;
            Iterator iterator$15 = $this.iterator();
            while ((element$16 = iterator$15.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$16;
                }
                step.f(element);
            }
        }
    }
    Iterable map([Callable collecting]);
    static Iterable $map([final Iterable $this, Callable collecting]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object elem$21;
        $dart$core.bool step$1$23() {
            while (step$1$Init$22()) {
                $dart$core.Object next$20;
                if ((next$20 = iterator_1$19.next()) is !Finished) {
                    $dart$core.Object elem;
                    {
                        elem = next$20;
                    }
                    elem$21 = elem;
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
            $dart$core.Object elem = elem$21;
            return collecting.f(elem);
        }

        return new dart$Callable(step$2$24);
    }));
    Iterable flatMap([Callable collecting]);
    static Iterable $flatMap([final Iterable $this, Callable collecting]) => $package$expand($this.map(collecting));
    Iterable filter([Callable selecting]);
    static Iterable $filter([final Iterable $this, Callable selecting]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object elem$29;
        $dart$core.bool step$1$31() {
            while (step$1$Init$30()) {
                $dart$core.Object next$28;
                if ((next$28 = iterator_1$27.next()) is !Finished) {
                    $dart$core.Object elem;
                    {
                        elem = next$28;
                    }
                    elem$29 = elem;
                    return true;
                }
                iterator_1$27 = null;
            }
            return false;
        }

        $dart$core.bool step$2$32() {
            while (step$1$31()) {
                $dart$core.Object elem = elem$29;
                if ($dartBool(selecting.f(elem) as Boolean)) {
                    return true;
                }
            }
            return false;
        }

        $dart$core.Object step$3$33() {
            if (!step$2$32()) {
                return $package$finished;
            }
            $dart$core.Object elem = elem$29;
            return elem;
        }

        return new dart$Callable(step$3$33);
    }));
    Iterable narrow();
    static Iterable $narrow([final Iterable $this]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object elem$38;
        $dart$core.bool step$1$40() {
            while (step$1$Init$39()) {
                $dart$core.Object next$37;
                if ((next$37 = iterator_1$36.next()) is !Finished) {
                    $dart$core.Object elem;
                    {
                        elem = next$37;
                    }
                    elem$38 = elem;
                    return true;
                }
                iterator_1$36 = null;
            }
            return false;
        }

        $dart$core.bool step$2$41() {
            while (step$1$40()) {
                $dart$core.Object elem = elem$38;
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
            $dart$core.Object elem = elem$38;
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
                $dart$core.Object elem;
                {
                    elem = element$44;
                }
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
                $dart$core.Object elem;
                {
                    elem = element$51;
                }
                if (!(null == elem)) {
                    if ($dartBool(selecting.f(elem) as Boolean)) {
                        return elem;
                    }
                }
            }
        }
        return null;
    }
    $dart$core.Object findLast([Callable selecting]);
    static $dart$core.Object $findLast([final Iterable $this, Callable selecting]) {
        $dart$core.Object last$s1 = null;
        {
            $dart$core.Object element$53;
            Iterator iterator$52 = $this.iterator();
            while ((element$53 = iterator$52.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$53;
                }
                if (!(null == elem)) {
                    if ($dartBool(selecting.f(elem) as Boolean)) {
                        last$s1 = elem;
                    }
                }
            }
        }
        return last$s1;
    }
    Entry locate([Callable selecting]);
    static Entry $locate([final Iterable $this, Callable selecting]) {
        $dart$core.int index = 0;
        {
            $dart$core.Object element$55;
            Iterator iterator$54 = $this.iterator();
            while ((element$55 = iterator$54.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$55;
                }
                if (!(null == elem)) {
                    if ($dartBool(selecting.f(elem) as Boolean)) {
                        return new Entry($ceylonInteger(index), elem);
                    }
                }
                index = $dartInt($ceylonInteger(index).successor);
            }
        }
        return null;
    }
    Entry locateLast([Callable selecting]);
    static Entry $locateLast([final Iterable $this, Callable selecting]) {
        Entry last$s1 = null;
        $dart$core.int index = 0;
        {
            $dart$core.Object element$57;
            Iterator iterator$56 = $this.iterator();
            while ((element$57 = iterator$56.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$57;
                }
                if (!(null == elem)) {
                    if ($dartBool(selecting.f(elem) as Boolean)) {
                        last$s1 = new Entry($ceylonInteger(index), elem);
                    }
                }
                index = $dartInt($ceylonInteger(index).successor);
            }
        }
        return last$s1;
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
                    $dart$core.Object first$s1;
                    first$s1 = first$62;
                    doElse$61 = false;
                    $dart$core.Object max$s1 = first$s1;
                    while (true) {
                        $dart$core.Object val;
                        {
                            $dart$core.Object val$63 = it.next();
                            if (val$63 is Finished) {
                                break;
                            }
                            val = val$63;
                        }
                        if (comparing.f(val, max$s1) == $package$larger) {
                            max$s1 = val;
                        }
                    }
                    return max$s1;
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
    static Callable $spread([final Iterable $this, Callable method]) => $package$flatten(new dart$Callable(([$dart$core.Object args]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object elem$68;
        $dart$core.bool step$1$70() {
            while (step$1$Init$69()) {
                $dart$core.Object next$67;
                if ((next$67 = iterator_1$66.next()) is !Finished) {
                    $dart$core.Object elem;
                    {
                        elem = next$67;
                    }
                    elem$68 = elem;
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
            $dart$core.Object elem = elem$68;
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
        $dart$core.int count$s1 = 0;
        {
            $dart$core.Object element$73;
            Iterator iterator$72 = $this.iterator();
            while ((element$73 = iterator$72.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$73;
                }
                if ($dartBool(selecting.f(elem) as Boolean)) {
                    count$s1 = $dartInt($ceylonInteger(count$s1).successor);
                }
            }
        }
        return count$s1;
    }
    $dart$core.bool any([Callable selecting]);
    static $dart$core.bool $any([final Iterable $this, Callable selecting]) {{
            $dart$core.Object element$75;
            Iterator iterator$74 = $this.iterator();
            while ((element$75 = iterator$74.next()) is !Finished) {
                $dart$core.Object e;
                {
                    e = element$75;
                }
                if ($dartBool(selecting.f(e) as Boolean)) {
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
                $dart$core.Object e;
                {
                    e = element$77;
                }
                if (!$dartBool(selecting.f(e) as Boolean)) {
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
        if (step == 1) {
            return $this;
        } else {
            return new Iterable$by$$anonymous$17_($this, step);
        }
    }
    Iterable defaultNullElements([$dart$core.Object defaultValue]);
    static Iterable $defaultNullElements([final Iterable $this, $dart$core.Object defaultValue]) => $this.map(new dart$Callable(([$dart$core.Object elem]) => (($dart$core.Object $lhs$) => null == $lhs$ ? defaultValue : $lhs$)(elem)));
    Iterable get coalesced;
    static Iterable $get$coalesced([final Iterable $this]) => dart$functionIterable(new dart$Callable(() {
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

        $dart$core.Object e$85;
        $dart$core.bool step$1$87() {
            while (step$1$Init$86()) {
                $dart$core.Object next$84;
                if ((next$84 = iterator_1$83.next()) is !Finished) {
                    $dart$core.Object e;
                    {
                        e = next$84;
                    }
                    e$85 = e;
                    return true;
                }
                iterator_1$83 = null;
            }
            return false;
        }

        $dart$core.bool step$2$88() {
            while (step$1$87()) {
                $dart$core.Object e = e$85;
                if (!(!(null == e))) {
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
            $dart$core.Object e = e$85;
            return e;
        }

        return new dart$Callable(step$3$89);
    }));
    Iterable get indexed;
    static Iterable $get$indexed([final Iterable $this]) => new Iterable$indexed$$anonymous$20_($this);
    Iterable get paired;
    static Iterable $get$paired([final Iterable $this]) => new Iterable$paired$$anonymous$22_($this);
    Iterable partition([$dart$core.int length]);
    static Iterable $partition([final Iterable $this, $dart$core.int length]) {
        if (!(length > 0)) {
            throw new AssertionError("Violated: length>0");
        }
        return new Iterable$partition$$anonymous$24_($this, length);
    }
    Iterable follow([$dart$core.Object head]);
    static Iterable $follow([final Iterable $this, $dart$core.Object head]) => new LazyIterable(1, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return head;
        }
    }, $this);
    Iterable chain([Iterable other]);
    static Iterable $chain([final Iterable $this, Iterable other]) => new Iterable$chain$$anonymous$26_($this, other);
    Iterable product([Iterable other]);
    static Iterable $product([final Iterable $this, Iterable other]) => dart$functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$98 = false;
        $dart$core.bool step$0$99() {
            if (step$0$expired$98) {
                return false;
            }
            step$0$expired$98 = true;
            return true;
        }

        Iterator iterator_1$100;
        $dart$core.bool step$1$Init$103() {
            if (iterator_1$100 != null) {
                return true;
            }
            if (!step$0$99()) {
                return false;
            }
            iterator_1$100 = $this.iterator();
            return true;
        }

        $dart$core.Object x$102;
        $dart$core.bool step$1$104() {
            while (step$1$Init$103()) {
                $dart$core.Object next$101;
                if ((next$101 = iterator_1$100.next()) is !Finished) {
                    $dart$core.Object x;
                    {
                        x = next$101;
                    }
                    x$102 = x;
                    return true;
                }
                iterator_1$100 = null;
            }
            return false;
        }

        Iterator iterator_2$105;
        $dart$core.bool step$2$Init$108() {
            if (iterator_2$105 != null) {
                return true;
            }
            if (!step$1$104()) {
                return false;
            }
            $dart$core.Object x = x$102;
            iterator_2$105 = other.iterator();
            return true;
        }

        $dart$core.Object y$107;
        $dart$core.bool step$2$109() {
            while (step$2$Init$108()) {
                $dart$core.Object x = x$102;
                $dart$core.Object next$106;
                if ((next$106 = iterator_2$105.next()) is !Finished) {
                    $dart$core.Object y;
                    {
                        y = next$106;
                    }
                    y$107 = y;
                    return true;
                }
                iterator_2$105 = null;
            }
            return false;
        }

        $dart$core.Object step$3$110() {
            if (!step$2$109()) {
                return $package$finished;
            }
            $dart$core.Object x = x$102;
            $dart$core.Object y = y$107;
            return new Tuple.$withList([x, y]);
        }

        return new dart$Callable(step$3$110);
    }));
    Iterable get cycled;
    static Iterable $get$cycled([final Iterable $this]) => new Iterable$cycled$$anonymous$27_($this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]);
    static Iterable $interpose([final Iterable $this, $dart$core.Object element, $dart$core.Object step = $package$dart$default]) {
        if ($dart$core.identical(step, $package$dart$default)) {
            step = Iterable.$interpose$step($this, element);
        }
        if (!((step as $dart$core.int) >= 1)) {
            throw new AssertionError("Violated: step>=1");
        }
        return new Iterable$interpose$$anonymous$29_($this, step, element);
    }
    static $dart$core.Object $interpose$step(final Iterable $this, $dart$core.Object element) => 1;
    Iterable get distinct;
    static Iterable $get$distinct([final Iterable $this]) => new Iterable$distinct$$anonymous$31_($this);
    Map frequencies();
    static Map $frequencies([final Iterable $this]) => $this.coalesced.summarize(new dart$Callable($package$identity), new dart$Callable(([Integer count, $dart$core.Object $_]) => $ceylonInteger((($dart$core.int $lhs$) => null == $lhs$ ? 0 : $lhs$)($dartInt(count)) + 1)));
    Map tabulate([Callable collecting]);
    static Map $tabulate([final Iterable $this, Callable collecting]) => $this.coalesced.summarize(new dart$Callable($package$identity), new dart$Callable(([$dart$core.Object item, $dart$core.Object key]) => (() {
        $dart$core.bool doElse$127 = true;
        if (!(null == item)) {
            doElse$127 = false;
            return item;
        }
        if (doElse$127) {
            return collecting.f(key);
        }
    })()));
    Map group([Callable grouping]);
    static Map $group([final Iterable $this, Callable grouping]) => $this.summarize(grouping, new dart$Callable(([ElementEntry $0, $dart$core.Object $1]) => new ElementEntry($0, $1))).mapItems(new dart$Callable(([$dart$core.Object $_, ElementEntry item]) => item.reversedSequence()));
    Map summarize([Callable grouping, Callable accumulating]);
    static Map $summarize([final Iterable $this, Callable grouping, Callable accumulating]) => new Summary($this, grouping, accumulating);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Iterable $this]) => (() {
        Sequential elements;
        {
            elements = $this.take(31).sequence();
        }
        return elements.empty ? "{}" : elements.size == 31 ? ("{ " + $package$commaList(elements.take(30))) + ", ... }" : ("{ " + $package$commaList(elements)) + " }";
    })();
}
$dart$core.String $package$commaList([Iterable elements]) => (() {
    Iterable arg$128$0 = dart$functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$129 = false;
        $dart$core.bool step$0$130() {
            if (step$0$expired$129) {
                return false;
            }
            step$0$expired$129 = true;
            return true;
        }

        Iterator iterator_1$131;
        $dart$core.bool step$1$Init$134() {
            if (iterator_1$131 != null) {
                return true;
            }
            if (!step$0$130()) {
                return false;
            }
            iterator_1$131 = elements.iterator();
            return true;
        }

        $dart$core.Object e$133;
        $dart$core.bool step$1$135() {
            while (step$1$Init$134()) {
                $dart$core.Object next$132;
                if ((next$132 = iterator_1$131.next()) is !Finished) {
                    $dart$core.Object e;
                    {
                        e = next$132;
                    }
                    e$133 = e;
                    return true;
                }
                iterator_1$131 = null;
            }
            return false;
        }

        $dart$core.Object step$2$136() {
            if (!step$1$135()) {
                return $package$finished;
            }
            $dart$core.Object e = e$133;
            return $ceylonString($package$stringify(e));
        }

        return new dart$Callable(step$2$136);
    }));
    return $ceylonString(", ").join(arg$128$0);
})();

$dart$core.String commaList([Iterable elements]) => $package$commaList(elements);

class ElementEntry implements dart$$Basic {
    ElementEntry([ElementEntry next, $dart$core.Object element]) {
        this.next = next;
        this.element = element;
    }
    ElementEntry next;
    $dart$core.Object element;
    $dart$core.Object get first => element;
    $dart$core.bool has([$dart$core.Object element]) {
        ElementEntry entry = this;
        while (true) {
            ElementEntry e;
            {
                ElementEntry tmp$139 = entry;
                if (null == tmp$139) {
                    break;
                }
                e = tmp$139;
            }
            {
                $dart$core.bool doElse$137 = true;
                if (!(null == element)) {
                    doElse$137 = false;
                    {
                        $dart$core.Object tmp$138 = e.element;
                        if (!(null == tmp$138)) {
                            $dart$core.Object ee;
                            ee = tmp$138;
                            if (element == ee) {
                                return true;
                            }
                        }
                    }
                }
                if (doElse$137) {
                    if (!(!(null == e.element))) {
                        return true;
                    }
                }
            }
            entry = e.next;
        }
        return false;
    }
    $dart$core.int get size {
        $dart$core.int count = 1;
        ElementEntry entry = this;
        while (true) {
            ElementEntry next$s1;
            {
                ElementEntry tmp$140 = entry.next;
                if (null == tmp$140) {
                    break;
                }
                next$s1 = tmp$140;
            }
            entry = next$s1;
            count = $dartInt($ceylonInteger(count).successor);
        }
        return count;
    }
    Sequence reversedSequence() {
        $dart$core.int size$s1 = this.size;
        Array array = (() {
            $dart$core.int arg$141$0 = size$s1;
            $dart$core.Object arg$141$1 = first;
            return new Array.ofSize(arg$141$0, arg$141$1);
        })();
        $dart$core.int i = size$s1;
        ElementEntry entry = this;
        while (true) {
            ElementEntry next$s1;
            {
                ElementEntry tmp$142 = entry;
                if (null == tmp$142) {
                    break;
                }
                next$s1 = tmp$142;
            }
            array.set(i = $dartInt($ceylonInteger(i).predecessor), next$s1.element);
            entry = next$s1.next;
        }
        return new ArraySequence(array);
    }
}
class GroupEntry implements dart$$Basic {
    GroupEntry([GroupEntry next, $dart$core.Object group, $dart$core.Object elements]) {
        this.next = next;
        this.group = group;
        this.elements = elements;
    }
    GroupEntry next;
    $dart$core.Object group;
    $dart$core.Object elements;
    GroupEntry get([$dart$core.Object group]) {
        GroupEntry entry = this;
        while (true) {
            GroupEntry e;
            {
                GroupEntry tmp$143 = entry;
                if (null == tmp$143) {
                    break;
                }
                e = tmp$143;
            }
            if (group == e.group) {
                return e;
            }
            entry = e.next;
        }
        return null;
    }
}
class Summary$$anonymous$36_ implements dart$$Basic, Iterator {
    Summary $outer$ceylon$language$Summary;
    Summary$$anonymous$36_([Summary $outer$ceylon$language$Summary]) {
        this.$outer$ceylon$language$Summary = $outer$ceylon$language$Summary;
        _index = 0;
        _entry = null;
    }
    $dart$core.int _index;
    GroupEntry _entry;
    $dart$core.Object next() {
        GroupEntry result;
        {
            $dart$core.bool doElse$159 = true;
            {
                GroupEntry tmp$160 = _entry;
                if (!(null == tmp$160)) {
                    GroupEntry e;
                    e = tmp$160;
                    doElse$159 = false;
                    _entry = e.next;
                    result = e;
                }
            }
            if (doElse$159) {
                while (true) {
                    if (_index >= $outer$ceylon$language$Summary._store.size) {
                        return $package$finished;
                    } else {
                        _entry = $outer$ceylon$language$Summary._store.getFromFirst((() {
                            $dart$core.int tmp$161 = _index;
                            _index = $dartInt($ceylonInteger(_index).successor);
                            return tmp$161;
                        })()) as GroupEntry;
                        {
                            GroupEntry tmp$162 = _entry;
                            if (!(null == tmp$162)) {
                                GroupEntry e;
                                e = tmp$162;
                                _entry = e.next;
                                result = e;
                                break;
                            }
                        }
                    }
                }
            }
        }
        return new Entry(result.group, result.elements);
    }
}
class Summary implements dart$$Object, Map {
    Summary([Iterable elements, Callable grouping, Callable accumulating]) {
        this._elements = elements;
        this._grouping = grouping;
        this._accumulating = accumulating;
        _store = (() {
            $dart$core.int arg$144$0 = 16;
            $dart$core.Object arg$144$1 = null;
            return new Array.ofSize(arg$144$0, arg$144$1);
        })();
        _count = 0;
        {
            $dart$core.Object element$146;
            Iterator iterator$145 = this._elements.iterator();
            while ((element$146 = iterator$145.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$146;
                }
                $dart$core.Object group$s1 = this._grouping.f(element);
                $dart$core.int index = (() {
                    $dart$core.Object arg$147$0 = group$s1;
                    $dart$core.int arg$147$1 = _store.size;
                    return _hash(arg$147$0, arg$147$1);
                })();
                GroupEntry entries = _store.getFromFirst(index) as GroupEntry;
                {
                    $dart$core.bool doElse$148 = true;
                    if (!(null == entries)) {{
                            GroupEntry tmp$149 = entries.get(group$s1);
                            if (!(null == tmp$149)) {
                                GroupEntry entry;
                                entry = tmp$149;
                                doElse$148 = false;
                                entry.elements = (() {
                                    $dart$core.Object arg$150$0 = entry.elements;
                                    $dart$core.Object arg$150$1 = element;
                                    return this._accumulating.f(arg$150$0, arg$150$1);
                                })();
                            }
                        }
                    }
                    if (doElse$148) {
                        _store.set(index, (() {
                            GroupEntry arg$151$0 = entries;
                            $dart$core.Object arg$151$1 = group$s1;
                            $dart$core.Object arg$151$2 = (() {
                                $dart$core.Object arg$152$0 = null;
                                $dart$core.Object arg$152$1 = element;
                                return this._accumulating.f(arg$152$0, arg$152$1);
                            })();
                            return new GroupEntry(arg$151$0, arg$151$1, arg$151$2);
                        })());
                        _count = $dartInt($ceylonInteger(_count).successor);
                        if (_count > (_store.size * 2)) {
                            _store = _rebuild(_store);
                        }
                    }
                }
            }
        }
    }
    Iterable _elements;
    Callable _grouping;
    Callable _accumulating;
    Array _store;
    $dart$core.int _hash([$dart$core.Object group, $dart$core.int size]) => group.hashCode.abs().remainder(size);
    Array _rebuild([Array store]) {
        Array newStore = (() {
            $dart$core.int arg$153$0 = store.size * 2;
            $dart$core.Object arg$153$1 = null;
            return new Array.ofSize(arg$153$0, arg$153$1);
        })();
        {
            $dart$core.Object element$155;
            Iterator iterator$154 = store.iterator();
            while ((element$155 = iterator$154.next()) is !Finished) {
                GroupEntry groups;
                {
                    groups = element$155;
                }
                GroupEntry group$s1 = groups;
                while (true) {
                    GroupEntry g;
                    {
                        GroupEntry tmp$158 = group$s1;
                        if (null == tmp$158) {
                            break;
                        }
                        g = tmp$158;
                    }
                    $dart$core.int index = (() {
                        $dart$core.Object arg$156$0 = g.group;
                        $dart$core.int arg$156$1 = newStore.size;
                        return _hash(arg$156$0, arg$156$1);
                    })();
                    newStore.set(index, (() {
                        GroupEntry arg$157$0 = newStore.getFromFirst(index) as GroupEntry;
                        $dart$core.Object arg$157$1 = g.group;
                        $dart$core.Object arg$157$2 = g.elements;
                        return new GroupEntry(arg$157$0, arg$157$1, arg$157$2);
                    })());
                    group$s1 = g.next;
                }
            }
        }
        return newStore;
    }
    $dart$core.int _count;
    $dart$core.int get size => _count;
    Iterator iterator() => new Summary$$anonymous$36_(this);
    Map clone() => this;
    GroupEntry _group([$dart$core.Object key]) => ((GroupEntry $r) => null == $r ? null : $r.get(key))(_store.getFromFirst(_hash(key, _store.size)) as GroupEntry);
    $dart$core.bool defines([$dart$core.Object key]) => !(null == _group(key));
    $dart$core.Object get([$dart$core.Object key]) => ((GroupEntry $r) => null == $r ? null : $r.elements)(_group(key));
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => (() {
        $dart$core.bool doElse$163 = true;
        {
            GroupEntry tmp$164 = _group(key);
            if (!(null == tmp$164)) {
                GroupEntry group$s1;
                group$s1 = tmp$164;
                doElse$163 = false;
                return group$s1.elements;
            }
        }
        if (doElse$163) {
            return $default;
        }
    })();
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Iterator {
    $dart$core.Object next();
}
class language_ implements dart$$Basic {
    language_() {}
    $dart$core.String get version => "1.3.0-DP3";
    $dart$core.int get majorVersion => 1;
    $dart$core.int get minorVersion => 2;
    $dart$core.int get releaseVersion => 3;
    $dart$core.String get versionName => "Charming But Irrational";
    $dart$core.int get majorVersionBinary => 8;
    $dart$core.int get minorVersionBinary => 0;
    $dart$core.String toString() => "language";
}
final language_ $package$language = new language_();

language_ get language => $package$language;

$dart$core.Object $package$largest([$dart$core.Object x, $dart$core.Object y]) => (!(x == x)) || ((y as Comparable) > x) ? y : x;

$dart$core.Object largest([$dart$core.Object x, $dart$core.Object y]) => $package$largest(x, y);

class List$iterator$$anonymous$0_ implements dart$$Basic, Iterator {
    List $outer$ceylon$language$List;
    List$iterator$$anonymous$0_([List $outer$ceylon$language$List]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        _index = 0;
        _size = $outer$ceylon$language$List.size;
    }
    $dart$core.int _index;
    $dart$core.int _size;
    $dart$core.Object next() => _index >= _size ? $package$finished : List.$_getElement($outer$ceylon$language$List, (() {
        $dart$core.int tmp$5 = _index;
        _index = $dartInt($ceylonInteger(_index).successor);
        return tmp$5;
    })());
    $dart$core.String toString() => $outer$ceylon$language$List.toString() + ".iterator()";
}
class List$collect$list_ implements dart$$Object, List {
    List $outer$ceylon$language$List;
    Callable $capture$List$collect$collecting;
    List$collect$list_([List $outer$ceylon$language$List, Callable $capture$List$collect$collecting]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this.$capture$List$collect$collecting = $capture$List$collect$collecting;
        size = $outer$ceylon$language$List.size;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (index >= 0) && (index < size) ? $capture$List$collect$collecting.f(List.$_getElement($outer$ceylon$language$List, index)) : null;
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Indexes$$anonymous$3_ implements dart$$Basic, Iterator {
    List$Indexes $outer$ceylon$language$List$Indexes;
    List$Indexes$$anonymous$3_([List$Indexes $outer$ceylon$language$List$Indexes]) {
        this.$outer$ceylon$language$List$Indexes = $outer$ceylon$language$List$Indexes;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() => _i < $outer$ceylon$language$List$Indexes.size ? (() {
        $dart$core.Object tmp$50 = $ceylonInteger(_i);
        $ceylonInteger(_i = $dartInt($ceylonInteger(_i).successor));
        return tmp$50;
    })() : $package$finished;
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Indexes.toString()) + ".iterator()";
}
class List$Indexes implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Indexes([List $outer$ceylon$language$List]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    Integer getFromFirst([$dart$core.int index]) => defines($ceylonInteger(index)) ? $ceylonInteger(index) : null;
    List clone() => $package$measure($ceylonInteger(0), size) as List;
    List measure([Integer from, $dart$core.int length]) => clone().measure(from, length);
    List span([Integer from, Integer to]) => clone().span(from, to);
    List spanFrom([Integer from]) => clone().spanFrom(from);
    List spanTo([Integer to]) => clone().spanTo(to);
    $dart$core.String toString() => (() {
        $dart$core.bool doElse$48 = true;
        {
            $dart$core.int tmp$49 = lastIndex;
            if (!(null == tmp$49)) {
                $dart$core.int endIndex;
                endIndex = tmp$49;
                doElse$48 = false;
                return ("{ 0, ... , " + endIndex.toString()) + " }";
            }
        }
        if (doElse$48) {
            return "{}";
        }
    })();
    Iterator iterator() => new List$Indexes$$anonymous$3_(this);
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Rest$$anonymous$4_ implements dart$$Basic, Iterator {
    List$Rest $outer$ceylon$language$List$Rest;
    List $capture$$o;
    List$Rest$$anonymous$4_([List$Rest $outer$ceylon$language$List$Rest, List $capture$$o]) {
        this.$outer$ceylon$language$List$Rest = $outer$ceylon$language$List$Rest;
        this.$capture$$o = $capture$$o;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() => _i < $outer$ceylon$language$List$Rest.size ? List.$_getElement($capture$$o, $outer$ceylon$language$List$Rest._from + (() {
        $dart$core.int tmp$51 = _i;
        _i = $dartInt($ceylonInteger(_i).successor);
        return tmp$51;
    })()) : $package$finished;
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Rest.toString()) + ".iterator()";
}
class List$Rest implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Rest([List $outer$ceylon$language$List, $dart$core.int from]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this._from = from;
        if (!(this._from >= 0)) {
            throw new AssertionError("Violated: from>=0");
        }
    }
    $dart$core.int _from;
    List sublistFrom([$dart$core.int from]) => from > 0 ? new List$Rest($outer$ceylon$language$List, from + this._from) : this;
    $dart$core.Object getFromFirst([$dart$core.int index]) => index < 0 ? null : $outer$ceylon$language$List.getFromFirst(index + _from);
    $dart$core.int get lastIndex => (() {
        $dart$core.int size$s1;
        {
            size$s1 = $outer$ceylon$language$List.size - _from;
        }
        return size$s1 > 0 ? size$s1 - 1 : null;
    })();
    List measure([Integer from, $dart$core.int length]) => $outer$ceylon$language$List.measure($ceylonInteger($dartInt(from) + this._from), length);
    List span([Integer from, Integer to]) => $outer$ceylon$language$List.span($ceylonInteger($dartInt(from) + this._from), $ceylonInteger($dartInt(to) + this._from));
    List spanFrom([Integer from]) => $outer$ceylon$language$List.spanFrom($ceylonInteger($dartInt(from) + this._from));
    List spanTo([Integer to]) => $outer$ceylon$language$List.span($ceylonInteger(this._from), $ceylonInteger($dartInt(to) + this._from));
    List clone() => new List$Rest($outer$ceylon$language$List.clone(), _from);
    Iterator iterator() => (() {
        List o;
        {
            o = $outer$ceylon$language$List;
        }
        return new List$Rest$$anonymous$4_(this, o);
    })();
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Sublist$$anonymous$5_ implements dart$$Basic, Iterator {
    List$Sublist $outer$ceylon$language$List$Sublist;
    Iterator $capture$$iter;
    List$Sublist$$anonymous$5_([List$Sublist $outer$ceylon$language$List$Sublist, Iterator $capture$$iter]) {
        this.$outer$ceylon$language$List$Sublist = $outer$ceylon$language$List$Sublist;
        this.$capture$$iter = $capture$$iter;
        _i = 0;
    }
    $dart$core.int _i;
    $dart$core.Object next() => (() {
        $dart$core.int tmp$52 = _i;
        _i = $dartInt($ceylonInteger(_i).successor);
        return tmp$52;
    })() > $outer$ceylon$language$List$Sublist._to ? $package$finished : $capture$$iter.next();
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Sublist.toString()) + ".iterator()";
}
class List$Sublist implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Sublist([List $outer$ceylon$language$List, $dart$core.int to]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this._to = to;
        if (!(this._to >= 0)) {
            throw new AssertionError("Violated: to>=0");
        }
    }
    $dart$core.int _to;
    List sublistTo([$dart$core.int to]) => to < 0 ? $package$empty : to < this._to ? new List$Sublist($outer$ceylon$language$List, to) : this;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (index >= 0) && (index <= _to) ? $outer$ceylon$language$List.getFromFirst(index) : null;
    $dart$core.int get lastIndex => (() {
        $dart$core.int endIndex;
        {
            endIndex = $outer$ceylon$language$List.size - 1;
        }
        return endIndex >= 0 ? endIndex < _to ? endIndex : _to : null;
    })();
    List measure([Integer from, $dart$core.int length]) => (($dartInt(from) + length) - 1) > _to ? $outer$ceylon$language$List.measure(from, _to) : $outer$ceylon$language$List.measure(from, length);
    List span([Integer from, Integer to]) => $dartInt(to) > this._to ? $outer$ceylon$language$List.span(from, $ceylonInteger(this._to)) : $outer$ceylon$language$List.span(from, to);
    List spanFrom([Integer from]) => $outer$ceylon$language$List.span(from, $ceylonInteger(_to));
    List spanTo([Integer to]) => $dartInt(to) > this._to ? $outer$ceylon$language$List.spanTo($ceylonInteger(this._to)) : $outer$ceylon$language$List.spanTo(to);
    List clone() => new List$Sublist($outer$ceylon$language$List.clone(), _to);
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$List.iterator();
        }
        return new List$Sublist$$anonymous$5_(this, iter);
    })();
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    $dart$core.bool shorterThan([$dart$core.int length]) => List.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => List.$longerThan(this, length);
    List repeat([$dart$core.int times]) => List.$repeat(this, times);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Repeat implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Repeat([List $outer$ceylon$language$List, $dart$core.int times]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this._times = times;
    }
    $dart$core.int _times;
    $dart$core.int get size => $outer$ceylon$language$List.size * _times;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size$s1;
        {
            size$s1 = this.size;
        }
        return size$s1 > 0 ? size$s1 - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size$s1;
        {
            size$s1 = $outer$ceylon$language$List.size;
        }
        return index < (size$s1 * _times) ? $outer$ceylon$language$List.getFromFirst(index.remainder(size$s1)) : null;
    })();
    List clone() => new List$Repeat($outer$ceylon$language$List.clone(), _times);
    Iterator iterator() => new CycledIterator($outer$ceylon$language$List, _times);
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$List.toString()) + ").repeat(") + _times.toString()) + ")";
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Patch$$anonymous$6_ implements dart$$Basic, Iterator {
    List$Patch $outer$ceylon$language$List$Patch;
    Iterator $capture$$iter;
    Iterator $capture$$patchIter;
    List$Patch$$anonymous$6_([List$Patch $outer$ceylon$language$List$Patch, Iterator $capture$$iter, Iterator $capture$$patchIter]) {
        this.$outer$ceylon$language$List$Patch = $outer$ceylon$language$List$Patch;
        this.$capture$$iter = $capture$$iter;
        this.$capture$$patchIter = $capture$$patchIter;
        _index = -1;
    }
    $dart$core.int _index;
    $dart$core.Object next() {
        if ((_index = $dartInt($ceylonInteger(_index).successor)) == $outer$ceylon$language$List$Patch._from) {{
                $dart$core.Object element$54;
                Iterator iterator$53 = ($package$measure($ceylonInteger(0), $outer$ceylon$language$List$Patch._length) as List).iterator();
                while ((element$54 = iterator$53.next()) is !Finished) {
                    Integer skip;
                    {
                        skip = element$54 as Integer;
                    }
                    $capture$$iter.next();
                }
            }
        }
        return ((_index - $outer$ceylon$language$List$Patch._from) >= 0) && ((_index - $outer$ceylon$language$List$Patch._from) < $outer$ceylon$language$List$Patch._list.size) ? $capture$$patchIter.next() : $capture$$iter.next();
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Patch.toString()) + ".iterator()";
}
class List$Patch implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Patch([List $outer$ceylon$language$List, List list, $dart$core.int from, $dart$core.int length]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this._list = list;
        this._from = from;
        this._length = length;
        if (!(this._length >= 0)) {
            throw new AssertionError("Violated: length>=0");
        }
        if (!((this._from >= 0) && (this._from <= $outer$ceylon$language$List.size))) {
            throw new AssertionError("Violated: 0<=from<=outer.size");
        }
    }
    List _list;
    $dart$core.int _from;
    $dart$core.int _length;
    $dart$core.int get size => ($outer$ceylon$language$List.size + _list.size) - _length;
    $dart$core.int get lastIndex => (() {
        $dart$core.int size$s1;
        {
            size$s1 = this.size;
        }
        return size$s1 > 0 ? size$s1 - 1 : null;
    })();
    $dart$core.Object getFromFirst([$dart$core.int index]) => index < _from ? $outer$ceylon$language$List.getFromFirst(index) : (index - _from) < _list.size ? _list.getFromFirst(index - _from) : $outer$ceylon$language$List.getFromFirst((index - _list.size) + _length);
    List clone() => new List$Patch($outer$ceylon$language$List.clone(), _list.clone(), _from, _length);
    Iterator iterator() => (() {
        Iterator iter;
        {
            iter = $outer$ceylon$language$List.iterator();
        }
        Iterator patchIter;
        {
            patchIter = _list.iterator();
        }
        return new List$Patch$$anonymous$6_(this, iter, patchIter);
    })();
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$Reversed$$anonymous$7_ implements dart$$Basic, Iterator {
    List$Reversed $outer$ceylon$language$List$Reversed;
    List $capture$$outerList;
    List$Reversed$$anonymous$7_([List$Reversed $outer$ceylon$language$List$Reversed, List $capture$$outerList]) {
        this.$outer$ceylon$language$List$Reversed = $outer$ceylon$language$List$Reversed;
        this.$capture$$outerList = $capture$$outerList;
        _index = $capture$$outerList.size - 1;
    }
    $dart$core.int _index;
    $dart$core.Object next() => _index < 0 ? $package$finished : List.$_getElement($capture$$outerList, (() {
        $dart$core.int tmp$55 = _index;
        _index = $dartInt($ceylonInteger(_index).predecessor);
        return tmp$55;
    })());
    $dart$core.String toString() => ("" + $outer$ceylon$language$List$Reversed.toString()) + ".iterator()";
}
class List$Reversed implements dart$$Object, List {
    List $outer$ceylon$language$List;
    List$Reversed([List $outer$ceylon$language$List]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int get size => $outer$ceylon$language$List.size;
    $dart$core.Object get first => $outer$ceylon$language$List.last;
    $dart$core.Object get last => $outer$ceylon$language$List.first;
    List get reversed => $outer$ceylon$language$List;
    $dart$core.Object getFromFirst([$dart$core.int index]) => size > 0 ? $outer$ceylon$language$List.getFromFirst((size - 1) - index) : null;
    List measure([Integer from, $dart$core.int length]) => (size > 0) && (length > 0) ? (() {
        $dart$core.int start;
        {
            start = (size - 1) - $dartInt(from);
        }
        return $outer$ceylon$language$List.span($ceylonInteger(start), $ceylonInteger((start - length) + 1));
    })() : $package$empty;
    List span([Integer from, Integer to]) => $outer$ceylon$language$List.span(to, from);
    List spanFrom([Integer from]) => (() {
        $dart$core.int endIndex;
        {
            endIndex = size - 1;
        }
        return (endIndex >= 0) && ($dartInt(from) <= endIndex) ? $outer$ceylon$language$List.span($ceylonInteger(endIndex - $dartInt(from)), $ceylonInteger(0)) : $package$empty;
    })();
    List spanTo([Integer to]) => (() {
        $dart$core.int endIndex;
        {
            endIndex = size - 1;
        }
        return (endIndex >= 0) && ($dartInt(to) >= 0) ? $outer$ceylon$language$List.span($ceylonInteger(endIndex), $ceylonInteger(endIndex - $dartInt(to))) : $package$empty;
    })();
    List clone() => $outer$ceylon$language$List.clone().reversed;
    Iterator iterator() => (() {
        List outerList;
        {
            outerList = $outer$ceylon$language$List;
        }
        return new List$Reversed$$anonymous$7_(this, outerList);
    })();
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class List$mapElements$$anonymous$8_$$anonymous$9_ implements dart$$Basic, Iterator {
    List$mapElements$$anonymous$8_ $outer$ceylon$language$List$mapElements$$anonymous$8_;
    Iterator $capture$$it;
    List$mapElements$$anonymous$8_$$anonymous$9_([List$mapElements$$anonymous$8_ $outer$ceylon$language$List$mapElements$$anonymous$8_, Iterator $capture$$it]) {
        this.$outer$ceylon$language$List$mapElements$$anonymous$8_ = $outer$ceylon$language$List$mapElements$$anonymous$8_;
        this.$capture$$it = $capture$$it;
        _index = 0;
    }
    $dart$core.int _index;
    $dart$core.Object next() => (() {
        $dart$core.bool doElse$58 = true;
        {
            $dart$core.Object element$59 = $capture$$it.next();
            if (!(element$59 is Finished)) {
                $dart$core.Object element;
                element = element$59;
                doElse$58 = false;
                return $outer$ceylon$language$List$mapElements$$anonymous$8_.$capture$List$mapElements$mapping.f((() {
                    $dart$core.Object tmp$60 = $ceylonInteger(_index);
                    $ceylonInteger(_index = $dartInt($ceylonInteger(_index).successor));
                    return tmp$60;
                })(), element);
            }
        }
        if (doElse$58) {
            return $package$finished;
        }
    })();
}
class List$mapElements$$anonymous$8_ implements dart$$Object, List {
    List $outer$ceylon$language$List;
    Callable $capture$List$mapElements$mapping;
    List$mapElements$$anonymous$8_([List $outer$ceylon$language$List, Callable $capture$List$mapElements$mapping]) {
        this.$outer$ceylon$language$List = $outer$ceylon$language$List;
        this.$capture$List$mapElements$mapping = $capture$List$mapElements$mapping;
    }
    $dart$core.Object getFromFirst([$dart$core.int index]) {
        if ((index >= 0) && (index < size)) {{
                $dart$core.bool doElse$56 = true;
                {
                    $dart$core.Object tmp$57 = $outer$ceylon$language$List.getFromFirst(index);
                    if (!(null == tmp$57)) {
                        $dart$core.Object element;
                        element = tmp$57;
                        doElse$56 = false;
                        return $capture$List$mapElements$mapping.f($ceylonInteger(index), element);
                    }
                }
                if (doElse$56) {
                    if (!true) {
                        throw new AssertionError("Violated: is Element null");
                    }
                    return $capture$List$mapElements$mapping.f($ceylonInteger(index), null);
                }
            }
        } else {
            return null;
        }
    }
    Iterator iterator() => (() {
        Iterator it;
        {
            it = $outer$ceylon$language$List.iterator();
        }
        return new List$mapElements$$anonymous$8_$$anonymous$9_(this, it);
    })();
    $dart$core.int get lastIndex => $outer$ceylon$language$List.lastIndex;
    $dart$core.int get size => $outer$ceylon$language$List.size;
    List clone() => $outer$ceylon$language$List.clone().mapElements($capture$List$mapElements$mapping);
    $dart$core.Object get first => List.$get$first(this);
    $dart$core.Object get last => List.$get$last(this);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool contains([$dart$core.Object element]) => List.$contains(this, element);
    List get rest => List.$get$rest(this);
    List get keys => List.$get$keys(this);
    List get reversed => List.$get$reversed(this);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class List implements Collection, Correspondence, Ranged {
    $dart$core.Object get first;
    static $dart$core.Object $get$first([final List $this]) => $this.getFromFirst(0);
    $dart$core.Object get last;
    static $dart$core.Object $get$last([final List $this]) => $this.getFromLast(0);
    $dart$core.Object get([Integer index]);
    static $dart$core.Object $get([final List $this, Integer index]) => $this.getFromFirst($dartInt(index));
    $dart$core.Object getFromFirst([$dart$core.int index]);
    $dart$core.Object getFromLast([$dart$core.int index]);
    static $dart$core.Object $getFromLast([final List $this, $dart$core.int index]) => $this.getFromFirst(($this.size - 1) - index);
    static $dart$core.Object $_getElement([final List $this, $dart$core.int index]) {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object tmp$1 = $this.getFromFirst(index);
                if (!(null == tmp$1)) {
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
    static $dart$core.int $get$size([final List $this]) => 1 + (($dart$core.int $lhs$) => null == $lhs$ ? -1 : $lhs$)($this.lastIndex);
    $dart$core.bool defines([Integer index]);
    static $dart$core.bool $defines([final List $this, Integer index]) => ($dartInt(index) >= 0) && ($dartInt(index) < $this.size);
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final List $this, $dart$core.Object element]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = ($package$measure($ceylonInteger(0), $this.size) as List).iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                Integer index;
                {
                    index = element$3 as Integer;
                }
                {
                    $dart$core.Object tmp$4 = $this.getFromFirst($dartInt(index));
                    if (!(null == tmp$4)) {
                        $dart$core.Object elem;
                        elem = tmp$4;
                        if (elem == element) {
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
    $dart$core.bool operator ==($dart$core.Object that);
    static $dart$core.bool $equals([final List $this, $dart$core.Object that]) {
        if (that is String) {
            $dart$core.String that$6;
            that$6 = $dartString(that as String);
            return false;
        }
        {
            $dart$core.bool doElse$7 = true;
            if (that is List) {
                List that$8;
                that$8 = that as List;
                doElse$7 = false;
                if (that$8.size == $this.size) {{
                        $dart$core.Object element$10;
                        Iterator iterator$9 = ($package$measure($ceylonInteger(0), $this.size) as List).iterator();
                        while ((element$10 = iterator$9.next()) is !Finished) {
                            Integer index;
                            {
                                index = element$10 as Integer;
                            }
                            $dart$core.Object x = $this.getFromFirst($dartInt(index));
                            $dart$core.Object y = that$8.getFromFirst($dartInt(index));
                            {
                                $dart$core.bool doElse$11 = true;
                                if (!(null == x)) {
                                    doElse$11 = false;
                                    {
                                        $dart$core.bool doElse$12 = true;
                                        if (!(null == y)) {
                                            doElse$12 = false;
                                            if (!(x == y)) {
                                                return false;
                                            }
                                        }
                                        if (doElse$12) {
                                            return false;
                                        }
                                    }
                                }
                                if (doElse$11) {
                                    if (!(null == y)) {
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
    static $dart$core.int $get$hashCode([final List $this]) {
        $dart$core.int hash$s1 = 1;
        {
            $dart$core.Object element$14;
            Iterator iterator$13 = $this.iterator();
            while ((element$14 = iterator$13.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$14;
                }
                hash$s1 = hash$s1 * 31;
                if (!(null == elem)) {
                    hash$s1 = hash$s1 + elem.hashCode;
                }
            }
        }
        return hash$s1;
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
                    index = $dartInt($ceylonInteger(index).successor);
                    return tmp$16;
                })());
                if (!(null == tmp$15)) {
                    $dart$core.Object elem;
                    elem = tmp$15;
                    if ($dartBool(selecting.f(elem) as Boolean)) {
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
                    index = $dartInt($ceylonInteger(index).predecessor);
                    return tmp$18;
                })());
                if (!(null == tmp$17)) {
                    $dart$core.Object elem;
                    elem = tmp$17;
                    if ($dartBool(selecting.f(elem) as Boolean)) {
                        return elem;
                    }
                }
            }
        }
        return null;
    }
    List sublistFrom([$dart$core.int from]);
    static List $sublistFrom([final List $this, $dart$core.int from]) => from <= 0 ? $this : new List$Rest($this, from);
    List sublistTo([$dart$core.int to]);
    static List $sublistTo([final List $this, $dart$core.int to]) => to < 0 ? $package$empty : new List$Sublist($this, to);
    List sublist([$dart$core.int from, $dart$core.int to]);
    static List $sublist([final List $this, $dart$core.int from, $dart$core.int to]) => $this.sublistTo(to).sublistFrom(from);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static List $patch([final List $this, List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = List.$patch$from($this, list);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = List.$patch$length($this, list, from);
        }
        return ((length as $dart$core.int) >= 0) && (((from as $dart$core.int) >= 0) && ((from as $dart$core.int) <= $this.size)) ? new List$Patch($this, list, from as $dart$core.int, length as $dart$core.int) : $this;
    }
    static $dart$core.Object $patch$from(final List $this, List list) => $this.size;
    static $dart$core.Object $patch$length(final List $this, List list, $dart$core.Object from) => 0;
    $dart$core.bool startsWith([List sublist]);
    static $dart$core.bool $startsWith([final List $this, List sublist]) => (!$this.shorterThan(sublist.size)) && $package$everyPair(new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => (() {
        $dart$core.bool doElse$19 = true;
        if (!(null == first)) {
            if (!(null == second)) {
                doElse$19 = false;
                return $ceylonBoolean(first == second);
            }
        }
        if (doElse$19) {
            return $ceylonBoolean((!(null == first)) == (!(null == second)));
        }
    })()), $this, sublist);
    $dart$core.bool endsWith([List sublist]);
    static $dart$core.bool $endsWith([final List $this, List sublist]) => (!$this.shorterThan(sublist.size)) && $package$everyPair(new dart$Callable(([$dart$core.Object first, $dart$core.Object second]) => (() {
        $dart$core.bool doElse$20 = true;
        if (!(null == first)) {
            if (!(null == second)) {
                doElse$20 = false;
                return $ceylonBoolean(first == second);
            }
        }
        if (doElse$20) {
            return $ceylonBoolean((!(null == first)) == (!(null == second)));
        }
    })()), $this.skip($this.size - sublist.size), sublist);
    Iterable indexesWhere([Callable selecting]);
    static Iterable $indexesWhere([final List $this, Callable selecting]) => dart$functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$21 = false;
        $dart$core.bool step$0$22() {
            if (step$0$expired$21) {
                return false;
            }
            step$0$expired$21 = true;
            return true;
        }

        Iterator iterator_1$23;
        $dart$core.bool step$1$Init$26() {
            if (iterator_1$23 != null) {
                return true;
            }
            if (!step$0$22()) {
                return false;
            }
            iterator_1$23 = ($package$measure($ceylonInteger(0), $this.size) as List).iterator();
            return true;
        }

        Integer index$25;
        $dart$core.bool step$1$27() {
            while (step$1$Init$26()) {
                $dart$core.Object next$24;
                if ((next$24 = iterator_1$23.next()) is !Finished) {
                    Integer index;
                    {
                        index = next$24 as Integer;
                    }
                    index$25 = index;
                    return true;
                }
                iterator_1$23 = null;
            }
            return false;
        }

        $dart$core.Object element$30;
        $dart$core.bool step$2$28() {
            while (step$1$27()) {
                Integer index = index$25;
                $dart$core.Object element;
                $dart$core.Object tmp$29 = $this.getFromFirst($dartInt(index));
                if (!(!(null == tmp$29))) {
                    continue;
                }
                element = tmp$29;
                if (!$dartBool(selecting.f(element) as Boolean)) {
                    continue;
                }
                element$30 = element;
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$31() {
            if (!step$2$28()) {
                return $package$finished;
            }
            Integer index = index$25;
            $dart$core.Object element = element$30;
            return index;
        }

        return new dart$Callable(step$3$31);
    }));
    $dart$core.int firstIndexWhere([Callable selecting]);
    static $dart$core.int $firstIndexWhere([final List $this, Callable selecting]) {
        $dart$core.int index = 0;
        while (index < $this.size) {{
                $dart$core.Object tmp$32 = $this.getFromFirst(index);
                if (!(null == tmp$32)) {
                    $dart$core.Object element;
                    element = tmp$32;
                    if ($dartBool(selecting.f(element) as Boolean)) {
                        return index;
                    }
                }
            }
            index = $dartInt($ceylonInteger(index).successor);
        }
        return null;
    }
    $dart$core.int lastIndexWhere([Callable selecting]);
    static $dart$core.int $lastIndexWhere([final List $this, Callable selecting]) {
        $dart$core.int index = $this.size;
        while (index > 0) {
            index = $dartInt($ceylonInteger(index).predecessor);
            {
                $dart$core.Object tmp$33 = $this.getFromFirst(index);
                if (!(null == tmp$33)) {
                    $dart$core.Object element;
                    element = tmp$33;
                    if ($dartBool(selecting.f(element) as Boolean)) {
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
            $dart$core.int from = -1;
            $dart$core.int to = -1;
            {
                $dart$core.bool doFail$34 = true;
                $dart$core.Object element$36;
                Iterator iterator$35 = $package$span($ceylonInteger(0), $ceylonInteger(end)).iterator();
                while ((element$36 = iterator$35.next()) is !Finished) {
                    Integer index;
                    {
                        index = element$36 as Integer;
                    }
                    {
                        $dart$core.Object tmp$37 = $this.getFromFirst($dartInt(index));
                        if (!(null == tmp$37)) {
                            $dart$core.Object elem;
                            elem = tmp$37;
                            if (!$dartBool(trimming.f(elem) as Boolean)) {
                                from = $dartInt(index);
                                doFail$34 = false;
                                break;
                            }
                        }
                    }
                }
                if (doFail$34) {
                    return $package$empty;
                }
            }
            {
                $dart$core.bool doFail$38 = true;
                $dart$core.Object element$40;
                Iterator iterator$39 = $package$span($ceylonInteger(end), $ceylonInteger(0)).iterator();
                while ((element$40 = iterator$39.next()) is !Finished) {
                    Integer index;
                    {
                        index = element$40 as Integer;
                    }
                    {
                        $dart$core.Object tmp$41 = $this.getFromFirst($dartInt(index));
                        if (!(null == tmp$41)) {
                            $dart$core.Object elem;
                            elem = tmp$41;
                            if (!$dartBool(trimming.f(elem) as Boolean)) {
                                to = $dartInt(index);
                                doFail$38 = false;
                                break;
                            }
                        }
                    }
                }
                if (doFail$38) {
                    return $package$empty;
                }
            }
            return $this.span($ceylonInteger(from), $ceylonInteger(to));
        } else {
            return $package$empty;
        }
    }
    List trimLeading([Callable trimming]);
    static List $trimLeading([final List $this, Callable trimming]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            {
                $dart$core.Object element$43;
                Iterator iterator$42 = $package$span($ceylonInteger(0), $ceylonInteger(end)).iterator();
                while ((element$43 = iterator$42.next()) is !Finished) {
                    Integer index;
                    {
                        index = element$43 as Integer;
                    }
                    {
                        $dart$core.Object tmp$44 = $this.getFromFirst($dartInt(index));
                        if (!(null == tmp$44)) {
                            $dart$core.Object elem;
                            elem = tmp$44;
                            if (!$dartBool(trimming.f(elem) as Boolean)) {
                                return $this.span(index, $ceylonInteger(end));
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
                $dart$core.Object element$46;
                Iterator iterator$45 = $package$span($ceylonInteger(end), $ceylonInteger(0)).iterator();
                while ((element$46 = iterator$45.next()) is !Finished) {
                    Integer index;
                    {
                        index = element$46 as Integer;
                    }
                    {
                        $dart$core.Object tmp$47 = $this.getFromFirst($dartInt(index));
                        if (!(null == tmp$47)) {
                            $dart$core.Object elem;
                            elem = tmp$47;
                            if (!$dartBool(trimming.f(elem) as Boolean)) {
                                return $this.span($ceylonInteger(0), index);
                            }
                        }
                    }
                }
            }
        }
        return $package$empty;
    }
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final List $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo($ceylonInteger(index - 1)), $this.spanFrom($ceylonInteger(index))]);
    List initial([$dart$core.int length]);
    static List $initial([final List $this, $dart$core.int length]) => $this.spanTo($ceylonInteger(length - 1));
    List terminal([$dart$core.int length]);
    static List $terminal([final List $this, $dart$core.int length]) => $this.spanFrom($ceylonInteger($this.size - length));
    List span([Integer from, Integer to]);
    static List $span([final List $this, Integer from, Integer to]) {
        if ($this.size > 0) {
            $dart$core.int end = $this.size - 1;
            if ($dartInt(from) <= $dartInt(to)) {
                return ($dartInt(to) >= 0) && ($dartInt(from) <= end) ? new ArraySequence(new Array($this.sublist($dartInt(from), $dartInt(to)))) : $package$empty;
            } else {
                return ($dartInt(from) >= 0) && ($dartInt(to) <= end) ? new ArraySequence(new Array($this.sublist($dartInt(to), $dartInt(from)).reversed)) : $package$empty;
            }
        } else {
            return $package$empty;
        }
    }
    List spanFrom([Integer from]);
    static List $spanFrom([final List $this, Integer from]) {
        if ($dartInt(from) <= 0) {
            return $this.clone();
        } else if ($dartInt(from) < $this.size) {
            return new ArraySequence(new Array($this.sublistFrom($dartInt(from))));
        } else {
            return $package$empty;
        }
    }
    List spanTo([Integer to]);
    static List $spanTo([final List $this, Integer to]) {
        if ($dartInt(to) >= ($this.size - 1)) {
            return $this.clone();
        } else if ($dartInt(to) >= 0) {
            return new ArraySequence(new Array($this.sublistTo($dartInt(to))));
        } else {
            return $package$empty;
        }
    }
    List measure([Integer from, $dart$core.int length]);
    static List $measure([final List $this, Integer from, $dart$core.int length]) => length > 0 ? $this.span(from, $ceylonInteger(($dartInt(from) + length) - 1)) : $package$empty;
    Sequential collect([Callable collecting]);
    static Sequential $collect([final List $this, Callable collecting]) {
        if ($this.empty) {
            return $package$empty;
        } else {
            final List$collect$list_ list = new List$collect$list_($this, collecting);
            return new ArraySequence(new Array(list));
        }
    }
    List mapElements([Callable mapping]);
    static List $mapElements([final List $this, Callable mapping]) => new List$mapElements$$anonymous$8_($this, mapping);
}
class loop$$anonymous$0_$$anonymous$1_ implements dart$$Basic, Iterator {
    loop$$anonymous$0_ $outer$ceylon$language$loop$$anonymous$0_;
    loop$$anonymous$0_$$anonymous$1_([loop$$anonymous$0_ $outer$ceylon$language$loop$$anonymous$0_]) {
        this.$outer$ceylon$language$loop$$anonymous$0_ = $outer$ceylon$language$loop$$anonymous$0_;
        _current = $outer$ceylon$language$loop$$anonymous$0_.$capture$loop$$start;
    }
    $dart$core.Object _current;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object result$1 = _current;
                if (!(result$1 is Finished)) {
                    $dart$core.Object result;
                    result = result$1;
                    doElse$0 = false;
                    _current = $outer$ceylon$language$loop$$anonymous$0_._nextElement(result);
                    return result;
                }
            }
            if (doElse$0) {
                return $package$finished;
            }
        }
    }
}
class loop$$anonymous$0_ implements dart$$Basic, Iterable {
    $dart$core.Object $capture$loop$$start;
    Callable $capture$loop$next;
    loop$$anonymous$0_([$dart$core.Object $capture$loop$$start, Callable $capture$loop$next]) {
        this.$capture$loop$$start = $capture$loop$$start;
        this.$capture$loop$next = $capture$loop$next;
    }
    $dart$core.Object get first => $capture$loop$$start;
    $dart$core.bool get empty => false;
    $dart$core.Object _nextElement([$dart$core.Object element]) => $capture$loop$next.f(element);
    Iterator iterator() => new loop$$anonymous$0_$$anonymous$1_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
Callable $package$loop([$dart$core.Object first]) => new dart$Callable(([Callable next]) => (() {
    $dart$core.Object start;
    {
        start = first;
    }
    return new loop$$anonymous$0_(start, next);
})());

Callable loop([$dart$core.Object first]) => $package$loop(first);

class Map$keys$$anonymous$0_ implements dart$$Object, Set {
    Map $outer$ceylon$language$Map;
    Map$keys$$anonymous$0_([Map $outer$ceylon$language$Map]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
    }
    $dart$core.bool contains([$dart$core.Object key]) => $outer$ceylon$language$Map.defines(key);
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).key)).iterator();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    $dart$core.bool get empty => $outer$ceylon$language$Map.empty;
    Set clone() => $package$set(this);
    $dart$core.bool superset([Set set]) => Set.$superset(this, set);
    $dart$core.bool subset([Set set]) => Set.$subset(this, set);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Set.$defaultNullElements(this, defaultValue);
    Set union([Set set]) => Set.$union(this, set);
    Set intersection([Set set]) => Set.$intersection(this, set);
    Set complement([Set set]) => Set.$complement(this, set);
    Set exclusiveUnion([Set set]) => Set.$exclusiveUnion(this, set);
    $dart$core.bool operator ==($dart$core.Object that) => Set.$equals(this, that);
    $dart$core.int get hashCode => Set.$get$hashCode(this);
    Iterable get distinct => Set.$get$distinct(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Map$Items implements dart$$Object, Collection {
    Map $outer$ceylon$language$Map;
    Map$Items([Map $outer$ceylon$language$Map]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
    }
    $dart$core.bool contains([$dart$core.Object item]) => $outer$ceylon$language$Map.any(new dart$Callable(([Entry $_0]) => (() {
        $dart$core.Object $_;
        $dart$core.Object it;
        {
            Entry d$5 = $_0;
            $_ = d$5.key;
            it = d$5.item;
        }
        return (() {
            $dart$core.bool doElse$6 = true;
            if (!(null == it)) {
                doElse$6 = false;
                return $ceylonBoolean(it == item);
            }
            if (doElse$6) {
                return $package$$false;
            }
        })();
    })()));
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).item)).iterator();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    $dart$core.bool get empty => $outer$ceylon$language$Map.empty;
    Collection clone() => this.sequence();
    $dart$core.int get hashCode => frequencies().hashCode;
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$7 = true;
        if (that is Map$Items) {
            Map$Items that$8;
            that$8 = that as Map$Items;
            doElse$7 = false;
            return frequencies() == that$8.frequencies();
        }
        if (doElse$7) {
            return false;
        }
    })();
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Map$mapItems$$anonymous$4_ implements dart$$Object, Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$mapItems$mapping;
    Map$mapItems$$anonymous$4_([Map $outer$ceylon$language$Map, Callable $capture$Map$mapItems$mapping]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
        this.$capture$Map$mapItems$mapping = $capture$Map$mapItems$mapping;
    }
    $dart$core.bool defines([$dart$core.Object key]) => $outer$ceylon$language$Map.defines(key);
    $dart$core.Object get([$dart$core.Object key]) {{
            $dart$core.bool doElse$18 = true;
            if (key != null) {
                doElse$18 = false;
                return (() {
                    $dart$core.Object item = Map.$_lookup($outer$ceylon$language$Map, key);
                    if ($dart$core.identical(item, $package$$new$Missing$instance)) {
                        return null;
                    } else {
                        return $capture$Map$mapItems$mapping.f(key, item);
                    }
                })();
            }
            if (doElse$18) {
                return null;
            }
        }
    }
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) {{
            $dart$core.bool doElse$19 = true;
            if (key != null) {
                doElse$19 = false;
                return (() {
                    $dart$core.Object item = Map.$_lookup($outer$ceylon$language$Map, key);
                    if ($dart$core.identical(item, $package$$new$Missing$instance)) {
                        return $default;
                    } else {
                        return $capture$Map$mapItems$mapping.f(key, item);
                    }
                })();
            }
            if (doElse$19) {
                return $default;
            }
        }
    }
    Entry _mapEntry([Entry entry]) => new Entry(entry.key, $capture$Map$mapItems$mapping.f(entry.key, entry.item));
    Iterator iterator() => $outer$ceylon$language$Map.map(new dart$Callable(_mapEntry)).iterator();
    $dart$core.int get size => $outer$ceylon$language$Map.size;
    Collection get keys => $outer$ceylon$language$Map.keys;
    Map clone() => $outer$ceylon$language$Map.clone().mapItems($capture$Map$mapItems$mapping);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$filterKeys$$anonymous$6_ implements dart$$Object, Map {
    Map $outer$ceylon$language$Map;
    Callable $capture$Map$filterKeys$filtering;
    Map$filterKeys$$anonymous$6_([Map $outer$ceylon$language$Map, Callable $capture$Map$filterKeys$filtering]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
        this.$capture$Map$filterKeys$filtering = $capture$Map$filterKeys$filtering;
    }
    $dart$core.Object get([$dart$core.Object key]) => (() {
        $dart$core.bool doElse$20 = true;
        if (key != null) {
            if ($dartBool($capture$Map$filterKeys$filtering.f(key) as Boolean)) {
                doElse$20 = false;
                return $outer$ceylon$language$Map.get(key);
            }
        }
        if (doElse$20) {
            return null;
        }
    })();
    $dart$core.bool defines([$dart$core.Object key]) => (() {
        $dart$core.bool doElse$21 = true;
        if (key != null) {
            if ($dartBool($capture$Map$filterKeys$filtering.f(key) as Boolean)) {
                doElse$21 = false;
                return $outer$ceylon$language$Map.defines(key);
            }
        }
        if (doElse$21) {
            return false;
        }
    })();
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => (() {
        $dart$core.bool doElse$22 = true;
        if (key != null) {
            if ($dartBool($capture$Map$filterKeys$filtering.f(key) as Boolean)) {
                doElse$22 = false;
                return $outer$ceylon$language$Map.getOrDefault(key, $default);
            }
        }
        if (doElse$22) {
            return $default;
        }
    })();
    Iterator iterator() => $outer$ceylon$language$Map.filter($package$forKey($capture$Map$filterKeys$filtering)).iterator();
    Map clone() => $outer$ceylon$language$Map.clone().filterKeys($capture$Map$filterKeys$filtering);
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$patch$$anonymous$7_ implements dart$$Object, Map {
    Map $outer$ceylon$language$Map;
    Map $capture$Map$patch$other;
    Map$patch$$anonymous$7_([Map $outer$ceylon$language$Map, Map $capture$Map$patch$other]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
        this.$capture$Map$patch$other = $capture$Map$patch$other;
    }
    $dart$core.bool defines([$dart$core.Object key]) => $capture$Map$patch$other.defines(key) || $outer$ceylon$language$Map.defines(key);
    $dart$core.Object get([$dart$core.Object key]) => (() {
        $dart$core.Object result = Map.$_lookup($capture$Map$patch$other, key);
        if ($dart$core.identical(result, $package$$new$Missing$instance)) {
            return $outer$ceylon$language$Map.get(key);
        } else {
            return result;
        }
    })();
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => (() {
        $dart$core.Object result = Map.$_lookup($capture$Map$patch$other, key);
        if ($dart$core.identical(result, $package$$new$Missing$instance)) {
            return $outer$ceylon$language$Map.getOrDefault(key, $default);
        } else {
            return result;
        }
    })();
    Map clone() => $outer$ceylon$language$Map.clone().patch($capture$Map$patch$other.clone());
    $dart$core.bool contains([$dart$core.Object entry]) => (() {
        $dart$core.bool doElse$23 = true;
        if (entry is Entry) {
            Entry entry$24;
            entry$24 = entry as Entry;
            doElse$23 = false;
            return $capture$Map$patch$other.contains(entry$24) || ((!$capture$Map$patch$other.defines(entry$24.key)) && $outer$ceylon$language$Map.contains(entry$24));
        }
        if (doElse$23) {
            return false;
        }
    })();
    $dart$core.int get size => $outer$ceylon$language$Map.size + $capture$Map$patch$other.keys.count($package$not(new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean($outer$ceylon$language$Map.defines($0)))));
    Iterator iterator() => new ChainedIterator($capture$Map$patch$other, $outer$ceylon$language$Map.filter($package$not(new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean($capture$Map$patch$other.contains($0))))));
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Map$coalescedMap$$anonymous$8_ implements dart$$Object, Map {
    Map $outer$ceylon$language$Map;
    Map$coalescedMap$$anonymous$8_([Map $outer$ceylon$language$Map]) {
        this.$outer$ceylon$language$Map = $outer$ceylon$language$Map;
    }
    $dart$core.bool defines([$dart$core.Object key]) => !(null == $outer$ceylon$language$Map.get(key));
    $dart$core.Object get([$dart$core.Object key]) => $outer$ceylon$language$Map.get(key);
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => (($dart$core.Object $lhs$) => null == $lhs$ ? $default : $lhs$)($outer$ceylon$language$Map.getOrDefault(key, $default));
    Iterator iterator() => dart$functionIterable(new dart$Callable(() {
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
            iterator_1$27 = $outer$ceylon$language$Map.iterator();
            return true;
        }

        Entry entry$29;
        $dart$core.bool step$1$31() {
            while (step$1$Init$30()) {
                $dart$core.Object next$28;
                if ((next$28 = iterator_1$27.next()) is !Finished) {
                    Entry entry;
                    {
                        entry = next$28 as Entry;
                    }
                    entry$29 = entry;
                    return true;
                }
                iterator_1$27 = null;
            }
            return false;
        }

        $dart$core.Object it$34;
        $dart$core.bool step$2$32() {
            while (step$1$31()) {
                Entry entry = entry$29;
                $dart$core.Object it;
                $dart$core.Object tmp$33 = entry.item;
                if (!(!(null == tmp$33))) {
                    continue;
                }
                it = tmp$33;
                it$34 = it;
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$35() {
            if (!step$2$32()) {
                return $package$finished;
            }
            Entry entry = entry$29;
            $dart$core.Object it = it$34;
            return new Entry(entry.key, it);
        }

        return new dart$Callable(step$3$35);
    })).iterator();
    Map clone() => $outer$ceylon$language$Map.clone().coalescedMap;
    $dart$core.bool contains([$dart$core.Object entry]) => Map.$contains(this, entry);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Collection get keys => Map.$get$keys(this);
    Collection get items => Map.$get$items(this);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map mapItems([Callable mapping]) => Map.$mapItems(this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
abstract class Map implements Collection, Correspondence {
    $dart$core.Object get([$dart$core.Object key]);
    $dart$core.bool defines([$dart$core.Object key]);
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]);
    static $dart$core.Object $getOrDefault([final Map $this, $dart$core.Object key, $dart$core.Object $default]) {
        if ($this.defines(key)) {{
                $dart$core.bool doElse$0 = true;
                {
                    $dart$core.Object tmp$1 = $this.get(key);
                    if (!(null == tmp$1)) {
                        $dart$core.Object item;
                        item = tmp$1;
                        doElse$0 = false;
                        return item;
                    }
                }
                if (doElse$0) {
                    if (!true) {
                        throw new AssertionError("Violated: is Item null");
                    }
                    return null;
                }
            }
        } else {
            return $default;
        }
    }
    static $dart$core.Object $_lookup([final Map $this, $dart$core.Object key]) => $this.getOrDefault(key, $package$$new$Missing$instance);
    $dart$core.bool contains([$dart$core.Object entry]);
    static $dart$core.bool $contains([final Map $this, $dart$core.Object entry]) {
        if (entry is Entry) {
            Entry entry$2;
            entry$2 = entry as Entry;
            $dart$core.Object key;
            $dart$core.Object it;
            {
                Entry d$3 = entry$2;
                key = d$3.key;
                it = d$3.item;
            }
            if ($this.defines(key)) {
                $dart$core.Object item = $this.get(key);
                return (() {
                    $dart$core.bool doElse$4 = true;
                    if (!(null == it)) {
                        if (!(null == item)) {
                            doElse$4 = false;
                            return item == it;
                        }
                    }
                    if (doElse$4) {
                        return (!(null == it)) == (!(null == item));
                    }
                })();
            }
        }
        return false;
    }
    Iterable get distinct;
    static Iterable $get$distinct([final Map $this]) => $this;
    Iterable defaultNullElements([$dart$core.Object defaultValue]);
    static Iterable $defaultNullElements([final Map $this, $dart$core.Object defaultValue]) => $this;
    Map clone();
    static Map $clone([final Map $this]) => $package$map($this);
    Collection get keys;
    static Collection $get$keys([final Map $this]) => new Map$keys$$anonymous$0_($this);
    Collection get items;
    static Collection $get$items([final Map $this]) => new Map$Items($this);
    Map inverse();
    static Map $inverse([final Map $this]) => $this.coalescedMap.summarize(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).item), new dart$Callable(([ElementEntry keys, Entry $_0]) => (() {
        $dart$core.Object key;
        $dart$core.Object $_;
        {
            Entry d$9 = $_0;
            key = d$9.key;
            $_ = d$9.item;
        }
        return new ElementEntry(keys, key);
    })())).mapItems(new dart$Callable(([$dart$core.Object $_, ElementEntry item]) => item.reversedSequence()));
    $dart$core.bool operator ==($dart$core.Object that);
    static $dart$core.bool $equals([final Map $this, $dart$core.Object that]) {{
            $dart$core.bool doElse$10 = true;
            if (that is Map) {
                Map that$11;
                that$11 = that as Map;
                if (that$11.size == $this.size) {
                    doElse$10 = false;
                    {
                        $dart$core.Object element$13;
                        Iterator iterator$12 = $this.iterator();
                        while ((element$13 = iterator$12.next()) is !Finished) {
                            $dart$core.Object key;
                            $dart$core.Object thisItem;
                            {
                                Entry d$14 = element$13 as Entry;
                                key = d$14.key;
                                thisItem = d$14.item;
                            }
                            $dart$core.Object thatItem = that$11.get(key);
                            {
                                $dart$core.bool doElse$15 = true;
                                if (!(null == thisItem)) {
                                    if (!(null == thatItem)) {
                                        doElse$15 = false;
                                        if (!(thatItem == thisItem)) {
                                            return false;
                                        }
                                    }
                                }
                                if (doElse$15) {
                                    if (!((!(null == thisItem)) == (!(null == thatItem)))) {
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
            if (doElse$10) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode;
    static $dart$core.int $get$hashCode([final Map $this]) {
        $dart$core.int hashCode = 0;
        {
            $dart$core.Object element$17;
            Iterator iterator$16 = $this.iterator();
            while ((element$17 = iterator$16.next()) is !Finished) {
                Entry elem;
                {
                    elem = element$17 as Entry;
                }
                hashCode = hashCode + elem.hashCode;
            }
        }
        return hashCode;
    }
    Map mapItems([Callable mapping]);
    static Map $mapItems([final Map $this, Callable mapping]) => new Map$mapItems$$anonymous$4_($this, mapping);
    Map defaultNullItems([$dart$core.Object defaultValue]);
    static Map $defaultNullItems([final Map $this, $dart$core.Object defaultValue]) => $this.mapItems(new dart$Callable(([$dart$core.Object key, $dart$core.Object elem]) => (($dart$core.Object $lhs$) => null == $lhs$ ? defaultValue : $lhs$)(elem)));
    Map filterKeys([Callable filtering]);
    static Map $filterKeys([final Map $this, Callable filtering]) => new Map$filterKeys$$anonymous$6_($this, filtering);
    Map patch([Map other]);
    static Map $patch([final Map $this, Map other]) => new Map$patch$$anonymous$7_($this, other);
    Map get coalescedMap;
    static Map $get$coalescedMap([final Map $this]) => new Map$coalescedMap$$anonymous$8_($this);
}
Map $package$map([Iterable stream, $dart$core.Object choosing = $package$dart$default]) {
    if ($dart$core.identical(choosing, $package$dart$default)) {
        choosing = new dart$Callable(([$dart$core.Object earlier, $dart$core.Object later]) => earlier);
    }
    return stream.summarize(new dart$Callable(([$dart$core.Object $r]) => ($r as Entry).key), new dart$Callable(([$dart$core.Object item, Entry entry]) => (() {
        $dart$core.bool doElse$36 = true;
        if (!(null == item)) {
            doElse$36 = false;
            return (choosing as Callable).f(item, entry.item);
        }
        if (doElse$36) {
            return entry.item;
        }
    })()));
}

Map map([Iterable stream, $dart$core.Object choosing = $package$dart$default]) => $package$map(stream, choosing);

class emptyMap_ implements dart$$Object, Map {
    emptyMap_() {}
    $dart$core.Object get([$dart$core.Object key]) => null;
    $dart$core.Object getOrDefault([$dart$core.Object key, $dart$core.Object $default]) => $default;
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
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Map.$defaultNullElements(this, defaultValue);
    Map inverse() => Map.$inverse(this);
    $dart$core.bool operator ==($dart$core.Object that) => Map.$equals(this, that);
    $dart$core.int get hashCode => Map.$get$hashCode(this);
    Map defaultNullItems([$dart$core.Object defaultValue]) => Map.$defaultNullItems(this, defaultValue);
    Map filterKeys([Callable filtering]) => Map.$filterKeys(this, filtering);
    Map patch([Map other]) => Map.$patch(this, other);
    Map get coalescedMap => Map.$get$coalescedMap(this);
    Iterable get distinct => Map.$get$distinct(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
final emptyMap_ $package$emptyMap = new emptyMap_();

emptyMap_ get emptyMap => $package$emptyMap;

class Missing implements dart$$Basic {
    void _$init$Missing([$dart$core.int $bitmap]) {
        if (0 != ($bitmap & 1)) {}
    }
    Missing.instance() : this.instance$d(1);
    Missing.instance$d([$dart$core.int $bitmap]) {
        _$init$Missing($bitmap | 1);
    }
}
Missing _$s$Missing$instance;

Missing get $package$$new$Missing$instance => _$s$Missing$instance != null ? _$s$Missing$instance : _$s$Missing$instance = new Missing.instance();

Missing get $new$Missing$instance => $package$$new$Missing$instance;

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
                    if (!(!(max == max))) {
                        break;
                    }
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$2 = it.next();
                        if (val$2 is Finished) {
                            break;
                        }
                        val = val$2;
                    }
                    max = val;
                }
                while (true) {
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$3 = it.next();
                        if (val$3 is Finished) {
                            break;
                        }
                        val = val$3;
                    }
                    if ((val as Comparable) > max) {
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

class Measure$$anonymous$0_ implements dart$$Basic, Iterator {
    Measure $outer$ceylon$language$Measure;
    Measure$$anonymous$0_([Measure $outer$ceylon$language$Measure]) {
        this.$outer$ceylon$language$Measure = $outer$ceylon$language$Measure;
        _count = 0;
        _current = $outer$ceylon$language$Measure.first;
    }
    $dart$core.int _count;
    $dart$core.Object _current;
    $dart$core.Object next() {
        if (_count >= $outer$ceylon$language$Measure.size) {
            return $package$finished;
        } else if ((() {
            $dart$core.int tmp$0 = _count;
            _count = $dartInt($ceylonInteger(_count).successor);
            return tmp$0;
        })() == 0) {
            return _current;
        } else {
            return _current = (_current as Enumerable).successor;
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Measure.toString()) + ").iterator()";
}
class Measure$By$$anonymous$1_ implements dart$$Basic, Iterator {
    Measure$By $outer$ceylon$language$Measure$By;
    Measure$By$$anonymous$1_([Measure$By $outer$ceylon$language$Measure$By]) {
        this.$outer$ceylon$language$Measure$By = $outer$ceylon$language$Measure$By;
        _count = 0;
        _current = $outer$ceylon$language$Measure$By.first;
    }
    $dart$core.int _count;
    $dart$core.Object _current;
    $dart$core.Object next() {
        if (_count >= $outer$ceylon$language$Measure$By.size) {
            return $package$finished;
        } else if ((() {
            $dart$core.int tmp$1 = _count;
            _count = $dartInt($ceylonInteger(_count).successor);
            return tmp$1;
        })() == 0) {
            return _current;
        } else {
            _current = (_current as Enumerable).neighbour($outer$ceylon$language$Measure$By._step);
            return _current;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Measure$By.toString()) + ".iterator()";
}
class Measure$By implements dart$$Basic, Iterable {
    Measure $outer$ceylon$language$Measure;
    Measure$By([Measure $outer$ceylon$language$Measure, $dart$core.int step]) {
        this.$outer$ceylon$language$Measure = $outer$ceylon$language$Measure;
        this._step = step;
    }
    $dart$core.int _step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Measure.size - 1) ~/ _step);
    $dart$core.Object get first => $outer$ceylon$language$Measure.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Measure.toString()) + ").by(") + _step.toString()) + ")";
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
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
    $dart$core.String toString() => (first.toString() + ":") + size.toString();
    $dart$core.Object get last => (first as Enumerable).neighbour(size - 1);
    $dart$core.bool longerThan([$dart$core.int length]) => size > length;
    $dart$core.bool shorterThan([$dart$core.int length]) => size < length;
    $dart$core.int get lastIndex => size - 1;
    Sequential get rest => size > 1 ? new Measure((first as Enumerable).successor, size - 1) : $package$empty;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (index >= 0) && (index < size) ? (first as Enumerable).neighbour(index) : null;
    $dart$core.bool get increasing => true;
    $dart$core.bool get decreasing => false;
    Iterator iterator() => new Measure$$anonymous$0_(this);
    Iterable by([$dart$core.int step]) {
        if (!(step > 0)) {
            throw new AssertionError("Violated: step > 0");
        }
        return step == 1 ? this : new Measure$By(this, step);
    }
    Range shifted([$dart$core.int shift]) => shift == 0 ? this : new Measure((first as Enumerable).neighbour(shift), size);
    $dart$core.bool containsElement([$dart$core.Object x]) => ((x as Enumerable).offset(first) >= 0) && ((x as Enumerable).offset(first) < size);
    $dart$core.bool includesRange([Range range]) {{
            Range switch$2 = range;
            if (switch$2 is Measure) {
                Measure range$3;
                range$3 = range as Measure;
                $dart$core.int offset = (range$3.first as Enumerable).offset(first);
                return (offset >= 0) && (offset <= (size - range$3.size));
            } else if (switch$2 is Span) {
                Span range$4;
                range$4 = range as Span;
                if (range$4.decreasing) {
                    return false;
                } else {
                    $dart$core.int offset = (range$4.first as Enumerable).offset(first);
                    return (offset >= 0) && (offset <= (size - range$4.size));
                }
            } else {
                throw new AssertionError("Supposedly exhaustive switch was not exhaustive");
            }
        }
    }
    $dart$core.bool operator ==($dart$core.Object that) {{
            $dart$core.bool doElse$5 = true;
            if (that is Measure) {
                Measure that$6;
                that$6 = that as Measure;
                doElse$5 = false;
                return (that$6.size == size) && (that$6.first == first);
            }
            if (doElse$5) {
                $dart$core.bool doElse$7 = true;
                if (that is Span) {
                    Span that$8;
                    that$8 = that as Span;
                    doElse$7 = false;
                    return (that$8.increasing && (that$8.first == first)) && (that$8.size == size);
                }
                if (doElse$7) {
                    return List.$equals(this, that);
                }
            }
        }
    }
    Sequential measure([Integer from, $dart$core.int length]) {
        if (length <= 0) {
            return $package$empty;
        } else {
            $dart$core.int len = ($dartInt(from) + length) < size ? length : size - $dartInt(from);
            return new Measure((first as Enumerable).neighbour($dartInt(from)), len);
        }
    }
    Sequential span([Integer from, Integer to]) {
        if ($dartInt(from) <= $dartInt(to)) {
            if (($dartInt(to) < 0) || ($dartInt(from) >= size)) {
                return $package$empty;
            } else {
                $dart$core.int len = $dartInt(to) < size ? ($dartInt(to) - $dartInt(from)) + 1 : size - $dartInt(from);
                return new Measure((first as Enumerable).neighbour($dartInt(from)), len);
            }
        } else {
            if (($dartInt(from) < 0) || ($dartInt(to) >= size)) {
                return $package$empty;
            } else {
                $dart$core.int len = $dartInt(from) < size ? ($dartInt(from) - $dartInt(to)) + 1 : size - $dartInt(to);
                return (new Measure((first as Enumerable).neighbour($dartInt(to)), len)).reversed;
            }
        }
    }
    Sequential spanFrom([Integer from]) {
        if ($dartInt(from) <= 0) {
            return this;
        } else if ($dartInt(from) < size) {
            return new Measure((first as Enumerable).neighbour($dartInt(from)), size - $dartInt(from));
        } else {
            return $package$empty;
        }
    }
    Sequential spanTo([Integer to]) {
        if ($dartInt(to) < 0) {
            return $package$empty;
        } else if ($dartInt(to) < (size - 1)) {
            return new Measure(first, $dartInt(to));
        } else {
            return this;
        }
    }
    void each([Callable step]) {
        $dart$core.Object current = first;
        $dart$core.int count$s1 = 0;
        while ((() {
            $dart$core.int tmp$9 = count$s1;
            count$s1 = $dartInt($ceylonInteger(count$s1).successor);
            return tmp$9;
        })() < size) {
            step.f((() {
                $dart$core.Object tmp$10 = current;
                current = (current as Enumerable).successor;
                return tmp$10;
            })());
        }
    }
}
$dart$core.Object $package$measure([$dart$core.Object first, $dart$core.int size]) => size <= 0 ? $package$empty : new Measure(first, size);

$dart$core.Object measure([$dart$core.Object first, $dart$core.int size]) => $package$measure(first, size);

$dart$core.Object $package$meta$annotations([meta$model$Class annotationType, $dart$core.Object programElement]) => $package$nothing;

$dart$core.Object meta$annotations([meta$model$Class annotationType, $dart$core.Object programElement]) => $package$meta$annotations(annotationType, programElement);

meta$declaration$ClassDeclaration $package$meta$classDeclaration([$dart$core.Object instance]) => $package$nothing as meta$declaration$ClassDeclaration;

meta$declaration$ClassDeclaration meta$classDeclaration([$dart$core.Object instance]) => $package$meta$classDeclaration(instance);

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
    meta$declaration$CallableConstructorDeclaration get defaultConstructor;
    Sequential get parameterDeclarations;
    meta$declaration$FunctionOrValueDeclaration getParameterDeclaration([$dart$core.String name]);
    $dart$core.bool get annotation;
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
            typeArguments = meta$declaration$ClassDeclaration.$instantiate$typeArguments($this);
        }
        return $this.classApply(typeArguments as Sequential).apply(arguments);
    }
    static $dart$core.Object $instantiate$typeArguments(final meta$declaration$ClassDeclaration $this) => $package$empty;
    $dart$core.Object memberInstantiate([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $memberInstantiate([final meta$declaration$ClassDeclaration $this, $dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]) {
        if ($dart$core.identical(typeArguments, $package$dart$default)) {
            typeArguments = meta$declaration$ClassDeclaration.$memberInstantiate$typeArguments($this, container);
        }
        return $this.memberClassApply(throw new AssertionError("Meta expressions not yet supported at 'ClassDeclaration.ceylon: 151:62-151:70'"), typeArguments as Sequential).bind(container).apply(arguments);
    }
    static $dart$core.Object $memberInstantiate$typeArguments(final meta$declaration$ClassDeclaration $this, $dart$core.Object container) => $package$empty;
    $dart$core.Object getConstructorDeclaration([$dart$core.String name]);
    Sequential constructorDeclarations();
    Sequential annotatedConstructorDeclarations();
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
abstract class meta$declaration$ClassWithConstructorsDeclaration implements meta$declaration$ClassDeclaration {
}
abstract class meta$declaration$ClassWithInitializerDeclaration implements meta$declaration$ClassDeclaration {
    meta$declaration$CallableConstructorDeclaration get defaultConstructor;
    Sequential get parameterDeclarations;
    Sequence constructorDeclarations();
    static Sequence $constructorDeclarations([final meta$declaration$ClassWithInitializerDeclaration $this]) => new Singleton($this.defaultConstructor);
    meta$declaration$CallableConstructorDeclaration getConstructorDeclaration([$dart$core.String name]);
    static meta$declaration$CallableConstructorDeclaration $getConstructorDeclaration([final meta$declaration$ClassWithInitializerDeclaration $this, $dart$core.String name]) => $ceylonString(name).empty ? $this.defaultConstructor : null;
    Sequential annotatedConstructorDeclarations();
}
abstract class meta$declaration$ConstructorDeclaration implements meta$declaration$NestableDeclaration {
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
            typeArguments = meta$declaration$FunctionalDeclaration.$invoke$typeArguments($this);
        }
        return ($this.apply(typeArguments as Sequential) as meta$model$Applicable).apply(arguments);
    }
    static $dart$core.Object $invoke$typeArguments(final meta$declaration$FunctionalDeclaration $this) => $package$empty;
    $dart$core.Object memberInvoke([$dart$core.Object container, $dart$core.Object typeArguments = $package$dart$default, Sequential arguments]);
    static $dart$core.Object $memberInvoke$typeArguments(final meta$declaration$FunctionalDeclaration $this, $dart$core.Object container) => $package$empty;
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
abstract class meta$declaration$GettableDeclaration {
    $dart$core.Object get();
    $dart$core.Object memberGet([$dart$core.Object container]);
}
abstract class meta$declaration$InterfaceDeclaration implements meta$declaration$ClassOrInterfaceDeclaration {
    meta$model$Interface interfaceApply([Sequential typeArguments]);
    meta$model$MemberInterface memberInterfaceApply([meta$model$Type containerType, Sequential typeArguments]);
}
abstract class meta$declaration$Module implements dart$$Identifiable, meta$declaration$AnnotatedDeclaration {
    $dart$core.String get version;
    Sequential get members;
    Sequential get dependencies;
    meta$declaration$Package findPackage([$dart$core.String name]);
    meta$declaration$Package findImportedPackage([$dart$core.String name]);
    Resource resourceByPath([$dart$core.String path]);
}
abstract class meta$declaration$Import implements dart$$Identifiable, Annotated {
    $dart$core.String get name;
    $dart$core.String get version;
    $dart$core.bool get shared;
    $dart$core.bool get optional;
    meta$declaration$Module get container;
}
abstract class meta$declaration$Package implements dart$$Identifiable, meta$declaration$AnnotatedDeclaration {
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
abstract class meta$declaration$NestableDeclaration implements meta$declaration$AnnotatedDeclaration, meta$declaration$TypedDeclaration {
    $dart$core.bool get actual;
    $dart$core.bool get formal;
    $dart$core.bool get $default;
    $dart$core.bool get shared;
    meta$declaration$Package get containingPackage;
    meta$declaration$Module get containingModule;
    $dart$core.Object get container;
    $dart$core.bool get toplevel;
}
class meta$declaration$nothingType_ implements dart$$Basic, meta$declaration$OpenType {
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
    Sequential get typeArgumentList;
    Map get typeArgumentWithVariances;
    Sequential get typeArgumentWithVarianceList;
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
abstract class meta$declaration$ValueConstructorDeclaration implements meta$declaration$GettableDeclaration, meta$declaration$ConstructorDeclaration {
    meta$declaration$ClassDeclaration get container;
    meta$model$ValueConstructor apply();
    meta$model$MemberClassValueConstructor memberApply([meta$model$Type containerType]);
    $dart$core.Object get();
    static $dart$core.Object $get([final meta$declaration$ValueConstructorDeclaration $this]) => $this.apply().get();
    $dart$core.Object memberGet([$dart$core.Object container]);
    static $dart$core.Object $memberGet([final meta$declaration$ValueConstructorDeclaration $this, $dart$core.Object container]) => $this.memberApply(throw new AssertionError("Meta expressions not yet supported at 'ValueConstructorDeclaration.ceylon: 51:44-51:52'")).bind(container).get();
}
abstract class meta$declaration$ValueDeclaration implements meta$declaration$FunctionOrValueDeclaration, meta$declaration$NestableDeclaration, meta$declaration$GettableDeclaration {
    $dart$core.bool get late;
    $dart$core.bool get variable;
    $dart$core.bool get objectValue;
    meta$declaration$ClassDeclaration get objectClass;
    meta$model$Value apply();
    meta$model$Attribute memberApply([meta$model$Type containerType]);
    $dart$core.Object get();
    static $dart$core.Object $get([final meta$declaration$ValueDeclaration $this]) => $this.apply().get();
    $dart$core.Object memberGet([$dart$core.Object container]);
    static $dart$core.Object $memberGet([final meta$declaration$ValueDeclaration $this, $dart$core.Object container]) => $this.memberApply(throw new AssertionError("Meta expressions not yet supported at 'ValueDeclaration.ceylon: 84:55-84:63'")).bind(container).get();
    void set([$dart$core.Object newValue]);
    static void $set([final meta$declaration$ValueDeclaration $this, $dart$core.Object newValue]) {
        $this.apply().setIfAssignable(newValue);
    }
    void memberSet([$dart$core.Object container, $dart$core.Object newValue]);
    meta$declaration$SetterDeclaration get setter;
}
abstract class meta$declaration$Variance {
}
class meta$declaration$invariant_ implements dart$$Basic, meta$declaration$Variance {
    meta$declaration$invariant_() {}
    $dart$core.String toString() => "Invariant";
}
final meta$declaration$invariant_ $package$meta$declaration$invariant = new meta$declaration$invariant_();

meta$declaration$invariant_ get meta$declaration$invariant => $package$meta$declaration$invariant;

class meta$declaration$covariant_ implements dart$$Basic, meta$declaration$Variance {
    meta$declaration$covariant_() {}
    $dart$core.String toString() => "Covariant";
}
final meta$declaration$covariant_ $package$meta$declaration$covariant = new meta$declaration$covariant_();

meta$declaration$covariant_ get meta$declaration$covariant => $package$meta$declaration$covariant;

class meta$declaration$contravariant_ implements dart$$Basic, meta$declaration$Variance {
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
    meta$model$CallableConstructor get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
}
abstract class meta$model$ClassModel implements meta$model$ClassOrInterface {
    meta$declaration$ClassDeclaration get declaration;
    meta$model$FunctionModel get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
    $dart$core.Object getDeclaredConstructor([$dart$core.String name]);
    Sequential getDeclaredCallableConstructors([Sequential annotationTypes]);
    Sequential getCallableConstructors([Sequential annotationTypes]);
    Sequential getDeclaredValueConstructors([Sequential annotationTypes]);
    Sequential getValueConstructors([Sequential annotationTypes]);
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
    Map get typeArgumentWithVariances;
    Sequential get typeArgumentWithVarianceList;
}
abstract class meta$model$Gettable {
    $dart$core.Object get();
    void set([$dart$core.Object newValue]);
    void setIfAssignable([$dart$core.Object newValue]);
}
class meta$model$IncompatibleTypeException  extends Exception {
    meta$model$IncompatibleTypeException([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
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
    meta$model$InvocationException([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
}
abstract class meta$model$Member implements meta$model$Qualified {
    meta$model$Type get declaringType;
}
abstract class meta$model$MemberClass implements meta$model$ClassModel, meta$model$Member {
    meta$model$Class bind([$dart$core.Object container]);
    meta$model$MemberClassCallableConstructor get defaultConstructor;
    $dart$core.Object getConstructor([$dart$core.String name]);
}
abstract class meta$model$MemberClassCallableConstructor implements meta$model$FunctionModel, meta$model$Qualified {
    meta$declaration$CallableConstructorDeclaration get declaration;
    meta$model$MemberClass get type;
    meta$model$ClassModel get container;
    meta$model$CallableConstructor bind([$dart$core.Object container]);
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
    meta$model$MutationException([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
}
class meta$model$nothingType_ implements dart$$Basic, meta$model$Type {
    meta$model$nothingType_() {}
    $dart$core.String toString() => "Nothing";
    $dart$core.bool typeOf([$dart$core.Object instance]) => false;
    $dart$core.bool exactly([meta$model$Type type]) => type == $package$meta$model$nothingType;
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
    meta$model$StorageException([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
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
    meta$model$TypeApplicationException([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
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

meta$model$ClassModel $package$meta$type([$dart$core.Object instance]) => $package$nothing as meta$model$ClassModel;

meta$model$ClassModel meta$type([$dart$core.Object instance]) => $package$meta$type(instance);

meta$model$Type $package$meta$typeLiteral() => $package$nothing as meta$model$Type;

meta$model$Type meta$typeLiteral() => $package$meta$typeLiteral();

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
                    if (!(!(min == min))) {
                        break;
                    }
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$2 = it.next();
                        if (val$2 is Finished) {
                            break;
                        }
                        val = val$2;
                    }
                    min = val;
                }
                while (true) {
                    $dart$core.Object val;
                    {
                        $dart$core.Object val$3 = it.next();
                        if (val$3 is Finished) {
                            break;
                        }
                        val = val$3;
                    }
                    if ((val as Comparable) < min) {
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

Callable $package$not([Callable p]) => new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean((([$dart$core.Object val]) => !$dartBool(p.f(val) as Boolean))($0)));

Callable not([Callable p]) => $package$not(p);

$dart$core.Object get $package$nothing {
    if (!false) {
        throw new AssertionError("Violated: false");
    }
}

$dart$core.Object get nothing => $package$nothing;

abstract class Number implements Numeric, Comparable {
    $dart$core.Object get magnitude;
    static $dart$core.Object $get$magnitude([final Number $this]) => $this.negative ? -$this : $this;
    $dart$core.int get sign;
    static $dart$core.int $get$sign([final Number $this]) => $this.positive ? 1 : $this.negative ? -1 : 0;
    $dart$core.bool get positive;
    $dart$core.bool get negative;
    $dart$core.Object get fractionalPart;
    $dart$core.Object get wholePart;
    $dart$core.Object timesInteger([$dart$core.int integer]);
    $dart$core.Object plusInteger([$dart$core.int integer]);
    $dart$core.Object powerOfInteger([$dart$core.int integer]);
    Comparison compare([$dart$core.Object other]);
    static Comparison $compare([final Number $this, $dart$core.Object other]) => (() {
        $dart$core.Object diff;
        {
            diff = $this - other;
        }
        return (diff as Number).positive ? $package$larger : (diff as Number).negative ? $package$smaller : $package$equal;
    })();
}
abstract class Numeric implements Invertible {
    $dart$core.Object operator *($dart$core.Object other);
    $dart$core.Object operator /($dart$core.Object other);
}
abstract class Obtainable implements Usable {
    void obtain();
    void release([Throwable error]);
}
class operatingSystem_ implements dart$$Basic {
    operatingSystem_() {
        fileSeparator = (($dart$core.String $lhs$) => null == $lhs$ ? "/" : $lhs$)($package$process.propertyValue("file.separator"));
        pathSeparator = (($dart$core.String $lhs$) => null == $lhs$ ? ":" : $lhs$)($package$process.propertyValue("path.separator"));
        version = "Unknown";
        name = (($dart$core.String $lhs$) => null == $lhs$ ? "Unknown" : $lhs$)($package$process.propertyValue("os.name"));
        newline = (($dart$core.String $lhs$) => null == $lhs$ ? "\n" : $lhs$)($package$process.propertyValue("line.separator"));
        string = ((("operating system [" + name) + " / ") + version) + "]";
    }
    $dart$core.String fileSeparator;
    $dart$core.String pathSeparator;
    $dart$core.String version;
    $dart$core.String name;
    $dart$core.String newline;
    $dart$core.String string;
    $dart$core.String toString() => string;
}
final operatingSystem_ $package$operatingSystem = new operatingSystem_();

operatingSystem_ get operatingSystem => $package$operatingSystem;

abstract class OptionalAnnotation implements ConstrainedAnnotation {
}
Callable $package$or([Callable p, Callable q]) => new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean((([$dart$core.Object val]) => $dartBool(p.f(val) as Boolean) || $dartBool(q.f(val) as Boolean))($0)));

Callable or([Callable p, Callable q]) => $package$or(p, q);

abstract class Ordinal {
    $dart$core.Object get successor;
    $dart$core.Object get predecessor;
}
class OverflowException  extends Exception {
    OverflowException([$dart$core.Object message = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(message, $package$dart$default)) {
            message = "Numeric overflow";
        }
        return [message];
    })());
    OverflowException.$s([$dart$core.List a]) : this.$w(a[0]);
    OverflowException.$w([$dart$core.String message]) : super(message) {
        this._message = message;
    }
    $dart$core.String _message;
}
class mapPairs$iterable_$iterator$iterator_ implements dart$$Basic, Iterator {
    mapPairs$iterable_ $outer$ceylon$language$mapPairs$iterable_;
    mapPairs$iterable_$iterator$iterator_([mapPairs$iterable_ $outer$ceylon$language$mapPairs$iterable_]) {
        this.$outer$ceylon$language$mapPairs$iterable_ = $outer$ceylon$language$mapPairs$iterable_;
        _firstIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$firstIterable.iterator();
        _secondIter = $outer$ceylon$language$mapPairs$iterable_.$capture$mapPairs$secondIterable.iterator();
    }
    Iterator _firstIter;
    Iterator _secondIter;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object first$1 = _firstIter.next();
                if (!(first$1 is Finished)) {
                    $dart$core.Object first;
                    first = first$1;
                    {
                        $dart$core.Object second$2 = _secondIter.next();
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
class mapPairs$iterable_ implements dart$$Basic, Iterable {
    Iterable $capture$mapPairs$firstIterable;
    Iterable $capture$mapPairs$secondIterable;
    Callable $capture$mapPairs$collecting;
    mapPairs$iterable_([Iterable $capture$mapPairs$firstIterable, Iterable $capture$mapPairs$secondIterable, Callable $capture$mapPairs$collecting]) {
        this.$capture$mapPairs$firstIterable = $capture$mapPairs$firstIterable;
        this.$capture$mapPairs$secondIterable = $capture$mapPairs$secondIterable;
        this.$capture$mapPairs$collecting = $capture$mapPairs$collecting;
    }
    Iterator iterator() {
        final mapPairs$iterable_$iterator$iterator_ iterator$s1 = new mapPairs$iterable_$iterator$iterator_(this);
        return iterator$s1;
    }
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
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
        if ($dartBool(selecting.f(first, second) as Boolean)) {
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
        if (!$dartBool(selecting.f(first, second) as Boolean)) {
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
        if ($dartBool(selecting.f(first, second) as Boolean)) {
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
        if (switch$0 == "true") {
            return true;
        } else if (switch$0 == "false") {
            return false;
        } else {
            return null;
        }
    }
}

$dart$core.bool parseBoolean([$dart$core.String string]) => $package$parseBoolean(string);

class ParseFloatState implements dart$$Basic {
    void _$init$ParseFloatState([$dart$core.int $bitmap]) {
        if (0 != ($bitmap & 1024)) {}
        if (0 != ($bitmap & 512)) {}
        if (0 != ($bitmap & 256)) {}
        if (0 != ($bitmap & 128)) {}
        if (0 != ($bitmap & 64)) {}
        if (0 != ($bitmap & 32)) {}
        if (0 != ($bitmap & 16)) {}
        if (0 != ($bitmap & 8)) {}
        if (0 != ($bitmap & 4)) {}
        if (0 != ($bitmap & 2)) {}
        if (0 != ($bitmap & 1)) {}
    }
    ParseFloatState.start() : this.start$d(1024);
    ParseFloatState.start$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 1024);
    }
    ParseFloatState.afterPlusMinus() : this.afterPlusMinus$d(512);
    ParseFloatState.afterPlusMinus$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 512);
    }
    ParseFloatState.digitsBeforeDecimal() : this.digitsBeforeDecimal$d(256);
    ParseFloatState.digitsBeforeDecimal$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 256);
    }
    ParseFloatState.afterJustDecimal() : this.afterJustDecimal$d(128);
    ParseFloatState.afterJustDecimal$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 128);
    }
    ParseFloatState.afterDecimal() : this.afterDecimal$d(64);
    ParseFloatState.afterDecimal$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 64);
    }
    ParseFloatState.digitsAfterDecimal() : this.digitsAfterDecimal$d(32);
    ParseFloatState.digitsAfterDecimal$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 32);
    }
    ParseFloatState.afterE() : this.afterE$d(16);
    ParseFloatState.afterE$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 16);
    }
    ParseFloatState.exponentDigits() : this.exponentDigits$d(8);
    ParseFloatState.exponentDigits$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 8);
    }
    ParseFloatState.afterEPlusMinus() : this.afterEPlusMinus$d(4);
    ParseFloatState.afterEPlusMinus$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 4);
    }
    ParseFloatState.afterSuffix() : this.afterSuffix$d(2);
    ParseFloatState.afterSuffix$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 2);
    }
    ParseFloatState.invalid() : this.invalid$d(1);
    ParseFloatState.invalid$d([$dart$core.int $bitmap]) {
        _$init$ParseFloatState($bitmap | 1);
    }
}
ParseFloatState _$s$ParseFloatState$start;

ParseFloatState get $package$$new$ParseFloatState$start => _$s$ParseFloatState$start != null ? _$s$ParseFloatState$start : _$s$ParseFloatState$start = new ParseFloatState.start();

ParseFloatState _$s$ParseFloatState$afterPlusMinus;

ParseFloatState get $package$$new$ParseFloatState$afterPlusMinus => _$s$ParseFloatState$afterPlusMinus != null ? _$s$ParseFloatState$afterPlusMinus : _$s$ParseFloatState$afterPlusMinus = new ParseFloatState.afterPlusMinus();

ParseFloatState _$s$ParseFloatState$digitsBeforeDecimal;

ParseFloatState get $package$$new$ParseFloatState$digitsBeforeDecimal => _$s$ParseFloatState$digitsBeforeDecimal != null ? _$s$ParseFloatState$digitsBeforeDecimal : _$s$ParseFloatState$digitsBeforeDecimal = new ParseFloatState.digitsBeforeDecimal();

ParseFloatState _$s$ParseFloatState$afterJustDecimal;

ParseFloatState get $package$$new$ParseFloatState$afterJustDecimal => _$s$ParseFloatState$afterJustDecimal != null ? _$s$ParseFloatState$afterJustDecimal : _$s$ParseFloatState$afterJustDecimal = new ParseFloatState.afterJustDecimal();

ParseFloatState _$s$ParseFloatState$afterDecimal;

ParseFloatState get $package$$new$ParseFloatState$afterDecimal => _$s$ParseFloatState$afterDecimal != null ? _$s$ParseFloatState$afterDecimal : _$s$ParseFloatState$afterDecimal = new ParseFloatState.afterDecimal();

ParseFloatState _$s$ParseFloatState$digitsAfterDecimal;

ParseFloatState get $package$$new$ParseFloatState$digitsAfterDecimal => _$s$ParseFloatState$digitsAfterDecimal != null ? _$s$ParseFloatState$digitsAfterDecimal : _$s$ParseFloatState$digitsAfterDecimal = new ParseFloatState.digitsAfterDecimal();

ParseFloatState _$s$ParseFloatState$afterE;

ParseFloatState get $package$$new$ParseFloatState$afterE => _$s$ParseFloatState$afterE != null ? _$s$ParseFloatState$afterE : _$s$ParseFloatState$afterE = new ParseFloatState.afterE();

ParseFloatState _$s$ParseFloatState$exponentDigits;

ParseFloatState get $package$$new$ParseFloatState$exponentDigits => _$s$ParseFloatState$exponentDigits != null ? _$s$ParseFloatState$exponentDigits : _$s$ParseFloatState$exponentDigits = new ParseFloatState.exponentDigits();

ParseFloatState _$s$ParseFloatState$afterEPlusMinus;

ParseFloatState get $package$$new$ParseFloatState$afterEPlusMinus => _$s$ParseFloatState$afterEPlusMinus != null ? _$s$ParseFloatState$afterEPlusMinus : _$s$ParseFloatState$afterEPlusMinus = new ParseFloatState.afterEPlusMinus();

ParseFloatState _$s$ParseFloatState$afterSuffix;

ParseFloatState get $package$$new$ParseFloatState$afterSuffix => _$s$ParseFloatState$afterSuffix != null ? _$s$ParseFloatState$afterSuffix : _$s$ParseFloatState$afterSuffix = new ParseFloatState.afterSuffix();

ParseFloatState _$s$ParseFloatState$invalid;

ParseFloatState get $package$$new$ParseFloatState$invalid => _$s$ParseFloatState$invalid != null ? _$s$ParseFloatState$invalid : _$s$ParseFloatState$invalid = new ParseFloatState.invalid();

ParseFloatState get $new$ParseFloatState$start => $package$$new$ParseFloatState$start;

ParseFloatState get $new$ParseFloatState$afterPlusMinus => $package$$new$ParseFloatState$afterPlusMinus;

ParseFloatState get $new$ParseFloatState$digitsBeforeDecimal => $package$$new$ParseFloatState$digitsBeforeDecimal;

ParseFloatState get $new$ParseFloatState$afterJustDecimal => $package$$new$ParseFloatState$afterJustDecimal;

ParseFloatState get $new$ParseFloatState$afterDecimal => $package$$new$ParseFloatState$afterDecimal;

ParseFloatState get $new$ParseFloatState$digitsAfterDecimal => $package$$new$ParseFloatState$digitsAfterDecimal;

ParseFloatState get $new$ParseFloatState$afterE => $package$$new$ParseFloatState$afterE;

ParseFloatState get $new$ParseFloatState$exponentDigits => $package$$new$ParseFloatState$exponentDigits;

ParseFloatState get $new$ParseFloatState$afterEPlusMinus => $package$$new$ParseFloatState$afterEPlusMinus;

ParseFloatState get $new$ParseFloatState$afterSuffix => $package$$new$ParseFloatState$afterSuffix;

ParseFloatState get $new$ParseFloatState$invalid => $package$$new$ParseFloatState$invalid;

$dart$core.double $package$parseFloat([$dart$core.String string]) {
    ParseFloatState state = $package$$new$ParseFloatState$start;
    $dart$core.int size = 0;
    $dart$core.int suffixExponent = null;
    {
        $dart$core.Object element$1;
        Iterator iterator$0 = $ceylonString(string).iterator();
        while ((element$1 = iterator$0.next()) is !Finished) {
            Character c;
            {
                c = element$1 as Character;
            }
            size = $dartInt($ceylonInteger(size).successor);
            state = (() {
                ParseFloatState switch$2 = state;
                if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$start)) {
                    return (c == (new Character.$fromInt(43))) || (c == (new Character.$fromInt(45))) ? $package$$new$ParseFloatState$afterPlusMinus : (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$digitsBeforeDecimal : c == (new Character.$fromInt(46)) ? $package$$new$ParseFloatState$afterJustDecimal : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$afterPlusMinus)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$digitsBeforeDecimal : c == (new Character.$fromInt(46)) ? $package$$new$ParseFloatState$afterJustDecimal : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$digitsBeforeDecimal)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$digitsBeforeDecimal : c == (new Character.$fromInt(46)) ? $package$$new$ParseFloatState$afterDecimal : (c == (new Character.$fromInt(101))) || (c == (new Character.$fromInt(69))) ? $package$$new$ParseFloatState$afterE : $ceylonString("PTGMkmunpf").contains(c) ? $package$$new$ParseFloatState$afterSuffix : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$afterJustDecimal)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$digitsAfterDecimal : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$digitsAfterDecimal) || $dart$core.identical(switch$2, $package$$new$ParseFloatState$afterDecimal)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$digitsAfterDecimal : (c == (new Character.$fromInt(101))) || (c == (new Character.$fromInt(69))) ? $package$$new$ParseFloatState$afterE : $ceylonString("PTGMkmunpf").contains(c) ? $package$$new$ParseFloatState$afterSuffix : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$afterE)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$exponentDigits : (c == (new Character.$fromInt(43))) || (c == (new Character.$fromInt(45))) ? $package$$new$ParseFloatState$afterEPlusMinus : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$exponentDigits) || $dart$core.identical(switch$2, $package$$new$ParseFloatState$afterEPlusMinus)) {
                    return (c >= (new Character.$fromInt(48))) && (c <= (new Character.$fromInt(57))) ? $package$$new$ParseFloatState$exponentDigits : $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$afterSuffix)) {
                    return $package$$new$ParseFloatState$invalid;
                } else if ($dart$core.identical(switch$2, $package$$new$ParseFloatState$invalid)) {
                    return $package$$new$ParseFloatState$invalid;
                } else {
                    throw new AssertionError("Supposedly exhaustive switch was not exhaustive");
                }
            })();
            if (state == $package$$new$ParseFloatState$afterSuffix) {
                suffixExponent = $package$parseSuffix(c);
            }
            if (state == $package$$new$ParseFloatState$invalid) {
                return null;
            }
        }
    }
    if (!(new Tuple.$withList([$package$$new$ParseFloatState$digitsBeforeDecimal, $package$$new$ParseFloatState$afterDecimal, $package$$new$ParseFloatState$digitsAfterDecimal, $package$$new$ParseFloatState$exponentDigits, $package$$new$ParseFloatState$afterSuffix])).contains(state)) {
        return null;
    }
    {
        $dart$core.bool doElse$3 = true;
        {
            $dart$core.int tmp$4 = suffixExponent;
            if (!(null == tmp$4)) {
                $dart$core.int exponent;
                exponent = tmp$4;
                doElse$3 = false;
                return $package$nativeParseFloat(((("" + $dartString($ceylonString(string).spanTo($ceylonInteger(size - 2)))) + "E") + exponent.toString()) + "");
            }
        }
        if (doElse$3) {
            return $package$nativeParseFloat(string);
        }
    }
}

$dart$core.double parseFloat([$dart$core.String string]) => $package$parseFloat(string);

$dart$core.int $package$parseSuffix([Character suffix]) {{
        Character switch$5 = suffix;
        if (switch$5 == (new Character.$fromInt(80))) {
            return 15;
        } else if (switch$5 == (new Character.$fromInt(84))) {
            return 12;
        } else if (switch$5 == (new Character.$fromInt(71))) {
            return 9;
        } else if (switch$5 == (new Character.$fromInt(77))) {
            return 6;
        } else if (switch$5 == (new Character.$fromInt(107))) {
            return 3;
        } else if (switch$5 == (new Character.$fromInt(109))) {
            return -3;
        } else if (switch$5 == (new Character.$fromInt(117))) {
            return -6;
        } else if (switch$5 == (new Character.$fromInt(110))) {
            return -9;
        } else if (switch$5 == (new Character.$fromInt(112))) {
            return -12;
        } else if (switch$5 == (new Character.$fromInt(102))) {
            return -15;
        } else {
            if (!false) {
                throw new AssertionError("Violated: false");
            }
        }
    }
}

$dart$core.int parseSuffix([Character suffix]) => $package$parseSuffix(suffix);

$dart$core.double $package$nativeParseFloat([$dart$core.String string]) => $dart$core.double.parse(string);

$dart$core.double nativeParseFloat([$dart$core.String string]) => $package$nativeParseFloat(string);

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
    $dart$core.int start;
    $dart$core.int max = $package$runtime.minIntegerValue ~/ (radix as $dart$core.int);
    $dart$core.bool negative;
    {
        $dart$core.bool doElse$0 = true;
        {
            Character tmp$1 = $ceylonString(string).first;
            if (!(null == tmp$1)) {
                Character char;
                char = tmp$1;
                doElse$0 = false;
                if (char == (new Character.$fromInt(45))) {
                    negative = true;
                    start = 1;
                } else if (char == (new Character.$fromInt(43))) {
                    negative = false;
                    start = 1;
                } else {
                    negative = false;
                    start = 0;
                }
            }
        }
        if (doElse$0) {
            return null;
        }
    }
    $dart$core.int limit = negative ? $package$runtime.minIntegerValue : -$package$runtime.maxIntegerValue;
    $dart$core.int length = $ceylonString(string).size;
    $dart$core.int result = 0;
    $dart$core.int digitIndex = 0;
    $dart$core.int index = start;
    while (index < length) {
        Character ch;
        {
            Character tmp$2 = $ceylonString(string).getFromFirst(index);
            if (null == tmp$2) {
                throw new AssertionError("Violated: exists ch = string.getFromFirst(index)");
            }
            ch = tmp$2;
        }
        if ((((index + 1) == length) && ((radix as $dart$core.int) == 10)) && $ceylonString("kMGTP").contains(ch)) {{
                $dart$core.bool doElse$3 = true;
                {
                    $dart$core.int tmp$4 = $package$parseIntegerExponent(ch);
                    if (!(null == tmp$4)) {
                        $dart$core.int exp;
                        exp = tmp$4;
                        doElse$3 = false;
                        $dart$core.int magnitude = $dartInt($ceylonInteger(10).power($ceylonInteger(exp)));
                        if ((limit ~/ magnitude) < result) {
                            result = result * magnitude;
                            break;
                        } else {
                            return null;
                        }
                    }
                }
                if (doElse$3) {
                    return null;
                }
            }
        } else {
            $dart$core.bool doElse$5 = true;
            {
                $dart$core.int tmp$6 = $package$parseDigit(ch, radix as $dart$core.int);
                if (!(null == tmp$6)) {
                    $dart$core.int digit;
                    digit = tmp$6;
                    doElse$5 = false;
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
            if (doElse$5) {
                return null;
            }
        }
        index = $dartInt($ceylonInteger(index).successor);
        digitIndex = $dartInt($ceylonInteger(digitIndex).successor);
    }
    if (digitIndex == 0) {
        return null;
    } else {
        return negative ? result : -result;
    }
}

$dart$core.int parseInteger([$dart$core.String string, $dart$core.Object radix = $package$dart$default]) => $package$parseInteger(string, radix);

$dart$core.int $package$parseIntegerExponent([Character char]) {{
        Character switch$7 = char;
        if (switch$7 == (new Character.$fromInt(80))) {
            return 15;
        } else if (switch$7 == (new Character.$fromInt(84))) {
            return 12;
        } else if (switch$7 == (new Character.$fromInt(71))) {
            return 9;
        } else if (switch$7 == (new Character.$fromInt(77))) {
            return 6;
        } else if (switch$7 == (new Character.$fromInt(107))) {
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

$dart$core.Object $package$plus([$dart$core.Object x, $dart$core.Object y]) => (x as Summable) + y;

$dart$core.Object plus([$dart$core.Object x, $dart$core.Object y]) => $package$plus(x, y);

void $package$print([$dart$core.Object val]) {
    $package$process.writeLine($package$stringify(val));
}

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

$dart$core.String $package$stringify([$dart$core.Object val]) => (($dart$core.String $lhs$) => null == $lhs$ ? "<null>" : $lhs$)((($dart$core.Object $r) => null == $r ? null : $r.toString())(val));

$dart$core.String stringify([$dart$core.Object val]) => $package$stringify(val);

Sequential $package$processArguments = $package$empty;

Sequential get processArguments => $package$processArguments;

set processArguments(Sequential value) => $package$processArguments = value;

StringBuilder $package$outputBuffer = new StringBuilder();

StringBuilder get outputBuffer => $package$outputBuffer;

class process_ implements dart$$Basic {
    process_() {}
    Sequential get arguments => $package$processArguments;
    $dart$core.bool namedArgumentPresent([$dart$core.String name]) => false;
    $dart$core.String namedArgumentValue([$dart$core.String name]) => null;
    $dart$core.String propertyValue([$dart$core.String name]) => $dartString($ceylon$dart$runtime$core.runtime.platformProperties.get($ceylonString(name)) as String);
    $dart$core.String environmentVariableValue([$dart$core.String name]) => $ceylon$dart$runtime$core.runtime.environmentVariableValue(name);
    void write([$dart$core.String string]) {
        $ceylon$dart$runtime$core.runtime.write(string);
    }
    void writeLine([$dart$core.Object line = $package$dart$default]) {
        if ($dart$core.identical(line, $package$dart$default)) {
            line = "";
        }
        $ceylon$dart$runtime$core.runtime.writeLine(line as $dart$core.String);
    }
    void flush() {
        $ceylon$dart$runtime$core.runtime.flush();
    }
    void writeError([$dart$core.String string]) {
        $ceylon$dart$runtime$core.runtime.writeError(string);
    }
    void writeErrorLine([$dart$core.Object line = $package$dart$default]) {
        if ($dart$core.identical(line, $package$dart$default)) {
            line = "";
        }
        $ceylon$dart$runtime$core.runtime.writeErrorLine(line as $dart$core.String);
    }
    void flushError() {
        $ceylon$dart$runtime$core.runtime.flushError();
    }
    $dart$core.String readLine() => $ceylon$dart$runtime$core.runtime.readLine();
    $dart$core.Object exit([$dart$core.int code]) => $ceylon$dart$runtime$core.runtime.exit(code);
    $dart$core.String toString() => "process";
}
final process_ $package$process = new process_();

process_ get process => $package$process;

$dart$core.Object $package$product([Iterable values]) {
    Iterator it = values.iterator();
    $dart$core.Object first;
    {
        $dart$core.Object first$0 = it.next();
        if (first$0 is Finished) {
            throw new AssertionError("Violated: !is Finished first = it.next()");
        }
        first = first$0;
    }
    $dart$core.Object product = first;
    while (true) {
        $dart$core.Object val;
        {
            $dart$core.Object val$1 = it.next();
            if (val$1 is Finished) {
                break;
            }
            val = val$1;
        }
        product = (product as Numeric) * val;
    }
    return product;
}

$dart$core.Object product([Iterable values]) => $package$product(values);

abstract class Range implements dart$$Object, Sequence {
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
    Range shifted([$dart$core.int shift]);
    $dart$core.bool get increasing;
    $dart$core.bool get decreasing;
    Range get coalesced => this;
    Range get distinct => this;
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromFirst([$dart$core.int index]) => Iterable.$getFromFirst(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
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
        $dart$core.int pos = $ceylonString($this.uri).lastOccurrence(new Character.$fromInt(47));
        if (!(null == pos)) {
            return $dartString($ceylonString($this.uri).spanFrom($ceylonInteger(pos + 1)));
        }
        return $this.uri;
    }
    $dart$core.int get size;
    $dart$core.String get uri;
    $dart$core.String textContent([$dart$core.Object encoding = $package$dart$default]);
    static $dart$core.Object $textContent$encoding(final Resource $this) => "UTF-8";
    $dart$core.String toString();
    static $dart$core.String $get$string([final Resource $this]) => ((("" + $package$className($this)) + "[") + $this.uri) + "]";
}
class runtime_ implements dart$$Basic {
    runtime_() {
        name = "DartVM";
        integerSize = 53;
        integerAddressableSize = 32;
        maxIntegerValue = $dartInt($ceylonInteger(2).power($ceylonInteger(53))) - 1;
        minIntegerValue = -($dartInt($ceylonInteger(2).power($ceylonInteger(53))) - 1);
        maxArraySize = $dartInt($ceylonInteger(2).power($ceylonInteger(63))) - 1;
        maxFloatValue = 1.7976931348623157E308;
        minFloatValue = $dartDouble((new dart$Callable(() {
            $dart$core.double x = 1.0;
            while (!((x / 2.0) == 0.0)) {
                x = x / 2.0;
            }
            return $ceylonFloat(x);
        })).f() as Float);
        epsilon = $dartDouble($ceylonFloat(2.0).power($ceylonFloat((-52).toDouble())));
        maxExactIntegralFloat = $dartInt($ceylonInteger(2).power($ceylonInteger(53))) - 1;
    }
    $dart$core.String name;
    $dart$core.String get version => (($dart$core.String $lhs$) => null == $lhs$ ? "Unknown" : $lhs$)($package$process.propertyValue("platform.version"));
    $dart$core.int integerSize;
    $dart$core.int integerAddressableSize;
    $dart$core.int maxIntegerValue;
    $dart$core.int minIntegerValue;
    $dart$core.int maxArraySize;
    $dart$core.double maxFloatValue;
    $dart$core.double minFloatValue;
    $dart$core.double epsilon;
    $dart$core.int maxExactIntegralFloat;
}
final runtime_ $package$runtime = new runtime_();

runtime_ get runtime => $package$runtime;

abstract class Scalable {
    $dart$core.Object scale([$dart$core.Object scalar]);
}
class SearchableList$occurrences$$anonymous$0_$$anonymous$1_ implements dart$$Basic, Iterator {
    SearchableList$occurrences$$anonymous$0_ $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_;
    SearchableList$occurrences$$anonymous$0_$$anonymous$1_([SearchableList$occurrences$$anonymous$0_ $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_]) {
        this.$outer$ceylon$language$SearchableList$occurrences$$anonymous$0_ = $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_;
        _index = $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_.$capture$SearchableList$occurrences$from as $dart$core.int;
    }
    $dart$core.int _index;
    $dart$core.Object next() {
        while (_index < $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_._max) {
            if ($outer$ceylon$language$SearchableList$occurrences$$anonymous$0_.$outer$ceylon$language$SearchableList.occursAt(_index, $outer$ceylon$language$SearchableList$occurrences$$anonymous$0_.$capture$SearchableList$occurrences$element)) {
                return (() {
                    $dart$core.Object tmp$1 = $ceylonInteger(_index);
                    $ceylonInteger(_index = $dartInt($ceylonInteger(_index).successor));
                    return tmp$1;
                })();
            } else {
                _index = $dartInt($ceylonInteger(_index).successor);
            }
        }
        return $package$finished;
    }
}
class SearchableList$occurrences$$anonymous$0_ implements dart$$Basic, Iterable {
    SearchableList $outer$ceylon$language$SearchableList;
    $dart$core.Object $capture$SearchableList$occurrences$from;
    $dart$core.Object $capture$SearchableList$occurrences$length;
    $dart$core.Object $capture$SearchableList$occurrences$element;
    SearchableList$occurrences$$anonymous$0_([SearchableList $outer$ceylon$language$SearchableList, $dart$core.Object $capture$SearchableList$occurrences$from, $dart$core.Object $capture$SearchableList$occurrences$length, $dart$core.Object $capture$SearchableList$occurrences$element]) {
        this.$outer$ceylon$language$SearchableList = $outer$ceylon$language$SearchableList;
        this.$capture$SearchableList$occurrences$from = $capture$SearchableList$occurrences$from;
        this.$capture$SearchableList$occurrences$length = $capture$SearchableList$occurrences$length;
        this.$capture$SearchableList$occurrences$element = $capture$SearchableList$occurrences$element;
        _len = $outer$ceylon$language$SearchableList.size;
        _max = (($capture$SearchableList$occurrences$from as $dart$core.int) + ($capture$SearchableList$occurrences$length as $dart$core.int)) > _len ? _len : ($capture$SearchableList$occurrences$from as $dart$core.int) + ($capture$SearchableList$occurrences$length as $dart$core.int);
    }
    $dart$core.int _len;
    $dart$core.int _max;
    Iterator iterator() => new SearchableList$occurrences$$anonymous$0_$$anonymous$1_(this);
    $dart$core.int get size {
        $dart$core.int size$s1 = 0;
        {
            $dart$core.Object element$3;
            Iterator iterator$2 = ($package$measure($ceylonInteger($capture$SearchableList$occurrences$from as $dart$core.int), _max - ($capture$SearchableList$occurrences$from as $dart$core.int)) as List).iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                Integer index;
                {
                    index = element$3 as Integer;
                }
                if ($outer$ceylon$language$SearchableList.occursAt($dartInt(index), $capture$SearchableList$occurrences$element)) {
                    size$s1 = $dartInt($ceylonInteger(size$s1).successor);
                }
            }
        }
        return size$s1;
    }
    $dart$core.bool get empty => $outer$ceylon$language$SearchableList.occurs($capture$SearchableList$occurrences$element, $capture$SearchableList$occurrences$from, $capture$SearchableList$occurrences$length);
    Integer get first => $ceylonInteger($outer$ceylon$language$SearchableList.firstOccurrence($capture$SearchableList$occurrences$element, $capture$SearchableList$occurrences$from, $capture$SearchableList$occurrences$length));
    Integer get last => $ceylonInteger($outer$ceylon$language$SearchableList.lastOccurrence($capture$SearchableList$occurrences$element, $capture$SearchableList$occurrences$from, $capture$SearchableList$occurrences$length));
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class SearchableList$inclusions$$anonymous$2_$$anonymous$3_ implements dart$$Basic, Iterator {
    SearchableList$inclusions$$anonymous$2_ $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_;
    SearchableList$inclusions$$anonymous$2_$$anonymous$3_([SearchableList$inclusions$$anonymous$2_ $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_]) {
        this.$outer$ceylon$language$SearchableList$inclusions$$anonymous$2_ = $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_;
        _max = ($outer$ceylon$language$SearchableList$inclusions$$anonymous$2_._len + 1) - $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_.$capture$SearchableList$inclusions$sublist.size;
        _index = $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_.$capture$SearchableList$inclusions$from as $dart$core.int;
    }
    $dart$core.int _max;
    $dart$core.int _index;
    $dart$core.Object next() {
        while (_index < _max) {
            if ($outer$ceylon$language$SearchableList$inclusions$$anonymous$2_.$outer$ceylon$language$SearchableList.includesAt(_index, $outer$ceylon$language$SearchableList$inclusions$$anonymous$2_.$capture$SearchableList$inclusions$sublist)) {
                return (() {
                    $dart$core.Object tmp$11 = $ceylonInteger(_index);
                    $ceylonInteger(_index = $dartInt($ceylonInteger(_index).successor));
                    return tmp$11;
                })();
            } else {
                _index = $dartInt($ceylonInteger(_index).successor);
            }
        }
        return $package$finished;
    }
}
class SearchableList$inclusions$$anonymous$2_ implements dart$$Basic, Iterable {
    SearchableList $outer$ceylon$language$SearchableList;
    List $capture$SearchableList$inclusions$sublist;
    $dart$core.Object $capture$SearchableList$inclusions$from;
    SearchableList$inclusions$$anonymous$2_([SearchableList $outer$ceylon$language$SearchableList, List $capture$SearchableList$inclusions$sublist, $dart$core.Object $capture$SearchableList$inclusions$from]) {
        this.$outer$ceylon$language$SearchableList = $outer$ceylon$language$SearchableList;
        this.$capture$SearchableList$inclusions$sublist = $capture$SearchableList$inclusions$sublist;
        this.$capture$SearchableList$inclusions$from = $capture$SearchableList$inclusions$from;
        _len = $outer$ceylon$language$SearchableList.size;
    }
    $dart$core.int _len;
    Iterator iterator() => new SearchableList$inclusions$$anonymous$2_$$anonymous$3_(this);
    $dart$core.int get size {
        $dart$core.int size$s1 = 0;
        {
            $dart$core.Object element$13;
            Iterator iterator$12 = ($package$measure($ceylonInteger($capture$SearchableList$inclusions$from as $dart$core.int), ((_len - ($capture$SearchableList$inclusions$from as $dart$core.int)) + 1) - $capture$SearchableList$inclusions$sublist.size) as List).iterator();
            while ((element$13 = iterator$12.next()) is !Finished) {
                Integer index;
                {
                    index = element$13 as Integer;
                }
                if ($outer$ceylon$language$SearchableList.includesAt($dartInt(index), $capture$SearchableList$inclusions$sublist)) {
                    size$s1 = $dartInt($ceylonInteger(size$s1).successor);
                }
            }
        }
        return size$s1;
    }
    $dart$core.bool get empty => $outer$ceylon$language$SearchableList.includes($capture$SearchableList$inclusions$sublist, $capture$SearchableList$inclusions$from);
    Integer get first => $ceylonInteger($outer$ceylon$language$SearchableList.firstInclusion($capture$SearchableList$inclusions$sublist, $capture$SearchableList$inclusions$from));
    Integer get last => $ceylonInteger($outer$ceylon$language$SearchableList.lastInclusion($capture$SearchableList$inclusions$sublist, $capture$SearchableList$inclusions$from));
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
abstract class SearchableList implements List {
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]);
    static $dart$core.bool $occursAt([final SearchableList $this, $dart$core.int index, $dart$core.Object element]) => (() {
        $dart$core.Object elem;
        {
            elem = $this.getFromFirst(index);
        }
        return (() {
            $dart$core.bool doElse$0 = true;
            if (!(null == element)) {
                if (!(null == elem)) {
                    doElse$0 = false;
                    return elem == element;
                }
            }
            if (doElse$0) {
                return (!(null == element)) == (!(null == elem));
            }
        })();
    })();
    Iterable occurrences([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static Iterable $occurrences([final SearchableList $this, $dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$occurrences$from($this, element);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$occurrences$length($this, element, from);
        }
        return new SearchableList$occurrences$$anonymous$0_($this, from, length, element);
    }
    static $dart$core.Object $occurrences$from(final SearchableList $this, $dart$core.Object element) => 0;
    static $dart$core.Object $occurrences$length(final SearchableList $this, $dart$core.Object element, $dart$core.Object from) => $this.size - (from as $dart$core.int);
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static $dart$core.bool $occurs([final SearchableList $this, $dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$occurs$from($this, element);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$occurs$length($this, element, from);
        }
        return !(null == $this.firstOccurrence(element, from, length));
    }
    static $dart$core.Object $occurs$from(final SearchableList $this, $dart$core.Object element) => 0;
    static $dart$core.Object $occurs$length(final SearchableList $this, $dart$core.Object element, $dart$core.Object from) => $this.size - (from as $dart$core.int);
    $dart$core.int firstOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static $dart$core.int $firstOccurrence([final SearchableList $this, $dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$firstOccurrence$from($this, element);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$firstOccurrence$length($this, element, from);
        }
        {
            $dart$core.Object element$5;
            Iterator iterator$4 = ($package$measure($ceylonInteger(from as $dart$core.int), length as $dart$core.int) as List).iterator();
            while ((element$5 = iterator$4.next()) is !Finished) {
                Integer index;
                {
                    index = element$5 as Integer;
                }
                if ($this.occursAt($dartInt(index), element)) {
                    return $dartInt(index);
                }
            }
            {
                return null;
            }
        }
    }
    static $dart$core.Object $firstOccurrence$from(final SearchableList $this, $dart$core.Object element) => 0;
    static $dart$core.Object $firstOccurrence$length(final SearchableList $this, $dart$core.Object element, $dart$core.Object from) => $this.size - (from as $dart$core.int);
    $dart$core.int lastOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]);
    static $dart$core.int $lastOccurrence([final SearchableList $this, $dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$lastOccurrence$from($this, element);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$lastOccurrence$length($this, element, from);
        }
        {
            $dart$core.Object element$7;
            Iterator iterator$6 = ($package$measure($ceylonInteger(($this.size - (length as $dart$core.int)) - (from as $dart$core.int)), length as $dart$core.int) as Sequential).reversed.iterator();
            while ((element$7 = iterator$6.next()) is !Finished) {
                Integer index;
                {
                    index = element$7 as Integer;
                }
                if ($this.occursAt($dartInt(index), element)) {
                    return $dartInt(index);
                }
            }
            {
                return null;
            }
        }
    }
    static $dart$core.Object $lastOccurrence$from(final SearchableList $this, $dart$core.Object element) => 0;
    static $dart$core.Object $lastOccurrence$length(final SearchableList $this, $dart$core.Object element, $dart$core.Object from) => $this.size - (from as $dart$core.int);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]);
    static $dart$core.bool $includesAt([final SearchableList $this, $dart$core.int index, List sublist]) {
        if ((index >= 0) && (index <= ($this.size - sublist.size))) {
            $dart$core.int i = index;
            {
                $dart$core.Object element$9;
                Iterator iterator$8 = sublist.iterator();
                while ((element$9 = iterator$8.next()) is !Finished) {
                    $dart$core.Object element;
                    {
                        element = element$9;
                    }
                    {
                        $dart$core.bool doElse$10 = true;
                        if (!(null == element)) {
                            doElse$10 = false;
                            if (!$this.occursAt(i, element)) {
                                return false;
                            }
                        }
                        if (doElse$10) {
                            if (!true) {
                                throw new AssertionError("Violated: is Element null");
                            }
                            if (!$this.occursAt(i, null)) {
                                return false;
                            }
                        }
                    }
                    i = $dartInt($ceylonInteger(i).successor);
                }
                {
                    return true;
                }
            }
        } else {
            return false;
        }
    }
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]);
    static Iterable $inclusions([final SearchableList $this, List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$inclusions$from($this, sublist);
        }
        return new SearchableList$inclusions$$anonymous$2_($this, sublist, from);
    }
    static $dart$core.Object $inclusions$from(final SearchableList $this, List sublist) => 0;
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]);
    static $dart$core.bool $includes([final SearchableList $this, List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$includes$from($this, sublist);
        }
        return !(null == $this.firstInclusion(sublist, from));
    }
    static $dart$core.Object $includes$from(final SearchableList $this, List sublist) => 0;
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]);
    static $dart$core.int $firstInclusion([final SearchableList $this, List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$firstInclusion$from($this, sublist);
        }
        {
            $dart$core.Object element$15;
            Iterator iterator$14 = ($package$measure($ceylonInteger(from as $dart$core.int), (($this.size - (from as $dart$core.int)) + 1) - sublist.size) as List).iterator();
            while ((element$15 = iterator$14.next()) is !Finished) {
                Integer index;
                {
                    index = element$15 as Integer;
                }
                if ($this.includesAt($dartInt(index), sublist)) {
                    return $dartInt(index);
                }
            }
            {
                return null;
            }
        }
    }
    static $dart$core.Object $firstInclusion$from(final SearchableList $this, List sublist) => 0;
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]);
    static $dart$core.int $lastInclusion([final SearchableList $this, List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$lastInclusion$from($this, sublist);
        }
        {
            $dart$core.Object element$17;
            Iterator iterator$16 = ($package$measure($ceylonInteger(0), (($this.size - (from as $dart$core.int)) + 1) - sublist.size) as Sequential).reversed.iterator();
            while ((element$17 = iterator$16.next()) is !Finished) {
                Integer index;
                {
                    index = element$17 as Integer;
                }
                if ($this.includesAt($dartInt(index), sublist)) {
                    return $dartInt(index);
                }
            }
            {
                return null;
            }
        }
    }
    static $dart$core.Object $lastInclusion$from(final SearchableList $this, List sublist) => 0;
}
class Sequence$collect$list_ implements dart$$Object, List {
    Sequence $outer$ceylon$language$Sequence;
    Callable $capture$Sequence$collect$collecting;
    Sequence$collect$list_([Sequence $outer$ceylon$language$Sequence, Callable $capture$Sequence$collect$collecting]) {
        this.$outer$ceylon$language$Sequence = $outer$ceylon$language$Sequence;
        this.$capture$Sequence$collect$collecting = $capture$Sequence$collect$collecting;
        size = $outer$ceylon$language$Sequence.size;
    }
    $dart$core.int get lastIndex => $outer$ceylon$language$Sequence.lastIndex;
    $dart$core.int size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => (index >= 0) && (index < size) ? $capture$Sequence$collect$collecting.f(Sequence.$_getElement$1($outer$ceylon$language$Sequence, index)) : null;
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
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
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
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Sequence$Reverse$$anonymous$0_ implements dart$$Basic, Iterator {
    Sequence$Reverse $outer$ceylon$language$Sequence$Reverse;
    Sequence $capture$$outerList;
    Sequence$Reverse$$anonymous$0_([Sequence$Reverse $outer$ceylon$language$Sequence$Reverse, Sequence $capture$$outerList]) {
        this.$outer$ceylon$language$Sequence$Reverse = $outer$ceylon$language$Sequence$Reverse;
        this.$capture$$outerList = $capture$$outerList;
        _index = $capture$$outerList.size - 1;
    }
    $dart$core.int _index;
    $dart$core.Object next() => _index < 0 ? $package$finished : Sequence.$_getElement$1($capture$$outerList, (() {
        $dart$core.int tmp$8 = _index;
        _index = $dartInt($ceylonInteger(_index).predecessor);
        return tmp$8;
    })());
    $dart$core.String toString() => ("" + $outer$ceylon$language$Sequence$Reverse.toString()) + ".iterator()";
}
class Sequence$Reverse implements dart$$Object, Sequence {
    Sequence $outer$ceylon$language$Sequence;
    Sequence$Reverse([Sequence $outer$ceylon$language$Sequence]) {
        this.$outer$ceylon$language$Sequence = $outer$ceylon$language$Sequence;
    }
    $dart$core.int get size => $outer$ceylon$language$Sequence.size;
    $dart$core.Object get first => $outer$ceylon$language$Sequence.last;
    $dart$core.Object get last => $outer$ceylon$language$Sequence.first;
    Sequential get rest => size == 1 ? $package$empty : $outer$ceylon$language$Sequence.span($ceylonInteger(size - 2), $ceylonInteger(0));
    Sequence get reversed => $outer$ceylon$language$Sequence;
    $dart$core.Object getFromFirst([$dart$core.int index]) => $outer$ceylon$language$Sequence.getFromFirst((size - 1) - index);
    Sequential measure([Integer from, $dart$core.int length]) => length > 0 ? (() {
        $dart$core.int start;
        {
            start = (size - 1) - $dartInt(from);
        }
        return $outer$ceylon$language$Sequence.span($ceylonInteger(start), $ceylonInteger((start - length) + 1));
    })() : $package$empty;
    Sequential span([Integer from, Integer to]) => $outer$ceylon$language$Sequence.span(to, from);
    Sequential spanFrom([Integer from]) => (() {
        $dart$core.int endIndex;
        {
            endIndex = size - 1;
        }
        return $dartInt(from) <= endIndex ? $outer$ceylon$language$Sequence.span($ceylonInteger(endIndex - $dartInt(from)), $ceylonInteger(0)) : $package$empty;
    })();
    Sequential spanTo([Integer to]) => $dartInt(to) >= 0 ? (() {
        $dart$core.int endIndex;
        {
            endIndex = size - 1;
        }
        return $outer$ceylon$language$Sequence.span($ceylonInteger(endIndex), $ceylonInteger(endIndex - $dartInt(to)));
    })() : $package$empty;
    Iterator iterator() => (() {
        Sequence outerList;
        {
            outerList = $outer$ceylon$language$Sequence;
        }
        return new Sequence$Reverse$$anonymous$0_(this, outerList);
    })();
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class Sequence$Repeat implements dart$$Object, Sequence {
    Sequence $outer$ceylon$language$Sequence;
    Sequence$Repeat([Sequence $outer$ceylon$language$Sequence, $dart$core.int times]) {
        this.$outer$ceylon$language$Sequence = $outer$ceylon$language$Sequence;
        this._times = times;
        if (!(this._times > 0)) {
            throw new AssertionError("Violated: times>0");
        }
    }
    $dart$core.int _times;
    $dart$core.Object get last => $outer$ceylon$language$Sequence.last;
    $dart$core.Object get first => $outer$ceylon$language$Sequence.first;
    $dart$core.int get size => $outer$ceylon$language$Sequence.size * _times;
    Sequential get rest => sublistFrom(1).sequence();
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int size$s1;
        {
            size$s1 = $outer$ceylon$language$Sequence.size;
        }
        return index < (size$s1 * _times) ? $outer$ceylon$language$Sequence.getFromFirst(index.remainder(size$s1)) : null;
    })();
    Iterator iterator() => new CycledIterator($outer$ceylon$language$Sequence, _times);
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
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
    static Range $indexes([final Sequence $this]) => $package$span($ceylonInteger(0), $ceylonInteger($this.lastIndex));
    Sequence sequence();
    static Sequence $sequence([final Sequence $this]) => $this;
    Sequential get rest;
    Sequence get reversed;
    static Sequence $get$reversed([final Sequence $this]) => new Sequence$Reverse($this);
    Sequential repeat([$dart$core.int times]);
    static Sequential $repeat([final Sequence $this, $dart$core.int times]) => times > 0 ? new Sequence$Repeat($this, times) : $package$empty;
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
    static Tuple $slice([final Sequence $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo($ceylonInteger(index - 1)), $this.spanFrom($ceylonInteger(index))]);
    Sequential measure([Integer from, $dart$core.int length]);
    static Sequential $measure([final Sequence $this, Integer from, $dart$core.int length]) => length > 0 ? $this.span(from, $ceylonInteger(($dartInt(from) + length) - 1)) : $package$empty;
    Sequential span([Integer from, Integer to]);
    static Sequential $span([final Sequence $this, Integer from, Integer to]) {
        if ($dartInt(from) <= $dartInt(to)) {
            return ($dartInt(to) >= 0) && ($dartInt(from) <= $this.lastIndex) ? new ArraySequence(new Array($this.sublist($dartInt(from), $dartInt(to)))) : $package$empty;
        } else {
            return ($dartInt(from) >= 0) && ($dartInt(to) <= $this.lastIndex) ? new ArraySequence(new Array($this.sublist($dartInt(to), $dartInt(from)).reversed)) : $package$empty;
        }
    }
    Sequential spanFrom([Integer from]);
    static Sequential $spanFrom([final Sequence $this, Integer from]) {
        if ($dartInt(from) <= 0) {
            return $this;
        } else if ($dartInt(from) < $this.size) {
            return new ArraySequence(new Array($this.sublistFrom($dartInt(from))));
        } else {
            return $package$empty;
        }
    }
    Sequential spanTo([Integer to]);
    static Sequential $spanTo([final Sequence $this, Integer to]) {
        if ($dartInt(to) >= $this.lastIndex) {
            return $this;
        } else if ($dartInt(to) >= 0) {
            return new ArraySequence(new Array($this.sublistTo($dartInt(to))));
        } else {
            return $package$empty;
        }
    }
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequence $this]) => Sequential.$get$string($this);
    static $dart$core.Object $_getElement$1([final Sequence $this, $dart$core.int index]) {{
            $dart$core.bool doElse$6 = true;
            {
                $dart$core.Object tmp$7 = $this.getFromFirst(index);
                if (!(null == tmp$7)) {
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

class JoinedSequence implements dart$$Object, Sequence {
    JoinedSequence([Sequence firstSeq, Sequence secondSeq]) {
        this._firstSeq = firstSeq;
        this._secondSeq = secondSeq;
    }
    Sequence _firstSeq;
    Sequence _secondSeq;
    $dart$core.int get size => _firstSeq.size + _secondSeq.size;
    $dart$core.Object get first => _firstSeq.first;
    $dart$core.Object get last => _secondSeq.last;
    Sequential get rest => _firstSeq.rest.append(_secondSeq);
    $dart$core.Object getFromFirst([$dart$core.int index]) => (() {
        $dart$core.int cutover;
        {
            cutover = _firstSeq.size;
        }
        return index < cutover ? _firstSeq.getFromFirst(index) : _secondSeq.getFromFirst(index - cutover);
    })();
    Tuple slice([$dart$core.int index]) => index == _firstSeq.size ? new Tuple.$withList([_firstSeq, _secondSeq]) : Sequence.$slice(this, index);
    Sequential spanTo([Integer to]) => $dartInt(to) == (_firstSeq.size - 1) ? _firstSeq : Sequence.$spanTo(this, to);
    Sequential spanFrom([Integer from]) => $dartInt(from) == _firstSeq.size ? _secondSeq : Sequence.$spanFrom(this, from);
    Sequential measure([Integer from, $dart$core.int length]) {
        if (($dartInt(from) == 0) && (length == _firstSeq.size)) {
            return _firstSeq;
        } else if (($dartInt(from) == _firstSeq.size) && (length >= _secondSeq.size)) {
            return _secondSeq;
        } else {
            return Sequence.$measure(this, from, length);
        }
    }
    Sequential span([Integer from, Integer to]) {
        if (($dartInt(from) <= 0) && ($dartInt(to) == (_firstSeq.size - 1))) {
            return _firstSeq;
        } else if (($dartInt(from) == _firstSeq.size) && ($dartInt(to) >= (size - 1))) {
            return _secondSeq;
        } else {
            return Sequence.$span(this, from, to);
        }
    }
    Iterator iterator() => new ChainedIterator(_firstSeq, _secondSeq);
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
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
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
    static Sequential $get$keys([final Sequential $this]) => $package$measure($ceylonInteger(0), $this.size) as Sequential;
    Sequential sequence();
    static Sequential $sequence([final Sequential $this]) => $this;
    Sequential get rest;
    Sequential get reversed;
    Sequential repeat([$dart$core.int times]);
    Sequential initial([$dart$core.int length]);
    static Sequential $initial([final Sequential $this, $dart$core.int length]) => $this.spanTo($ceylonInteger(length - 1)) as Sequential;
    Sequential terminal([$dart$core.int length]);
    static Sequential $terminal([final Sequential $this, $dart$core.int length]) => $this.spanFrom($ceylonInteger($this.size - length)) as Sequential;
    Sequential clone();
    static Sequential $clone([final Sequential $this]) => $this;
    Sequential trim([Callable trimming]);
    static Sequential $trim([final Sequential $this, Callable trimming]) => List.$trim($this, trimming).sequence();
    Sequential trimLeading([Callable trimming]);
    static Sequential $trimLeading([final Sequential $this, Callable trimming]) => List.$trimLeading($this, trimming).sequence();
    Sequential trimTrailing([Callable trimming]);
    static Sequential $trimTrailing([final Sequential $this, Callable trimming]) => List.$trimTrailing($this, trimming).sequence();
    Tuple slice([$dart$core.int index]);
    static Tuple $slice([final Sequential $this, $dart$core.int index]) => new Tuple.$withList([$this.spanTo($ceylonInteger(index - 1)), $this.spanFrom($ceylonInteger(index))]);
    Tuple withLeading([$dart$core.Object element]);
    Sequence withTrailing([$dart$core.Object element]);
    Sequential append([Sequential elements]);
    Sequential prepend([Sequential elements]);
    $dart$core.String toString();
    static $dart$core.String $get$string([final Sequential $this]) => $this.empty ? "[]" : ("[" + $package$commaList($this)) + "]";
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
class serialization$DeserializationContextImpl implements dart$$Basic, serialization$DeserializationContext {
    serialization$DeserializationContextImpl() {
        _instances = new serialization$NativeMap();
        memberTypeCache = new serialization$NativeMap();
    }
    serialization$NativeMap _instances;
    serialization$NativeMap memberTypeCache;
    $dart$core.Object leakInstance([$dart$core.Object id]) => _instances.get(id);
    void attribute([$dart$core.Object instanceId, meta$declaration$ValueDeclaration attribute, $dart$core.Object attributeValueId]) {
        _attributeOrElement(instanceId, new impl$MemberImpl(attribute), attributeValueId);
    }
    serialization$DeserializationException alreadyComplete([$dart$core.Object instanceId]) => new serialization$DeserializationException(("instance referred to by id " + instanceId.toString()) + " already complete.");
    void _attributeOrElement([$dart$core.Object instanceId, serialization$ReachableReference attributeOrIndex, $dart$core.Object attributeValueId]) {
        serialization$Partial referring;
        {
            $dart$core.Object r = _instances.get(instanceId);
            if (null == r) {
                serialization$PartialImpl p = new serialization$PartialImpl(instanceId);
                _instances.put(instanceId, p);
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
        _attributeOrElement(instanceId, new impl$ElementImpl(index), elementValueId);
    }
    void instance([$dart$core.Object instanceId, meta$model$ClassModel clazz]) {
        if (!clazz.declaration.serializable) {
            throw new serialization$DeserializationException(("not serializable: " + clazz.toString()) + "");
        }
        _getOrCreatePartial(instanceId).clazz = clazz;
    }
    serialization$Partial _getOrCreatePartial([$dart$core.Object instanceId]) {
        serialization$Partial partial;
        {
            $dart$core.Object r = _instances.get(instanceId);
            if (null == r) {
                serialization$PartialImpl p = new serialization$PartialImpl(instanceId);
                _instances.put(instanceId, p);
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
            $dart$core.Object r = _instances.get(containerId);
            if (null == r) {
                serialization$PartialImpl p = new serialization$PartialImpl(containerId);
                _instances.put(containerId, p);
                container = p;
            } else {
                container = r;
            }
        }
        _getOrCreatePartial(instanceId).container = container;
    }
    void instanceValue([$dart$core.Object instanceId, $dart$core.Object instanceValue]) {
        _instances.put(instanceId, instanceValue);
    }
    $dart$core.Object reconstruct([$dart$core.Object instanceId]) {
        serialization$NativeDeque deque = new serialization$NativeDeque();
        $dart$core.Object root = _instances.get(instanceId);
        if (!(!(null == root))) {
            if (_instances.contains(instanceId)) {
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
        deque.pushFront(_instances.get(instanceId));
        while (!deque.empty) {
            $dart$core.Object r = deque.popFront();
            {
                $dart$core.Object switch$3 = r;
                if (null == switch$3) {
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
                    if (!r$4.instantiated) {
                        r$4.instantiate();
                    }
                    {
                        $dart$core.Object element$7;
                        Iterator iterator$6 = r$4.refersTo.iterator();
                        while ((element$7 = iterator$6.next()) is !Finished) {
                            $dart$core.Object referredId;
                            {
                                referredId = element$7;
                            }
                            if (!(referredId != null)) {
                                throw new AssertionError("Violated: is Id referredId");
                            }
                            $dart$core.Object referred = _instances.get(referredId);
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
        deque.pushFront(_instances.get(instanceId));
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
                                $dart$core.Object referredId;
                                {
                                    referredId = element$12;
                                }
                                if (!(referredId != null)) {
                                    throw new AssertionError("Violated: is Id referredId");
                                }
                                $dart$core.Object referred = _instances.get(referredId);
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
            $dart$core.Object r = _instances.get(instanceId);
            if (r is serialization$Partial) {
                serialization$Partial r$15;
                r$15 = r as serialization$Partial;
                $dart$core.Object result = r$15.instance();
                {
                    $dart$core.bool doElse$16 = true;
                    if (true) {
                        doElse$16 = false;
                        _instances.put(instanceId, result);
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
    serialization$DeserializationException([$dart$core.String message, $dart$core.Object cause = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(cause, $package$dart$default)) {
            cause = null;
        }
        return [message, cause];
    })());
    serialization$DeserializationException.$s([$dart$core.List a]) : this.$w(a[0], a[1]);
    serialization$DeserializationException.$w([$dart$core.String message, Throwable cause]) : super(message, cause) {
        this._message = message;
        this._cause$1 = cause;
    }
    $dart$core.String _message;
    Throwable _cause$1;
}
abstract class serialization$Element implements serialization$ReachableReference {
    $dart$core.int get index;
}
abstract class serialization$Member implements serialization$ReachableReference {
    meta$declaration$ValueDeclaration get attribute;
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$UninitializedLateValue implements dart$$Basic {
    serialization$UninitializedLateValue() {}
}
class serialization$uninitializedLateValue_  extends serialization$UninitializedLateValue {
    serialization$uninitializedLateValue_() {}
}
final serialization$uninitializedLateValue_ $package$serialization$uninitializedLateValue = new serialization$uninitializedLateValue_();

serialization$uninitializedLateValue_ get serialization$uninitializedLateValue => $package$serialization$uninitializedLateValue;

class serialization$NativeDeque implements dart$$Basic {
    serialization$NativeDeque() {
        _deque = new $dart$collection.DoubleLinkedQueue();
    }
    $dart$collection.DoubleLinkedQueue _deque;
    void pushFront([$dart$core.Object element]) {
        _deque.addFirst(element);
    }
    void pushBack([$dart$core.Object element]) {
        _deque.addLast(element);
    }
    $dart$core.Object popFront() => _deque.removeFirst();
    $dart$core.bool get empty => _deque.isEmpty;
    $dart$core.String toString() => _deque.toString();
}
class serialization$NativeMap implements dart$$Basic {
    serialization$NativeMap() {
        _m = new $dart$core.Map();
    }
    $dart$core.Map _m;
    void put([$dart$core.Object id, $dart$core.Object instanceOrPartial]) {
        _m[id] = instanceOrPartial;
    }
    $dart$core.Object get([$dart$core.Object id]) => _m[id];
    $dart$core.bool contains([$dart$core.Object id]) => _m.containsKey(id);
    $dart$core.int get size => _m.length;
    Iterable get items => new $ceylon$interop$dart.CeylonIterable(_m.values);
    Iterable get keys => new $ceylon$interop$dart.CeylonIterable(_m.keys);
    $dart$core.String toString() => _m.toString();
}
abstract class serialization$Outer implements serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$Partial implements dart$$Basic {
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
            if (null == tmp$0) {
                throw new AssertionError("Violated: exists s=state");
            }
            s = tmp$0;
        }
        s.put(attrOrIndex, partialOrComplete);
    }
    void instantiate();
    void initialize([serialization$DeserializationContextImpl context]);
    $dart$core.bool get instantiated => !(null == instance_);
    $dart$core.bool get initialized => !(!(null == state));
    $dart$core.bool get member => !(null == container);
    $dart$core.Object instance() {
        if (!(instantiated && initialized)) {
            throw new AssertionError("Violated: instantiated && initialized");
        }
        return instance_;
    }
    Iterable get refersTo {{
            $dart$core.bool doElse$1 = true;
            {
                serialization$NativeMap tmp$2 = state;
                if (!(null == tmp$2)) {
                    serialization$NativeMap s;
                    s = tmp$2;
                    doElse$1 = false;
                    return s.items;
                }
            }
            if (doElse$1) {
                return $package$empty;
            }
        }
    }
}
class serialization$PartialImpl  extends serialization$Partial {
    serialization$PartialImpl([$dart$core.Object id]) : super(id) {
        this._id = id;
    }
    $dart$core.Object _id;
    void instantiate() {
        throw new Exception();
    }
    void initialize([serialization$DeserializationContextImpl context]) {
        throw new Exception();
    }
}
abstract class serialization$ReachableReference {
    $dart$core.Object referred([$dart$core.Object instance]);
}
abstract class serialization$References implements Iterable {
    $dart$core.Object get instance;
    Iterable get references;
}
class ReferencesImpl$iterator$$anonymous$0_  extends impl$BaseIterator implements dart$$Identifiable {
    serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl;
    $dart$core.Object $capture$serialization$ReferencesImpl$iterator$$$instance;
    ReferencesImpl$iterator$$anonymous$0_([serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl, $dart$core.Object $capture$serialization$ReferencesImpl$iterator$$$instance]) {
        this.$outer$ceylon$language$serialization$ReferencesImpl = $outer$ceylon$language$serialization$ReferencesImpl;
        this.$capture$serialization$ReferencesImpl$iterator$$$instance = $capture$serialization$ReferencesImpl$iterator$$$instance;
        _it = $outer$ceylon$language$serialization$ReferencesImpl.references.iterator();
    }
    Iterator _it;
    $dart$core.Object next() {
        $dart$core.Object next$s1 = _it.next();
        {
            $dart$core.bool doElse$1 = true;
            if (next$s1 is Finished) {
                Finished next$s1$2;
                next$s1$2 = next$s1 as Finished;
                doElse$1 = false;
                return $package$finished;
            }
            if (doElse$1) {
                return new Entry(next$s1, (next$s1 as serialization$ReachableReference).referred($outer$ceylon$language$serialization$ReferencesImpl.instance));
            }
        }
    }
}
class ReferencesImpl$references$$anonymous$1_  extends impl$BaseIterable implements dart$$Identifiable {
    serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl;
    ReferencesImpl$references$$anonymous$1_([serialization$ReferencesImpl $outer$ceylon$language$serialization$ReferencesImpl]) {
        this.$outer$ceylon$language$serialization$ReferencesImpl = $outer$ceylon$language$serialization$ReferencesImpl;
    }
    Iterator iterator() {
        return $package$impl$reach.references($outer$ceylon$language$serialization$ReferencesImpl.instance);
    }
}
class serialization$ReferencesImpl  extends impl$BaseIterable implements serialization$References, dart$$Identifiable {
    serialization$ReferencesImpl([$dart$core.Object instance]) {
        this.instance = instance;
    }
    $dart$core.Object instance;
    Iterator iterator() {{
            $dart$core.bool doElse$0 = true;
            if (!(null == instance)) {
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
}
serialization$SerializationContext $package$serialization$serialization() => new serialization$SerializationContextImpl();

serialization$SerializationContext serialization$serialization() => $package$serialization$serialization();

abstract class serialization$SerializationContext {
    serialization$References references([$dart$core.Object instance]);
}
class serialization$SerializationContextImpl implements dart$$Basic, serialization$SerializationContext {
    serialization$SerializationContextImpl() {}
    serialization$References references([$dart$core.Object instance]) {
        if ($package$meta$classDeclaration(instance).serializable) {
            return new serialization$ReferencesImpl(instance);
        } else {
            throw new serialization$SerializationException(("instance of non-serializable class: " + $package$meta$type(instance).toString()) + "");
        }
    }
}
class serialization$SerializationException  extends Exception {
    serialization$SerializationException([$dart$core.String message, $dart$core.Object cause = $package$dart$default]) : this.$s((() {
        if ($dart$core.identical(cause, $package$dart$default)) {
            cause = null;
        }
        return [message, cause];
    })());
    serialization$SerializationException.$s([$dart$core.List a]) : this.$w(a[0], a[1]);
    serialization$SerializationException.$w([$dart$core.String message, Throwable cause]) : super(message, cause) {
        this._message = message;
        this._cause$1 = cause;
    }
    $dart$core.String _message;
    Throwable _cause$1;
}
abstract class Set implements Collection {
    $dart$core.bool contains([$dart$core.Object element]);
    static $dart$core.bool $contains([final Set $this, $dart$core.Object element]) => Collection.$contains($this, element);
    Set clone();
    static Set $clone([final Set $this]) => $package$set($this);
    $dart$core.bool superset([Set set]);
    static $dart$core.bool $superset([final Set $this, Set set]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = set.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                $dart$core.Object element;
                {
                    element = element$1;
                }
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
                $dart$core.Object element;
                {
                    element = element$3;
                }
                if (!set.contains(element)) {
                    return false;
                }
            }
            {
                return true;
            }
        }
    }
    Iterable get distinct;
    static Iterable $get$distinct([final Set $this]) => $this;
    Iterable defaultNullElements([$dart$core.Object defaultValue]);
    static Iterable $defaultNullElements([final Set $this, $dart$core.Object defaultValue]) => $this;
    Set union([Set set]);
    static Set $union([final Set $this, Set set]) => $package$set($this.chain(set));
    Set intersection([Set set]);
    static Set $intersection([final Set $this, Set set]) => $package$set($this.filter(new dart$Callable(([$dart$core.Object e]) => $ceylonBoolean(set.contains(e)))).narrow());
    Set complement([Set set]);
    static Set $complement([final Set $this, Set set]) => $package$set($this.filter(new dart$Callable(([$dart$core.Object e]) => $ceylonBoolean(!set.contains(e)))));
    Set exclusiveUnion([Set set]);
    static Set $exclusiveUnion([final Set $this, Set set]) => $package$set($this.filter(new dart$Callable(([$dart$core.Object e]) => $ceylonBoolean(!set.contains(e)))).chain(set.filter(new dart$Callable(([$dart$core.Object e]) => $ceylonBoolean(!$this.contains(e))))));
    $dart$core.bool operator ==($dart$core.Object that);
    static $dart$core.bool $equals([final Set $this, $dart$core.Object that]) {
        if (that is Set) {
            Set that$4;
            that$4 = that as Set;
            if (that$4.size == $this.size) {{
                    $dart$core.Object element$6;
                    Iterator iterator$5 = $this.iterator();
                    while ((element$6 = iterator$5.next()) is !Finished) {
                        $dart$core.Object element;
                        {
                            element = element$6;
                        }
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
    static $dart$core.int $get$hashCode([final Set $this]) {
        $dart$core.int hashCode = 0;
        {
            $dart$core.Object element$8;
            Iterator iterator$7 = $this.iterator();
            while ((element$8 = iterator$7.next()) is !Finished) {
                $dart$core.Object elem;
                {
                    elem = element$8;
                }
                hashCode = hashCode + elem.hashCode;
            }
        }
        return hashCode;
    }
}
Set $package$set([Iterable stream, $dart$core.Object choosing = $package$dart$default]) {
    if ($dart$core.identical(choosing, $package$dart$default)) {
        choosing = new dart$Callable(([$dart$core.Object earlier, $dart$core.Object later]) => earlier);
    }
    return new IterableSet(stream, choosing as Callable);
}

Set set([Iterable stream, $dart$core.Object choosing = $package$dart$default]) => $package$set(stream, choosing);

class IterableSet implements dart$$Object, Set {
    IterableSet([Iterable stream, Callable choosing]) {
        this._stream = stream;
        this._choosing = choosing;
        _elements = this._stream.summarize(new dart$Callable($package$identity), new dart$Callable(([$dart$core.Object current, $dart$core.Object element]) => (() {
            $dart$core.bool doElse$9 = true;
            if (!(null == current)) {
                doElse$9 = false;
                return this._choosing.f(current, element);
            }
            if (doElse$9) {
                return element;
            }
        })()));
    }
    Iterable _stream;
    Callable _choosing;
    Map _elements;
    $dart$core.bool contains([$dart$core.Object element]) => _elements.defines(element);
    Iterator iterator() => _elements.keys.iterator();
    $dart$core.int get size => _elements.size;
    $dart$core.bool get empty => _elements.empty;
    Set clone() => this;
    $dart$core.bool superset([Set set]) => Set.$superset(this, set);
    $dart$core.bool subset([Set set]) => Set.$subset(this, set);
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Set.$defaultNullElements(this, defaultValue);
    Set union([Set set]) => Set.$union(this, set);
    Set intersection([Set set]) => Set.$intersection(this, set);
    Set complement([Set set]) => Set.$complement(this, set);
    Set exclusiveUnion([Set set]) => Set.$exclusiveUnion(this, set);
    $dart$core.bool operator ==($dart$core.Object that) => Set.$equals(this, that);
    $dart$core.int get hashCode => Set.$get$hashCode(this);
    Iterable get distinct => Set.$get$distinct(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class emptySet_ implements dart$$Object, Set {
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
    Iterable defaultNullElements([$dart$core.Object defaultValue]) => Set.$defaultNullElements(this, defaultValue);
    $dart$core.bool operator ==($dart$core.Object that) => Set.$equals(this, that);
    $dart$core.int get hashCode => Set.$get$hashCode(this);
    Iterable get distinct => Set.$get$distinct(this);
    $dart$core.String toString() => Collection.$get$string(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get coalesced => Iterable.$get$coalesced(this);
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
}
final emptySet_ $package$emptySet = new emptySet_();

emptySet_ get emptySet => $package$emptySet;

Callable $package$shuffle([Callable f]) => $package$flatten(new dart$Callable(([$dart$core.Object secondArgs]) => $package$flatten(new dart$Callable(([$dart$core.Object firstArgs]) => $package$unflatten($package$unflatten(f).f(firstArgs) as Callable).f(secondArgs)))));

Callable shuffle([Callable f]) => $package$shuffle(f);

class Singleton$iterator$$anonymous$0_ implements dart$$Basic, Iterator {
    Singleton $outer$ceylon$language$Singleton;
    Singleton$iterator$$anonymous$0_([Singleton $outer$ceylon$language$Singleton]) {
        this.$outer$ceylon$language$Singleton = $outer$ceylon$language$Singleton;
        _done = false;
    }
    $dart$core.bool _done;
    $dart$core.Object next() {
        if (_done) {
            return $package$finished;
        } else {
            _done = true;
            return $outer$ceylon$language$Singleton._element;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Singleton.toString()) + ".iterator()";
}
class Singleton$cycled$$anonymous$1_$$anonymous$2_ implements dart$$Basic, Iterator {
    Singleton$cycled$$anonymous$1_ $outer$ceylon$language$Singleton$cycled$$anonymous$1_;
    Singleton$cycled$$anonymous$1_$$anonymous$2_([Singleton$cycled$$anonymous$1_ $outer$ceylon$language$Singleton$cycled$$anonymous$1_]) {
        this.$outer$ceylon$language$Singleton$cycled$$anonymous$1_ = $outer$ceylon$language$Singleton$cycled$$anonymous$1_;
    }
    $dart$core.Object next() => $outer$ceylon$language$Singleton$cycled$$anonymous$1_.$outer$ceylon$language$Singleton._element;
    $dart$core.String toString() => $outer$ceylon$language$Singleton$cycled$$anonymous$1_.toString() + ".iterator()";
}
class Singleton$cycled$$anonymous$1_ implements dart$$Basic, Iterable {
    Singleton $outer$ceylon$language$Singleton;
    Singleton$cycled$$anonymous$1_([Singleton $outer$ceylon$language$Singleton]) {
        this.$outer$ceylon$language$Singleton = $outer$ceylon$language$Singleton;
    }
    $dart$core.String toString() => $outer$ceylon$language$Singleton.toString() + ".cycled";
    $dart$core.int get size {
        if (!false) {
            throw new AssertionError("Violated: false");
        }
    }
    Iterator iterator() => new Singleton$cycled$$anonymous$1_$$anonymous$2_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Singleton implements dart$$Object, Sequence {
    Singleton([$dart$core.Object element]) {
        this._element = element;
    }
    $dart$core.Object _element;
    $dart$core.Object get first => _element;
    $dart$core.Object get last => _element;
    $dart$core.int get lastIndex => 0;
    $dart$core.int get size => 1;
    Empty get rest => $package$empty;
    $dart$core.Object getFromFirst([$dart$core.int index]) => index == 0 ? _element : null;
    Singleton get reversed => this;
    Singleton clone() => this;
    $dart$core.bool contains([$dart$core.Object element]) => (() {
        $dart$core.bool doElse$0 = true;
        {
            $dart$core.Object tmp$1 = this._element;
            if (!(null == tmp$1)) {
                $dart$core.Object e;
                e = tmp$1;
                doElse$0 = false;
                return e == element;
            }
        }
        if (doElse$0) {
            return false;
        }
    })();
    $dart$core.String toString() => ("[" + $package$stringify(_element)) + "]";
    Iterator iterator() => new Singleton$iterator$$anonymous$0_(this);
    $dart$core.bool operator ==($dart$core.Object that) {{
            $dart$core.bool doElse$2 = true;
            if (that is List) {
                List that$3;
                that$3 = that as List;
                if (that$3.size == 1) {
                    doElse$2 = false;
                    $dart$core.Object elem = that$3.first;
                    return (() {
                        $dart$core.bool doElse$4 = true;
                        if (!(null == _element)) {
                            if (!(null == elem)) {
                                doElse$4 = false;
                                return elem == _element;
                            }
                        }
                        if (doElse$4) {
                            return (!(!(null == _element))) && (!(!(null == elem)));
                        }
                    })();
                }
            }
            if (doElse$2) {
                return false;
            }
        }
    }
    $dart$core.int get hashCode => 31 + (($dart$core.int $lhs$) => null == $lhs$ ? 0 : $lhs$)((($dart$core.Object $r) => null == $r ? null : $r.hashCode)(_element));
    $dart$core.Object measure([Integer from, $dart$core.int length]) => ($dartInt(from) <= 0) && (($dartInt(from) + length) > 0) ? this : $package$empty;
    $dart$core.Object span([Integer from, Integer to]) => (($dartInt(from) <= 0) && ($dartInt(to) >= 0)) || (($dartInt(from) >= 0) && ($dartInt(to) <= 0)) ? this : $package$empty;
    $dart$core.Object spanTo([Integer to]) => $dartInt(to) < 0 ? $package$empty : this;
    $dart$core.Object spanFrom([Integer from]) => $dartInt(from) > 0 ? $package$empty : this;
    $dart$core.Object terminal([$dart$core.int length]) => length > 0 ? this : $package$empty;
    $dart$core.Object initial([$dart$core.int length]) => length > 0 ? this : $package$empty;
    $dart$core.Object slice([$dart$core.int index]) => index > 0 ? new Tuple.$withList([this, $package$empty]) : new Tuple.$withList([$package$empty, this]);
    $dart$core.int count([Callable selecting]) => $dartBool(selecting.f(_element) as Boolean) ? 1 : 0;
    Singleton map([Callable collecting]) => new Singleton(collecting.f(_element));
    $dart$core.Object filter([Callable selecting]) => $dartBool(selecting.f(_element) as Boolean) ? this : $package$empty;
    Callable fold([$dart$core.Object initial]) => new dart$Callable(([Callable accumulating]) => accumulating.f(initial, _element));
    $dart$core.Object reduce([Callable accumulating]) => _element;
    Singleton collect([Callable collecting]) => new Singleton(collecting.f(_element));
    $dart$core.Object select([Callable selecting]) => $dartBool(selecting.f(_element) as Boolean) ? this : $package$empty;
    $dart$core.Object find([Callable selecting]) => (() {
        $dart$core.bool doElse$5 = true;
        if (!(null == _element)) {
            if ($dartBool(selecting.f(_element) as Boolean)) {
                doElse$5 = false;
                return _element;
            }
        }
        if (doElse$5) {
            return null;
        }
    })();
    $dart$core.Object findLast([Callable selecting]) => find(selecting);
    Singleton sort([Callable comparing]) => this;
    $dart$core.bool any([Callable selecting]) => $dartBool(selecting.f(_element) as Boolean);
    $dart$core.bool every([Callable selecting]) => $dartBool(selecting.f(_element) as Boolean);
    $dart$core.Object skip([$dart$core.int skipping]) => skipping < 1 ? this : $package$empty;
    $dart$core.Object take([$dart$core.int taking]) => taking > 0 ? this : $package$empty;
    $dart$core.Object get coalesced => (() {
        $dart$core.bool doElse$6 = true;
        if (!(null == _element)) {
            doElse$6 = false;
            return new Singleton(_element);
        }
        if (doElse$6) {
            return $package$empty;
        }
    })();
    Iterable chain([Iterable other]) => other.follow(_element);
    void each([Callable step]) {
        step.f(_element);
    }
    Iterable get indexed => new LazyIterable(1, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return new Entry($ceylonInteger(0), _element);
        }
    }, null);
    Iterable follow([$dart$core.Object head]) => new LazyIterable(2, (final $dart$core.int $i$) {
        switch ($i$) {
        case 0 :
        return head;
        case 1 :
        return _element;
        }
    }, null);
    Iterable get cycled => new Singleton$cycled$$anonymous$1_(this);
    Singleton interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) {
        if ($dart$core.identical(step, $package$dart$default)) {
            step = Iterable.$interpose$step(this, element);
        }
        if (!((step as $dart$core.int) >= 1)) {
            throw new AssertionError("Violated: step>=1");
        }
        return this;
    }
    Singleton get distinct => this;
    Empty get paired => $package$empty;
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
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
$dart$core.Object $package$smallest([$dart$core.Object x, $dart$core.Object y]) => (!(x == x)) || ((y as Comparable) < x) ? y : x;

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

class Span$iterator$$anonymous$0_ implements dart$$Basic, Iterator {
    Span $outer$ceylon$language$Span;
    Span$iterator$$anonymous$0_([Span $outer$ceylon$language$Span]) {
        this.$outer$ceylon$language$Span = $outer$ceylon$language$Span;
        _firstTime = true;
        _element = $outer$ceylon$language$Span.first;
    }
    $dart$core.bool _firstTime;
    $dart$core.Object _element;
    $dart$core.Object next() {{
            $dart$core.bool doElse$0 = true;
            {
                $dart$core.Object c$1 = _element;
                if (!(c$1 is Finished)) {
                    $dart$core.Object c;
                    c = c$1;
                    doElse$0 = false;
                    $dart$core.Object result;
                    if (_firstTime) {
                        _firstTime = false;
                        result = c;
                    } else {
                        result = $outer$ceylon$language$Span._next(c);
                    }
                    if ((result as Enumerable).offset($outer$ceylon$language$Span.last) == 0) {
                        this._element = $package$finished;
                    } else {
                        this._element = result;
                    }
                    return result;
                }
            }
            if (doElse$0) {
                return _element;
            }
        }
    }
    $dart$core.String toString() => ("(" + $outer$ceylon$language$Span.toString()) + ").iterator()";
}
class Span$By$iterator$$anonymous$1_ implements dart$$Basic, Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$1_([Span$By $outer$ceylon$language$Span$By]) {
        this.$outer$ceylon$language$Span$By = $outer$ceylon$language$Span$By;
        _count = 0;
        _current = $outer$ceylon$language$Span$By.first;
    }
    $dart$core.int _count;
    $dart$core.Object _current;
    $dart$core.Object next() {
        if ((_count = $dartInt($ceylonInteger(_count).successor)) > $outer$ceylon$language$Span$By.size) {
            return $package$finished;
        } else {
            $dart$core.Object result = _current;
            _current = (_current as Enumerable).neighbour($outer$ceylon$language$Span$By._step);
            return result;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By$iterator$$anonymous$2_ implements dart$$Basic, Iterator {
    Span$By $outer$ceylon$language$Span$By;
    Span$By$iterator$$anonymous$2_([Span$By $outer$ceylon$language$Span$By]) {
        this.$outer$ceylon$language$Span$By = $outer$ceylon$language$Span$By;
        _current = $outer$ceylon$language$Span$By.first;
        _firstTime = true;
    }
    $dart$core.Object _current;
    $dart$core.bool _firstTime;
    $dart$core.Object next() {
        if (_firstTime) {
            _firstTime = false;
            return _current;
        } else {{
                $dart$core.Object c$9 = _current;
                if (c$9 != null) {
                    $dart$core.Object c;
                    c = c$9;
                    $dart$core.Object r = $outer$ceylon$language$Span$By.$outer$ceylon$language$Span._nextStep(c, $outer$ceylon$language$Span$By._step);
                    if (!$outer$ceylon$language$Span$By.$outer$ceylon$language$Span.containsElement(r)) {
                        _current = $package$finished;
                    } else {
                        _current = r;
                    }
                }
            }
            return _current;
        }
    }
    $dart$core.String toString() => ("" + $outer$ceylon$language$Span$By.toString()) + ".iterator()";
}
class Span$By implements dart$$Basic, Iterable {
    Span $outer$ceylon$language$Span;
    Span$By([Span $outer$ceylon$language$Span, $dart$core.int step]) {
        this.$outer$ceylon$language$Span = $outer$ceylon$language$Span;
        this._step = step;
    }
    $dart$core.int _step;
    $dart$core.int get size => 1 + (($outer$ceylon$language$Span.size - 1) ~/ _step);
    $dart$core.Object get first => $outer$ceylon$language$Span.first;
    $dart$core.String toString() => ((("(" + $outer$ceylon$language$Span.toString()) + ").by(") + _step.toString()) + ")";
    Iterator iterator() {
        if ($outer$ceylon$language$Span._recursive) {
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class Span  extends Range {
    Span([$dart$core.Object first, $dart$core.Object last]) {
        this.first = first;
        this.last = last;
        increasing = (this.last as Enumerable).offsetSign(this.first) >= 0;
        _recursive = ((this.first as Enumerable).offsetSign((this.first as Enumerable).successor) > 0) && (((this.last as Enumerable).predecessor as Enumerable).offsetSign(this.last) > 0);
    }
    $dart$core.Object first;
    $dart$core.Object last;
    $dart$core.String toString() => (first.toString() + "..") + last.toString();
    $dart$core.bool increasing;
    $dart$core.bool get decreasing => !increasing;
    $dart$core.bool _recursive;
    $dart$core.Object _next([$dart$core.Object x]) => increasing ? (x as Enumerable).successor : (x as Enumerable).predecessor;
    $dart$core.Object _nextStep([$dart$core.Object x, $dart$core.int step]) => increasing ? (x as Enumerable).neighbour(step) : (x as Enumerable).neighbour(-step);
    $dart$core.Object _fromFirst([$dart$core.int offset]) => increasing ? (first as Enumerable).neighbour(offset) : (first as Enumerable).neighbour(-offset);
    $dart$core.bool _afterLast([$dart$core.Object x]) => increasing ? (x as Enumerable).offsetSign(last) > 0 : (x as Enumerable).offsetSign(last) < 0;
    $dart$core.bool _beforeLast([$dart$core.Object x]) => increasing ? (x as Enumerable).offsetSign(last) < 0 : (x as Enumerable).offsetSign(last) > 0;
    $dart$core.bool _beforeFirst([$dart$core.Object x]) => increasing ? (x as Enumerable).offsetSign(first) < 0 : (x as Enumerable).offsetSign(first) > 0;
    $dart$core.bool _afterFirst([$dart$core.Object x]) => increasing ? (x as Enumerable).offsetSign(first) > 0 : (x as Enumerable).offsetSign(first) < 0;
    $dart$core.int get size {
        $dart$core.int lastIndex$s1 = (last as Enumerable).offset(first).abs();
        if (lastIndex$s1 < $package$runtime.maxIntegerValue) {
            return lastIndex$s1 + 1;
        } else {
            throw new OverflowException("size of range");
        }
    }
    $dart$core.bool longerThan([$dart$core.int length]) => length < 1 ? true : _recursive ? size > length : _beforeLast(_fromFirst(length - 1));
    $dart$core.bool shorterThan([$dart$core.int length]) => length < 1 ? true : _recursive ? size < length : _afterLast(_fromFirst(length - 1));
    $dart$core.int get lastIndex => size - 1;
    Sequential get rest => first == last ? $package$empty : $package$span(_next(first), last);
    Sequence get reversed => _recursive ? Sequence.$get$reversed(this) : $package$span(last, first);
    $dart$core.Object getFromFirst([$dart$core.int index]) {
        if (index < 0) {
            return null;
        } else if (_recursive) {
            return index < size ? _fromFirst(index) : null;
        } else {
            $dart$core.Object result = _fromFirst(index);
            return !_afterLast(result) ? result : null;
        }
    }
    Iterator iterator() => new Span$iterator$$anonymous$0_(this);
    Iterable by([$dart$core.int step]) {
        if (!(step > 0)) {
            throw new AssertionError("Violated: step > 0");
        }
        return step == 1 ? this : new Span$By(this, step);
    }
    Range shifted([$dart$core.int shift]) => shift == 0 ? this : new Span((first as Enumerable).neighbour(shift), (last as Enumerable).neighbour(shift));
    $dart$core.bool containsElement([$dart$core.Object x]) => _recursive ? (x as Enumerable).offset(first) <= (last as Enumerable).offset(first) : (!_afterLast(x)) && (!_beforeFirst(x));
    $dart$core.int count([Callable selecting]) {
        $dart$core.Object element = first;
        $dart$core.int count$s1 = 0;
        while (containsElement(element)) {
            if ($dartBool(selecting.f(element) as Boolean)) {
                count$s1 = $dartInt($ceylonInteger(count$s1).successor);
            }
            element = _next(element);
        }
        return count$s1;
    }
    $dart$core.bool includesRange([Range range]) {{
            Range switch$2 = range;
            if (switch$2 is Span) {
                Span range$3;
                range$3 = range as Span;
                if (_recursive) {
                    return ((range$3.first as Enumerable).offset(first) < size) && ((range$3.last as Enumerable).offset(first) < size);
                } else {
                    return ((increasing == range$3.increasing) && (!range$3._afterFirst(first))) && (!range$3._beforeLast(last));
                }
            } else if (switch$2 is Measure) {
                Measure range$4;
                range$4 = range as Measure;
                if (decreasing) {
                    return false;
                } else {
                    $dart$core.int offset = (range$4.first as Enumerable).offset(first);
                    return (offset >= 0) && (offset <= (size - range$4.size));
                }
            } else {
                throw new AssertionError("Supposedly exhaustive switch was not exhaustive");
            }
        }
    }
    $dart$core.bool operator ==($dart$core.Object that) {{
            $dart$core.bool doElse$5 = true;
            if (that is Span) {
                Span that$6;
                that$6 = that as Span;
                doElse$5 = false;
                return (that$6.first == first) && (that$6.last == last);
            }
            if (doElse$5) {
                $dart$core.bool doElse$7 = true;
                if (that is Measure) {
                    Measure that$8;
                    that$8 = that as Measure;
                    doElse$7 = false;
                    return (increasing && (that$8.first == first)) && (that$8.size == size);
                }
                if (doElse$7) {
                    return List.$equals(this, that);
                }
            }
        }
    }
    Sequential measure([Integer from, $dart$core.int length]) => length <= 0 ? $package$empty : span(from, $ceylonInteger(($dartInt(from) + length) - 1));
    Sequential span([Integer from, Integer to]) {
        if ($dartInt(from) <= $dartInt(to)) {
            if (($dartInt(to) < 0) || (!longerThan($dartInt(from)))) {
                return $package$empty;
            } else {
                return $package$span((($dart$core.Object $lhs$) => null == $lhs$ ? first : $lhs$)(this.getFromFirst($dartInt(from))), (($dart$core.Object $lhs$) => null == $lhs$ ? last : $lhs$)(this.getFromFirst($dartInt(to))));
            }
        } else {
            if (($dartInt(from) < 0) || (!longerThan($dartInt(to)))) {
                return $package$empty;
            } else {
                Range range = $package$span((($dart$core.Object $lhs$) => null == $lhs$ ? first : $lhs$)(this.getFromFirst($dartInt(to))), (($dart$core.Object $lhs$) => null == $lhs$ ? last : $lhs$)(this.getFromFirst($dartInt(from))));
                return range.reversed;
            }
        }
    }
    Sequential spanFrom([Integer from]) {
        if ($dartInt(from) <= 0) {
            return this;
        } else if (longerThan($dartInt(from))) {
            $dart$core.Object first$s1;
            {
                $dart$core.Object tmp$10 = this.getFromFirst($dartInt(from));
                if (null == tmp$10) {
                    throw new AssertionError("Violated: exists first = this[from]");
                }
                first$s1 = tmp$10;
            }
            return $package$span(first$s1, last);
        } else {
            return $package$empty;
        }
    }
    Sequential spanTo([Integer to]) {
        if ($dartInt(to) < 0) {
            return $package$empty;
        } else if (longerThan($dartInt(to) + 1)) {
            $dart$core.Object last$s1;
            {
                $dart$core.Object tmp$11 = this.getFromFirst($dartInt(to));
                if (null == tmp$11) {
                    throw new AssertionError("Violated: exists last = this[to]");
                }
                last$s1 = tmp$11;
            }
            return $package$span(first, last$s1);
        } else {
            return this;
        }
    }
    void each([Callable step]) {
        $dart$core.Object current = first;
        while (true) {
            step.f(current);
            if ((current as Enumerable).offset(last) == 0) {
                break;
            } else {
                current = _next(current);
            }
        }
    }
}
Range $package$span([$dart$core.Object first, $dart$core.Object last]) => new Span(first, last);

Range span([$dart$core.Object first, $dart$core.Object last]) => $package$span(first, last);

abstract class BaseStringBoxer {
    $dart$core.Object get self;
    Comparison compare([$dart$core.Object other]);
}
class BaseString$split$$anonymous$5_$iterator$$anonymous$6_ implements dart$$Basic, Iterator {
    BaseString$split$$anonymous$5_ $outer$ceylon$language$BaseString$split$$anonymous$5_;
    BaseString$split$$anonymous$5_$iterator$$anonymous$6_([BaseString$split$$anonymous$5_ $outer$ceylon$language$BaseString$split$$anonymous$5_]) {
        this.$outer$ceylon$language$BaseString$split$$anonymous$5_ = $outer$ceylon$language$BaseString$split$$anonymous$5_;
        _seq = $outer$ceylon$language$BaseString$split$$anonymous$5_.$outer$ceylon$language$BaseString.self.sequence();
        _it = _seq.iterator();
        _index = 0;
        _first = true;
        _lastWasSeparator = false;
        _peeked = false;
        _peekedWasSeparator = false;
        _eof = false;
        _peekSeparator();
    }
    Sequential _seq;
    Iterator _it;
    $dart$core.int _index;
    $dart$core.bool _first;
    $dart$core.bool _lastWasSeparator;
    $dart$core.bool _peeked;
    $dart$core.bool _peekedWasSeparator;
    $dart$core.bool _eof;
    $dart$core.bool _peekSeparator() {
        if (!_peeked) {
            _peeked = true;
            {
                $dart$core.bool doElse$2 = true;
                {
                    $dart$core.Object next$3 = _it.next();
                    if (!(next$3 is Finished)) {
                        Character next$s1;
                        next$s1 = next$3 as Character;
                        doElse$2 = false;
                        _peekedWasSeparator = $dartBool(($outer$ceylon$language$BaseString$split$$anonymous$5_.$capture$BaseString$split$splitting as Callable).f(next$s1) as Boolean);
                    }
                }
                if (doElse$2) {
                    _eof = true;
                    _peekedWasSeparator = false;
                }
            }
        }
        return _peekedWasSeparator;
    }
    void _eatChar() {
        _peeked = false;
        _peekSeparator();
        _index = $dartInt($ceylonInteger(_index).successor);
    }
    $dart$core.bool _eatSeparator() {
        $dart$core.bool result = _peekSeparator();
        if (result) {
            _eatChar();
        }
        return result;
    }
    $dart$core.String _substring([$dart$core.int start, $dart$core.int end]) => $dartString(new String(_seq.measure($ceylonInteger(start), end - start) as Iterable));
    $dart$core.Object next() {
        if (!_eof) {
            $dart$core.int start = _index;
            if (((_first && (start == 0)) || _lastWasSeparator) && _peekSeparator()) {
                _first = false;
                _lastWasSeparator = false;
                return $ceylonString("");
            }
            if (_eatSeparator()) {
                if ($outer$ceylon$language$BaseString$split$$anonymous$5_.$capture$BaseString$split$groupSeparators as $dart$core.bool) {
                    while (_eatSeparator()) {}
                }
                if (!($outer$ceylon$language$BaseString$split$$anonymous$5_.$capture$BaseString$split$discardSeparators as $dart$core.bool)) {
                    _lastWasSeparator = true;
                    return $ceylonString(_substring(start, _index));
                }
                start = _index;
            }
            while ((!_eof) && (!_peekSeparator())) {
                _eatChar();
            }
            _lastWasSeparator = false;
            return $ceylonString(_substring(start, _index));
        } else if (_lastWasSeparator) {
            _lastWasSeparator = false;
            return $ceylonString("");
        } else {
            return $package$finished;
        }
    }
}
class BaseString$split$$anonymous$5_ implements dart$$Basic, Iterable {
    BaseString $outer$ceylon$language$BaseString;
    Callable $capture$BaseString$split$splitting;
    $dart$core.Object $capture$BaseString$split$groupSeparators;
    $dart$core.Object $capture$BaseString$split$discardSeparators;
    BaseString$split$$anonymous$5_([BaseString $outer$ceylon$language$BaseString, Callable $capture$BaseString$split$splitting, $dart$core.Object $capture$BaseString$split$groupSeparators, $dart$core.Object $capture$BaseString$split$discardSeparators]) {
        this.$outer$ceylon$language$BaseString = $outer$ceylon$language$BaseString;
        this.$capture$BaseString$split$splitting = $capture$BaseString$split$splitting;
        this.$capture$BaseString$split$groupSeparators = $capture$BaseString$split$groupSeparators;
        this.$capture$BaseString$split$discardSeparators = $capture$BaseString$split$discardSeparators;
    }
    Iterator iterator() => new BaseString$split$$anonymous$5_$iterator$$anonymous$6_(this);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.String toString() => Iterable.$get$string(this);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
}
class BaseString$iterator$$anonymous$8_ implements dart$$Basic, Iterator {
    BaseString $outer$ceylon$language$BaseString;
    BaseString$iterator$$anonymous$8_([BaseString $outer$ceylon$language$BaseString]) {
        this.$outer$ceylon$language$BaseString = $outer$ceylon$language$BaseString;
        _runeIterator = $ceylon$interop$dart.dartString($outer$ceylon$language$BaseString._val).runes.iterator;
    }
    $dart$core.RuneIterator _runeIterator;
    $dart$core.Object next() => _runeIterator.moveNext() ? $package$characterFromInteger(_runeIterator.current) : $package$finished;
}
abstract class BaseString implements dart$$Object, SearchableList, BaseStringBoxer {
    void _$init$BaseString([$dart$core.int $bitmap, $dart$core.String $withString$s, Iterable $$characters]) {
        if (0 != ($bitmap & 2)) {{
                $dart$core.bool doElse$0 = true;
                if ($$characters is String) {
                    $dart$core.String characters$1;
                    characters$1 = $dartString($$characters as String);
                    doElse$0 = false;
                    _val = characters$1;
                }
                if (doElse$0) {
                    _val = (new $dart$core.String.fromCharCodes(new $ceylon$interop$dart.DartIterable($$characters.map(new dart$Callable(([Character c]) => $ceylon$interop$dart.dartInt(c.integer)))))).toString();
                }
            }
        }
        if (0 != ($bitmap & 1)) {
            this._val = $withString$s;
        }
    }
    BaseString([Iterable characters]) : this.$d(2, null, characters);
    BaseString.$d([$dart$core.int $bitmap, $dart$core.String $withString$s, Iterable $$characters]) {
        _$init$BaseString($bitmap | 2, $withString$s, $$characters);
    }
    BaseString.withString([$dart$core.String s]) : this.withString$d(1, s);
    BaseString.withString$d([$dart$core.int $bitmap, $dart$core.String $withString$s]) {
        _$init$BaseString($bitmap | 1, $withString$s);
    }
    $dart$core.String _val;
    String get self;
    $dart$core.String get lowercased => $ceylon$interop$dart.dartString($dartString(self)).toLowerCase();
    $dart$core.String get uppercased => $ceylon$interop$dart.dartString($dartString(self)).toUpperCase();
    Iterable split([$dart$core.Object splitting = $package$dart$default, $dart$core.Object discardSeparators = $package$dart$default, $dart$core.Object groupSeparators = $package$dart$default]) {
        if ($dart$core.identical(splitting, $package$dart$default)) {
            splitting = new dart$Callable(([Character ch]) => $ceylonBoolean(ch.whitespace));
        }
        if ($dart$core.identical(discardSeparators, $package$dart$default)) {
            discardSeparators = true;
        }
        if ($dart$core.identical(groupSeparators, $package$dart$default)) {
            groupSeparators = true;
        }
        return empty ? new Singleton(self) : new BaseString$split$$anonymous$5_(this, splitting, groupSeparators, discardSeparators);
    }
    Character get first => !empty ? $package$characterFromInteger(($ceylon$interop$dart.dartString(_val).runes.first as $dart$core.num).toInt()) : null;
    Character get last => !empty ? $package$characterFromInteger($ceylon$interop$dart.dartString(_val).runes.last) : null;
    String get rest => $ceylonString((new $dart$core.String.fromCharCodes($ceylon$interop$dart.dartString(_val).runes.skip(1))).toString());
    Character getFromLast([$dart$core.int index]) => empty || (index < 0) ? null : (() {
        $dart$core.Runes runes;
        {
            runes = $ceylon$interop$dart.dartString(_val).runes;
        }
        return index < runes.length ? $package$characterFromInteger((runes.elementAt((runes.length - 1) - index) as $dart$core.num).toInt()) : null;
    })();
    Sequential get keys => $package$measure($ceylonInteger(0), size) as Sequential;
    $dart$core.String join([Iterable objects]) => (new $ceylon$interop$dart.DartIterable(objects)).join($dartString(self));
    Iterable get lines => split((() {
        Character $r = new Character.$fromInt(10);
        return new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean($r == $0));
    })(), true, false).spread(new dart$Callable(([$dart$core.Object $r]) => new dart$Callable(([$dart$core.Object $0]) => ($r as String).trimTrailing($0 as Callable)))).f((() {
        Character $r = new Character.$fromInt(13);
        return new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean($r == $0));
    })()) as Iterable;
    Iterable get linesWithBreaks => split((() {
        Character $r = new Character.$fromInt(10);
        return new dart$Callable(([$dart$core.Object $0]) => $ceylonBoolean($r == $0));
    })(), false, false).partition(2).map(new dart$Callable(([Sequence lineWithBreak]) => (() {
        $dart$core.String line;
        {
            line = $dartString(lineWithBreak.getFromFirst(0) as String);
        }
        $dart$core.String br;
        {
            br = $dartString(lineWithBreak.getFromFirst(1) as String);
        }
        return (() {
            $dart$core.bool doElse$4 = true;
            if (!(null == br)) {
                doElse$4 = false;
                return $ceylonString(line + br);
            }
            if (doElse$4) {
                $dart$core.Object br$5;
                br$5 = $ceylonString(br);
                return $ceylonString(line);
            }
        })();
    })()));
    $dart$core.String get trimmed => $dartString(trim(new dart$Callable(([$dart$core.Object $r]) => $ceylonBoolean(($r as Character).whitespace))));
    String trim([Callable trimming]) => new String(List.$trim(this, trimming));
    String trimLeading([Callable trimming]) => new String(List.$trimLeading(this, trimming));
    String trimTrailing([Callable trimming]) => new String(List.$trimTrailing(this, trimming));
    $dart$core.String get normalized {
        $dart$core.bool previousWasWhitespace = false;
        $dart$core.bool leadingWhitespace = true;
        StringBuilder sb = new StringBuilder();
        {
            $dart$core.Object element$7;
            Iterator iterator$6 = this.iterator();
            while ((element$7 = iterator$6.next()) is !Finished) {
                Character character;
                {
                    character = element$7 as Character;
                }
                if (character.whitespace) {
                    if (leadingWhitespace) {
                        continue;
                    }
                    previousWasWhitespace = true;
                } else {
                    leadingWhitespace = false;
                    if (previousWasWhitespace) {
                        sb.append(" ");
                        previousWasWhitespace = false;
                    }
                    sb.appendCharacter(character);
                }
            }
        }
        return sb.toString();
    }
    String get reversed => $ceylonString((new $dart$core.String.fromCharCodes($ceylon$interop$dart.dartString(_val).runes.toList().reversed)).toString());
    $dart$core.bool get whitespace => every(new dart$Callable(([$dart$core.Object $r]) => $ceylonBoolean(($r as Character).whitespace)));
    $dart$core.bool defines([Integer index]) => ($dartInt(index) >= 0) && ($dartInt(index) < size);
    String span([Integer from, Integer to]) {
        $dart$core.bool reverse = $dartInt(to) < $dartInt(from);
        if (reverse) {
            $dart$core.int tmp = $dartInt(to);
            to = from;
            from = $ceylonInteger(tmp);
        }
        if ($dartInt(to) < 0) {
            return $ceylonString("");
        }
        $dart$core.int len = size;
        if (len == 0) {
            return self;
        }
        if ($dartInt(from) >= len) {
            return $ceylonString("");
        }
        if ($dartInt(to) >= len) {
            to = $ceylonInteger(len - 1);
        }
        if ($dartInt(from) < 0) {
            from = $ceylonInteger(0);
        }
        $dart$core.Iterable runes = $ceylon$interop$dart.dartString(_val).runes.skip($dartInt(from)).take(($dartInt(to) - $dartInt(from)) + 1);
        if (reverse) {
            return $ceylonString((new $dart$core.String.fromCharCodes(runes.toList().reversed)).toString());
        } else {
            return $ceylonString((new $dart$core.String.fromCharCodes(runes)).toString());
        }
    }
    String spanFrom([Integer from]) => span(from, $ceylonInteger($package$runtime.maxIntegerValue));
    String spanTo([Integer to]) => $dartInt(to) >= 0 ? span($ceylonInteger(0), to) : $ceylonString("");
    String measure([Integer from, $dart$core.int length]) => length > 0 ? span(from, $ceylonInteger(($dartInt(from) + length) - 1)) : $ceylonString("");
    String initial([$dart$core.int length]) => length > 0 ? span($ceylonInteger(0), $ceylonInteger(length - 1)) : $ceylonString("");
    String terminal([$dart$core.int length]) => spanFrom($ceylonInteger(size - length));
    Tuple slice([$dart$core.int index]) {
        if (index < 1) {
            return new Tuple.$withList([$ceylonString(""), self]);
        }
        $dart$core.Runes runes = $ceylon$interop$dart.dartString(_val).runes;
        return new Tuple.$withList([$ceylonString((new $dart$core.String.fromCharCodes(runes.take(index))).toString()), $ceylonString((new $dart$core.String.fromCharCodes(runes.skip(index))).toString())]);
    }
    $dart$core.int get size => $ceylon$interop$dart.dartString(_val).runes.length;
    $dart$core.int get lastIndex => !empty ? size - 1 : null;
    Iterator iterator() => new BaseString$iterator$$anonymous$8_(this);
    Character getFromFirst([$dart$core.int index]) {
        if (index < 0) {
            return null;
        }
        $dart$core.Runes runes = $ceylon$interop$dart.dartString(_val).runes;
        if (index < runes.length) {
            return $package$characterFromInteger((runes.elementAt(index) as $dart$core.num).toInt());
        }
        return null;
    }
    $dart$core.bool contains([$dart$core.Object element]) {{
            $dart$core.bool doElse$8 = true;
            if (element is String) {
                $dart$core.String element$9;
                element$9 = $dartString(element as String);
                doElse$8 = false;
                return $ceylon$interop$dart.dartString(_val).contains($ceylon$interop$dart.dartString(element$9));
            }
            if (doElse$8) {
                if (element is Character) {
                    Character element$10;
                    element$10 = element as Character;
                    {
                        $dart$core.Object element$12;
                        Iterator iterator$11 = this.iterator();
                        while ((element$12 = iterator$11.next()) is !Finished) {
                            Character c;
                            {
                                c = element$12 as Character;
                            }
                            if (c == element$10) {
                                return true;
                            }
                        }
                    }
                }
            }
        }
        return false;
    }
    $dart$core.bool startsWith([List substring]) => (() {
        $dart$core.bool doElse$13 = true;
        if (substring is String) {
            $dart$core.String substring$14;
            substring$14 = $dartString(substring as String);
            doElse$13 = false;
            return $ceylon$interop$dart.dartString(_val).startsWith($ceylon$interop$dart.dartString(substring$14));
        }
        if (doElse$13) {
            return $package$everyPair(new dart$Callable(([Character first, $dart$core.Object second]) => (() {
                $dart$core.bool doElse$15 = true;
                if (second is Character) {
                    Character second$16;
                    second$16 = second as Character;
                    doElse$15 = false;
                    return $ceylonBoolean(first == second$16);
                }
                if (doElse$15) {
                    return $package$$false;
                }
            })()), this, substring);
        }
    })();
    $dart$core.bool endsWith([List substring]) => (() {
        $dart$core.bool doElse$17 = true;
        if (substring is String) {
            $dart$core.String substring$18;
            substring$18 = $dartString(substring as String);
            doElse$17 = false;
            return $ceylon$interop$dart.dartString(_val).endsWith(substring$18);
        }
        if (doElse$17) {
            return List.$endsWith(this, substring);
        }
    })();
    String repeat([$dart$core.int times]) => $ceylonString($ceylon$interop$dart.dartString(_val) * times);
    $dart$core.String replace([$dart$core.String substring, $dart$core.String replacement]) => $ceylon$interop$dart.dartString(_val).replaceAll($ceylon$interop$dart.dartString(substring), replacement);
    $dart$core.String replaceFirst([$dart$core.String substring, $dart$core.String replacement]) => $ceylon$interop$dart.dartString(_val).replaceFirst($ceylon$interop$dart.dartString(substring), replacement);
    $dart$core.String replaceLast([$dart$core.String substring, $dart$core.String replacement]) => (() {
        $dart$core.int startIndex;
        {
            startIndex = $ceylon$interop$dart.dartString(_val).lastIndexOf($ceylon$interop$dart.dartString(substring));
        }
        return startIndex == (-1) ? $dartString(self) : $ceylon$interop$dart.dartString(_val).replaceFirst($ceylon$interop$dart.dartString(substring), replacement, startIndex);
    })();
    $dart$core.String removeInitial([$dart$core.String prefix]) => startsWith($ceylonString(prefix)) ? $dartString(spanFrom($ceylonInteger($ceylonString(prefix).size))) : $dartString(self);
    $dart$core.String removeTerminal([$dart$core.String postfix]) => endsWith($ceylonString(postfix)) ? $dartString(spanTo($ceylonInteger(size - $ceylonString(postfix).size))) : $dartString(self);
    Comparison compare([String other]) => (() {
        $dart$core.int result;
        {
            result = $ceylon$interop$dart.dartString(_val).compareTo($ceylon$interop$dart.dartString($dartString(other)));
        }
        return result < 0 ? $package$smaller : result > 0 ? $package$larger : $package$equal;
    })();
    Comparison compareIgnoringCase([$dart$core.String other]) => $ceylonString(uppercased).compare($ceylonString($ceylonString(other).uppercased));
    $dart$core.bool longerThan([$dart$core.int length]) => !(null == getFromFirst(length));
    $dart$core.bool shorterThan([$dart$core.int length]) => !(!(null == getFromFirst(length - 1)));
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$19 = true;
        if (that is String) {
            $dart$core.String that$20;
            that$20 = $dartString(that as String);
            doElse$19 = false;
            return $ceylon$interop$dart.dartString(_val) == $ceylon$interop$dart.dartString(that$20);
        }
        if (doElse$19) {
            return false;
        }
    })();
    $dart$core.bool equalsIgnoringCase([$dart$core.String that]) => uppercased == $ceylonString(that).uppercased;
    $dart$core.int get hashCode => $ceylon$interop$dart.dartString(_val).hashCode;
    $dart$core.String toString() => _val;
    $dart$core.bool get empty => $ceylon$interop$dart.dartString(_val).isEmpty;
    String get coalesced => self;
    String clone() => self;
    $dart$core.String pad([$dart$core.int size, $dart$core.Object character = $package$dart$default]) {
        if ($dart$core.identical(character, $package$dart$default)) {
            character = new Character.$fromInt(32);
        }
        $dart$core.int length = this.size;
        if (size <= length) {
            return $dartString(self);
        }
        $dart$core.int leftPad = (size - length) ~/ 2;
        $dart$core.int rightPad = (size - leftPad) - length;
        StringBuilder sb = new StringBuilder();
        {
            $dart$core.Object element$22;
            Iterator iterator$21 = ($package$measure($ceylonInteger(0), leftPad) as List).iterator();
            while ((element$22 = iterator$21.next()) is !Finished) {
                Integer $_;
                {
                    $_ = element$22 as Integer;
                }
                sb.appendCharacter(character as Character);
            }
        }
        sb.append($dartString(self));
        {
            $dart$core.Object element$24;
            Iterator iterator$23 = ($package$measure($ceylonInteger(0), rightPad) as List).iterator();
            while ((element$24 = iterator$23.next()) is !Finished) {
                Integer $_;
                {
                    $_ = element$24 as Integer;
                }
                sb.appendCharacter(character as Character);
            }
        }
        return sb.toString();
    }
    $dart$core.String padLeading([$dart$core.int size, $dart$core.Object character = $package$dart$default]) {
        if ($dart$core.identical(character, $package$dart$default)) {
            character = new Character.$fromInt(32);
        }
        $dart$core.int length = this.size;
        if (size <= length) {
            return _val;
        }
        $dart$core.int padAmount = size - length;
        return ((character as Character).toString() * padAmount) + _val;
    }
    $dart$core.String padTrailing([$dart$core.int size, $dart$core.Object character = $package$dart$default]) {
        if ($dart$core.identical(character, $package$dart$default)) {
            character = new Character.$fromInt(32);
        }
        $dart$core.int length = this.size;
        if (size <= length) {
            return _val;
        }
        $dart$core.int padAmount = size - length;
        return _val + ((character as Character).toString() * padAmount);
    }
    void copyTo([Array destination, $dart$core.Object sourcePosition = $package$dart$default, $dart$core.Object destinationPosition = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(sourcePosition, $package$dart$default)) {
            sourcePosition = 0;
        }
        if ($dart$core.identical(destinationPosition, $package$dart$default)) {
            destinationPosition = 0;
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = $dartInt($package$smallest($ceylonInteger(size - (sourcePosition as $dart$core.int)), $ceylonInteger(destination.size - (destinationPosition as $dart$core.int))) as Integer);
        }
        $dart$core.int i = destinationPosition as $dart$core.int;
        {
            $dart$core.Object element$26;
            Iterator iterator$25 = skip((sourcePosition as $dart$core.int) - 1).take(length as $dart$core.int).iterator();
            while ((element$26 = iterator$25.next()) is !Finished) {
                Character c;
                {
                    c = element$26 as Character;
                }
                destination.set((() {
                    $dart$core.int tmp$27 = i;
                    i = $dartInt($ceylonInteger(i).successor);
                    return tmp$27;
                })(), c);
            }
        }
        if (i < ((destinationPosition as $dart$core.int) + (length as $dart$core.int))) {
            throw new Exception(((("Expected to copy " + (length as $dart$core.int).toString()) + " items but only copied ") + (i - (destinationPosition as $dart$core.int)).toString()) + " items");
        }
    }
    $dart$core.String substring([$dart$core.Object from = $package$dart$default, $dart$core.Object end = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = 0;
        }
        if ($dart$core.identical(end, $package$dart$default)) {
            end = size;
        }
        return $dartString(self.measure($ceylonInteger(from as $dart$core.int), (end as $dart$core.int) - (from as $dart$core.int)));
    }
    $dart$core.int indexOf([$dart$core.String string, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = 0;
        }
        return (($dart$core.int $lhs$) => null == $lhs$ ? -1 : $lhs$)(firstInclusion($ceylonString(string), from));
    }
    $dart$core.int lastIndexOf([$dart$core.String string, $dart$core.Object to = $package$dart$default]) {
        if ($dart$core.identical(to, $package$dart$default)) {
            to = size;
        }
        return (($dart$core.int $lhs$) => null == $lhs$ ? -1 : $lhs$)(lastInclusion($ceylonString(string), size - (to as $dart$core.int)));
    }
    Iterable indexesWhere([Callable selecting]) => dart$functionIterable(new dart$Callable(() {
        $dart$core.bool step$0$expired$28 = false;
        $dart$core.bool step$0$29() {
            if (step$0$expired$28) {
                return false;
            }
            step$0$expired$28 = true;
            return true;
        }

        Iterator iterator_1$30;
        $dart$core.bool step$1$Init$35() {
            if (iterator_1$30 != null) {
                return true;
            }
            if (!step$0$29()) {
                return false;
            }
            iterator_1$30 = this.indexed.iterator();
            return true;
        }

        Integer index$33;
        Character element$34;
        $dart$core.bool step$1$36() {
            while (step$1$Init$35()) {
                $dart$core.Object next$31;
                if ((next$31 = iterator_1$30.next()) is !Finished) {
                    Integer index;
                    Character element;
                    {
                        Entry d$32 = next$31 as Entry;
                        index = d$32.key as Integer;
                        element = d$32.item as Character;
                    }
                    index$33 = index;
                    element$34 = element;
                    return true;
                }
                iterator_1$30 = null;
            }
            return false;
        }

        $dart$core.bool step$2$37() {
            while (step$1$36()) {
                Integer index = index$33;
                Character element = element$34;
                if (!(!(null == element))) {
                    continue;
                }
                if (!$dartBool(selecting.f(element) as Boolean)) {
                    continue;
                }
                return true;
            }
            return false;
        }

        $dart$core.Object step$3$38() {
            if (!step$2$37()) {
                return $package$finished;
            }
            Integer index = index$33;
            Character element = element$34;
            return index;
        }

        return new dart$Callable(step$3$38);
    }));
    $dart$core.bool occursAt([$dart$core.int index, $dart$core.Object element]) => SearchableList.$occursAt(this, index, element);
    Iterable occurrences([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurrences(this, element, from, length);
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurs(this, element, from, length);
    $dart$core.int firstOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$firstOccurrence(this, element, from, length);
    $dart$core.int lastOccurrence([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$lastOccurrence(this, element, from, length);
    $dart$core.bool includesAt([$dart$core.int index, List sublist]) => SearchableList.$includesAt(this, index, sublist);
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$inclusions(this, sublist, from);
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$includes(this, sublist, from);
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$firstInclusion(this, sublist, from);
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$lastInclusion(this, sublist, from);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object find([Callable selecting]) => List.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => List.$findLast(this, selecting);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Iterable get indexed => Iterable.$get$indexed(this);
    Iterable get paired => Iterable.$get$paired(this);
    Iterable partition([$dart$core.int length]) => Iterable.$partition(this, length);
    Iterable follow([$dart$core.Object head]) => Iterable.$follow(this, head);
    Iterable chain([Iterable other]) => Iterable.$chain(this, other);
    Iterable product([Iterable other]) => Iterable.$product(this, other);
    Iterable get cycled => Iterable.$get$cycled(this);
    Iterable interpose([$dart$core.Object element, $dart$core.Object step = $package$dart$default]) => Iterable.$interpose(this, element, step);
    Iterable get distinct => Iterable.$get$distinct(this);
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
class StringBuilder implements dart$$Basic, SearchableList {
    StringBuilder() {
        _delegate = new $dart$core.StringBuffer();
    }
    $dart$core.StringBuffer _delegate;
    $dart$core.int get size => $ceylonString(_delegate.toString()).size;
    $dart$core.int get lastIndex => !empty ? size - 1 : null;
    $dart$core.String toString() => _delegate.toString();
    void set string($dart$core.String string) {
        clear();
        append(string);
    }
    Iterator iterator() => $ceylonString(toString()).iterator();
    $dart$core.String substring([$dart$core.int index, $dart$core.int length]) => $dartString($ceylonString(toString()).measure($ceylonInteger(index), length));
    String measure([Integer from, $dart$core.int length]) => $ceylonString(toString()).measure(from, length);
    String span([Integer from, Integer to]) => $ceylonString(toString()).measure(from, $dartInt(to));
    String spanTo([Integer to]) => $ceylonString(toString()).spanTo(to);
    String spanFrom([Integer from]) => $ceylonString(toString()).spanFrom(from);
    Character getFromFirst([$dart$core.int index]) => $ceylonString(toString()).getFromFirst(index);
    StringBuilder append([$dart$core.String string]) {
        _delegate.write($ceylonString(string));
        return this;
    }
    StringBuilder appendAll([Iterable strings]) {{
            $dart$core.Object element$1;
            Iterator iterator$0 = strings.iterator();
            while ((element$1 = iterator$0.next()) is !Finished) {
                String s;
                {
                    s = element$1 as String;
                }
                append($dartString(s));
            }
        }
        return this;
    }
    StringBuilder prepend([$dart$core.String string]) {
        $dart$core.String newString = string + this.toString();
        clear();
        _delegate.write($ceylonString(newString));
        return this;
    }
    StringBuilder prependAll([Iterable strings]) {{
            $dart$core.Object element$3;
            Iterator iterator$2 = strings.iterator();
            while ((element$3 = iterator$2.next()) is !Finished) {
                String s;
                {
                    s = element$3 as String;
                }
                prepend($dartString(s));
            }
        }
        return this;
    }
    StringBuilder appendCharacter([Character character]) {
        _delegate.write(character);
        return this;
    }
    StringBuilder prependCharacter([Character character]) {
        prepend(character.toString());
        return this;
    }
    StringBuilder appendNewline() => appendCharacter(new Character.$fromInt(10));
    StringBuilder appendSpace() => appendCharacter(new Character.$fromInt(32));
    StringBuilder clear() {
        _delegate.clear();
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
        _delegate.write($ceylonString(($dartString($ceylonString(oldString).spanTo($ceylonInteger(index - 1))) + string) + $dartString($ceylonString(oldString).spanFrom($ceylonInteger(index)))));
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
        if (!$ceylonString(string).empty) {
            $dart$core.String oldString = this.toString();
            clear();
            _delegate.write($ceylonString(($dartString($ceylonString(oldString).spanTo($ceylonInteger(index - 1))) + string) + $dartString($ceylonString(oldString).spanFrom($ceylonInteger(index + length)))));
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
        _delegate.write($ceylonString($dartString($ceylonString(oldString).spanTo($ceylonInteger(index - 1))) + $dartString($ceylonString(oldString).spanFrom($ceylonInteger(index + length)))));
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
        _delegate.write($ceylonString(oldString).reversed);
        return this;
    }
    $dart$core.int firstInclusion([List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$firstInclusion$from(this, sublist);
        }
        return $ceylonString(toString()).firstInclusion(sublist, from);
    }
    $dart$core.int lastInclusion([List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$lastInclusion$from(this, sublist);
        }
        return $ceylonString(toString()).lastInclusion(sublist, from);
    }
    $dart$core.int firstOccurrence([Character character, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$firstOccurrence$from(this, character);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$firstOccurrence$length(this, character, from);
        }
        return $ceylonString(toString()).firstOccurrence(character, from, length);
    }
    $dart$core.int lastOccurrence([Character character, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$lastOccurrence$from(this, character);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$lastOccurrence$length(this, character, from);
        }
        return $ceylonString(toString()).lastOccurrence(character, from, length);
    }
    Iterable inclusions([List sublist, $dart$core.Object from = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$inclusions$from(this, sublist);
        }
        return $ceylonString(toString()).inclusions(sublist, from);
    }
    Iterable occurrences([Character character, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) {
        if ($dart$core.identical(from, $package$dart$default)) {
            from = SearchableList.$occurrences$from(this, character);
        }
        if ($dart$core.identical(length, $package$dart$default)) {
            length = SearchableList.$occurrences$length(this, character, from);
        }
        return $ceylonString(toString()).occurrences(character, from, length);
    }
    $dart$core.bool operator ==($dart$core.Object that) => (() {
        $dart$core.bool doElse$4 = true;
        if (that is StringBuilder) {
            StringBuilder that$5;
            that$5 = that as StringBuilder;
            doElse$4 = false;
            return _delegate == that$5._delegate;
        }
        if (doElse$4) {
            return false;
        }
    })();
    $dart$core.int get hashCode => _delegate.hashCode;
    $dart$core.bool occurs([$dart$core.Object element, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => SearchableList.$occurs(this, element, from, length);
    $dart$core.bool includes([List sublist, $dart$core.Object from = $package$dart$default]) => SearchableList.$includes(this, sublist, from);
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
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List trim([Callable trimming]) => List.$trim(this, trimming);
    List trimLeading([Callable trimming]) => List.$trimLeading(this, trimming);
    List trimTrailing([Callable trimming]) => List.$trimTrailing(this, trimming);
    Tuple slice([$dart$core.int index]) => List.$slice(this, index);
    Sequential collect([Callable collecting]) => List.$collect(this, collecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    $dart$core.bool get empty => Collection.$get$empty(this);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
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
        sum = (sum as Summable) + val;
    }
    return sum;
}

$dart$core.Object sum([Iterable values]) => $package$sum(values);

abstract class Summable {
    $dart$core.Object operator +($dart$core.Object other);
}
class system_ implements dart$$Basic {
    system_() {
        _stopwatch = new $dart$core.Stopwatch();
        _stopwatch.start();
        timezoneOffset = (new $dart$core.DateTime.now()).timeZoneOffset.inMilliseconds;
    }
    $dart$core.Stopwatch _stopwatch;
    $dart$core.int get milliseconds => (new $dart$core.DateTime.now()).millisecondsSinceEpoch;
    $dart$core.int get nanoseconds => _stopwatch.elapsedMicroseconds * 1000;
    $dart$core.String toString() => "system";
    $dart$core.String get locale => "en";
    $dart$core.String get characterEncoding => "UTF-8";
    $dart$core.int timezoneOffset;
}
final system_ $package$system = new system_();

system_ get system => $package$system;

$dart$core.Object $package$times([$dart$core.Object x, $dart$core.Object y]) => (x as Numeric) * y;

$dart$core.Object times([$dart$core.Object x, $dart$core.Object y]) => $package$times(x, y);

abstract class BaseTuple implements dart$$Object, Sequence {
    void _$init$BaseTuple([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest, Iterable $trailing$initial, $dart$core.Object $trailing$element, $dart$core.Object $$first, $dart$core.Object $$rest]) {
        if (0 != ($bitmap & 8)) {
            _list = new $dart$core.List(1);
            _list[0] = $$first;
            this._restSequence = $$rest as Sequential;
        }
        if (0 != ($bitmap & 4)) {
            _list = new $dart$core.List.from(new $ceylon$interop$dart.DartIterable($trailing$initial.chain(new LazyIterable(1, (final $dart$core.int $i$) {
                switch ($i$) {
                case 0 :
                return $trailing$element;
                }
            }, null))));
            this._restSequence = $package$empty;
        }
        if (0 != ($bitmap & 2)) {
            _list = new $dart$core.List.from(new $ceylon$interop$dart.DartIterable($ofElements$rest));
            if (_list.isEmpty) {
                throw new AssertionError("list must not be empty");
            }
            this._restSequence = $package$empty;
        }
        if (0 != ($bitmap & 1)) {
            if ($withList$list.isEmpty) {
                throw new AssertionError("list must not be empty");
            }
            this._list = $withList$list;
            this._restSequence = $withList$rest as Sequential;
        }
    }
    BaseTuple([$dart$core.Object first, $dart$core.Object rest = $package$dart$default]) : this.$d(8, null, null, null, null, null, first, rest);
    BaseTuple.$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest, Iterable $trailing$initial, $dart$core.Object $trailing$element, $dart$core.Object $$first, $dart$core.Object $$rest = $package$dart$default]) : this.$s($bitmap | 8, $withList$list, $withList$rest, $ofElements$rest, $trailing$initial, $trailing$element, (() {
        if ($dart$core.identical($$rest, $package$dart$default)) {
            $$rest = $package$empty;
        }
        return [$$first, $$rest];
    })());
    BaseTuple.$s([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest, Iterable $trailing$initial, $dart$core.Object $trailing$element, $dart$core.List a]) : this.$w($bitmap, $withList$list, $withList$rest, $ofElements$rest, $trailing$initial, $trailing$element, a[0], a[1]);
    BaseTuple.$w([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest, Iterable $trailing$initial, $dart$core.Object $trailing$element, $dart$core.Object $$first, $dart$core.Object $$rest]) {
        _$init$BaseTuple($bitmap | 8, $withList$list, $withList$rest, $ofElements$rest, $trailing$initial, $trailing$element, $$first, $$rest);
    }
    BaseTuple.trailing([Iterable initial, $dart$core.Object element]) : this.trailing$d(4, null, null, null, initial, element);
    BaseTuple.trailing$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest, Iterable $trailing$initial, $dart$core.Object $trailing$element]) {
        _$init$BaseTuple($bitmap | 4, $withList$list, $withList$rest, $ofElements$rest, $trailing$initial, $trailing$element);
    }
    BaseTuple.ofElements([Iterable rest]) : this.ofElements$d(2, null, null, rest);
    BaseTuple.ofElements$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest, Iterable $ofElements$rest]) {
        _$init$BaseTuple($bitmap | 2, $withList$list, $withList$rest, $ofElements$rest);
    }
    BaseTuple.withList([$dart$core.List list, $dart$core.Object rest = $package$dart$default]) : this.withList$d(1, list, rest);
    BaseTuple.withList$d([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest = $package$dart$default]) : this.withList$s($bitmap | 1, (() {
        if ($dart$core.identical($withList$rest, $package$dart$default)) {
            $withList$rest = $package$empty;
        }
        return [$withList$list, $withList$rest];
    })());
    BaseTuple.withList$s([$dart$core.int $bitmap, $dart$core.List a]) : this.withList$w($bitmap, a[0], a[1]);
    BaseTuple.withList$w([$dart$core.int $bitmap, $dart$core.List $withList$list, $dart$core.Object $withList$rest]) {
        _$init$BaseTuple($bitmap | 1, $withList$list, $withList$rest);
    }
    $dart$core.List _list;
    Sequential _restSequence;
    $dart$core.Object get first {
        $dart$core.Object first$s1;
        {
            $dart$core.Object first$0 = getFromFirst(0);
            if (!true) {
                throw new AssertionError("Violated: is First first = getFromFirst(0)");
            }
            first$s1 = first$0;
        }
        return first$s1;
    }
    $dart$core.Object get rest {
        $dart$core.Object result;
        {
            Sequential result$1 = _list.length == 1 ? _restSequence : $package$tupleWithList(_list.sublist(1), _restSequence);
            if (!(result$1 != null)) {
                throw new AssertionError("Violated: is Rest result =   if (list.length == 1) then restSequence else tupleWithList(list.sublist(1), restSequence)");
            }
            result = result$1;
        }
        return result;
    }
    $dart$core.int get lastIndex => size - 1;
    $dart$core.int get size => _list.length + _restSequence.size;
    $dart$core.Object getFromFirst([$dart$core.int index]) => index < 0 ? null : index < _list.length ? _list[index] : _restSequence.getFromFirst(index - _list.length);
    $dart$core.Object get last {
        $dart$core.Object result;
        {
            $dart$core.Object tmp$2 = getFromLast(0);
            if (null == tmp$2) {
                throw new AssertionError("Violated: exists result = getFromLast(0)");
            }
            result = tmp$2;
        }
        return result;
    }
    Sequential spanFrom([Integer from]) {
        if ($dartInt(from) <= 0) {
            return this;
        } else if ($dartInt(from) < _list.length) {
            return $package$tupleWithList(_list.sublist($dartInt(from)), _restSequence);
        } else {
            return _restSequence.spanFrom($ceylonInteger($dartInt(from) - _list.length)) as Sequential;
        }
    }
    BaseTuple clone() => this;
    Iterator iterator() => List.$iterator(this);
    $dart$core.bool contains([$dart$core.Object element]) => Sequence.$contains(this, element);
    Tuple withLeading([$dart$core.Object element]) {
        Tuple self;
        {
            $dart$core.Object self$3 = this;
            if (!(self$3 is Tuple)) {
                throw new AssertionError("Violated: is Tuple<Element, First, Rest> self = (this of Anything)");
            }
            self = self$3 as Tuple;
        }
        return new Tuple(element, self);
    }
    Tuple withTrailing([$dart$core.Object element]) {
        Tuple result;
        {
            Sequential result$4 = $package$tupleTrailing(this, element);
            if (!(result$4 is Tuple)) {
                throw new AssertionError("Violated: is [First,Element|Other+] result = tupleTrailing(this, element)");
            }
            result = result$4 as Tuple;
        }
        return result;
    }
    Tuple append([Sequential elements]) {
        Tuple result;
        {
            Sequential result$5 = $package$tupleWithList(_list, _restSequence.append(elements));
            if (!(result$5 is Tuple)) {
                throw new AssertionError("Violated: is [First, Element | Other*] result =   tupleWithList(list, restSequence.append(elements))");
            }
            result = result$5 as Tuple;
        }
        return result;
    }
    $dart$core.bool get empty => Sequence.$get$empty(this);
    Range get keys => Sequence.$get$keys(this);
    Range indexes() => Sequence.$indexes(this);
    Sequence sequence() => Sequence.$sequence(this);
    Sequence get reversed => Sequence.$get$reversed(this);
    Sequential repeat([$dart$core.int times]) => Sequence.$repeat(this, times);
    Sequence sort([Callable comparing]) => Sequence.$sort(this, comparing);
    Sequence collect([Callable collecting]) => Sequence.$collect(this, collecting);
    Sequence prepend([Sequential elements]) => Sequence.$prepend(this, elements);
    $dart$core.bool shorterThan([$dart$core.int length]) => Sequence.$shorterThan(this, length);
    $dart$core.bool longerThan([$dart$core.int length]) => Sequence.$longerThan(this, length);
    $dart$core.Object find([Callable selecting]) => Sequence.$find(this, selecting);
    $dart$core.Object findLast([Callable selecting]) => Sequence.$findLast(this, selecting);
    Tuple slice([$dart$core.int index]) => Sequence.$slice(this, index);
    Sequential measure([Integer from, $dart$core.int length]) => Sequence.$measure(this, from, length);
    Sequential span([Integer from, Integer to]) => Sequence.$span(this, from, to);
    Sequential spanTo([Integer to]) => Sequence.$spanTo(this, to);
    $dart$core.String toString() => Sequence.$get$string(this);
    Sequential initial([$dart$core.int length]) => Sequential.$initial(this, length);
    Sequential terminal([$dart$core.int length]) => Sequential.$terminal(this, length);
    Sequential trim([Callable trimming]) => Sequential.$trim(this, trimming);
    Sequential trimLeading([Callable trimming]) => Sequential.$trimLeading(this, trimming);
    Sequential trimTrailing([Callable trimming]) => Sequential.$trimTrailing(this, trimming);
    $dart$core.Object get([Integer index]) => List.$get(this, index);
    $dart$core.Object getFromLast([$dart$core.int index]) => List.$getFromLast(this, index);
    $dart$core.bool defines([Integer index]) => List.$defines(this, index);
    $dart$core.bool operator ==($dart$core.Object that) => List.$equals(this, that);
    $dart$core.int get hashCode => List.$get$hashCode(this);
    List sublistFrom([$dart$core.int from]) => List.$sublistFrom(this, from);
    List sublistTo([$dart$core.int to]) => List.$sublistTo(this, to);
    List sublist([$dart$core.int from, $dart$core.int to]) => List.$sublist(this, from, to);
    List patch([List list, $dart$core.Object from = $package$dart$default, $dart$core.Object length = $package$dart$default]) => List.$patch(this, list, from, length);
    $dart$core.bool startsWith([List sublist]) => List.$startsWith(this, sublist);
    $dart$core.bool endsWith([List sublist]) => List.$endsWith(this, sublist);
    Iterable indexesWhere([Callable selecting]) => List.$indexesWhere(this, selecting);
    $dart$core.int firstIndexWhere([Callable selecting]) => List.$firstIndexWhere(this, selecting);
    $dart$core.int lastIndexWhere([Callable selecting]) => List.$lastIndexWhere(this, selecting);
    List mapElements([Callable mapping]) => List.$mapElements(this, mapping);
    Iterable get permutations => Collection.$get$permutations(this);
    Iterable combinations([$dart$core.int length]) => Collection.$combinations(this, length);
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
    Map frequencies() => Iterable.$frequencies(this);
    Map tabulate([Callable collecting]) => Iterable.$tabulate(this, collecting);
    Map group([Callable grouping]) => Iterable.$group(this, grouping);
    Map summarize([Callable grouping, Callable accumulating]) => Iterable.$summarize(this, grouping, accumulating);
    $dart$core.bool containsEvery([Iterable elements]) => Category.$containsEvery(this, elements);
    $dart$core.bool containsAny([Iterable elements]) => Category.$containsAny(this, elements);
    $dart$core.bool definesEvery([Iterable keys]) => Correspondence.$definesEvery(this, keys);
    $dart$core.bool definesAny([Iterable keys]) => Correspondence.$definesAny(this, keys);
    Iterable getAll([Iterable keys]) => Correspondence.$getAll(this, keys);
}
Tuple $package$unzip([Iterable tuples]) => new Tuple.$withList([tuples.map(new dart$Callable(([Tuple tuple]) => tuple.first)), tuples.map(new dart$Callable(([Tuple tuple]) => tuple.rest))]);

Tuple unzip([Iterable tuples]) => $package$unzip(tuples);

Tuple $package$unzipPairs([Iterable pairs]) => new Tuple.$withList([pairs.map(new dart$Callable(([Tuple pair]) => pair.getFromFirst(0))), pairs.map(new dart$Callable(([Tuple pair]) => pair.getFromFirst(1)))]);

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

const _$jsonModel = const{"\$mod-name":"ceylon.language","\$mod-version":"1.3.0-DP3","ceylon.language":const{"Annotated":const{"mt":"i","nm":"Annotated","sts":const[]},"Annotation":const{"mt":"i","nm":"Annotation","sts":const[]},"AnnotationAnnotation":const{"mt":"c","nm":"AnnotationAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"AnnotationAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"ClassDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"SharedAnnotation":const{"mt":"c","nm":"SharedAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SharedAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ConstructorDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"Package","pk":"ceylon.language.meta.declaration"}, const{"nm":"Import","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"VariableAnnotation":const{"mt":"c","nm":"VariableAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"VariableAnnotation","pk":"."},"ProgramElement":const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"AbstractAnnotation":const{"mt":"c","nm":"AbstractAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"AbstractAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"ClassDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ConstructorDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"FinalAnnotation":const{"mt":"c","nm":"FinalAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"FinalAnnotation","pk":"."},"ProgramElement":const{"nm":"ClassDeclaration","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"SealedAnnotation":const{"mt":"c","nm":"SealedAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SealedAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ConstructorDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"ActualAnnotation":const{"mt":"c","nm":"ActualAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"ActualAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"FormalAnnotation":const{"mt":"c","nm":"FormalAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"FormalAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"DefaultAnnotation":const{"mt":"c","nm":"DefaultAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"DefaultAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"LateAnnotation":const{"mt":"c","nm":"LateAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"LateAnnotation","pk":"."},"ProgramElement":const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"NativeAnnotation":const{"mt":"c","nm":"NativeAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"NativeAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"DocAnnotation":const{"mt":"c","nm":"DocAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"DocAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"SeeAnnotation":const{"mt":"c","nm":"SeeAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"SequencedAnnotation","pk":".","ta":const{"Value":const{"nm":"SeeAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"AuthorsAnnotation":const{"mt":"c","nm":"AuthorsAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"AuthorsAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"ThrownExceptionAnnotation":const{"mt":"c","nm":"ThrownExceptionAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"SequencedAnnotation","pk":".","ta":const{"Value":const{"nm":"ThrownExceptionAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ConstructorDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"DeprecationAnnotation":const{"mt":"c","nm":"DeprecationAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"DeprecationAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"TagsAnnotation":const{"mt":"c","nm":"TagsAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"TagsAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"AliasesAnnotation":const{"mt":"c","nm":"AliasesAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"AliasesAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"LicenseAnnotation":const{"mt":"c","nm":"LicenseAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"LicenseAnnotation","pk":"."},"ProgramElement":const{"nm":"Module","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"OptionalImportAnnotation":const{"mt":"c","nm":"OptionalImportAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"OptionalImportAnnotation","pk":"."},"ProgramElement":const{"nm":"Import","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"SuppressWarningsAnnotation":const{"mt":"c","nm":"SuppressWarningsAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SuppressWarningsAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ClassOrInterfaceDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"ConstructorDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"Module","pk":"ceylon.language.meta.declaration"}, const{"nm":"Package","pk":"ceylon.language.meta.declaration"}, const{"nm":"Import","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"SerializableAnnotation":const{"mt":"c","nm":"SerializableAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SerializableAnnotation","pk":"."},"ProgramElement":const{"nm":"ClassDeclaration","pk":"ceylon.language.meta.declaration"},"Type":const{"nm":"Anything","pk":"."}}}]},"SmallAnnotation":const{"mt":"c","nm":"SmallAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SmallAnnotation","pk":"."},"ProgramElement":const{"comp":"u","l":const[const{"nm":"ValueDeclaration","pk":"ceylon.language.meta.declaration"}, const{"nm":"FunctionDeclaration","pk":"ceylon.language.meta.declaration"}]},"Type":const{"nm":"Anything","pk":"."}}}]},"SinceAnnotation":const{"mt":"c","nm":"SinceAnnotation","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"OptionalAnnotation","pk":".","ta":const{"Value":const{"nm":"SinceAnnotation","pk":"."},"ProgramElement":const{"nm":"Annotated","pk":"."},"Type":const{"nm":"Anything","pk":"."}}}]},"Anything":const{"mt":"c","nm":"Anything","sts":const[]},"Array":const{"mt":"c","nm":"Array","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"SearchableList","pk":".","ta":const{"Element":const{"nm":"Element"}}}, const{"nm":"Ranged","pk":".","ta":const{"Index":const{"nm":"Integer","pk":"."},"Subrange":const{"nm":"Array","pk":".","ta":const{"Element":const{"nm":"Element"}}},"Element":const{"nm":"Element"}}}, const{"nm":"IndexedCorrespondenceMutator","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"ArraySequence":const{"mt":"c","nm":"ArraySequence","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"AssertionError":const{"mt":"c","nm":"AssertionError","super":const{"nm":"Throwable","pk":"."},"sts":const[]},"Basic":const{"mt":"c","nm":"Basic","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Identifiable","pk":"."}]},"Binary":const{"mt":"i","nm":"Binary","sts":const[]},"Boolean":const{"mt":"c","nm":"Boolean","super":const{"nm":"Basic","pk":"."},"sts":const[]},"true":const{"mt":"c","nm":"true","super":const{"nm":"Boolean","pk":"."},"sts":const[]},"false":const{"mt":"c","nm":"false","super":const{"nm":"Boolean","pk":"."},"sts":const[]},"Byte":const{"mt":"c","nm":"Byte","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Binary","pk":".","ta":const{"Other":const{"nm":"Byte","pk":"."}}}, const{"nm":"Invertible","pk":".","ta":const{"Other":const{"nm":"Byte","pk":"."}}}, const{"nm":"Enumerable","pk":".","ta":const{"Other":const{"nm":"Byte","pk":"."}}}]},"Callable":const{"mt":"i","nm":"Callable","sts":const[]},"Category":const{"mt":"i","nm":"Category","sts":const[]},"ChainedIterator":const{"mt":"c","nm":"ChainedIterator","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Iterator","pk":".","ta":const{"Element":const{"comp":"u","l":const[const{"nm":"Element"}, const{"nm":"Other"}]}}}]},"Character":const{"mt":"c","nm":"Character","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Comparable","pk":".","ta":const{"Other":const{"nm":"Character","pk":"."}}}, const{"nm":"Enumerable","pk":".","ta":const{"Other":const{"nm":"Character","pk":"."}}}]},"BaseCharacter":const{"mt":"c","nm":"BaseCharacter","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Comparable","pk":".","ta":const{"Other":const{"nm":"BaseCharacter","pk":"."}}}]},"Collection":const{"mt":"i","nm":"Collection","sts":const[const{"nm":"Iterable","pk":".","ta":const{"Absent":const{"nm":"Null","pk":"."},"Element":const{"nm":"Element"}}}]},"nullElement":const{"mt":"c","nm":"nullElement","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Comparable":const{"mt":"i","nm":"Comparable","sts":const[]},"Comparison":const{"mt":"c","nm":"Comparison","super":const{"nm":"Basic","pk":"."},"sts":const[]},"equal":const{"mt":"c","nm":"equal","super":const{"nm":"Comparison","pk":"."},"sts":const[]},"smaller":const{"mt":"c","nm":"smaller","super":const{"nm":"Comparison","pk":"."},"sts":const[]},"larger":const{"mt":"c","nm":"larger","super":const{"nm":"Comparison","pk":"."},"sts":const[]},"ConstrainedAnnotation":const{"mt":"i","nm":"ConstrainedAnnotation","sts":const[const{"nm":"Annotation","pk":"."}]},"Contextual":const{"mt":"c","nm":"Contextual","super":const{"nm":"Basic","pk":"."},"sts":const[],"\$c":const{"Using":const{"mt":"c","nm":"Using","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Obtainable","pk":"."}]}}},"Correspondence":const{"mt":"i","nm":"Correspondence","sts":const[]},"CorrespondenceMutator":const{"mt":"i","nm":"CorrespondenceMutator","sts":const[]},"IndexedCorrespondenceMutator":const{"mt":"i","nm":"IndexedCorrespondenceMutator","sts":const[const{"nm":"CorrespondenceMutator","pk":".","ta":const{"Item":const{"nm":"Element"}}}]},"KeyedCorrespondenceMutator":const{"mt":"i","nm":"KeyedCorrespondenceMutator","sts":const[const{"nm":"CorrespondenceMutator","pk":".","ta":const{"Item":const{"nm":"Item"}}}]},"CycledIterator":const{"mt":"c","nm":"CycledIterator","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Iterator","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Destroyable":const{"mt":"i","nm":"Destroyable","sts":const[const{"nm":"Usable","pk":"."}]},"Empty":const{"mt":"i","nm":"Empty","sts":const[const{"nm":"Sequential","pk":".","ta":const{"Element":const{"nm":"Nothing","pk":"."}}}, const{"nm":"Ranged","pk":".","ta":const{"Index":const{"nm":"Integer","pk":"."},"Subrange":const{"nm":"Empty","pk":"."},"Element":const{"nm":"Nothing","pk":"."}}}]},"empty":const{"mt":"c","nm":"empty","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Empty","pk":"."}]},"emptyIterator":const{"mt":"c","nm":"emptyIterator","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Iterator","pk":".","ta":const{"Element":const{"nm":"Nothing","pk":"."}}}]},"Entry":const{"mt":"c","nm":"Entry","super":const{"nm":"Object","pk":"."},"sts":const[]},"Enumerable":const{"mt":"i","nm":"Enumerable","sts":const[const{"nm":"Ordinal","pk":".","ta":const{"Other":const{"nm":"Other"}}}]},"Exception":const{"mt":"c","nm":"Exception","super":const{"nm":"Throwable","pk":"."},"sts":const[]},"Exponentiable":const{"mt":"i","nm":"Exponentiable","sts":const[const{"nm":"Numeric","pk":".","ta":const{"Other":const{"nm":"This"}}}]},"Finished":const{"mt":"c","nm":"Finished","super":const{"nm":"Basic","pk":"."},"sts":const[]},"finished":const{"mt":"c","nm":"finished","super":const{"nm":"Finished","pk":"."},"sts":const[]},"Float":const{"mt":"c","nm":"Float","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Number","pk":".","ta":const{"Other":const{"nm":"Float","pk":"."}}}, const{"nm":"Exponentiable","pk":".","ta":const{"Other":const{"nm":"Float","pk":"."},"This":const{"nm":"Float","pk":"."}}}]},"Identifiable":const{"mt":"i","nm":"Identifiable","sts":const[]},"InitializationError":const{"mt":"c","nm":"InitializationError","super":const{"nm":"AssertionError","pk":"."},"sts":const[]},"Integer":const{"mt":"c","nm":"Integer","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Integral","pk":".","ta":const{"Other":const{"nm":"Integer","pk":"."}}}, const{"nm":"Binary","pk":".","ta":const{"Other":const{"nm":"Integer","pk":"."}}}, const{"nm":"Exponentiable","pk":".","ta":const{"Other":const{"nm":"Integer","pk":"."},"This":const{"nm":"Integer","pk":"."}}}]},"Integral":const{"mt":"i","nm":"Integral","sts":const[const{"nm":"Number","pk":".","ta":const{"Other":const{"nm":"Other"}}}, const{"nm":"Enumerable","pk":".","ta":const{"Other":const{"nm":"Other"}}}]},"Invertible":const{"mt":"i","nm":"Invertible","sts":const[const{"nm":"Summable","pk":".","ta":const{"Other":const{"nm":"Other"}}}]},"Iterable":const{"mt":"i","nm":"Iterable","sts":const[const{"nm":"Category","pk":".","ta":const{"Element":const{"nm":"Object","pk":"."}}}]},"ElementEntry":const{"mt":"c","nm":"ElementEntry","super":const{"nm":"Basic","pk":"."},"sts":const[]},"GroupEntry":const{"mt":"c","nm":"GroupEntry","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Summary":const{"mt":"c","nm":"Summary","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Map","pk":".","ta":const{"Item":const{"nm":"Result"},"Key":const{"nm":"Group"}}}]},"Iterator":const{"mt":"i","nm":"Iterator","sts":const[]},"language":const{"mt":"c","nm":"language","super":const{"nm":"Basic","pk":"."},"sts":const[]},"List":const{"mt":"i","nm":"List","sts":const[const{"nm":"Collection","pk":".","ta":const{"Element":const{"nm":"Element"}}}, const{"nm":"Correspondence","pk":".","ta":const{"Item":const{"nm":"Element"},"Key":const{"nm":"Integer","pk":"."}}}, const{"nm":"Ranged","pk":".","ta":const{"Index":const{"nm":"Integer","pk":"."},"Subrange":const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}},"Element":const{"nm":"Element"}}}],"\$c":const{"Indexes":const{"mt":"c","nm":"Indexes","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Integer","pk":"."}}}]},"Sublist":const{"mt":"c","nm":"Sublist","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Rest":const{"mt":"c","nm":"Rest","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Repeat":const{"mt":"c","nm":"Repeat","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Patch":const{"mt":"c","nm":"Patch","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"comp":"u","l":const[const{"nm":"Element"}, const{"nm":"Other"}]}}}]},"Reversed":const{"mt":"c","nm":"Reversed","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}]}}},"Map":const{"mt":"i","nm":"Map","sts":const[const{"nm":"Collection","pk":".","ta":const{"Element":const{"nm":"Entry","pk":".","ta":const{"Item":const{"nm":"Item"},"Key":const{"nm":"Key"}}}}}, const{"nm":"Correspondence","pk":".","ta":const{"Item":const{"nm":"Item"},"Key":const{"nm":"Object","pk":"."}}}],"\$c":const{"Items":const{"mt":"c","nm":"Items","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Collection","pk":".","ta":const{"Element":const{"nm":"Item"}}}]}}},"emptyMap":const{"mt":"c","nm":"emptyMap","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Map","pk":".","ta":const{"Item":const{"nm":"Nothing","pk":"."},"Key":const{"nm":"Nothing","pk":"."}}}]},"Missing":const{"mt":"c","nm":"Missing","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Measure":const{"mt":"c","nm":"Measure","super":const{"nm":"Range","pk":".","ta":const{"Element":const{"nm":"Element"}}},"sts":const[],"\$c":const{"By":const{"mt":"c","nm":"By","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Iterable","pk":".","ta":const{"Absent":const{"nm":"Nothing","pk":"."},"Element":const{"nm":"Element"}}}]}}},"Null":const{"mt":"c","nm":"Null","super":const{"nm":"Anything","pk":"."},"sts":const[]},"null":const{"mt":"c","nm":"null","super":const{"nm":"Null","pk":"."},"sts":const[]},"Number":const{"mt":"i","nm":"Number","sts":const[const{"nm":"Numeric","pk":".","ta":const{"Other":const{"nm":"Other"}}}, const{"nm":"Comparable","pk":".","ta":const{"Other":const{"nm":"Other"}}}]},"Numeric":const{"mt":"i","nm":"Numeric","sts":const[const{"nm":"Invertible","pk":".","ta":const{"Other":const{"nm":"Other"}}}]},"Object":const{"mt":"c","nm":"Object","super":const{"nm":"Anything","pk":"."},"sts":const[]},"Obtainable":const{"mt":"i","nm":"Obtainable","sts":const[const{"nm":"Usable","pk":"."}]},"operatingSystem":const{"mt":"c","nm":"operatingSystem","super":const{"nm":"Basic","pk":"."},"sts":const[]},"OptionalAnnotation":const{"mt":"i","nm":"OptionalAnnotation","sts":const[const{"nm":"ConstrainedAnnotation","pk":".","ta":const{"Value":const{"nm":"Value"},"ProgramElement":const{"nm":"ProgramElement"},"Type":const{"nm":"Type"},"Values":const{"comp":"u","l":const[const{"nm":"Null","pk":"."}, const{"nm":"Value"}]}}}]},"Ordinal":const{"mt":"i","nm":"Ordinal","sts":const[]},"OverflowException":const{"mt":"c","nm":"OverflowException","super":const{"nm":"Exception","pk":"."},"sts":const[]},"ParseFloatState":const{"mt":"c","nm":"ParseFloatState","super":const{"nm":"Basic","pk":"."},"sts":const[]},"process":const{"mt":"c","nm":"process","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Range":const{"mt":"c","nm":"Range","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Ranged":const{"mt":"i","nm":"Ranged","sts":const[const{"nm":"Iterable","pk":".","ta":const{"Absent":const{"nm":"Null","pk":"."},"Element":const{"nm":"Element"}}}]},"Resource":const{"mt":"i","nm":"Resource","sts":const[]},"runtime":const{"mt":"c","nm":"runtime","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Scalable":const{"mt":"i","nm":"Scalable","sts":const[]},"SearchableList":const{"mt":"i","nm":"SearchableList","sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Sequence":const{"mt":"i","nm":"Sequence","sts":const[const{"nm":"Sequential","pk":".","ta":const{"Element":const{"nm":"Element"}}}, const{"nm":"Iterable","pk":".","ta":const{"Absent":const{"nm":"Nothing","pk":"."},"Element":const{"nm":"Element"}}}],"\$c":const{"Repeat":const{"mt":"c","nm":"Repeat","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Reverse":const{"mt":"c","nm":"Reverse","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]}}},"JoinedSequence":const{"mt":"c","nm":"JoinedSequence","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"SequencedAnnotation":const{"mt":"i","nm":"SequencedAnnotation","sts":const[const{"nm":"ConstrainedAnnotation","pk":".","ta":const{"Value":const{"nm":"Value"},"ProgramElement":const{"nm":"ProgramElement"},"Type":const{"nm":"Type"},"Values":const{"nm":"Sequential","pk":".","ta":const{"Element":const{"nm":"Value"}}}}}]},"Sequential":const{"mt":"i","nm":"Sequential","sts":const[const{"nm":"List","pk":".","ta":const{"Element":const{"nm":"Element"}}}, const{"nm":"Ranged","pk":".","ta":const{"Index":const{"nm":"Integer","pk":"."},"Subrange":const{"nm":"Sequential","pk":".","ta":const{"Element":const{"nm":"Element"}}},"Element":const{"nm":"Element"}}}]},"Set":const{"mt":"i","nm":"Set","sts":const[const{"nm":"Collection","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"IterableSet":const{"mt":"c","nm":"IterableSet","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Set","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"emptySet":const{"mt":"c","nm":"emptySet","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Set","pk":".","ta":const{"Element":const{"nm":"Nothing","pk":"."}}}]},"Singleton":const{"mt":"c","nm":"Singleton","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Span":const{"mt":"c","nm":"Span","super":const{"nm":"Range","pk":".","ta":const{"Element":const{"nm":"Element"}}},"sts":const[],"\$c":const{"By":const{"mt":"c","nm":"By","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"Iterable","pk":".","ta":const{"Absent":const{"nm":"Nothing","pk":"."},"Element":const{"nm":"Element"}}}]}}},"String":const{"mt":"c","nm":"String","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"SearchableList","pk":".","ta":const{"Element":const{"nm":"Character","pk":"."}}}, const{"nm":"Comparable","pk":".","ta":const{"Other":const{"nm":"String","pk":"."}}}, const{"nm":"Summable","pk":".","ta":const{"Other":const{"nm":"String","pk":"."}}}, const{"nm":"Ranged","pk":".","ta":const{"Index":const{"nm":"Integer","pk":"."},"Subrange":const{"nm":"String","pk":"."},"Element":const{"nm":"Character","pk":"."}}}]},"BaseStringBoxer":const{"mt":"i","nm":"BaseStringBoxer","sts":const[]},"BaseString":const{"mt":"c","nm":"BaseString","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"SearchableList","pk":".","ta":const{"Element":const{"nm":"Character","pk":"."}}}, const{"nm":"BaseStringBoxer","pk":".","ta":const{"T":const{"nm":"String","pk":"."}}}]},"StringBuilder":const{"mt":"c","nm":"StringBuilder","super":const{"nm":"Basic","pk":"."},"sts":const[const{"nm":"SearchableList","pk":".","ta":const{"Element":const{"nm":"Character","pk":"."}}}]},"Summable":const{"mt":"i","nm":"Summable","sts":const[]},"system":const{"mt":"c","nm":"system","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Throwable":const{"mt":"c","nm":"Throwable","super":const{"nm":"Basic","pk":"."},"sts":const[]},"Tuple":const{"mt":"c","nm":"Tuple","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"BaseTuple":const{"mt":"c","nm":"BaseTuple","super":const{"nm":"Object","pk":"."},"sts":const[const{"nm":"Sequence","pk":".","ta":const{"Element":const{"nm":"Element"}}}]},"Usable":const{"mt":"i","nm":"Usable","sts":const[]}},"ceylon.language.dart":const{"VariableBox":const{"mt":"c","nm":"VariableBox","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"VariableBoxBool":const{"mt":"c","nm":"VariableBoxBool","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"VariableBoxInt":const{"mt":"c","nm":"VariableBoxInt","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"VariableBoxDouble":const{"mt":"c","nm":"VariableBoxDouble","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"VariableBoxString":const{"mt":"c","nm":"VariableBoxString","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]}},"ceylon.language.impl":const{"BaseIterable":const{"mt":"c","nm":"BaseIterable","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"Iterable","pk":"\$","md":"\$","ta":const{"Absent":const{"nm":"Absent"},"Element":const{"nm":"Element"}}}]},"BaseIterator":const{"mt":"c","nm":"BaseIterator","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"Iterator","pk":"\$","md":"\$","ta":const{"Element":const{"nm":"Element"}}}]},"BaseMap":const{"mt":"c","nm":"BaseMap","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"Map","pk":"\$","md":"\$","ta":const{"Item":const{"nm":"Item"},"Key":const{"nm":"Key"}}}]},"BaseList":const{"mt":"c","nm":"BaseList","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"SearchableList","pk":"\$","md":"\$","ta":const{"Element":const{"nm":"Element"}}}]},"BaseCharacterList":const{"mt":"c","nm":"BaseCharacterList","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"SearchableList","pk":"\$","md":"\$","ta":const{"Element":const{"nm":"Character","pk":"."}}}]},"BaseSequence":const{"mt":"c","nm":"BaseSequence","super":const{"nm":"Object","pk":"\$","md":"\$"},"sts":const[const{"nm":"Sequence","pk":"\$","md":"\$","ta":const{"Element":const{"nm":"Element"}}}]},"ElementImpl":const{"mt":"c","nm":"ElementImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Element","pk":"ceylon.language.serialization"}]},"MemberImpl":const{"mt":"c","nm":"MemberImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Member","pk":"ceylon.language.serialization"}]},"outerImpl":const{"mt":"c","nm":"outerImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Outer","pk":"ceylon.language.serialization"}]},"reach":const{"mt":"c","nm":"reach","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]}},"ceylon.language.impl.meta":const{"ModuleImpl":const{"mt":"c","nm":"ModuleImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Module","pk":"ceylon.language.meta.declaration"}]},"PackageImpl":const{"mt":"c","nm":"PackageImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Package","pk":"ceylon.language.meta.declaration"}]},"ClassWithConstructorsDeclarationImpl":const{"mt":"c","nm":"ClassWithConstructorsDeclarationImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"ClassWithConstructorsDeclaration","pk":"ceylon.language.meta.declaration"}]}},"ceylon.language.meta":const{"modules":const{"mt":"c","nm":"modules","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]}},"ceylon.language.meta.declaration":const{"AliasDeclaration":const{"mt":"i","nm":"AliasDeclaration","sts":const[const{"nm":"NestableDeclaration","pk":"."}, const{"nm":"GenericDeclaration","pk":"."}]},"AnnotatedDeclaration":const{"mt":"i","nm":"AnnotatedDeclaration","sts":const[const{"nm":"Declaration","pk":"."}, const{"nm":"Annotated","pk":"\$","md":"\$"}]},"CallableConstructorDeclaration":const{"mt":"i","nm":"CallableConstructorDeclaration","sts":const[const{"nm":"FunctionalDeclaration","pk":"."}, const{"nm":"ConstructorDeclaration","pk":"."}]},"ClassDeclaration":const{"mt":"i","nm":"ClassDeclaration","sts":const[const{"nm":"ClassOrInterfaceDeclaration","pk":"."}]},"ClassOrInterfaceDeclaration":const{"mt":"i","nm":"ClassOrInterfaceDeclaration","sts":const[const{"nm":"NestableDeclaration","pk":"."}, const{"nm":"GenericDeclaration","pk":"."}]},"ClassWithConstructorsDeclaration":const{"mt":"i","nm":"ClassWithConstructorsDeclaration","sts":const[const{"nm":"ClassDeclaration","pk":"."}]},"ClassWithInitializerDeclaration":const{"mt":"i","nm":"ClassWithInitializerDeclaration","sts":const[const{"nm":"ClassDeclaration","pk":"."}]},"ConstructorDeclaration":const{"mt":"i","nm":"ConstructorDeclaration","sts":const[const{"nm":"NestableDeclaration","pk":"."}]},"Declaration":const{"mt":"i","nm":"Declaration","sts":const[]},"FunctionalDeclaration":const{"mt":"i","nm":"FunctionalDeclaration","sts":const[const{"nm":"GenericDeclaration","pk":"."}]},"FunctionDeclaration":const{"mt":"i","nm":"FunctionDeclaration","sts":const[const{"nm":"FunctionOrValueDeclaration","pk":"."}, const{"nm":"FunctionalDeclaration","pk":"."}]},"FunctionOrValueDeclaration":const{"mt":"i","nm":"FunctionOrValueDeclaration","sts":const[const{"nm":"NestableDeclaration","pk":"."}]},"GenericDeclaration":const{"mt":"i","nm":"GenericDeclaration","sts":const[]},"GettableDeclaration":const{"mt":"i","nm":"GettableDeclaration","sts":const[]},"InterfaceDeclaration":const{"mt":"i","nm":"InterfaceDeclaration","sts":const[const{"nm":"ClassOrInterfaceDeclaration","pk":"."}]},"Module":const{"mt":"i","nm":"Module","sts":const[const{"nm":"Identifiable","pk":"\$","md":"\$"}, const{"nm":"AnnotatedDeclaration","pk":"."}]},"Import":const{"mt":"i","nm":"Import","sts":const[const{"nm":"Identifiable","pk":"\$","md":"\$"}, const{"nm":"Annotated","pk":"\$","md":"\$"}]},"Package":const{"mt":"i","nm":"Package","sts":const[const{"nm":"Identifiable","pk":"\$","md":"\$"}, const{"nm":"AnnotatedDeclaration","pk":"."}]},"NestableDeclaration":const{"mt":"i","nm":"NestableDeclaration","sts":const[const{"nm":"AnnotatedDeclaration","pk":"."}, const{"nm":"TypedDeclaration","pk":"."}]},"nothingType":const{"mt":"c","nm":"nothingType","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"OpenType","pk":"."}]},"OpenClassOrInterfaceType":const{"mt":"i","nm":"OpenClassOrInterfaceType","sts":const[const{"nm":"OpenType","pk":"."}]},"OpenClassType":const{"mt":"i","nm":"OpenClassType","sts":const[const{"nm":"OpenClassOrInterfaceType","pk":"."}]},"OpenInterfaceType":const{"mt":"i","nm":"OpenInterfaceType","sts":const[const{"nm":"OpenClassOrInterfaceType","pk":"."}]},"OpenIntersection":const{"mt":"i","nm":"OpenIntersection","sts":const[const{"nm":"OpenType","pk":"."}]},"OpenType":const{"mt":"i","nm":"OpenType","sts":const[]},"OpenTypeVariable":const{"mt":"i","nm":"OpenTypeVariable","sts":const[const{"nm":"OpenType","pk":"."}]},"OpenUnion":const{"mt":"i","nm":"OpenUnion","sts":const[const{"nm":"OpenType","pk":"."}]},"SetterDeclaration":const{"mt":"i","nm":"SetterDeclaration","sts":const[const{"nm":"NestableDeclaration","pk":"."}]},"TypedDeclaration":const{"mt":"i","nm":"TypedDeclaration","sts":const[]},"TypeParameter":const{"mt":"i","nm":"TypeParameter","sts":const[const{"nm":"Declaration","pk":"."}]},"ValueConstructorDeclaration":const{"mt":"i","nm":"ValueConstructorDeclaration","sts":const[const{"nm":"GettableDeclaration","pk":"."}, const{"nm":"ConstructorDeclaration","pk":"."}]},"ValueDeclaration":const{"mt":"i","nm":"ValueDeclaration","sts":const[const{"nm":"FunctionOrValueDeclaration","pk":"."}, const{"nm":"NestableDeclaration","pk":"."}, const{"nm":"GettableDeclaration","pk":"."}]},"Variance":const{"mt":"i","nm":"Variance","sts":const[]},"invariant":const{"mt":"c","nm":"invariant","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Variance","pk":"."}]},"covariant":const{"mt":"c","nm":"covariant","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Variance","pk":"."}]},"contravariant":const{"mt":"c","nm":"contravariant","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Variance","pk":"."}]}},"ceylon.language.meta.model":const{"Applicable":const{"mt":"i","nm":"Applicable","sts":const[const{"nm":"Callable","pk":"\$","md":"\$","ta":const{"Return":const{"nm":"Type"},"Arguments":const{"nm":"Arguments"}}}]},"Attribute":const{"mt":"i","nm":"Attribute","sts":const[const{"nm":"ValueModel","pk":".","ta":const{"Set":const{"nm":"Set"},"Get":const{"nm":"Get"}}}, const{"nm":"Member","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"Value","pk":".","ta":const{"Set":const{"nm":"Set"},"Get":const{"nm":"Get"}}}}}]},"CallableConstructor":const{"mt":"i","nm":"CallableConstructor","sts":const[const{"nm":"FunctionModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Applicable","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}]},"Class":const{"mt":"i","nm":"Class","sts":const[const{"nm":"ClassModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Applicable","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}]},"ClassModel":const{"mt":"i","nm":"ClassModel","sts":const[const{"nm":"ClassOrInterface","pk":".","ta":const{"Type":const{"nm":"Type"}}}]},"ClassOrInterface":const{"mt":"i","nm":"ClassOrInterface","sts":const[const{"nm":"Model","pk":"."}, const{"nm":"Generic","pk":"."}, const{"nm":"Type","pk":".","ta":const{"Target":const{"nm":"Type"}}}]},"Declared":const{"mt":"i","nm":"Declared","sts":const[]},"Function":const{"mt":"i","nm":"Function","sts":const[const{"nm":"FunctionModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Applicable","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}]},"Functional":const{"mt":"i","nm":"Functional","sts":const[]},"FunctionModel":const{"mt":"i","nm":"FunctionModel","sts":const[const{"nm":"Model","pk":"."}, const{"nm":"Generic","pk":"."}, const{"nm":"Functional","pk":"."}]},"Generic":const{"mt":"i","nm":"Generic","sts":const[]},"Gettable":const{"mt":"i","nm":"Gettable","sts":const[]},"IncompatibleTypeException":const{"mt":"c","nm":"IncompatibleTypeException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"Interface":const{"mt":"i","nm":"Interface","sts":const[const{"nm":"InterfaceModel","pk":".","ta":const{"Type":const{"nm":"Type"}}}]},"InterfaceModel":const{"mt":"i","nm":"InterfaceModel","sts":const[const{"nm":"ClassOrInterface","pk":".","ta":const{"Type":const{"nm":"Type"}}}]},"IntersectionType":const{"mt":"i","nm":"IntersectionType","sts":const[const{"nm":"Type","pk":".","ta":const{"Target":const{"nm":"Intersection"}}}]},"InvocationException":const{"mt":"c","nm":"InvocationException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"Member":const{"mt":"i","nm":"Member","sts":const[const{"nm":"Qualified","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"Kind"}}}]},"MemberClass":const{"mt":"i","nm":"MemberClass","sts":const[const{"nm":"ClassModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Member","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"Class","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}}}]},"MemberClassCallableConstructor":const{"mt":"i","nm":"MemberClassCallableConstructor","sts":const[const{"nm":"FunctionModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Qualified","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"CallableConstructor","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}}}]},"MemberClassValueConstructor":const{"mt":"i","nm":"MemberClassValueConstructor","sts":const[const{"nm":"ValueModel","pk":".","ta":const{"Set":const{"nm":"Nothing","pk":"\$","md":"\$"},"Get":const{"nm":"Type"}}}, const{"nm":"Qualified","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"ValueConstructor","pk":".","ta":const{"Type":const{"nm":"Type"}}}}}]},"MemberInterface":const{"mt":"i","nm":"MemberInterface","sts":const[const{"nm":"InterfaceModel","pk":".","ta":const{"Type":const{"nm":"Type"}}}, const{"nm":"Member","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"Interface","pk":".","ta":const{"Type":const{"nm":"Type"}}}}}]},"Method":const{"mt":"i","nm":"Method","sts":const[const{"nm":"FunctionModel","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}, const{"nm":"Member","pk":".","ta":const{"Container":const{"nm":"Container"},"Kind":const{"nm":"Function","pk":".","ta":const{"Arguments":const{"nm":"Arguments"},"Type":const{"nm":"Type"}}}}}]},"Model":const{"mt":"i","nm":"Model","sts":const[const{"nm":"Declared","pk":"."}]},"MutationException":const{"mt":"c","nm":"MutationException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"nothingType":const{"mt":"c","nm":"nothingType","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"Type","pk":".","ta":const{"Target":const{"nm":"Nothing","pk":"\$","md":"\$"}}}]},"Qualified":const{"mt":"i","nm":"Qualified","sts":const[const{"nm":"Callable","pk":"\$","md":"\$","ta":const{"Return":const{"nm":"Kind"},"Arguments":const{"nm":"Tuple","pk":".","ta":const{"First":const{"nm":"Container"},"Rest":const{"nm":"Empty","pk":"."},"Element":const{"nm":"Container"}}}}}]},"StorageException":const{"mt":"c","nm":"StorageException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"Type":const{"mt":"i","nm":"Type","sts":const[]},"TypeApplicationException":const{"mt":"c","nm":"TypeApplicationException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"UnionType":const{"mt":"i","nm":"UnionType","sts":const[const{"nm":"Type","pk":".","ta":const{"Target":const{"nm":"Union"}}}]},"Value":const{"mt":"i","nm":"Value","sts":const[const{"nm":"ValueModel","pk":".","ta":const{"Set":const{"nm":"Set"},"Get":const{"nm":"Get"}}}, const{"nm":"Gettable","pk":".","ta":const{"Set":const{"nm":"Set"},"Get":const{"nm":"Get"}}}]},"ValueConstructor":const{"mt":"i","nm":"ValueConstructor","sts":const[const{"nm":"ValueModel","pk":".","ta":const{"Set":const{"nm":"Nothing","pk":"\$","md":"\$"},"Get":const{"nm":"Type"}}}, const{"nm":"Gettable","pk":".","ta":const{"Set":const{"nm":"Nothing","pk":"\$","md":"\$"},"Get":const{"nm":"Type"}}}]},"ValueModel":const{"mt":"i","nm":"ValueModel","sts":const[const{"nm":"Model","pk":"."}]}},"ceylon.language.serialization":const{"DeserializationContext":const{"mt":"i","nm":"DeserializationContext","sts":const[]},"DeserializationContextImpl":const{"mt":"c","nm":"DeserializationContextImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"DeserializationContext","pk":".","ta":const{"Id":const{"nm":"Id"}}}]},"DeserializationException":const{"mt":"c","nm":"DeserializationException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]},"Element":const{"mt":"i","nm":"Element","sts":const[const{"nm":"ReachableReference","pk":"."}]},"Member":const{"mt":"i","nm":"Member","sts":const[const{"nm":"ReachableReference","pk":"."}]},"UninitializedLateValue":const{"mt":"c","nm":"UninitializedLateValue","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"uninitializedLateValue":const{"mt":"c","nm":"uninitializedLateValue","super":const{"nm":"UninitializedLateValue","pk":"."},"sts":const[]},"NativeDeque":const{"mt":"c","nm":"NativeDeque","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"NativeMap":const{"mt":"c","nm":"NativeMap","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"Outer":const{"mt":"i","nm":"Outer","sts":const[const{"nm":"ReachableReference","pk":"."}]},"Partial":const{"mt":"c","nm":"Partial","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[]},"PartialImpl":const{"mt":"c","nm":"PartialImpl","super":const{"nm":"Partial","pk":"."},"sts":const[]},"ReachableReference":const{"mt":"i","nm":"ReachableReference","sts":const[]},"References":const{"mt":"i","nm":"References","sts":const[const{"nm":"Iterable","pk":"\$","md":"\$","ta":const{"Absent":const{"nm":"Null","pk":"."},"Element":const{"nm":"Entry","pk":".","ta":const{"Item":const{"nm":"Anything","pk":"."},"Key":const{"nm":"ReachableReference","pk":"ceylon.language.serialization"}}}}}]},"ReferencesImpl":const{"mt":"c","nm":"ReferencesImpl","super":const{"nm":"BaseIterable","pk":"ceylon.language.impl","ta":const{"Absent":const{"nm":"Null","pk":"\$","md":"\$"},"Element":const{"nm":"Entry","pk":"\$","md":"\$","ta":const{"Item":const{"nm":"Anything","pk":"."},"Key":const{"nm":"ReachableReference","pk":"ceylon.language.serialization"}}}}},"sts":const[const{"nm":"References","pk":"."}, const{"nm":"Identifiable","pk":"\$","md":"\$"}]},"SerializationContext":const{"mt":"i","nm":"SerializationContext","sts":const[]},"SerializationContextImpl":const{"mt":"c","nm":"SerializationContextImpl","super":const{"nm":"Basic","pk":"\$","md":"\$"},"sts":const[const{"nm":"SerializationContext","pk":"."}]},"SerializationException":const{"mt":"c","nm":"SerializationException","super":const{"nm":"Exception","pk":"\$","md":"\$"},"sts":const[]}}};

var _$module = null;

get $module {
    if (_$module == null) {
        _$module = new $ceylon$dart$runtime$model.json$LazyJsonModule(new $ceylon$interop$dart.JsonObject(_$jsonModel));
        _$module.initializeImports((new $ceylon$interop$dart.CeylonIterable([$ceylon$interop$dart.$module, $ceylon$dart$runtime$core.$module, $ceylon$dart$runtime$model.$module])).sequence());
    }
    return _$module;
}
