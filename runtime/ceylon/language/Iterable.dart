part of ceylon.language;

abstract class Iterable {
  Iterator iterator();

  $dart$core.int get size;
  static $dart$core.int $get$size(Iterable $this) {
    var count = 0;
    $this.each(new dart$Callable((_) { count++; }));
    return count;
  }

  $dart$core.bool get empty;
  static $dart$core.bool $empty(Iterable $this)
    =>  $dart$core.identical($this.iterator().next(), finished);

  void each(Callable step);
  static void $each(
      Collection $this,
      Callable step) {
    var it = $this.iterator();
    for (var item = it.next(); item != finished;
          item = it.next()) {
      step.$delegate$(item);
    }
  }

  $dart$core.Object get first;
  static $dart$core.Object $first(Iterable $this) {
    $dart$core.Object result = $this.iterator().next();
    if (result is Finished) {
      return null;
    }
    return result;
  }

  Iterable get rest;
  static $dart$core.Object $rest(Iterable $this) {
    // FIXME this is a terrible, non-lazy hack
    var list = [];
    Iterator it = $this.iterator();
    var e = it.next();
    while ((e = it.next()) is !Finished) {
      list.add(e);
    }
    return new Array._withList(list);
  }

  Sequential sequence();
  static Sequential $sequence(Iterable $this) {
    Array array = new Array($this);
    if (array.empty) {
      return $package$empty;
    }
    return new ArraySequence(array);
  }

  $dart$core.bool contains($dart$core.Object element);
  static $dart$core.bool $contains(Iterable $this, $dart$core.Object element) {
    // TODO
    throw new AssertionError("not yet implemented");
  }

  Iterable follow($dart$core.Object element);
}
