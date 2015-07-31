library ceylon.language;

import 'dart:core' as $dart$core;
import 'dart:io' as $dart$io;
import 'dart:math' as $dart$math;
import 'dart:mirrors' as $dart$mirrors;
import '../../../ceylon.language-1.1.1.dart';

class LazyIterable implements Iterable {
  $dart$core.int count;
  $dart$core.Function generate; // Object(Integer)
  Iterable spread;

  LazyIterable(this.count, this.generate, this.spread) {}

  @$dart$core.override
  Iterator iterator()
    =>  new LazyIterator(count, generate, spread);

  @$dart$core.override
  Iterable follow($dart$core.Object head)
    // FIXME this is a terrible, non-lazy hack
    =>  new Tuple(head, this);

  // bridge methods

  @$dart$core.override
  $dart$core.int get size
    =>  Iterable.$get$size(this);

  @$dart$core.override
  $dart$core.bool get empty
    =>  Iterable.$empty(this);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable map(Callable collecting)
    =>  Iterable.$map(this, collecting);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  $dart$core.String toString()
    =>  Iterable.$toString(this);

  @$dart$core.override
  void each(Callable step)
    =>  Iterable.$each(this, step);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);
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

class Array implements List {
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
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  @$dart$core.override
  Iterable follow($dart$core.Object head)
    =>  new Tuple(head, this);

  // bridge methods
  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    =>  List.$defines(this, index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    =>  List.$get(this, index);

  @$dart$core.override
  getFromLast($dart$core.int index)
    =>  List.$getFromLast(this, index);

  @$dart$core.override
  Iterator iterator()
    =>  List.$iterator(this);

  @$dart$core.override
  $dart$core.int get size
    =>  List.$get$size(this);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable map(Callable collecting)
    =>  Iterable.$map(this, collecting);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  $dart$core.String toString()
    =>  Iterable.$toString(this);

  @$dart$core.override
  void each(Callable step)
    =>  Iterable.$each(this, step);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);
}

//
// ArraySequence.dart
//

class ArraySequence implements Sequence {
  final Array array;

  ArraySequence(Array this.array) {
    if (array.empty) {
      throw new AssertionError("array must not be empty");
    }
  }

  @$dart$core.override
  Iterable follow($dart$core.Object head)
    =>  withLeading(head);

  // delegate
  @$dart$core.override
  $dart$core.int get lastIndex
    =>  array.lastIndex;

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  array.getFromFirst(index);

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    =>  array.defines(index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    =>  array.get(index);

  @$dart$core.override
  getFromLast($dart$core.int index)
    =>  array.getFromLast(index);

  @$dart$core.override
  Iterator iterator()
    =>  array.iterator();

  @$dart$core.override
  $dart$core.int get size
    =>  array.size;

  @$dart$core.override
  void each(Callable step)
    =>  array.each(step);

  @$dart$core.override
  Iterable map(Callable collecting)
    =>  array.map(collecting);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  $dart$core.String toString()
    =>  Iterable.$toString(this);

  @$dart$core.override
  Sequence sequence()
    =>  Sequence.$sequence(this);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  Sequence.$withLeading(this, other);

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  Sequence.$withTrailing(this, other);
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
// Collection.dart
//

abstract class Collection implements Iterable {}

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
// Correspondence.dart
//

abstract class Correspondence {
  $dart$core.bool defines($dart$core.Object key);
  $dart$core.Object get($dart$core.Object key);
}

//
// Empty.dart
//

class Empty implements Sequential {
  const Empty();

  @$dart$core.override
  get size => 0;

  @$dart$core.override
  each(Callable step) {}

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element) => false;

  @$dart$core.override
  Iterator iterator() => emptyIterator;

  @$dart$core.override
  getFromFirst(index) => null;

  @$dart$core.override
  getFromLast(index) => null;

  @$dart$core.override
  get($dart$core.Object index) => null;

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object el) => false;

  @$dart$core.override
  $dart$core.int get lastIndex => null;

  @$dart$core.override
  $dart$core.bool get empty => true;

  @$dart$core.override
  Iterable map(Callable collecting) => this;

  @$dart$core.override
  Sequential sequence() => $package$empty;

  @$dart$core.override
  $dart$core.String toString() => "{}";

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  new Tuple(other, $package$empty);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  new Tuple(other, $package$empty);

  @$dart$core.override
  $dart$core.Object follow($dart$core.Object head)
    =>  new Tuple(head, $package$empty);

  @$dart$core.override
  $dart$core.Object get first
    =>  null;

  @$dart$core.override
  Iterable get rest
    =>  this;
}

final Empty empty = new Empty();
final $package$empty = empty;

class $EmptyIterator implements Iterator {
  const $EmptyIterator();

  @$dart$core.override
  next() => finished;
}
final emptyIterator = new $EmptyIterator();

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

  Float plusInteger($dart$core.int integer) => new Float(_value * integer);
  Float powerOfInteger($dart$core.int integer) => new Float($dart$math.pow(_value, integer));
  Float timesInteger($dart$core.int integer) => new Float(_value * integer);

  Float divided([Float other]) => new Float(this._value / other._value);
  Float times([Float other]) => new Float(this._value * other._value);

  Float get negated => new Float(-this._value);
  Float minus([Float other]) => new Float(this._value - other._value);

  Float plus([Float other]) => new Float(this._value + other._value);

  Float power([Float other]) => new Float($dart$math.pow(this._value, other._value));

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

  $dart$core.bool divides(Integer other) => other._value % _value == 0;
  Integer remainder(Integer other)
    => new Integer(_value - other._value * (_value ~/ other._value));

  Integer plusInteger($dart$core.int integer) => new Integer(_value + integer);
  Integer powerOfInteger($dart$core.int integer) => new Integer($dart$math.pow(_value, integer));
  Integer timesInteger($dart$core.int integer) => new Integer(_value * integer);

  Integer divided([Integer other]) => new Integer(this._value ~/ other._value);
  Integer times([Integer other]) => new Integer(this._value * other._value);

  Integer get negated => new Integer(-this._value);
  Integer minus(Integer other) => new Integer(this._value - other._value);

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
// Integral.dart
//

abstract class Integral implements Number, Enumerable {
  $dart$core.bool get unit;
  $dart$core.bool get zero;

  $dart$core.bool divides($dart$core.Object other);
  $dart$core.Object remainder($dart$core.Object other);
}

//
// Invertible.dart
//

abstract class Invertible implements Summable {
  $dart$core.Object get negated;
  $dart$core.Object minus($dart$core.Object other);
}

//
// Iterable.dart
//

abstract class Iterable {
  Iterator iterator();

  $dart$core.int get size;
  static $dart$core.int $get$size(Iterable $this) {
    var count = 0;
    $this.each(new dart$Callable((_) { count++; }));
    return count;
  }

  $dart$core.bool get empty;
  static $dart$core.bool $empty(Iterable $this)
    =>  $dart$core.identical($this.iterator().next(), finished);

  void each(Callable step);
  static void $each(
      Iterable $this,
      Callable step) {
    var it = $this.iterator();
    for (var item = it.next(); item != finished;
          item = it.next()) {
      step.$delegate$(item);
    }
  }

  $dart$core.Object get first;
  static $dart$core.Object $first(Iterable $this) {
    $dart$core.Object result = $this.iterator().next();
    if (result is Finished) {
      return null;
    }
    return result;
  }

  Iterable map(Callable collecting);
  static $dart$core.Object $map(Iterable $this, Callable collecting) {
    // FIXME this is a terrible, non-lazy hack
    var list = [];
    $this.each(new dart$Callable((e) => list.add(e)));
    return new Array._withList(list.map(collecting.$delegate$).toList());
  }

  Iterable get rest;
  static $dart$core.Object $rest(Iterable $this) {
    // FIXME this is a terrible, non-lazy hack
    var list = [];
    Iterator it = $this.iterator();
    var e = it.next();
    while ((e = it.next()) is !Finished) {
      list.add(e);
    }
    return new Array._withList(list);
  }

  Sequential sequence();
  static Sequential $sequence(Iterable $this) {
    Array array = new Array($this);
    if (array.empty) {
      return $package$empty;
    }
    return new ArraySequence(array);
  }

  $dart$core.bool contains($dart$core.Object element);
  static $dart$core.bool $contains(Iterable $this, $dart$core.Object element) {
    // TODO
    throw new AssertionError("not yet implemented");
  }

  Iterable follow($dart$core.Object element);

  static $dart$core.String $toString(Iterable $this) {
    //Sequential elements = $this.take(31).sequence();
    Sequential elements = $this.sequence();
    if (elements.empty) {
      return "{}";
    } else if (Integer.instance(elements.size).equals(Integer.instance(31))) {
      //return ("{ " + commaList(elements.take(30))) + ", ... }";
      return ("{ " + commaList(elements)) + ", ... }";
    } else {
      return ("{ " + commaList(elements)) + " }";
    }
  }
}

//
// List.dart
//

abstract class List implements Collection, Correspondence {
  $dart$core.int get lastIndex;

  $dart$core.Object getFromFirst($dart$core.int index);

  $dart$core.Object get($dart$core.Object index);
  static $dart$core.Object $get
        (List $this, $dart$core.Object index)
    =>  index is Integer &&
        $this.getFromFirst(index._value);

  $dart$core.Object getFromLast($dart$core.int index);
  static $dart$core.Object $getFromLast
        (List $this, $dart$core.int index)
    =>  $this.get($this.lastIndex);

  $dart$core.bool defines($dart$core.Object index);
  static $dart$core.Object $defines
        (List $this, $dart$core.Object index) {
    $dart$core.int lastIndex = $this.lastIndex;
    return lastIndex != null &&
        index is Integer &&
        0 <= index._value &&
        index._value <= $this.lastIndex;
  }

  @$dart$core.override
  $dart$core.int get size;
  static $dart$core.int $get$size
        (List $this)
    =>  $this.lastIndex == null ? 0 : $this.lastIndex + 1;

  $dart$core.bool get empty;
  static $dart$core.bool $empty(List $this)
    =>  $this.lastIndex == null;

  @$dart$core.override
  Iterator iterator();
  static Iterator $iterator(List $this) {
    // capture a variable (very unoptimized!)
    dart$VariableBoxInt index = new dart$VariableBoxInt(0);
    // simulate anonymous class
    return new _$ListIterator_anon($this, index);
  }
}

// Simulate anonymous class
class _$ListIterator_anon implements Iterator {
  // just assume all members are visible
  List $outer;

  // this can only be captured when there is
  // no member name conflict, right?
  dart$VariableBoxInt index;

  _$ListIterator_anon(List this.$outer, dart$VariableBoxInt this.index);

  $dart$core.Object next() {
    if (index.ref <= $outer.lastIndex) {
      return $outer.getFromFirst(index.ref++);
    }
    return finished;
  }
}

//
// Nothing.dart
//

$dart$core.Object get nothing
  =>  throw new AssertionError("nothing may not be evaluated");

//
// Number.dart
//

abstract class Number implements Numeric, Comparable {
  $dart$core.Object plusInteger($dart$core.int integer);
  $dart$core.Object powerOfInteger($dart$core.int integer);
  $dart$core.Object timesInteger($dart$core.int integer);
}

//
// Sequence.dart
//

abstract class Sequence implements Sequential {
  Sequence sequence();
  static Sequence $sequence(Iterable $this)
    =>  $this;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other);
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
  Sequence withLeading($dart$core.Object other);
  static Sequence $withLeading
        (Sequence $this, $dart$core.Object other)
    =>  new Tuple(other, $this);
}

//
// Sequential.dart
//

abstract class Sequential implements List {
  Sequence withLeading($dart$core.Object element);
  Sequence withTrailing($dart$core.Object element);
}

//
// String.dart
//

class String implements List {
  final $dart$core.String _value;

  String(Iterable characters) :
      _value = characters is String
        ? characters._value
        : fromCharacters(characters);

  String._fromNative($dart$core.String this._value);

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
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
  Iterable follow($dart$core.Object c)
    =>  new String._fromNative(c.toString() + _value);

  // bridge methods

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    => List.$defines(this, index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    => List.$get(this, index);

  @$dart$core.override
  Iterator iterator()
    => List.$iterator(this);

  @$dart$core.override
  getFromLast(index)
    => List.$getFromLast(this, index);

  @$dart$core.override
  $dart$core.int get size
    => List.$get$size(this);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  void each(Callable step)
    => Iterable.$each(this, step);

  @$dart$core.override
  Iterable map(Callable collecting)
    =>  Iterable.$map(this, collecting);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);

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

  // TODO remove this hack (compiler needs to translate)
  $dart$core.String get string => toString();

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

class Tuple implements List, Sequence, Iterable {
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
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  new Tuple._trailing(this, other);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  new Tuple(other, this);

  @$dart$core.override
  Iterable follow($dart$core.Object head)
    =>  withLeading(head);

  // bridge methods
  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    =>  List.$defines(this, index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    =>  List.$get(this, index);

  @$dart$core.override
  getFromLast($dart$core.int index)
    =>  List.$getFromLast(this, index);

  @$dart$core.override
  Iterator iterator()
    =>  List.$iterator(this);

  @$dart$core.override
  $dart$core.int get size
    =>  List.$get$size(this);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable map(Callable collecting)
    =>  Iterable.$map(this, collecting);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  $dart$core.String toString()
    =>  Iterable.$toString(this);

  @$dart$core.override
  void each(Callable step)
    =>  Iterable.$each(this, step);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequence sequence()
    =>  Sequence.$sequence(this);
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

//
// newStuff.dart
//

abstract class Identifiable {
  $dart$core.bool equals($dart$core.Object that);
  static $dart$core.bool $equals
        (Identifiable $this, $dart$core.Object that) {
    return (that is Identifiable) &&
        $dart$core.identical($this,  that);
  }
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

abstract class Enumerable implements Ordinal {}

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

