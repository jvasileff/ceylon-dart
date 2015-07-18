part of ceylon.language;

abstract class List implements Collection, Correspondence {
  $dart$core.int get lastIndex;

  $dart$core.Object getFromFirst($dart$core.int index);

  $dart$core.Object get($dart$core.Object index);
  static $dart$core.Object $get
        (List $this, $dart$core.Object index)
    =>  index is Integer &&
        $this.getFromFirst(index._value);

  $dart$core.Object getFromLast($dart$core.int index);
  static $dart$core.Object $getFromLast
        (List $this, $dart$core.int index)
    =>  $this.get($this.lastIndex);

  $dart$core.bool defines($dart$core.Object index);
  static $dart$core.Object $defines
        (List $this, $dart$core.Object index) {
    $dart$core.int lastIndex = $this.lastIndex;
    return lastIndex != null &&
        index is Integer &&
        0 <= index._value &&
        index._value <= $this.lastIndex;
  }

  @$dart$core.override
  $dart$core.int get size;
  static $dart$core.int $get$size
        (List $this)
    =>  $this.lastIndex == null ? 0 : $this.lastIndex + 1;

  $dart$core.bool get empty;
  static $dart$core.bool $empty(List $this)
    =>  $this.lastIndex == null;

  @$dart$core.override
  Iterator iterator();
  static Iterator $iterator(List $this) {
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

  $dart$core.Object next() {
    if (index.ref <= $outer.lastIndex) {
      return $outer.getFromFirst(index.ref++);
    }
    return finished;
  }
}
