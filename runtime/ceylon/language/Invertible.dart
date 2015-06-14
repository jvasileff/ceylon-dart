part of ceylon_language;

abstract class Invertible implements Summable {
  core.Object get negated;
  core.Object minus(core.Object other);
}
