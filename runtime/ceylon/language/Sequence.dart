part of ceylon.language;

abstract class Sequence implements Sequential {
  Sequence sequence();
  static Sequence $sequence(Iterable $this)
    =>  $this;

  @$dart$core.override
  Sequence withTrailing($dart$core.Object other);
  static Sequence $withTrailing
        (Sequence $this, $dart$core.Object other) {
    var oldSize = $this.size;
    var list = new $dart$core.List(oldSize + 1);
    for (var i = 0; i < oldSize; i++) {
      list[i] = $this.get(i);
    }
    list[oldSize] = other;
    return new ArraySequence(new Array._withList(list));
  }

  @$dart$core.override
  Sequence withLeading($dart$core.Object other);
  static Sequence $withLeading
        (Sequence $this, $dart$core.Object other)
    =>  new Tuple(other, $this);
}
