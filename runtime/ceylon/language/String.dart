part of ceylon_language;

class String implements List {
  final core.String _value;

  String(core.String this._value);

  @core.override
  core.Object getFromFirst(core.int index)
    => index >= 0 && index <= lastIndex
        ? new Character._fromInt(
                _value.codeUnitAt(index))
        : null;

  @core.override
  core.int get lastIndex
    => _value.isNotEmpty
          ? _value.length - 1
          : null;

  // bridge methods
  @core.override
  core.bool defines(core.Object index)
    => List.$defines(this, index);

  @core.override
  get(core.Object index)
    => List.$get(this, index);

  @core.override
  Iterator get iterator
    => List.$get$iterator(this);

  @core.override
  getFromLast(index)
    => List.$getFromLast(this, index);

  @core.override
  core.int get size
    => List.$get$size(this);

  @core.override
  void each(void f(core.Object item))
    => Iterable.$each(this, f);
}
