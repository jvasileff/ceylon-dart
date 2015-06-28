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
}
