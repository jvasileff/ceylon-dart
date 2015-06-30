part of ceylon.language;

abstract class Identifiable {
  $dart$core.bool equals($dart$core.Object that);
  static $dart$core.bool $equals
        (Identifiable $this, $dart$core.Object that) {
    return (that is Identifiable) &&
        $dart$core.identical($this,  that);
  }
}
