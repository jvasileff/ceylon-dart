part of ceylon.language;

abstract class Iterable {
  Iterator get iterator;

  core.int get size;
  static core.int $get$size(Iterable $this) {
    var count = 0;
    $this.each((_) { count++; });
    return count;
  }

  core.bool get empty;
  static core.bool $empty(Iterable $this)
    =>  core.identical($this.iterator.next(), finished);

  void each(void f(core.Object item));
  static void $each(
      Collection $this,
      void f(core.Object item)) {
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
}
