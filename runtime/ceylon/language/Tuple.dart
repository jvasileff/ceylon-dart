part of ceylon.language;

class Tuple implements List, Sequence, Iterable {
  final $dart$core.List _list = [];

  Tuple($dart$core.Object first, Iterable rest) {
    _list.add(first);
    rest.each(new dart$Callable((e) => _list.add(e)));
  }

  Tuple._trailing(Iterable initial, $dart$core.Object element) {
    initial.each(new dart$Callable((e) => _list.add(e)));
    _list.add(element);
  }

  @$dart$core.override
  $dart$core.int get lastIndex =>
      _list.length - 1;

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  (0 <= index && index < size)
            ? _list[index]
            : null;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  new Tuple._trailing(this, other);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  new Tuple(other, this);

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
  void each(Callable step)
    =>  Iterable.$each(this, step);

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element)
    =>  Iterable.$contains(this, element);

  @$dart$core.override
  Sequence sequence()
    =>  Sequence.$sequence(this);
}
