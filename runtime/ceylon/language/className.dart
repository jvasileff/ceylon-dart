part of ceylon.language;

core.String className(core.Object obj) {
  // TODO use our own reified metadata when available?
  // removing dependency on `dart:mirrors` would be nice
  mirrors.ClassMirror mirror = mirrors.reflectClass(obj.runtimeType);
  return mirrors.MirrorSystem.getName(mirror.qualifiedName);
}
