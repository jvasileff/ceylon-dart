part of ceylon_language;

abstract class Iterable {
  Iterator get iterator;

  core.int get size;
  static core.int $get$size(Iterable $this) {
    var count = 0;
    $this.each((_) { count++; });
    return count;
  }

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
}
