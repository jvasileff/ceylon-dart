part of ceylon.language;

abstract class Invertible implements Summable {
  core.Object get negated;
  core.Object minus(core.Object other);
}
