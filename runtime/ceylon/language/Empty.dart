part of ceylon.language;

class Empty implements Sequential {
  const Empty();

  @$dart$core.override
  get size => 0;

  @$dart$core.override
  each($dart$core.Function f) {}

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element) => false;

  @$dart$core.override
  Iterator get iterator => emptyIterator;

  @$dart$core.override
  getFromFirst(index) => null;

  @$dart$core.override
  getFromLast(index) => null;

  @$dart$core.override
  get($dart$core.Object index) => null;

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object el) => false;

  @$dart$core.override
  $dart$core.int get lastIndex => null;

  @$dart$core.override
  $dart$core.bool get empty => true;

  @$dart$core.override
  Sequential sequence() => $toplevel$empty;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  new Tuple(other, $toplevel$empty);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  new Tuple(other, $toplevel$empty);
}

final Empty empty = new Empty();
final $toplevel$empty = empty; // FIXME?

class $EmptyIterator implements Iterator {
  const $EmptyIterator();

  @$dart$core.override
  next() => finished;
}
final emptyIterator = new $EmptyIterator();
