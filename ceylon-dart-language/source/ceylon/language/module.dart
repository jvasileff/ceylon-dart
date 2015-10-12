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

$dart$core.Function dartComparator(Callable ceylonComparator) {
  return (var x, var y) {
    var result = ceylonComparator.f(x,y);
    if (result is $Smaller) {
      return -1;
    }
    if (result is $Equal) {
      return 0;
    }
    return 1;
  };
}

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

  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index])
    => (0 <= index && index < size) ? _list[index] : null;

  @$dart$core.override
  $dart$core.int get lastIndex
    => _list.isEmpty ? null : _list.length - 1;

  @$dart$core.override
  $dart$core.int get size
    => _list.length;

  @$dart$core.override
  $dart$core.bool get empty
    => _list.isEmpty;

  @$dart$core.override
  Array clone()
    => new Array._withList(_list.toList());

  void set($dart$core.int index, $dart$core.Object element) {
    if (index < 0 || index > lastIndex) {
      throw new AssertionError("Index out of bounds");
    }
    _list[index] = element;
  }

  void copyTo([Array destination,
          $dart$core.Object sourcePosition = $package$dart$default,
          $dart$core.Object destinationPosition = $package$dart$default,
          $dart$core.Object length = $package$dart$default]) {
    Array source;
    if ($dart$core.identical(this._list, destination._list)) {
      source = this.clone();
    }
    else {
      source = this;
    }
    $package$dartListCopyTo(source, destination, sourcePosition, destinationPosition, length);
  }

  // TODO optimize span and measure functions
  @$dart$core.override
  Array span([Integer from, Integer to])
    => new Array(List.$span(this, from, to));

  @$dart$core.override
  Array spanFrom([Integer from])
    => new Array(List.$spanFrom(this, from));

  @$dart$core.override
  Array spanTo([Integer to])
    => new Array(List.$spanTo(this, to));

  @$dart$core.override
  Array measure([Integer from, $dart$core.int length])
    => new Array(List.$measure(this, from, length));

  Sequential sort([Callable c]) {
    var newList = _list.toList();
    newList.sort(dartComparator(c));
    return new ArraySequence(new Array._withList(newList));
  }

  void sortInPlace([Callable c]) {
    _list.sort(dartComparator(c));
  }
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

const $package$$true = $true;
const $package$$false = $false;

//
// Callable.dart
//

abstract
class Callable {
    $dart$core.Function get f;
    $dart$core.Function get s;
}

//
// Character.dart
//

$dart$core.Set<$dart$core.int> wsChars = new $dart$core.Set.from([
    0x9, 0xa, 0xb, 0xc, 0xd, 0x20, 0x85,
    0x1680, 0x180e, 0x2028, 0x2029, 0x205f, 0x3000,
    0x1c, 0x1d, 0x1e, 0x1f,
    0x2000, 0x2001, 0x2002, 0x2003, 0x2004, 0x2005, 0x2006,
    0x2008, 0x2009, 0x200a]);

$dart$core.Set<$dart$core.int> digitZeroChars = new $dart$core.Set.from([
    0x30, 0x660, 0x6f0, 0x7c0, 0x966, 0x9e6, 0xa66,
    0xae6, 0xb66, 0xbe6, 0xc66, 0xce6, 0xd66, 0xe50,
    0xed0, 0xf20, 0x1040, 0x1090, 0x17e0, 0x1810, 0x1946,
    0x19d0, 0x1a80, 0x1a90, 0x1b50, 0x1bb0, 0x1c40, 0x1c50,
    0xa620, 0xa8d0, 0xa900, 0xa9d0, 0xaa50, 0xabf0, 0xff10,
    0x104a0, 0x11066, 0x110f0, 0x11136, 0x111d0, 0x116c0]);

class Character implements Comparable {
  $dart$core.int _value;

  Character(Character character) {
    _value = character._value;
  }

  Character.$fromInt($dart$core.int this._value);

  $dart$core.int get integer => _value;

  @$dart$core.override
  $dart$core.String toString()
    => new $dart$core.String.fromCharCode(_value);

  $dart$core.bool get whitespace => wsChars.contains(_value);

  $dart$core.bool get digit {
    // logic from javascript backend
    var check = _value & 0xfffffff0;
    if (digitZeroChars.contains(check)) {
      return (_value & 0xf <= 9);
    }
    else if (digitZeroChars.contains(check | 6)) {
      return (_value & 0xf >= 6);
    }
    else {
      return (_value >= 0x1d7ce && _value <= 0x1d7ff);
    }
  }

  $dart$core.bool get uppercase => toString().toLowerCase() != toString();

  $dart$core.bool get lowercase => toString().toUpperCase() != toString();

  Character get uppercased => new Character.$fromInt(toString().toUpperCase().runes.elementAt(0));

  Character get lowercased => new Character.$fromInt(toString().toLowerCase().runes.elementAt(0));

  // Comparable
  @$dart$core.override
  Comparison compare([Character other])
      =>  String.instance(toString()).compare(String.instance(other.toString()));

  @$dart$core.override
  $dart$core.bool largerThan([Character other])
    =>  String.instance(toString()).largerThan(String.instance(other.toString()));

  @$dart$core.override
  $dart$core.bool smallerThan([Character other])
    =>  String.instance(toString()).smallerThan(String.instance(other.toString()));

  @$dart$core.override
  $dart$core.bool notLargerThan([Character other])
    =>  String.instance(toString()).notLargerThan(String.instance(other.toString()));

  @$dart$core.override
  $dart$core.bool notSmallerThan([Character other])
    =>  String.instance(toString()).notSmallerThan(String.instance(other.toString()));

  $dart$core.bool equals($dart$core.Object other) {
    if (other is Character) {
      return _value == other._value;
    }
    return false;
  }
}

//
// Comparison.dart
//

abstract class Comparison {
  const Comparison();
  $dart$core.bool equals($dart$core.Object other)
    =>  ($dart$core.identical(this, other));
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

  $dart$core.int get integer => this._value.toInt();

  Float minus([Float other]) => new Float(this._value - other._value);

  Float plus([Float other]) => new Float(this._value + other._value);

  Float power([Float other]) => new Float($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  $dart$core.bool equals($dart$core.Object other) {
    if (other is Float) {
      return _value == other._value;
    }
    else if (other is Integer) {
      return _value == other._value;
    }
    return false;
  }

  $dart$core.int get hashCode => _value.hashCode;

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
  Integer get magnitude => new Integer(this._value.abs());
  Integer minus([Integer other]) => new Integer(this._value - other._value);

  Integer plus([Integer other]) => new Integer(this._value + other._value);

  Integer power([Integer other]) => new Integer($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  Character get character => new Character.$fromInt(_value);

  $dart$core.int get hashCode => _value.hashCode;

  $dart$core.bool equals($dart$core.Object other) {
    if (other is Integer) {
      return _value == other._value;
    }
    else if (other is Float) {
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

  // Enumerable
  Integer neighbour([$dart$core.int offset]) => new Integer(this._value + offset);
  $dart$core.int offset([Integer other]) => this._value - other._value;
  $dart$core.int offsetSign([Integer other]) => offset(other).sign;

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
// String.dart
//

class String extends impl$BaseCharacterList implements Summable, Comparable {
  final $dart$core.String _value;

  String(Iterable characters) :
      _value = characters is String
        ? characters._value
        : fromCharacters(characters);

  String._fromNative($dart$core.String this._value);

  //  shared native String lowercased;
  $dart$core.String get lowercased => _value.toLowerCase();

  //  shared native String uppercased;
  $dart$core.String get uppercased => _value.toUpperCase();

  //  shared native {String+} split(
  //          Boolean splitting(Character ch) => ch.whitespace,
  //          Boolean discardSeparators=true,
  //          Boolean groupSeparators=true);
  Iterable split([$dart$core.Object splitting = $package$dart$default,
          $dart$core.Object discardSeparators = $package$dart$default,
          $dart$core.Object groupSeparators = $package$dart$default])
    => $package$dartStringSplit(_value, splitting, discardSeparators, groupSeparators);

  //  shared actual formal Character? first;
  //  shared actual formal Character? last;

  //  shared actual native Character? getFromFirst(Integer index);
  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index]) {
    try {
      return new Character.$fromInt(_value.runes.elementAt(index));
    }
    catch (rangeError) {
      return null;
    }
  }

  //  shared actual formal Character? getFromLast(Integer index);

  //  shared actual formal String rest;
  @$dart$core.override
  String get rest {
    var sb = new $dart$core.StringBuffer();
    var it = _value.runes.iterator;
    it.moveNext();
    while (it.moveNext()) {
      sb.writeCharCode(it.current);
    }
    return new String._fromNative(sb.toString());
  }

  // shared actual native Integer[] keys => 0:size;
  @$dart$core.override
  Sequential get keys
    => new Measure(Integer.instance(0), size);

  //  shared native String join({Object*} objects);
  $dart$core.String join(Iterable objects)
    => $package$dartStringJoin(this._value, objects);

  //  shared {String*} lines
  Iterable get lines
    => $package$dartStringLines(this._value);

  //  shared {String*} linesWithBreaks
  Iterable get linesWithBreaks
    => $package$dartStringLinesWithBreaks(this._value);

  //  shared String trimmed => trim(Character.whitespace);
  $dart$core.String get trimmed
    => String.nativeValue(trim(new dart$Callable(([Character c])
        => Boolean.instance(c.whitespace))));

  //  shared actual native String trim(Boolean trimming(Character element));
  String trim([Callable trimming])
    => new String(super.trim(trimming));

  //  shared actual native String trimLeading(Boolean trimming(Character element));
  String trimLeading([Callable trimming])
    => new String(super.trimLeading(trimming));

  //  shared actual native String trimTrailing(Boolean trimming(Character element));
  String trimTrailing([Callable trimming])
    => new String(super.trimTrailing(trimming));

  //  shared native String normalized;
  $dart$core.String get normalized {
    var previousWasWhitespace = false;
    var sb = new $dart$core.StringBuffer();
    for (var r in _value.runes) {
      if (new Character.$fromInt(r).whitespace) {
        if (!previousWasWhitespace) {
          sb.write(" ");
        }
        previousWasWhitespace = true;
      }
      else {
        previousWasWhitespace = false;
        sb.writeCharCode(r);
      }
    }
    return String.instance(sb.toString()).trimmed;
  }

  //  shared actual native String reversed;
  String get reversed
    => new String(this.sequence().reversed);

  //  shared actual native String span(Integer from, Integer to);
  String span([Integer from, Integer to])
    => new String(this.sequence().span(from, to));

  //  shared actual String spanFrom(Integer from) => from<size then span(from, size) else "";
  String spanFrom([Integer from])
    => new String(this.sequence().spanFrom(from));

  //  shared actual String spanTo(Integer to) => to>=0 then span(0, to) else "";
  String spanTo([Integer to])
    => to._value >= 0 ? span(Integer.instance(0), to) : String.instance("");

  //  shared actual native String measure(Integer from, Integer length);
  String measure([Integer from, $dart$core.int length])
    => length > 0 ? new String(this.sequence().measure(from, length)) : String.instance("");

  //  shared actual native String initial(Integer length);
  String initial([$dart$core.int length])
    => length > 0 ? new String(this.sequence().initial(length)) : String.instance("");

  //  shared actual native String terminal(Integer length);
  String terminal([$dart$core.int length])
    => length > 0 ? new String(this.sequence().terminal(length)) : String.instance("");

  //  shared actual native [String,String] slice(Integer index);
  Sequence slice([$dart$core.int length]) {
    var its = this.sequence().slice(length);
    return new ArraySequence(new Array._withList([
        new String(its.getFromFirst(0)),
        new String(its.getFromFirst(1))]));
  }

  //  shared actual native Integer size;
  @$dart$core.override
  $dart$core.int get size => _value.runes.length;

  //  shared actual Integer? lastIndex;
  @$dart$core.override
  $dart$core.int get lastIndex => empty ? null : size - 1;

  //  shared actual native Character? getFromFirst(Integer index);

  //  shared actual native Boolean contains(Object element);
  @$dart$core.override
  $dart$core.bool contains([$dart$core.Object element]) {
    if (element is String) {
      return _value.contains(element._value);
    }
    else if (element is Character) {
      return super.contains(element);
    }
    else {
      return false;
    }
  }

  //  shared actual native Boolean startsWith(List<Anything> substring);

  //  shared actual native Boolean endsWith(List<Anything> substring);

  //  shared actual native String plus(String other);
  @$dart$core.override
  String plus([String other]) => String.instance(_value + other._value);

  //  shared actual native String repeat(Integer times);
  @$dart$core.override
  String repeat([$dart$core.int times])
    => new String(this.sequence().repeat(times));

  // TODO
  //  shared native String replace(String substring,
  //                               String replacement);

  // TODO
  //  shared native String replaceFirst(String substring,
  //                                    String replacement);

  // TODO
  //  shared native String replaceLast(String substring,
  //                                   String replacement);

  //  shared actual Comparison compare(String other) {
  //      // TODO should use iterators instead of getFromFirst
  //      value min = smallest(size, other.size);
  //      for (i in 0:min) {
  //          assert (exists thisChar = this.getFromFirst(i),
  //                  exists thatChar = other.getFromFirst(i));
  //          if (thisChar!=thatChar) {
  //              return thisChar <=> thatChar;
  //          }
  //      }
  //      return size <=> other.size;
  //  }
  Comparison compare([String other]) {
    var i = _value.compareTo(other._value);
    if (i < 0) {
      return smaller;
    }
    else if (i > 0) {
      return larger;
    }
    return equal;
  }

  //  shared Comparison compareIgnoringCase(String other) {
  //      // TODO should use iterators instead of getFromFirst
  //      value min = smallest(size, other.size);
  //      for (i in 0:min) {
  //          assert (exists thisChar = this.getFromFirst(i),
  //                  exists thatChar = other.getFromFirst(i));
  //          if (thisChar!=thatChar &&
  //              thisChar.uppercased!=thatChar.uppercased &&
  //              thisChar.lowercased!=thatChar.lowercased) {
  //              return thisChar.lowercased <=> thatChar.lowercased;
  //          }
  //      }
  //      return size <=> other.size;
  //  }
  Comparison compareIgnoringCase([$dart$core.String other]) {
    var i = _value.toUpperCase().compareTo(other.toUpperCase());
    if (i < 0) {
      return smaller;
    }
    else if (i > 0) {
      return larger;
    }
    return equal;
  }

  //  shared actual Boolean equals(Object that) {
  //      // TODO should use iterators instead of getFromFirst
  //      if (is String that) {
  //          if (size!=that.size) {
  //              return false;
  //          }
  //          value min = smallest(size, that.size);
  //          for (i in 0:min) {
  //              assert (exists thisChar = this.getFromFirst(i),
  //                      exists thatChar = that.getFromFirst(i));
  //              if (thisChar!=thatChar) {
  //                  return false;
  //              }
  //          }
  //          return true;
  //      }
  //      else {
  //          return false;
  //      }
  //  }
  // TODO change to "==" once compiler handles this
  $dart$core.bool equals([$dart$core.Object other])
    => (other is String) ? _value == other._value : false;

  //  shared Boolean equalsIgnoringCase(String that) {
  //      // TODO should use iterators instead of getFromFirst
  //      if (size!=that.size) {
  //          return false;
  //      }
  //      value min = smallest(size, that.size);
  //      for (i in 0:min) {
  //          assert (exists thisChar = this.getFromFirst(i),
  //                  exists thatChar = that.getFromFirst(i));
  //          if (thisChar!=thatChar &&
  //              thisChar.uppercased!=thatChar.uppercased &&
  //              thisChar.lowercased!=thatChar.lowercased) {
  //              return false;
  //          }
  //      }
  //      return true;
  //  }
  $dart$core.bool equalsIgnoringCase([$dart$core.String other])
    => _value.toUpperCase() == other.toUpperCase();

  //  shared actual native Integer hash
  @$dart$core.override
  $dart$core.int get hashCode => _value.hashCode;

  //  shared actual native String string;
  @$dart$core.override
  $dart$core.String toString() => this._value;

  //  shared actual native Boolean empty;
  @$dart$core.override
  $dart$core.bool get empty => _value.isEmpty;

  //  shared actual native String coalesced;
  @$dart$core.override
  String get coalesced => this;

  //  shared actual String clone() => this;
  @$dart$core.override
  String clone() => this;

  //  shared native String pad(Integer size, Character character=' ');
  $dart$core.String pad([$dart$core.int size, $dart$core.Object character = dart$default]) {
    $dart$core.int ch = character == dart$default ? 32 : (character as Character).integer;
    var length = this.size;
    if (size <= length) return _value;
    var leftPad = (size - length) ~/ 2;
    var rightPad = size - leftPad - length;
    var sb = new $dart$core.StringBuffer();
    for (var i = 0; i < leftPad; i++) {
      sb.writeCharCode(ch);
    }
    sb.write(_value);
    for (var i = 0; i < rightPad; i++) {
      sb.writeCharCode(ch);
    }
    return sb.toString();
  }

  //  shared native String padLeading(Integer size, Character character=' ');
  $dart$core.String padLeading([$dart$core.int size, $dart$core.Object character = dart$default]) {
    $dart$core.int ch = character == dart$default ? 32 : (character as Character).integer;
    var length = this.size;
    if (size <= length) return _value;
    var padAmount = size - length;
    var sb = new $dart$core.StringBuffer();
    for (var i = 0; i < padAmount; i++) {
      sb.writeCharCode(ch);
    }
    sb.write(_value);
    return sb.toString();
  }

  //  shared native String padTrailing(Integer size, Character character=' ');
  $dart$core.String padTrailing([$dart$core.int size, $dart$core.Object character = dart$default]) {
    $dart$core.int ch = character == dart$default ? 32 : (character as Character).integer;
    var length = this.size;
    if (size <= length) return _value;
    var padAmount = size - length;
    var sb = new $dart$core.StringBuffer(_value);
    for (var i = 0; i < padAmount; i++) {
      sb.writeCharCode(ch);
    }
    return sb.toString();
  }

  //  shared native
  //  void copyTo(
  //      Array<Character> destination,
  //      Integer sourcePosition = 0,
  //      Integer destinationPosition = 0,
  //      Integer length
  //              = smallest(size - sourcePosition,
  //                  destination.size - destinationPosition));
  void copyTo([Array destination,
          $dart$core.Object sourcePosition = $package$dart$default,
          $dart$core.Object destinationPosition = $package$dart$default,
          $dart$core.Object length = $package$dart$default]) {
    $package$dartListCopyTo(this, destination, sourcePosition, destinationPosition, length);
  }

  // TODO
  //  shared actual native Boolean occurs(Anything element);
  //  shared actual native Boolean occursAt(Integer index, Anything element);
  //  shared actual native Boolean includes(List<Anything> sublist);
  //  shared actual native Boolean includesAt(Integer index, List<Anything> sublist);

  // TODO
  //  shared actual native Integer? firstOccurrence(Anything element);
  //  shared actual native Integer? lastOccurrence(Anything element);
  //  shared actual native Integer? firstInclusion(List<Anything> sublist);
  //  shared actual native Integer? lastInclusion(List<Anything> sublist);

  // TODO
  //  shared actual native {Integer*} inclusions(List<Anything> sublist);

  //  shared actual native Boolean largerThan(String other);
  $dart$core.bool largerThan([String other])
    => _value.compareTo(other._value) > 0;

  //  shared actual native Boolean smallerThan(String other);
  $dart$core.bool smallerThan([String other])
    => _value.compareTo(other._value) < 0;

  //  shared actual native Boolean notSmallerThan(String other);
  $dart$core.bool notSmallerThan([String other])
    => _value.compareTo(other._value) >= 0;

  //  shared actual native Boolean notLargerThan(String other);
  $dart$core.bool notLargerThan([String other])
    => _value.compareTo(other._value) <= 0;

  //  shared actual native void each(void step(Character element));
  //  shared actual native Integer count(Boolean selecting(Character element));
  //  shared actual native Boolean every(Boolean selecting(Character element));
  //  shared actual native Boolean any(Boolean selecting(Character element));
  //  shared actual native Result|Character|Null reduce<Result>
  //          (Result accumulating(Result|Character partial, Character element));
  //  shared actual native Character? find(Boolean selecting(Character element));
  //  shared actual native Character? findLast(Boolean selecting(Character element));
  //  shared actual native <Integer->Character>? locate(Boolean selecting(Character element));
  //  shared actual native <Integer->Character>? locateLast(Boolean selecting(Character element));

  // Dart runtime

  static String instance($dart$core.String value)
    => value == null ? null : new String._fromNative(value);

  static $dart$core.String nativeValue(String value)
    => value == null ? null : value._value;

  static $dart$core.String fromCharacters(Iterable characters) {
    var sb = new $dart$core.StringBuffer();
    characters.each(new dart$Callable((Character c)
      => sb.writeCharCode(c.integer)));
    return sb.toString();
  }
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

class Tuple extends impl$BaseSequence {
  final $dart$core.List _list;
  Sequential restSequence;

  Tuple([$dart$core.Object first, $dart$core.Object rest = dart$default]) : _list = [] {
    restSequence = rest == dart$default ? $package$empty : rest;
    _list.add(first);
  }

  Tuple._trailing(Iterable initial, $dart$core.Object element) : _list = [] {
    restSequence = $package$empty;
    initial.each(new dart$Callable((e) => _list.add(e)));
    _list.add(element);
  }

  Tuple.$ofElements(Iterable rest) : _list = [] {
    if (_list.length == 0) {
      throw new AssertionError("list must not be empty");
    }
    restSequence = $package$empty;
    rest.each(new dart$Callable((e) => _list.add(e)));
  }

  Tuple.$withList([$dart$core.List this._list, $dart$core.Object rest = dart$default]) {
    if (_list.length == 0) {
      throw new AssertionError("list must not be empty");
    }
    restSequence = rest == dart$default || rest == null ? $package$empty : rest;
  }

  @$dart$core.override
  $dart$core.Object get first
    => getFromFirst(0);

  @$dart$core.override
  Sequential get rest {
    if (_list.length == 1) {
      return restSequence;
    }
    else {
      return new Tuple.$withList(_list.sublist(1), restSequence);
    }
  }

  @$dart$core.override
  $dart$core.int get lastIndex
    => size - 1;

  @$dart$core.override
  $dart$core.int get size
    => _list.length + restSequence.size;

  @$dart$core.override
  $dart$core.Object getFromFirst([$dart$core.int index]) {
    if (index < 0) {
      return null;
    }
    else if (index < _list.length) {
      return _list[index];
    }
    else {
      return restSequence.getFromFirst(index - _list.length);
    }
  }

  @$dart$core.override
  $dart$core.Object get last
    => getFromLast(0);

  // measure
  @$dart$core.override
  Sequential measure([Integer from, $dart$core.int length])
    => List.$measure(this, from, length).sequence();

  // span
  @$dart$core.override
  Sequential span([Integer from, Integer to])
    => List.$span(this, from, to).sequence();

  // spanTo
  @$dart$core.override
  Sequential spanTo([Integer to])
    => List.$spanTo(this, to).sequence();

  // spanFrom
  @$dart$core.override
  Sequential spanFrom([Integer from])
    => List.$spanFrom(this, from).sequence();

  // FIXME why doesn't impl$BaseSequence define this?
  @$dart$core.override
  Iterator iterator()
    => List.$iterator(this);

  @$dart$core.override
  Sequence withLeading([$dart$core.Object other])
    => new Tuple(other, this);

  @$dart$core.override
  Sequence withTrailing([$dart$core.Object other])
    => new Tuple._trailing(this, other);
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

// runtime

class runtime_ {
  const runtime_.$value$();

  final $dart$core.String name = "DartVM";
  final $dart$core.String version = "Unknown Version";
  $dart$core.String toString() => "runtime [" + name + " / " + version + "]";

  // just making stuff up...
  final $dart$core.int integerSize = 64;
  final $dart$core.int integerAddressableSize = 64;
  $dart$core.int get maxIntegerValue => $dart$math.pow(2, 63) - 1;
  $dart$core.int get minIntegerValue => -$dart$math.pow(2, 63);
  $dart$core.int get maxArraySize => $dart$math.pow(2, 63) - 1;
}

const runtime = const runtime_.$value$();

const $package$runtime = runtime;

// operatingSystem

class operatingSystem_ {
  const operatingSystem_.$value$();

  $dart$core.String get newline => "\n";
}

const operatingSystem = const operatingSystem_.$value$();

const $package$operatingSystem = operatingSystem;

// system

class system_ {
const system_.$value$();
  $dart$core.int get milliseconds
      =>  new $dart$core.DateTime.now().millisecondsSinceEpoch;

  $dart$core.int get nanoseconds
      =>  new $dart$core.DateTime.now().millisecondsSinceEpoch * 1000000;

  $dart$core.String toString()
      =>  "Dart";
}

const system = const system_.$value$();

const $package$system = system;

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

abstract class meta$declaration$ValueDeclaration {}

///////////////////////////////////////
//
// Callable & Flatten
//
///////////////////////////////////////

class dart$Callable implements $dart$core.Function, Callable {
  final $dart$core.Function _function;
  final $dart$core.int _variadicIndex;

  dart$Callable([$dart$core.Function this._function, $dart$core.int this._variadicIndex = -1]);

  // for non-spread calls `f()`
  $dart$core.Function get f => _variadicIndex == -1 ? _function : this;

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    if (invocation.memberName == #call) {
      // There is no spread argument (this is the "f" function)

      var inArgs = invocation.positionalArguments;
      var outArgs = new $dart$core.List(_variadicIndex + 1);

      var initialLength = $dart$math.min(_variadicIndex, inArgs.length);

      if (initialLength > 0) {
        outArgs.setRange(0, initialLength, inArgs);
      }

      if (inArgs.length > initialLength) {
        // The rest form the variadic parameter
        outArgs[_variadicIndex] = new Tuple.$withList(inArgs.sublist(initialLength));
      }
      else {
        // Fill with default values
        outArgs.fillRange(initialLength, _variadicIndex, dart$default);
        outArgs[_variadicIndex] = empty;
      }

      return $dart$core.Function.apply(_function, outArgs, null);
    }
    else if (invocation.memberName == #s) {
      // The last of inArgs is a spread argument

      var inArgs = invocation.positionalArguments;

      if (_variadicIndex == -1) {
        // Not variadic
        var seq = inArgs.last as Sequential;
        var outSize = inArgs.length + seq.size - 1;
        var initialLength = inArgs.length - 1;
        var outArgs = new $dart$core.List(outSize);

        // Copy non-spread args
        if (initialLength > 0) {
          outArgs.setRange(0, initialLength, inArgs);
        }

        // Add more from the spread arg
        var outIndex = initialLength;
        var seqIndex = 0;
        while (seqIndex < seq.size) {
          outArgs[outIndex] = seq.getFromFirst(seqIndex);
          outIndex++;
          seqIndex++;
        }

        return $dart$core.Function.apply(_function, outArgs, null);
      }
      else if (inArgs.length == _variadicIndex + 1) {
        // Variadic index lines up with spread index. Simply forward the positional arguments.
        return $dart$core.Function.apply(_function, invocation.positionalArguments, null);
      }
      else {
        // Populate outArgs for the invocation.
        var seq = inArgs.last as Sequential;
        var outArgs = new $dart$core.List(_variadicIndex + 1);

        var initialLength = $dart$math.min(_variadicIndex, inArgs.length - 1);

        if (initialLength > 0) {
          outArgs.setRange(0, initialLength, inArgs);
        }

        if (initialLength < _variadicIndex) {
          var outIndex = initialLength;
          var seqIndex = 0;

          // Add more from the spread arg
          while (outIndex < _variadicIndex && seqIndex < seq.size) {
            outArgs[outIndex] = seq.getFromFirst(seqIndex);
            outIndex++;
            seqIndex++;
          }

          if (seqIndex < seq.size) {
            // Include the rest in the variadic
            outArgs[_variadicIndex]
                = seq.spanFrom(Integer.instance(_variadicIndex - initialLength));
          }
          else {
            // Fill with default values
            outArgs.fillRange(outIndex, _variadicIndex, dart$default);
            outArgs[_variadicIndex] = empty;
          }
        }
        else {
          // Create new tuple with tail of inArgs and entire spread
          outArgs[_variadicIndex]
              = new Tuple.$withList(inArgs.sublist(initialLength, inArgs.length - 1), seq);
        }

        return $dart$core.Function.apply(_function, outArgs, null);
      }
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

Callable flatten(Callable tupleFunction) {
  if (tupleFunction is dart$UnflatFunction) {
    return tupleFunction.flatFunction;
  }
  return new dart$FlatFunction(tupleFunction);
}

Callable unflatten(Callable flatFunction) {
  if (flatFunction is dart$FlatFunction) {
    return flatFunction.tupleFunction;
  }
  return new dart$UnflatFunction(flatFunction);
}

class dart$FlatFunction implements $dart$core.Function, Callable {
  final Callable tupleFunction;

  dart$FlatFunction(Callable this.tupleFunction);

  // for non-spread calls `f()`, always use noSuchMethod.

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    var inArgs = invocation.positionalArguments;
    if (invocation.memberName == #f) {
      var tuple = invocation.positionalArguments.length > 0
          ? new Tuple.$withList(inArgs, empty) : empty;

      return tupleFunction.f(tuple);
    }
    else if (invocation.memberName == #s) {
      // Simply create a tuple with all arguments
      if (inArgs.length == 1) {
        return tupleFunction.f(inArgs.first);
      }
      else {
        // assert(inArgs > 1)
        return tupleFunction.f(new Tuple.$withList(
                inArgs.sublist(0, inArgs.length - 1), inArgs.last), null);
      }
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

class dart$UnflatFunction implements $dart$core.Function, dart$Callable {
  final Callable flatFunction;

  dart$UnflatFunction(Callable this.flatFunction);

  // for non-spread calls `f()`, always use noSuchMethod.

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    var inArgs = invocation.positionalArguments;
    if (invocation.memberName == #f) {
      // There will always be exactly one argument, which is a sequence
      return flatFunction.s(inArgs.first);
    }
    else if (invocation.memberName == #s) {
      // There will always be exactly one argument, which is a sequence holding a sequential
      return flatFunction.s(inArgs.first.first);
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

Callable $package$flatten(Callable tupleFunction) => flatten(tupleFunction);

Callable $package$unflatten(Callable flatFunction) => unflatten(flatFunction);

///////////////////////////////////////
//
// Wrappers
//
///////////////////////////////////////

class DartStringBuffer {
  $dart$core.StringBuffer delegate = new $dart$core.StringBuffer();

  DartStringBuffer() {}

  $dart$core.bool get empty => delegate.isEmpty;
  $dart$core.int get length => delegate.length;
  void clear() => delegate.clear();
  void write([$dart$core.Object obj]) => delegate.write(obj);
  void writeCharCode([$dart$core.int charCode]) => delegate.writeCharCode(charCode);
  $dart$core.String toString() => delegate.toString();
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

/////////////////////////////////////////////////////////////////////////////////
