part of ceylon.language;

class Empty implements Sequential {
  const Empty();

  @$dart$core.override
  get size => 0;

  @$dart$core.override
  each(Callable step) {}

  @$dart$core.override
  $dart$core.bool contains($dart$core.Object element) => false;

  @$dart$core.override
  Iterator iterator() => emptyIterator;

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
  Sequential sequence() => $package$empty;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  new Tuple(other, $package$empty);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  new Tuple(other, $package$empty);

  @$dart$core.override
  $dart$core.Object follow($dart$core.Object head)
    =>  new Tuple(head, $package$empty);

  @$dart$core.override
  $dart$core.Object get first
    =>  null;

  @$dart$core.override
  Iterable get rest
    =>  this;
}

final Empty empty = new Empty();
final $package$empty = empty;

class $EmptyIterator implements Iterator {
  const $EmptyIterator();

  @$dart$core.override
  next() => finished;
}
final emptyIterator = new $EmptyIterator();
