library ceylon.language;

import 'dart:core' as $dart$core;
import 'dart:io' as $dart$io;
import 'dart:math' as $dart$math;
import 'dart:mirrors' as $dart$mirrors;
import '../../../ceylon.language-1.1.1.dart';

class LazyIterable extends impl$BaseIterable {
  $dart$core.int count_;
  $dart$core.Function generate; // Object(Integer)
  Iterable spread_;

  LazyIterable(this.count_, this.generate, this.spread_) {}

  @$dart$core.override
  Iterator iterator()
    =>  new LazyIterator(count_, generate, spread_);

  @$dart$core.override
  Iterable follow([$dart$core.Object head])
    // FIXME this is a terrible, non-lazy hack
    =>  new Tuple(head, this);
}

class LazyIterator implements Iterator {
  final $dart$core.int count;
  final $dart$core.Function generate;
  final Iterable spread;

  $dart$core.int index = 0;
  Iterator rest;

  LazyIterator(this.count, this.generate, this.spread) {}

  $dart$core.Object next() {
    if (rest != null) {
      return rest.next();
    }
    else if (index >= count) {
      return $package$finished;
    }
    else {
      $dart$core.Object result = generate(index++);
      if (index == count && spread != null) {
        rest = spread.iterator();
      }
      return result;
    }
  }
}

//
// Array.dart
//

class Array extends impl$BaseList {
  $dart$core.List _list;

  Array(Iterable elements) {
    _list = [];
    elements.each(new dart$Callable((e) => _list.add(e)));
  }

  Array.ofSize($dart$core.int size, $dart$core.Object element) {
    _list = new $dart$core.List.filled(size, element);
  }

  Array._withList($dart$core.List this._list);

  void set($dart$core.int index, $dart$core.Object element) {
    if (index < 0 || index > lastIndex) {
      throw new AssertionError("Index out of bounds");
    }
    _list[index] = element;
  }

  @$dart$core.override
  $dart$core.int get lastIndex
    =>  _list.length - 1;

  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index])
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  @$dart$core.override
  Iterable follow([$dart$core.Object head])
    =>  new Tuple(head, this);

  Sequential sort([Callable c]) {
    var newList = _list.toList();
    newList.sort(c.$delegate$);
    return new ArraySequence(new Array._withList(newList));
  }

  @$dart$core.override
  $dart$core.bool get empty
    =>  _list.length == 0;
}

//
// AssertionError.dart
//

class AssertionError extends Throwable {
  AssertionError($dart$core.String message)
      : super(message);
}

//
// Boolean.dart
//

class Boolean {
  final $dart$core.bool _value;

  const Boolean.$true() : _value = true;
  const Boolean.$false() : _value = false;

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  // Dart runtime

  static Boolean instance($dart$core.bool value)
    => value == null ? null : (value ? $true : $false);

  static $dart$core.bool nativeValue(Boolean value)
    => value == null ? null : value._value;
}

const $true = const Boolean.$true();
const $false = const Boolean.$false();

//
// Callable.dart
//

abstract
class Callable {
    $dart$core.Function get $delegate$;
}

//
// Character.dart
//

class Character {
  $dart$core.int _value;

  Character(Character character) {
    _value = character._value;
  }

  Character.$fromInt($dart$core.int this._value);

  $dart$core.int get integer => _value;

  @$dart$core.override
  $dart$core.String toString()
    => new $dart$core.String.fromCharCode(_value);

  // TODO remove this hack (compiler needs to translate)
  $dart$core.String get string => toString();
}

//
// Comparison.dart
//

class Comparison {
  const Comparison();
}

class $Larger extends Comparison {
  const $Larger.value();
}

class $Smaller extends Comparison {
  const $Smaller.value();
}

class $Equal extends Comparison {
  const $Equal.value();
}

const larger = const $Larger.value();
const smaller = const $Smaller.value();
const equal = const $Equal.value();

const $package$larger = larger;
const $package$smaller = smaller;
const $package$equal = equal;

//
// Empty.dart
//
class $empty implements Empty {
  const $empty();

  $dart$core.Object getFromLast([$dart$core.int index])
      => Empty.$getFromLast(this, index);

  $dart$core.Object getFromFirst([$dart$core.int index])
      => Empty.$getFromFirst(this, index);

  $dart$core.bool contains([$dart$core.Object element])
      =>  Empty.$contains(this, element);

  $dart$core.bool defines([Integer index])
      =>  Empty.$defines(this, index);

  Empty get keys
      =>  Empty.$get$keys(this);

  $dart$core.bool get empty
      =>  Empty.$get$empty(this);

  $dart$core.int get size
      =>  Empty.$get$size(this);

  Empty get reversed
      =>  Empty.$get$reversed(this);

  Empty sequence()
      =>  Empty.$sequence(this);

  $dart$core.String get string
      =>  Empty.$get$string(this);

  $dart$core.Object get lastIndex
      =>  Empty.$get$lastIndex(this);

  $dart$core.Object get first
      =>  Empty.$get$first(this);

  $dart$core.Object get last
      =>  Empty.$get$last(this);

  Empty get rest
      =>  Empty.$get$rest(this);

  Empty clone()
      =>  Empty.$clone(this);

  Empty get coalesced
      =>  Empty.$get$coalesced(this);

  Empty get indexed
      =>  Empty.$get$indexed(this);

  Empty repeat([$dart$core.int times])
      =>  Empty.$repeat(this, times);

  Empty get cycled
      =>  Empty.$get$cycled(this);

  Empty get paired
      =>  Empty.$get$paired(this);

  Iterator iterator()
      =>  Empty.$iterator(this);

  Empty measure([Integer from, $dart$core.int length])
      =>  Empty.$measure(this, from, length);

  Empty span([Integer from, Integer to])
      =>  Empty.$span(this, from, to);

  Empty spanTo([Integer to])
      =>  Empty.$spanTo(this, to);

  Empty spanFrom([Integer from])
      =>  Empty.$spanFrom(this, from);

  Iterable chain([Iterable other])
      =>  Empty.$chain(this, other);

  Empty defaultNullElements([$dart$core.Object defaultValue])
      =>  Empty.$defaultNullElements(this, defaultValue);

  $dart$core.int count([Callable selecting])
      =>  Empty.$count(this, selecting);

  Empty map([Callable collecting])
      =>  Empty.$map(this, collecting);

  Empty flatMap([Callable collecting])
      =>  Empty.$flatMap(this, collecting);

  Callable spread([Callable method])
      =>  Empty.$spread(this, method);

  Empty filter([Callable selecting])
      =>  Empty.$filter(this, selecting);

  Callable fold([$dart$core.Object initial])
      =>  Empty.$fold(this, initial);

  $dart$core.Object reduce([Callable accumulating])
      =>  Empty.$reduce(this, accumulating);

  $dart$core.Object find([Callable selecting])
      =>  Empty.$find(this, selecting);

  Empty sort([Callable comparing])
      =>  Empty.$sort(this, comparing);

  Empty collect([Callable collecting])
      =>  Empty.$collect(this, collecting);

  Empty select([Callable selecting])
      =>  Empty.$select(this, selecting);

  $dart$core.bool any([Callable selecting])
      =>  Empty.$any(this, selecting);

  $dart$core.bool every([Callable selecting])
      =>  Empty.$every(this, selecting);

  Empty skip([$dart$core.int skipping])
      =>  Empty.$skip(this, skipping);

  Empty take([$dart$core.int taking])
      =>  Empty.$take(this, taking);

  Empty skipWhile([Callable skipping])
      =>  Empty.$skipWhile(this, skipping);

  Empty takeWhile([Callable taking])
      =>  Empty.$takeWhile(this, taking);

  Empty by([$dart$core.int step])
      =>  Empty.$by(this, step);

  Tuple withLeading([$dart$core.Object element])
      =>  Empty.$withLeading(this, element);

  Tuple withTrailing([$dart$core.Object element])
      =>  Empty.$withTrailing(this, element);

  Sequential append([Sequential elements])
      =>  Empty.$append(this, elements);

  Sequential prepend([Sequential elements])
      =>  Empty.$prepend(this, elements);

  Empty sublist([$dart$core.int from, $dart$core.int to])
      =>  Empty.$sublist(this, from, to);

  Empty sublistFrom([$dart$core.int from])
      =>  Empty.$sublistFrom(this, from);

  Empty sublistTo([$dart$core.int to])
      =>  Empty.$sublistTo(this, to);

  Empty initial([$dart$core.int length])
      =>  Empty.$initial(this, length);

  Empty terminal([$dart$core.int length])
      =>  Empty.$terminal(this, length);

  Empty indexesWhere([Callable selecting])
      =>  Empty.$indexesWhere(this, selecting);

  $dart$core.Object firstIndexWhere([Callable selecting])
      =>  Empty.$firstIndexWhere(this, selecting);

  $dart$core.Object lastIndexWhere([Callable selecting])
      =>  Empty.$lastIndexWhere(this, selecting);

  $dart$core.bool includes([List sublist])
      =>  Empty.$includes(this, sublist);

  Empty trim([Callable trimming])
      =>  Empty.$trim(this, trimming);

  Empty trimLeading([Callable trimming])
      =>  Empty.$trimLeading(this, trimming);

  Empty trimTrailing([Callable trimming])
      =>  Empty.$trimTrailing(this, trimming);

  Tuple slice([$dart$core.int index])
      =>  Empty.$slice(this, index);

  void each([Callable step])
      =>  Empty.$each(this, step);

  Iterable follow([$dart$core.Object head])
      =>  Empty.$follow(this, head);
}

//
// Exception.dart
//

class Exception extends Throwable {
  Exception.$(
      $dart$core.String message,
      Throwable cause)
      : super(message, cause);

  Exception([
      $dart$core.String message = dart$default,
      Throwable cause = dart$default]) : this.$(
          $dart$core.identical(message, dart$default) ? null : message,
          $dart$core.identical(cause, dart$default) ? null : cause);
}

//
// Finished.dart
//

class Finished {
  const Finished();
}

const finished = const Finished();
const $package$finished = finished;

//
// Float.dart
//

class Float implements Number, Exponentiable {
  final $dart$core.double _value;

  Float($dart$core.double this._value);

  Float plusInteger([$dart$core.int integer]) => new Float(_value * integer);
  Float powerOfInteger([$dart$core.int integer]) => new Float($dart$math.pow(_value, integer));
  Float timesInteger([$dart$core.int integer]) => new Float(_value * integer);

  Float divided([Float other]) => new Float(this._value / other._value);
  Float times([Float other]) => new Float(this._value * other._value);

  Float get negated => new Float(-this._value);
  Float minus([Float other]) => new Float(this._value - other._value);

  Float plus([Float other]) => new Float(this._value + other._value);

  Float power([Float other]) => new Float($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  $dart$core.bool equals($dart$core.Object other) {
    if (other is Float) {
      return _value == other._value;
    }
    return false;
  }

  // Comparable
  Comparison compare([Float other])
      =>  _value < other._value ? smaller : (_value > other._value ? larger : equal);

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool largerThan([Float other]) => _value > other._value;

  @$dart$core.override
  $dart$core.bool smallerThan([Float other]) => _value < other._value;

  @$dart$core.override
  $dart$core.bool notLargerThan([Float other]) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool notSmallerThan([Float other]) => _value >= other._value;

  // Dart runtime

  static Float instance($dart$core.double value)
    => value == null ? null : new Float(value);

  static $dart$core.double nativeValue(Float value)
    => value == null ? null : value._value;
}

//
// Integer.dart
//

class Integer implements Integral, Exponentiable, Binary {
  final $dart$core.int _value;

  Integer($dart$core.int this._value);

  $dart$core.bool get unit => _value == 1;
  $dart$core.bool get zero => _value == 0;

  $dart$core.bool divides([Integer other]) => other._value % _value == 0;
  Integer remainder([Integer other])
    => new Integer(_value - other._value * (_value ~/ other._value));

  Integer plusInteger([$dart$core.int integer]) => new Integer(_value + integer);
  Integer powerOfInteger([$dart$core.int integer]) => new Integer($dart$math.pow(_value, integer));
  Integer timesInteger([$dart$core.int integer]) => new Integer(_value * integer);

  Integer divided([Integer other]) => new Integer(this._value ~/ other._value);
  Integer times([Integer other]) => new Integer(this._value * other._value);

  Integer get negated => new Integer(-this._value);
  Integer minus([Integer other]) => new Integer(this._value - other._value);

  Integer plus([Integer other]) => new Integer(this._value + other._value);

  Integer power([Integer other]) => new Integer($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  Character get character => new Character.$fromInt(_value);

  $dart$core.bool equals($dart$core.Object other) {
    if (other is Integer) {
      return _value == other._value;
    }
    return false;
  }

  $dart$core.double get float => _value.toDouble();

  // Binary

  // FIXME fix bugs and simulate 64bits using `toSigned`

  Integer rightLogicalShift([$dart$core.int shift]) => new Integer(this._value >> shift);
  Integer leftLogicalShift([$dart$core.int shift]) => new Integer(this._value << shift);

  Integer rightArithmeticShift([$dart$core.int shift]) => new Integer(this._value >> shift);
  Integer leftArithmeticShift([$dart$core.int shift]) => new Integer(this._value << shift);

  $dart$core.bool get([$dart$core.int index]) {
    if (index < 0 || index > 63) {
      return false;
    }
    return _value.toSigned(64) & (1<<index) == 0;
  }

  Integer set([$dart$core.int index, $dart$core.bool bit]) {
    if (index < 0 || index > 63) {
      return new Integer(_value.toSigned(64));
    }
    $dart$core.int mask = (1 << index).toSigned(64);
    if (bit) {
      return new Integer(_value.toSigned(64) | mask);
    }
    else {
      return new Integer(_value.toSigned(64) & ~mask);
    }
  }

  Integer flip([$dart$core.int index, $dart$core.bool bit]) {
    if (index < 0 || index > 63) {
      return new Integer(_value.toSigned(64));
    }
    $dart$core.int mask = (1 << index).toSigned(64);
    return new Integer(_value.toSigned(64) ^ mask);
  }

  Integer clear([$dart$core.int index]) => set(index, false);

  Integer or([Integer other])
    =>  new Integer(_value.toSigned(64) | other._value.toSigned(64));

  Integer and([Integer other])
    =>  new Integer(_value.toSigned(64) & other._value.toSigned(64));

  Integer xor([Integer other])
    =>  new Integer(_value.toSigned(64) ^ other._value.toSigned(64));

  Integer get not => new Integer(~_value.toSigned(64));

  // Ordinal

  Integer get predecessor => new Integer(this._value - 1);
  Integer get successor => new Integer(this._value + 1);

  // Comparable
  Comparison compare([Float other])
      =>  _value < other._value ? smaller : (_value > other._value ? larger : equal);

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool largerThan([Integer other]) => _value > other._value;

  @$dart$core.override
  $dart$core.bool smallerThan([Integer other]) => _value < other._value;

  @$dart$core.override
  $dart$core.bool notLargerThan([Integer other]) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool notSmallerThan([Integer other]) => _value >= other._value;

  // Dart runtime

  static Integer instance($dart$core.int value)
    => value == null ? null : new Integer(value);

  static $dart$core.int nativeValue(Integer value)
    => value == null ? null : value._value;

  // TODO remove this hack (compiler needs to translate)
  $dart$core.String get string => toString();
}

//
// Sequence.dart
//

abstract class Sequence implements Sequential {
  Sequence sequence();
  static Sequence $sequence(Iterable $this)
    =>  $this;

  @$dart$core.override
  Sequence withTrailing([$dart$core.Object other]);
  static Sequence $withTrailing
        (Sequence $this, $dart$core.Object other) {
    var oldSize = $this.size;
    var list = new $dart$core.List(oldSize + 1);
    for (var i = 0; i < oldSize; i++) {
      list[i] = $this.get(i);
    }
    list[oldSize] = other;
    return new ArraySequence(new Array._withList(list));
  }

  @$dart$core.override
  Sequence withLeading([$dart$core.Object other]);
  static Sequence $withLeading
        (Sequence $this, $dart$core.Object other)
    =>  new Tuple(other, $this);

  @$dart$core.override
  static $dart$core.String $get$string($this)
    =>  Iterable.$get$string($this);

  static $dart$core.bool $get$empty($this)
    =>  false;
}

//
// String.dart
//

class String extends impl$BaseList {
  final $dart$core.String _value;

  String(Iterable characters) :
      _value = characters is String
        ? characters._value
        : fromCharacters(characters);

  String._fromNative($dart$core.String this._value);

  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index])
    => index >= 0 && index <= lastIndex
        ? new Character.$fromInt(
                _value.codeUnitAt(index))
        : null;

  @$dart$core.override
  $dart$core.int get lastIndex
    => _value.isNotEmpty
          ? _value.length - 1
          : null;

  $dart$core.String join(Iterable objects)
    => dartJoin(this._value, objects);

  // Iterable

  @$dart$core.override
  Iterable follow([$dart$core.Object c])
    =>  new String._fromNative(c.toString() + _value);

  @$dart$core.override
  $dart$core.bool get empty
    =>  _value == "";

  // Dart runtime

  static String instance($dart$core.String value)
    => value == null ? null : new String._fromNative(value);

  static $dart$core.String nativeValue(String value)
    => value == null ? null : value._value;

  static $dart$core.String fromCharacters(Iterable characters) {
    // TODO make much more efficient!
    $dart$core.String result = "";
    characters.each(new dart$Callable((c) => result = result + c.toString()));
    return result;
  }

  // TODO change to "==" once compiler handles this
  $dart$core.bool equals([$dart$core.Object other]) {
    if (other is String) {
      return _value == other._value;
    }
    return false;
  }

  $dart$core.String toString() => _value;
}

//
// Throwable.dart
//

class Throwable extends $dart$core.Error {
  $dart$core.String _description;
  final Throwable cause;

  Sequential _suppressed = empty;

  Throwable.$(
        $dart$core.String message,
        Throwable this.cause) {
    this._description = message;
  }

  Throwable([
      $dart$core.String message = dart$default,
      $dart$core.Object cause = dart$default]) : this.$(
          $dart$core.identical(message, dart$default) ? null : message,
          $dart$core.identical(cause, dart$default) ? null : cause);

  $dart$core.String get message {
    if (_description != null) {
      return _description;
    }
    else if (cause != null) {
      return cause.message;
    }
    return "";
  }

  $dart$core.String toString() {
    return className(this) + " \"$message\"";
  }

  void addSuppressed(Throwable suppressed) {
    _suppressed = _suppressed.withTrailing(suppressed);
  }

  Sequential get suppressed
    =>  _suppressed;

  void printStackTrace() {
    // Note: stackTrace is only available after `throw`
    print(stackTrace);
  }
}

//
// Tuple.dart
//

class Tuple extends impl$BaseList implements Sequence, Iterable {
  final $dart$core.List _list;

  Tuple($dart$core.Object first, Iterable rest) : _list = [] {
    _list.add(first);
    rest.each(new dart$Callable((e) => _list.add(e)));
  }

  Tuple._trailing(Iterable initial, $dart$core.Object element) : _list = [] {
    initial.each(new dart$Callable((e) => _list.add(e)));
    _list.add(element);
  }

  Tuple.$ofElements(Iterable rest) : _list = [] {
    rest.each(new dart$Callable((e) => _list.add(e)));
    if (_list.length == 0) {
      throw new AssertionError("list must not be empty");
    }
  }

  Tuple.$withList([$dart$core.List this._list, Iterable rest = null]) {
    if (_list.length == 0) {
      throw new AssertionError("list must not be empty");
    }
    if (rest != null) {
      rest.each(new dart$Callable((e) => _list.add(e)));
    }
  }

  @$dart$core.override
  $dart$core.int get lastIndex =>
      _list.length - 1;

  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index])
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  @$dart$core.override
  Sequence withTrailing([$dart$core.Object other])
    =>  new Tuple._trailing(this, other);

  @$dart$core.override
  Sequence withLeading([$dart$core.Object other])
    =>  new Tuple(other, this);

  @$dart$core.override
  Iterable follow([$dart$core.Object head])
    =>  withLeading(head);

  @$dart$core.override
  $dart$core.bool get empty
    =>  _list.length == 0;
}

//
// className.dart
//

$dart$core.String className($dart$core.Object obj) {
  // TODO use our own reified metadata when available?
  // removing dependency on `dart:mirrors` would be nice
  $dart$mirrors.ClassMirror mirror = $dart$mirrors.reflectClass(obj.runtimeType);
  return $dart$mirrors.MirrorSystem.getName(mirror.qualifiedName);
}

// process

class process_ {
  const process_.$value$();

  void write([$dart$core.String string]) {
    $dart$io.stdout.write(string);
  }

  void writeLine([$dart$core.Object line = dart$default]) {
    if ($dart$core.identical(line, dart$default)) {
      line = "";
    }
    $dart$io.stdout.writeln(line);
  }

  void writeError([$dart$core.String string]) {
    $dart$io.stderr.write(string);
  }

  void writeErrorLine([$dart$core.Object line = dart$default]) {
    if ($dart$core.identical(line, dart$default)) {
      line = "";
    }
    $dart$io.stderr.writeln(line);
  }
}

const process = const process_.$value$();

const $package$process = process;

// operatingSystem

class operatingSystem_ {
  const operatingSystem_.$value$();

  $dart$core.String get newline => "\n";
}

const operatingSystem = const operatingSystem_.$value$();

const $package$operatingSystem = operatingSystem;

////////////////////////////////////////////////////////////////////////////////
//
// Runtime Package (ceylon.language.dart)
//
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////
//
// Capture boxes
//
///////////////////////////////////////

// Separate classes for bool, int, etc, aren't
// necessary on Dart, but using them anyway. And,
// to keep everything consistent, we'll have a
// box for core.String too.

class dart$VariableBox<T> {
  T ref;
  dart$VariableBox(T this.ref);
}

class dart$VariableBoxBool {
  $dart$core.bool ref;
  dart$VariableBoxBool($dart$core.bool this.ref);
}

class dart$VariableBoxInt {
  $dart$core.int ref;
  dart$VariableBoxInt($dart$core.int this.ref);
}

class dart$VariableBoxDouble {
  $dart$core.double ref;
  dart$VariableBoxDouble($dart$core.double this.ref);
}

class dart$VariableBoxString {
  $dart$core.String ref;
  dart$VariableBoxString($dart$core.String this.ref);
}

///////////////////////////////////////
//
// Unimplemented
//
///////////////////////////////////////

class Map {}

///////////////////////////////////////
//
// Default Argument
//
///////////////////////////////////////

class dart$Default {
  const dart$Default();
}

const dart$default = const dart$Default();

const $package$dart$default = dart$Default;

///////////////////////////////////////
//
// Misc
//
///////////////////////////////////////

class dart$Callable implements Callable {

  final $dart$core.Function $delegate$;

  dart$Callable($dart$core.Function this.$delegate$);
}

/////////////////////////////////////////////////////////////////////////////////

