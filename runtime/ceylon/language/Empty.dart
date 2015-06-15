part of ceylon.language;

class Empty implements Sequential {
  const Empty();

  @core.override
  get size => 0;

  @core.override
  each(core.Function f) {}

  @core.override
  Iterator get iterator => emptyIterator;

  @core.override
  getFromFirst(index) => null;

  @core.override
  getFromLast(index) => null;

  @core.override
  get(core.Object index) => null;

  @core.override
  core.bool defines(core.Object el) => false;

  @core.override
  core.int get lastIndex => null;

  @core.override
  core.bool get empty => true;

  @core.override
  Sequential sequence() => $toplevel$empty;
}

final Empty empty = new Empty();
final $toplevel$empty = empty; // FIXME?

class $EmptyIterator implements Iterator {
  const $EmptyIterator();

  @core.override
  next() => finished;
}
final emptyIterator = new $EmptyIterator();
