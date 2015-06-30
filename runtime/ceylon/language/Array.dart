part of ceylon.language;

class Array implements List {
  $dart$core.List _list;

  Array(Iterable elements) {
    _list = [];
    elements.each((e) => _list.add(e));
  }

  Array.OfSize($dart$core.int size, $dart$core.Object element) {
    _list = new $dart$core.List.filled(size, element);
  }

  Array._withList($dart$core.List this._list);

  void set($dart$core.int index, $dart$core.Object element) {
    if (index < 0 || index > lastIndex) {
      throw new AssertionError("Index out of bounds");
    }
    _list[index] = element;
  }

  @$dart$core.override
  $dart$core.int get lastIndex
    =>  _list.length - 1;

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  // bridge methods
  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    =>  List.$defines(this, index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    =>  List.$get(this, index);

  @$dart$core.override
  getFromLast($dart$core.int index)
    =>  List.$getFromLast(this, index);

  @$dart$core.override
  Iterator get iterator
    =>  List.$get$iterator(this);

  @$dart$core.override
  $dart$core.int get size
    =>  List.$get$size(this);

  @$dart$core.override
  void each(void f($dart$core.Object item))
    =>  Iterable.$each(this, f);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequential sequence()
    =>  Iterable.$sequence(this);
}
