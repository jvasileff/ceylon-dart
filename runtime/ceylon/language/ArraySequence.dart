part of ceylon.language;

class ArraySequence implements Sequential {
  final Array array;

  ArraySequence(Array this.array);

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
}
