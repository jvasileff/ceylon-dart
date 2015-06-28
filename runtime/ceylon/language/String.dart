part of ceylon.language;

class String implements List {
  final $dart$core.String _value;

  String($dart$core.String this._value);

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    => index >= 0 && index <= lastIndex
        ? new Character._fromInt(
                _value.codeUnitAt(index))
        : null;

  @$dart$core.override
  $dart$core.int get lastIndex
    => _value.isNotEmpty
          ? _value.length - 1
          : null;

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
  Iterator get iterator
    => List.$get$iterator(this);

  @$dart$core.override
  getFromLast(index)
    => List.$getFromLast(this, index);

  @$dart$core.override
  $dart$core.int get size
    => List.$get$size(this);

  @$dart$core.override
  void each(void f($dart$core.Object item))
    => Iterable.$each(this, f);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);
}
