library ceylon.language;

import 'dart:core' as $dart$core;
import 'dart:io' as $dart$io;
import 'dart:math' as $dart$math;
import '../../../ceylon.language.dart';

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
// Boolean.dart
//

class Boolean implements dart$$Basic {
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

class Character implements dart$$Object, Comparable, Enumerable {
  $dart$core.int _value;

  Character(Character character) {
    _value = character._value;
  }

  Character.$fromInt($dart$core.int this._value) {
      if (_value > 0x10FFFF || _value < 0) {
          throw new OverflowException(_value.toString() + " is not a possible Unicode code point");
      }
  }

  $dart$core.int get integer => _value;

  $dart$core.int get codePoint => _value;

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

  $dart$core.bool get letter => uppercased != lowercased;

  $dart$core.bool get titlecase => uppercase;

  Character get uppercased => new Character.$fromInt(toString().toUpperCase().runes.elementAt(0));

  Character get lowercased => new Character.$fromInt(toString().toLowerCase().runes.elementAt(0));

  Character get titlecased => uppercased;

  // Enumerable
  Character neighbour([$dart$core.int offset]) => new Character.$fromInt(this._value + offset);
  $dart$core.int offset([Character other]) => this._value - other._value;
  $dart$core.int offsetSign([Character other]) => offset(other).sign;

  // Ordinal
  Character get predecessor => new Character.$fromInt(this._value - 1);
  Character get successor => new Character.$fromInt(this._value + 1);

  // Comparable
  @$dart$core.override
  Comparison compare([Character other]) {
    if (_value < other._value) {
      return $package$smaller;
    }
    else if (_value > other._value) {
      return $package$larger;
    }
    else {
      return $package$equal;
    }
  }

  @$dart$core.override
  $dart$core.bool operator >(Character other)
    =>  _value > other._value;

  @$dart$core.override
  $dart$core.bool operator <(Character other)
    =>  _value < other._value;

  @$dart$core.override
  $dart$core.bool operator <=(Character other)
    =>  _value <= other._value;

  @$dart$core.override
  $dart$core.bool operator >=(Character other)
    =>  _value >= other._value;

  $dart$core.bool operator ==($dart$core.Object other) {
    if (other is Character) {
      return _value == other._value;
    }
    return false;
  }

  $dart$core.int get hashCode => _value;
}


//
// Float.dart
//

class Float implements dart$$Object, Number, Exponentiable {
  final $dart$core.double _value;

  Float($dart$core.double this._value);

  Float plusInteger([$dart$core.int integer]) => new Float(_value * integer);
  Float powerOfInteger([$dart$core.int integer]) => new Float($dart$math.pow(_value, integer));
  Float timesInteger([$dart$core.int integer]) => new Float(_value * integer);

  Float operator /(Float other) => new Float(this._value / other._value);
  Float operator *(Float other) => new Float(this._value * other._value);

  Float operator -() => new Float(-this._value);

  $dart$core.int get integer => this._value.toInt();

  Float operator -(Float other) => new Float(this._value - other._value);

  Float operator +(Float other) => new Float(this._value + other._value);

  Float get magnitude => new Float(this._value.abs());

  Float power([Float other]) => new Float($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  $dart$core.bool operator ==($dart$core.Object other) {
    if (other is Float) {
      return _value == other._value;
    }
    else if (other is Integer) {
      return other._value < Integer.twoFiftyThree &&
          other._value > -Integer.twoFiftyThree &&
          _value == other._value;
    }
    return false;
  }

  $dart$core.int get hashCode => _value.hashCode;

  $dart$core.int get sign
    => _value < 0.0 ? -1 : (_value > 0.0 ? 1 : 0);

  $dart$core.bool get undefined => _value.isNaN;
  $dart$core.bool get infinite => _value.isInfinite;
  $dart$core.bool get finite => _value.isFinite;
  $dart$core.bool get strictlyPositive => !_value.isNaN && !_value.isNegative;
  $dart$core.bool get strictlyNegative => !_value.isNaN && _value.isNegative;

  $dart$core.bool get positive => _value > 0.0;
  $dart$core.bool get negative => _value < 0.0;
  Float get fractionalPart => new Float(_value.remainder(1));
  Float get wholePart {
    $dart$core.double result = _value.truncateToDouble();
    if (result == _value && result.sign == _value.sign) {
      return this;
    }
    return new Float(result);
  }

  // Comparable
  Comparison compare([Float other])
      =>  _value < other._value ? smaller : (_value > other._value ? larger : equal);

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool operator >(Float other) => _value > other._value;

  @$dart$core.override
  $dart$core.bool operator <(Float other) => _value < other._value;

  @$dart$core.override
  $dart$core.bool operator <=(Float other) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool operator >=(Float other) => _value >= other._value;

  // Dart runtime

  static Float instance($dart$core.double value)
    => value == null ? null : new Float(value);

  static $dart$core.double nativeValue(Float value)
    => value == null ? null : value._value;
}

//
// Integer.dart
//

class Integer implements dart$$Object, Integral, Exponentiable, Binary {
  final $dart$core.int _value;

  static $dart$core.int twoFiftyThree = 1<<53;

  Integer($dart$core.int this._value);

  $dart$core.bool get unit => _value == 1;
  $dart$core.bool get zero => _value == 0;

  $dart$core.bool divides([Integer other]) => other._value % _value == 0;
  Integer operator %(Integer other) => new Integer(_value.remainder(other._value));

  Integer modulo([Integer modulus]) {
    if (modulus._value < 0) {
      throw new AssertionError("modulus must be positive");
    }
    $dart$core.int result = _value.remainder(modulus._value);
    if (result < 0) {
      return new Integer(result + modulus._value);
    }
    return new Integer(result);
  }

  Integer plusInteger([$dart$core.int integer]) => new Integer(_value + integer);
  Integer powerOfInteger([$dart$core.int integer]) {
    if (integer < 0) {
      if (_value == -1) {
        return new Integer(integer % 2 == 0 ? 1 : -1);
      }
      if (_value == 1) {
        return this;
      }
      throw new AssertionError("exponent must not be negative");
    }
    return new Integer($dart$math.pow(_value, integer));
  }
  Integer timesInteger([$dart$core.int integer]) => new Integer(_value * integer);

  Integer operator /(Integer other) => new Integer(this._value ~/ other._value);
  Integer operator *(Integer other) => new Integer(this._value * other._value);

  Integer operator -() => new Integer(-this._value);
  Integer get magnitude => new Integer(this._value.abs());
  Integer operator -(Integer other) => new Integer(this._value - other._value);

  Integer operator +(Integer other) => new Integer(this._value + other._value);

  Integer power([Integer other]) => powerOfInteger(other._value);

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  Character get character => new Character.$fromInt(_value);

  $dart$core.int get hashCode => _value.hashCode;

  $dart$core.bool operator ==($dart$core.Object other) {
    if (other is Integer) {
      return _value == other._value;
    }
    else if (other is Float) {
      return _value < twoFiftyThree
          && _value > -twoFiftyThree
          && _value == other._value;
    }
    return false;
  }

  $dart$core.double get float {
    if (_value <= -twoFiftyThree || _value >= twoFiftyThree) {
      throw new OverflowException(_value.toString()
          + " cannot be coerced into a 64 bit floating point value");
    }
    return _value.toDouble();
  }
  $dart$core.double get nearestFloat => _value.toDouble();
  Byte get byte => new Byte(_value);

  // Binary

  // Treat as unsigned to match javascript's Unsigned Right Shift Operator >>>
  Integer rightLogicalShift([$dart$core.int shift])
    => new Integer(((_value & 0xFFFFFFFF) >> (shift & 0x1F)).toUnsigned(32));

  Integer leftLogicalShift([$dart$core.int shift])
    => new Integer((_value << (shift & 0x1F)).toSigned(32));

  Integer rightArithmeticShift([$dart$core.int shift])
    => new Integer((_value.toSigned(32) >> (shift & 0x1F)).toSigned(32));

  $dart$core.bool get([$dart$core.int index]) {
    if (index < 0 || index > 31) {
      return false;
    }
    return _value.toSigned(32) & (1<<index) != 0;
  }

  Integer set([$dart$core.int index, $dart$core.bool bit = true]) {
    if (index < 0 || index > 31) {
      // Match JS behavior, for now
      // https://github.com/ceylon/ceylon/issues/5799
      //return new Integer(_value.toSigned(32));
      return this;
    }
    $dart$core.int mask = (1 << index).toSigned(32);
    if (bit) {
      return new Integer(_value.toSigned(32) | mask);
    }
    else {
      return new Integer(_value.toSigned(32) & ~mask);
    }
  }

  Integer flip([$dart$core.int index]) {
    if (index < 0 || index > 31) {
      // Match JS behavior, for now
      // https://github.com/ceylon/ceylon/issues/5799
      //return new Integer(_value.toSigned(32));
      return this;
    }
    $dart$core.int mask = (1 << index).toSigned(32);
    return new Integer(_value.toSigned(32) ^ mask);
  }

  Integer clear([$dart$core.int index]) => set(index, false);

  Integer or([Integer other])
    =>  new Integer(_value.toSigned(32) | other._value.toSigned(32));

  Integer and([Integer other])
    =>  new Integer(_value.toSigned(32) & other._value.toSigned(32));

  Integer xor([Integer other])
    =>  new Integer(_value.toSigned(32) ^ other._value.toSigned(32));

  Integer get not => new Integer((~_value).toSigned(32));

  // Enumerable
  Integer neighbour([$dart$core.int offset]) => new Integer(this._value + offset);
  $dart$core.int offset([Integer other]) => this._value - other._value;
  $dart$core.int offsetSign([Integer other]) => offset(other).sign;

  // Ordinal

  Integer get predecessor => new Integer(this._value - 1);
  Integer get successor => new Integer(this._value + 1);

  // Comparable
  Comparison compare([Integer other])
      =>  _value < other._value ? smaller : (_value > other._value ? larger : equal);

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool operator >(Integer other) => _value > other._value;

  @$dart$core.override
  $dart$core.bool operator <(Integer other) => _value < other._value;

  @$dart$core.override
  $dart$core.bool operator <=(Integer other) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool operator >=(Integer other) => _value >= other._value;

  // Number

  $dart$core.int get sign
    => _value < 0 ? -1 : (_value > 0 ? 1 : 0);

  $dart$core.bool get positive => _value > 0;
  $dart$core.bool get negative => _value < 0;
  Integer get fractionalPart => new Integer(0);
  Integer get wholePart => this;

  $dart$core.bool get even => _value % 2 == 0;

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

  $dart$core.String replace($dart$core.String substring, $dart$core.String replacement)
    => this._value.replaceAll(substring, replacement);

  $dart$core.String replaceFirst($dart$core.String substring, $dart$core.String replacement)
    => this._value.replaceFirst(substring, replacement);

  $dart$core.String replaceLast($dart$core.String substring, $dart$core.String replacement) {
    var index = _value.lastIndexOf(substring);
    if (index < 0) {
      return this._value;
    }
    return this._value.replaceFirst(substring, replacement, index);
  }

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
  Tuple slice([$dart$core.int length]) {
    var its = this.sequence().slice(length);
    return new Tuple.$withList([
        new String(its.getFromFirst(0)),
        new String(its.getFromFirst(1))]);
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
  String operator +(String other) => String.instance(_value + other._value);

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
  $dart$core.bool operator ==($dart$core.Object other)
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
  $dart$core.bool operator >(String other)
    => _value.compareTo(other._value) > 0;

  //  shared actual native Boolean smallerThan(String other);
  $dart$core.bool operator <(String other)
    => _value.compareTo(other._value) < 0;

  //  shared actual native Boolean notSmallerThan(String other);
  $dart$core.bool operator >=(String other)
    => _value.compareTo(other._value) >= 0;

  //  shared actual native Boolean notLargerThan(String other);
  $dart$core.bool operator <=(String other)
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
    restSequence = $package$empty;
    rest.each(new dart$Callable((e) => _list.add(e)));
    if (_list.length == 0) {
      throw new AssertionError("list must not be empty");
    }
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
  Sequential spanFrom([Integer from]) {
    // Return a Tuple, since destructuring and subrange expressions
    // may have Tuple results when enough static type information is
    // available. It may be necessary to optimize this at some point;
    // the Java backend uses a utility method for spanFrom for when
    // a Tuple is the expected result, leaving the Tuple.spanFrom
    // method free to return *just* a Sequential.
    if (Integer.nativeValue(from) > lastIndex) {
      return empty;
    }
    return new Tuple.$ofElements(List.$spanFrom(this, from));
  }

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
// identityHash
//

$dart$core.int identityHash($dart$core.Object identifiable)
  => $dart$core.identityHashCode(identifiable);

$package$identityHash($dart$core.Object identifiable)
  => identityHash(identifiable);

// printStackTrace

void printStackTrace([Throwable exception, $dart$core.Object write = dart$default]) {
  // TODO if the stackTrace is not available, should we just print <null> or something instead?
  if (null == exception.stackTrace) {
    try { throw exception; } catch (e) {}
  }
  if (write == dart$default) {
    process.writeLine(exception.stackTrace.toString());
  }
  else {
    (write as Callable).f(String.instance(exception.stackTrace.toString()));
  }
}

// process

Sequential _processArguments = $package$empty;

// Buffer output for write and writeError, to avoid having to use dart:io.
// ($dart$core.print outputs newlines)
$dart$core.StringBuffer _$outputBuffer = new $dart$core.StringBuffer();

$dart$core.Map _$properties = {
  "os.name" : $dart$io.Platform.operatingSystem,
  "line.separator" : $dart$io.Platform.isWindows ? "\r\n" : "\n",
  "file.separator" : $dart$io.Platform.pathSeparator,
  "path.separator" : $dart$io.Platform.isWindows ? ";" : ":",
  "dart.version" : $dart$io.Platform.version
};

class process_ implements dart$$Basic {
  const process_.$value$();

  $dart$core.String readLine() {
    return $dart$io.stdin.readLineSync();
  }

  void flush() {}

  void flushError() {}

  $dart$core.String environmentVariableValue([$dart$core.String name])
    =>  $dart$io.Platform.environment[name];

  $dart$core.bool namedArgumentPresent([$dart$core.String name]) => false;

  $dart$core.String namedArgumentValue([$dart$core.String name]) => null;

  $dart$core.String propertyValue([$dart$core.String name]) => _$properties[name];

  $dart$core.Object exit([$dart$core.int code]) {
    $dart$io.exit(code);
    return nothing;
  }

  void write([$dart$core.String string]) {
    var newlineIndex = string.lastIndexOf('\n');
    if (newlineIndex > -1) {
      $dart$core.print(_$outputBuffer.toString() + string.substring(0, newlineIndex));
      _$outputBuffer.clear();
      _$outputBuffer.write(string.substring(newlineIndex + 1));
    }
    else {
      _$outputBuffer.write(string);
    }
  }

  void writeLine([$dart$core.Object line = dart$default]) {
    if ($dart$core.identical(line, dart$default)) {
      line = "";
    }
    $dart$core.print(_$outputBuffer.toString() + line);
    _$outputBuffer.clear();
  }

  void writeError([$dart$core.String string]) {
    write(string);
  }

  void writeErrorLine([$dart$core.Object line = dart$default]) {
    writeLine(line);
  }

  Sequential get arguments => _processArguments;

  $dart$core.String toString() => "process";
}

const process = const process_.$value$();

const $package$process = process;

initializeProcess($dart$core.List<$dart$core.String> arguments) {
  if (arguments.isEmpty) {
    _processArguments = $package$empty;
  }
  else {
    _processArguments = new ArraySequence(new Array._withList(
        arguments.map((s) => new String._fromNative(s)).toList(growable: false)));
  }
}

////////////////////////////////////////////////////////////////////////////////
//
// Runtime Package (ceylon.language.dart)
//
////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////
//
// Marker interfaces
//
///////////////////////////////////////

abstract class dart$$Object {}
abstract class dart$$Identifiable extends dart$$Object {}
abstract class dart$$Basic extends dart$$Identifiable {}

///////////////////////////////////////
//
// Capture boxes
//
///////////////////////////////////////

// Separate classes for bool, int, etc, aren't
// necessary on Dart, but using them anyway. And,
// to keep everything consistent, we'll have a
// box for core.String too.

class dart$VariableBox {
  var v;
  dart$VariableBox(var this.v);
}

class dart$VariableBoxBool {
  $dart$core.bool v;
  dart$VariableBoxBool($dart$core.bool this.v);
}

class dart$VariableBoxInt {
  $dart$core.int v;
  dart$VariableBoxInt($dart$core.int this.v);
}

class dart$VariableBoxDouble {
  $dart$core.double v;
  dart$VariableBoxDouble($dart$core.double this.v);
}

class dart$VariableBoxString {
  $dart$core.String v;
  dart$VariableBoxString($dart$core.String this.v);
}

///////////////////////////////////////
//
// Unimplemented
//
///////////////////////////////////////

class serialization$NativeDeque implements dart$$Basic {
  void pushFront(element) {}
  void pushBack(element) {}
  popFront() {}
  $dart$core.bool empty;
  $dart$core.String string;
}

class serialization$PartialImpl extends serialization$Partial {
  serialization$PartialImpl(id) {}

  void instantiate() {}
  void initialize([serialization$DeserializationContextImpl context]) {}
}

class serialization$NativeMap implements dart$$Basic {
  get(id) {}
  void put(id, instanceOrPartial) {}
  contains(id) {}
  Iterable keys;
  Iterable items;
  Integer size;
  String string;
}

$package$meta$type(var x) {}
$package$meta$annotations([var x, var y]) {}
$package$meta$classDeclaration(var x) {}
$package$meta$typeLiteral() {}

final $package$impl$reach = null;

///////////////////////////////////////
//
// Callable & Flatten
//
///////////////////////////////////////

class dart$Callable implements dart$$Object, $dart$core.Function, Callable {
  final $dart$core.Function _function;
  final $dart$core.int _variadicIndex;

  $dart$core.bool operator ==($dart$core.Object other) => false;

  dart$Callable([$dart$core.Function this._function, $dart$core.int this._variadicIndex = -1]);

  // for non-spread calls `f()`
  $dart$core.Function get f => _variadicIndex == -1 ? _function : this;

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    if (invocation.memberName == #call) {
      // There is no spread argument (this is the "f" function)

      // For interop, dart$Calable's may be used directly as Functions, so handle the
      // non-variadic case that is normally avoided in `get f` above.
      if (_variadicIndex == -1) {
          return $dart$core.Function.apply(_function, invocation.positionalArguments, null);
      }

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

class dart$FlatFunction implements dart$$Object, $dart$core.Function, Callable {
  final Callable tupleFunction;

  dart$FlatFunction(Callable this.tupleFunction);

  $dart$core.bool operator ==($dart$core.Object other) => false;

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

class dart$UnflatFunction implements dart$$Object, $dart$core.Function, dart$Callable {
  final Callable flatFunction;

  dart$UnflatFunction(Callable this.flatFunction);

  $dart$core.bool operator ==($dart$core.Object other) => false;

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

class DartStringBuffer implements dart$$Basic {
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

const $package$dart$default = dart$default;

/////////////////////////////////////////////////////////////////////////////////
