part of ceylon.language;

$dart$core.String className($dart$core.Object obj) {
  // TODO use our own reified metadata when available?
  // removing dependency on `dart:mirrors` would be nice
  $dart$mirrors.ClassMirror mirror = $dart$mirrors.reflectClass(obj.runtimeType);
  return $dart$mirrors.MirrorSystem.getName(mirror.qualifiedName);
}
