part of ceylon_language;

class Tuple implements List, Sequential, Iterable {
  core.List _list;

  Tuple(core.Object first, Iterable rest) {
    _list = [first];
    rest.each((e) => _list.add(e));
  }

  @core.override
  core.int get lastIndex =>
      _list.length - 1;

  @core.override
  core.Object getFromFirst(core.int index)
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  // bridge methods
  @core.override
  core.bool defines(core.Object index)
    =>  List.$defines(this, index);

  @core.override
  get(core.Object index)
    =>  List.$get(this, index);

  @core.override
  getFromLast(core.int index)
    =>  List.$getFromLast(this, index);

  @core.override
  Iterator get iterator
    =>  List.$get$iterator(this);

  @core.override
  core.int get size
    =>  List.$get$size(this);

  @core.override
  void each(void f(core.Object item))
    =>  Iterable.$each(this, f);
}
