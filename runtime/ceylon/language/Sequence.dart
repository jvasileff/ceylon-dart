part of ceylon.language;

abstract class Sequence implements Sequential {
  Sequence sequence();
  static Sequence $sequence(Iterable $this)
    =>  $this;

  @core.override
  Sequence withTrailing(core.Object other);
  static Sequence $withTrailing
        (Sequence $this, core.Object other) {
    var oldSize = $this.size;
    var list = new core.List(oldSize + 1);
    for (var i = 0; i < oldSize; i++) {
      list[i] = $this.get(i);
    }
    list[oldSize] = other;
    return new ArraySequence(new Array._withList(list));
  }

  @core.override
  Sequence withLeading(core.Object other);
  static Sequence $withLeading
        (Sequence $this, core.Object other)
    =>  new Tuple(other, $this);
}
