part of ceylon.language;

class ArraySequence implements Sequence {
  final Array array;

  ArraySequence(Array this.array) {
    if (array.empty) {
      throw new AssertionError("array must not be empty");
    }
  }

  // delegate
  @$dart$core.override
  $dart$core.int get lastIndex
    =>  array.lastIndex;

  @$dart$core.override
  $dart$core.Object getFromFirst($dart$core.int index)
    =>  array.getFromFirst(index);

  @$dart$core.override
  $dart$core.bool defines($dart$core.Object index)
    =>  array.defines(index);

  @$dart$core.override
  $dart$core.bool get empty
    =>  List.$empty(this);

  @$dart$core.override
  get($dart$core.Object index)
    =>  array.get(index);

  @$dart$core.override
  getFromLast($dart$core.int index)
    =>  array.getFromLast(index);

  @$dart$core.override
  Iterator get iterator
    =>  array.iterator;

  @$dart$core.override
  $dart$core.int get size
    =>  array.size;

  @$dart$core.override
  void each(void f($dart$core.Object item))
    =>  array.each(f);

  @$dart$core.override
  Sequence sequence()
    =>  Sequence.$sequence(this);

  @$dart$core.override
  Sequence withLeading($dart$core.Object other)
    =>  Sequence.$withLeading(this, other);

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other)
    =>  Sequence.$withTrailing(this, other);
}
