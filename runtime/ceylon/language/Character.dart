part of ceylon_language;

class Character {
  core.int _value;

  Character(Character character) {
    _value = character._value;
  }

  Character._fromInt(core.int this._value);

  core.int get integer => _value;

  @core.override
  core.String toString()
    => new core.String.fromCharCode(_value);
}
