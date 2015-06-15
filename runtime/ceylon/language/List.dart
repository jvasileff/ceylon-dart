part of ceylon.language;

abstract class List implements Collection, Correspondence {
  core.int get lastIndex;

  core.Object getFromFirst(core.int index);

  core.Object get(core.Object index);
  static core.Object $get
        (List $this, core.Object index)
    =>  index is Integer &&
        $this.getFromFirst(index._value);

  core.Object getFromLast(core.int index);
  static core.Object $getFromLast
        (List $this, core.int index)
    =>  $this.get($this.lastIndex);

  core.bool defines(core.Object index);
  static core.Object $defines
        (List $this, core.Object index) {
    core.int lastIndex = $this.lastIndex;
    return lastIndex != null &&
        index is Integer &&
        0 <= index._value &&
        index._value <= $this.lastIndex;
  }

  @core.override
  core.int get size;
  static core.int $get$size
        (List $this)
    =>  $this.lastIndex == null ? 0 : $this.lastIndex + 1;

  core.bool get empty;
  static core.bool $empty(List $this)
    =>  $this.lastIndex == null;

  @core.override
  Iterator get iterator;
  static Iterator $get$iterator(List $this) {
    // capture a variable (very unoptimized!)
    dart$VariableBoxInt index = new dart$VariableBoxInt(0);
    // simulate anonymous class
    return new _$ListIterator_anon($this, index);
  }
}

// Simulate anonymous class
class _$ListIterator_anon implements Iterator {
  // just assume all members are visible
  List $outer;

  // this can only be captured when there is
  // no member name conflict, right?
  dart$VariableBoxInt index;

  _$ListIterator_anon(List this.$outer, dart$VariableBoxInt this.index);

  core.Object next() {
    if (index.ref <= $outer.lastIndex) {
      return $outer.getFromFirst(index.ref++);
    }
    return finished;
  }
}
