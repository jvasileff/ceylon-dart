part of ceylon_language;

class Integer implements Integral, Exponentiable { // Binary
  final core.int _value;

  Integer(core.int this._value);

  core.bool get unit => _value == 1;
  core.bool get zero => _value == 0;

  core.bool divides(Integer other) => other._value % _value == 0;
  Integer remainder(Integer other) => new Integer(other._value % _value);

  Integer plusInteger(core.int integer) => new Integer(_value + integer);
  Integer powerOfInteger(core.int integer) => new Integer(math.pow(_value, integer));
  Integer timesInteger(core.int integer) => new Integer(_value * integer);

  Integer divided(Integer other) => new Integer(this._value ~/ other._value);
  Integer times(Integer other) => new Integer(this._value * other._value);

  Integer get negated => new Integer(-this._value);
  Integer minus(Integer other) => new Integer(this._value - other._value);

  Integer plus(Integer other) => new Integer(this._value + other._value);

  Integer power(Integer other) => new Integer(math.pow(this._value, other._value));
}
