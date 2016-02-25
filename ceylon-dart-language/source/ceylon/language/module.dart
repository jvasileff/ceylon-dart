library ceylon.language;

import 'dart:core' as $dart$core;
import 'dart:io' as $dart$io;
import 'dart:math' as $dart$math;
import '../../../ceylon.language.dart';

/////////////////////////////////////////////////
//
// ceylon.language::LazyIterable
//
/////////////////////////////////////////////////

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

/////////////////////////////////////////////////
//
// ceylon.language::Boolean
//
/////////////////////////////////////////////////

$dart$core.bool $dartBool(Boolean value)
  =>  value == null ? null : (value == $true ? true : false);

Boolean $ceylonBoolean($dart$core.bool value)
  =>  value == null ? null : (value ? $true : $false);

/////////////////////////////////////////////////
//
// ceylon.language::Character
//
/////////////////////////////////////////////////

Character $package$characterFromInteger($dart$core.int integer)
  =>  characterFromInteger(integer);

Character characterFromInteger($dart$core.int integer)
  =>  new Character.$fromInt(integer);

class Character extends BaseCharacter implements dart$$Object, Comparable, Enumerable {

  Character(Character character) : super(character.integer) {}

  Character.$fromInt($dart$core.int integer) : super(integer) {}
}

/////////////////////////////////////////////////
//
// ceylon.language::Float
//
/////////////////////////////////////////////////

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

  static $dart$core.int twoFiftyThree = 1<<53;

  $dart$core.bool operator ==($dart$core.Object other) {
    if (other is Float) {
      return _value == other._value;
    }
    else if (other is Integer) {
      return $dartInt(other) < twoFiftyThree &&
          $dartInt(other) > -twoFiftyThree &&
          _value == $dartInt(other);
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

/////////////////////////////////////////////////
//
// ceylon.language::Integer
//
/////////////////////////////////////////////////

$dart$core.int $dartInt(Integer value)
  =>  value == null ? null : value._$integer;

Integer $ceylonInteger($dart$core.int value)
  =>  new Integer(value);

$dart$core.int $package$intRightArithmeticShift($dart$core.int integer, $dart$core.int shift)
  =>  intRightArithmeticShift(integer, shift);

$dart$core.int intRightArithmeticShift($dart$core.int integer, $dart$core.int shift)
  =>  (integer.toSigned(32) >> (shift & 0x1F)).toSigned(32);

$dart$core.int $package$intRightLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  intRightLogicalShift(integer, shift);

$dart$core.int intRightLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  ((integer & 0xFFFFFFFF) >> (shift & 0x1F)).toUnsigned(32);

$dart$core.int $package$intLeftLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  intLeftLogicalShift(integer, shift);

$dart$core.int intLeftLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  (integer << (shift & 0x1F)).toSigned(32);

$dart$core.int $package$intNot($dart$core.int integer)
  =>  intNot(integer);

$dart$core.int intNot($dart$core.int integer)
  =>  (~integer).toSigned(32);

$dart$core.int $package$intOr($dart$core.int integer, $dart$core.int other)
  =>  intOr(integer, other);

$dart$core.int intOr($dart$core.int integer, $dart$core.int other)
  => integer.toSigned(32) | other.toSigned(32);

$dart$core.int $package$intAnd($dart$core.int integer, $dart$core.int other)
  =>  intAnd(integer, other);

$dart$core.int intAnd($dart$core.int integer, $dart$core.int other)
  =>  integer.toSigned(32) & other.toSigned(32);

$dart$core.int intXor($dart$core.int integer, $dart$core.int other)
  =>  integer.toSigned(32) ^ other.toSigned(32);

$dart$core.int $package$intXor($dart$core.int integer, $dart$core.int other)
  =>  intXor(integer, other);

$dart$core.bool $package$intGet($dart$core.int integer, $dart$core.int index)
  =>  intGet(integer, index);

$dart$core.bool intGet($dart$core.int integer, $dart$core.int index) {
  if (index < 0 || index > 31) {
    return false;
  }
  return integer.toSigned(32) & (1<<index) != 0;
}

$dart$core.int $package$intPow($dart$core.int integer, $dart$core.int other)
  =>  intPow(integer, other);

$dart$core.int intPow($dart$core.int integer, $dart$core.int other) {
  if (other < 0) {
    if (integer == -1) {
      return other % 2 == 0 ? 1 : -1;
    }
    if (integer == 1) {
      return integer;
  }
    throw new AssertionError("exponent must not be negative");
  }
  return $dart$math.pow(integer, other);
}

$dart$core.int $package$intSet($dart$core.int integer, $dart$core.int index, $dart$core.bool bit)
  =>  intSet(integer, index, bit);

$dart$core.int intSet($dart$core.int integer, $dart$core.int index, $dart$core.bool bit) {
    if (index < 0 || index > 31) {
      // Match JS behavior, for now
      // https://github.com/ceylon/ceylon/issues/5799
      //return new Integer(_value.toSigned(32));
    return integer;
    }
    $dart$core.int mask = (1 << index).toSigned(32);
    if (bit) {
    return integer.toSigned(32) | mask;
    }
    else {
    return integer.toSigned(32) & ~mask;
    }
  }

$dart$core.int $package$intFlip($dart$core.int integer, $dart$core.int index)
  =>  intFlip(integer, index);

$dart$core.int intFlip($dart$core.int integer, $dart$core.int index) {
    if (index < 0 || index > 31) {
      // Match JS behavior, for now
      // https://github.com/ceylon/ceylon/issues/5799
      //return new Integer(_value.toSigned(32));
    return integer;
    }
    $dart$core.int mask = (1 << index).toSigned(32);
  return integer.toSigned(32) ^ mask;
}

/////////////////////////////////////////////////
//
// ceylon.language::String
//
/////////////////////////////////////////////////

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
    => new Measure(new Integer(0), size);

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
        => $ceylonBoolean(c.whitespace))));

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
    => $dartInt(to) >= 0 ? span(new Integer(0), to) : String.instance("");

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

/////////////////////////////////////////////////
//
// ceylon.language::Throwable
//
/////////////////////////////////////////////////

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

/////////////////////////////////////////////////
//
// ceylon.language::Tuple
//
/////////////////////////////////////////////////

Tuple tupleTrailing(Iterable initial, $dart$core.Object element)
  =>  new Tuple.$trailing(initial, element);

Tuple $package$tupleTrailing(Iterable initial, $dart$core.Object element)
  =>  tupleTrailing(initial, element);

Tuple tupleOfElements(Iterable rest)
  =>  new Tuple.$ofElements(rest);

Tuple $package$tupleOfElements(Iterable rest)
  =>  tupleOfElements(rest);

Tuple tupleWithList([$dart$core.List list, $dart$core.Object rest = dart$default])
  =>  new Tuple.$withList(list, rest);

Tuple $package$tupleWithList([$dart$core.List list, $dart$core.Object rest = dart$default])
  =>  tupleWithList(list, rest);

class Tuple extends BaseTuple {

  Tuple([$dart$core.Object first, $dart$core.Object rest = dart$default]) : super(first, rest) {}

  Tuple.$trailing(Iterable initial, $dart$core.Object element) : super.trailing(initial, element);

  Tuple.$ofElements(Iterable rest) : super.ofElements(rest) {}

  Tuple.$withList([$dart$core.List list, $dart$core.Object rest = dart$default]) : super.withList(list, rest) {}
}

/////////////////////////////////////////////////
//
// ceylon.language::printStackTrace
//
/////////////////////////////////////////////////

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

/////////////////////////////////////////////////
//
// ceylon.language::process
//
/////////////////////////////////////////////////

initializeProcess($dart$core.List<$dart$core.String> arguments) {
  if (arguments.isEmpty) {
    processArguments = $package$empty;
  }
  else {
    processArguments = new ArraySequence(new Array.withList(
        arguments.map((s) => new String._fromNative(s)).toList(growable: false)));
  }
}

/////////////////////////////////////////////////
//
// Marker Interfaces:
//
//    ceylon.language.dart::Object
//    ceylon.language.dart::Basic
//    ceylon.language.dart::Identifiable
//
/////////////////////////////////////////////////

abstract class dart$$Object {}
abstract class dart$$Identifiable extends dart$$Object {}
abstract class dart$$Basic extends dart$$Identifiable {}

/////////////////////////////////////////////////
//
// Unimplemented
//
/////////////////////////////////////////////////

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

/////////////////////////////////////////////////
//
// ceylon.language::Callable
// ceylon.language::flatten
// ceylon.language::unflatten
//
/////////////////////////////////////////////////

abstract
class Callable {
$dart$core.Function get f;
$dart$core.Function get s;
}

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
                = seq.spanFrom(new Integer(_variadicIndex - initialLength));
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

/////////////////////////////////////////////////
//
// ceylon.language.dart::default
//
/////////////////////////////////////////////////

class dart$Default {
  const dart$Default();
}

const dart$default = const dart$Default();

const $package$dart$default = dart$default;
