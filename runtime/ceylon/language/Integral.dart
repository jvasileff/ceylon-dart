part of ceylon.language;

abstract class Integral implements Number { // Enumerable
  $dart$core.bool get unit;
  $dart$core.bool get zero;

  $dart$core.bool divides($dart$core.Object other);
  $dart$core.Object remainder($dart$core.Object other);
}
