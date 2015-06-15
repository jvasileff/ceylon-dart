part of ceylon.language;

class Array implements List {
  core.List _list;

  Array(Iterable elements) {
    _list = [];
    elements.each((e) => _list.add(e));
  }

  Array.OfSize(core.int size, core.Object element) {
    _list = new core.List.filled(size, element);
  }

  void set(core.int index, core.Object element) {
    if (index < 0 || index > lastIndex) {
      throw new AssertionError("Index out of bounds");
    }
    _list[index] = element;
  }

  @core.override
  core.int get lastIndex
    =>  _list.length - 1;

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
