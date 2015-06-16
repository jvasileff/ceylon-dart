part of ceylon.language;

class ArraySequence implements Sequence {
  final Array array;

  ArraySequence(Array this.array) {
    if (array.empty) {
      throw new AssertionError("array must not be empty");
    }
  }

  // delegate
  @core.override
  core.int get lastIndex
    =>  array.lastIndex;

  @core.override
  core.Object getFromFirst(core.int index)
    =>  array.getFromFirst(index);

  @core.override
  core.bool defines(core.Object index)
    =>  array.defines(index);

  @core.override
  core.bool get empty
    =>  List.$empty(this);

  @core.override
  get(core.Object index)
    =>  array.get(index);

  @core.override
  getFromLast(core.int index)
    =>  array.getFromLast(index);

  @core.override
  Iterator get iterator
    =>  array.iterator;

  @core.override
  core.int get size
    =>  array.size;

  @core.override
  void each(void f(core.Object item))
    =>  array.each(f);

  @core.override
  Sequence sequence()
    =>  Sequence.$sequence(this);

  @core.override
  Sequence withLeading(core.Object other)
    =>  Sequence.$withLeading(this, other);

  @core.override
  Sequence withTrailing(core.Object other)
    =>  Sequence.$withTrailing(this, other);
}
