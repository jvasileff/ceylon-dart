part of ceylon.language;

class Float implements Number, Exponentiable {
  final $dart$core.double _value;

  Float($dart$core.double this._value);

  Float plusInteger($dart$core.int integer) => new Float(_value * integer);
  Float powerOfInteger($dart$core.int integer) => new Float($dart$math.pow(_value, integer));
  Float timesInteger($dart$core.int integer) => new Float(_value * integer);

  Float divided(Float other) => new Float(this._value / other._value);
  Float times(Float other) => new Float(this._value * other._value);

  Float get negated => new Float(-this._value);
  Float minus(Float other) => new Float(this._value - other._value);

  Float plus(Float other) => new Float(this._value + other._value);

  Float power(Float other) => new Float($dart$math.pow(this._value, other._value));

  // Comparable

  //Comparison compare(Integer other);

  @$dart$core.override
  $dart$core.bool largerThan(Float other) => _value > other._value;

  @$dart$core.override
  $dart$core.bool smallerThan(Float other) => _value < other._value;

  @$dart$core.override
  $dart$core.bool notLargerThan(Float other) => _value <= other._value;

  @$dart$core.override
  $dart$core.bool notSmallerThan(Float other) => _value >= other._value;

  // Dart runtime

  static Float instance($dart$core.double value)
    => value == null ? null : new Float(value);

  static $dart$core.double nativeValue(Float value)
    => value == null ? null : value._value;
}
