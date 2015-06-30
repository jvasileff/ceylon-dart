part of ceylon.language;

abstract class Iterable {
  Iterator get iterator;

  $dart$core.int get size;
  static $dart$core.int $get$size(Iterable $this) {
    var count = 0;
    $this.each((_) { count++; });
    return count;
  }

  $dart$core.bool get empty;
  static $dart$core.bool $empty(Iterable $this)
    =>  $dart$core.identical($this.iterator.next(), finished);

  void each(void f($dart$core.Object item));
  static void $each(
      Collection $this,
      void f($dart$core.Object item)) {
    var it = $this.iterator;
    for (var item = it.next(); item != finished;
          item = it.next()) {
      f(item);
    }
  }

  Sequential sequence();
  static Sequential $sequence(Iterable $this) {
    Array array = new Array($this);
    if (array.empty) {
      return $toplevel$empty;
    }
    return new ArraySequence(array);
  }


  $dart$core.bool contains($dart$core.Object element);
  static $dart$core.bool $contains(Iterable $this, $dart$core.Object element) {
    // TODO
    throw new AssertionError("not yet implemented");
  }
}
