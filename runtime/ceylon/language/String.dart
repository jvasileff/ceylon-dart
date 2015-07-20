part of ceylon.language;

class String implements List {
  final $dart$core.String _value;

  String(Iterable characters) :
      _value = characters is String
        ? characters._value
        : fromCharacters(characters);

  String._fromNative($dart$core.String this._value);

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    => index >= 0 && index <= lastIndex
        ? new Character.$fromInt(
                _value.codeUnitAt(index))
        : null;

  @$dart$core.override
  $dart$core.int get lastIndex
    => _value.isNotEmpty
          ? _value.length - 1
          : null;

  // Iterable

  @$dart$core.override
  Iterable follow($dart$core.Object c)
    =>  new String._fromNative(c.toString() + _value);

  // bridge methods

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    => List.$defines(this, index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    => List.$get(this, index);

  @$dart$core.override
  Iterator iterator()
    => List.$iterator(this);

  @$dart$core.override
  getFromLast(index)
    => List.$getFromLast(this, index);

  @$dart$core.override
  $dart$core.int get size
    => List.$get$size(this);

  @$dart$core.override
  $dart$core.Object get first
    =>  Iterable.$first(this);

  @$dart$core.override
  Iterable get rest
    =>  Iterable.$rest(this);

  @$dart$core.override
  void each(Callable step)
    => Iterable.$each(this, step);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);

  // Dart runtime

  static String instance($dart$core.String value)
    => value == null ? null : new String._fromNative(value);

  static $dart$core.String nativeValue(String value)
    => value == null ? null : value._value;

  static $dart$core.String fromCharacters(Iterable characters) {
    // TODO make much more efficient!
    $dart$core.String result = "";
    characters.each(new dart$Callable((c) => result = result + c.toString()));
    return result;
  }

  // TODO remove this hack (compiler needs to translate)
  $dart$core.String get string => toString();

  $dart$core.String toString() => _value;
}
