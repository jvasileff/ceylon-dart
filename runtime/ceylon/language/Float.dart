part of ceylon.language;

class Float implements Number, Exponentiable {
  final core.double _value;

  Float(core.double this._value);

  Float plusInteger(core.int integer) => new Float(_value * integer);
  Float powerOfInteger(core.int integer) => new Float(math.pow(_value, integer));
  Float timesInteger(core.int integer) => new Float(_value * integer);

  Float divided(Float other) => new Float(this._value / other._value);
  Float times(Float other) => new Float(this._value * other._value);

  Float get negated => new Float(-this._value);
  Float minus(Float other) => new Float(this._value - other._value);

  Float plus(Float other) => new Float(this._value + other._value);

  Float power(Float other) => new Float(math.pow(this._value, other._value));
}