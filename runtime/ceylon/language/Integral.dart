part of ceylon_language;

abstract class Integral implements Number { // Enumerable
  core.bool get unit;
  core.bool get zero;

  core.bool divides(core.Object other);
  core.Object remainder(core.Object other);
}
