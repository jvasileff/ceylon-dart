part of ceylon.language;

class Character {
  $dart$core.int _value;

  Character(Character character) {
    _value = character._value;
  }

  Character._fromInt($dart$core.int this._value);

  $dart$core.int get integer => _value;

  @$dart$core.override
  $dart$core.String toString()
    => new $dart$core.String.fromCharCode(_value);
}
