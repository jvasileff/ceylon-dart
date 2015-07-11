part of ceylon.language;

class Integer implements Integral, Exponentiable { // Binary
  final $dart$core.int _value;

  Integer($dart$core.int this._value);

  $dart$core.bool get unit => _value == 1;
  $dart$core.bool get zero => _value == 0;

  $dart$core.bool divides(Integer other) => other._value % _value == 0;
  Integer remainder(Integer other) => new Integer(other._value % _value);

  Integer plusInteger($dart$core.int integer) => new Integer(_value + integer);
  Integer powerOfInteger($dart$core.int integer) => new Integer($dart$math.pow(_value, integer));
  Integer timesInteger($dart$core.int integer) => new Integer(_value * integer);

  Integer divided(Integer other) => new Integer(this._value ~/ other._value);
  Integer times(Integer other) => new Integer(this._value * other._value);

  Integer get negated => new Integer(-this._value);
  Integer minus(Integer other) => new Integer(this._value - other._value);

  Integer plus(Integer other) => new Integer(this._value + other._value);

  Integer power(Integer other) => new Integer($dart$math.pow(this._value, other._value));

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  // Comparable

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool largerThan(Integer other) => _value > other._value;

  @$dart$core.override
  $dart$core.bool smallerThan(Integer other) => _value < other._value;

  @$dart$core.override
  $dart$core.bool notLargerThan(Integer other) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool notSmallerThan(Integer other) => _value >= other._value;

  // Dart runtime

  static Integer instance($dart$core.int value)
    => value == null ? null : new Integer(value);

  static $dart$core.int nativeValue(Integer value)
    => value == null ? null : value._value;
}
