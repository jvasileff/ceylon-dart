part of ceylon.language;

class Boolean {
  final $dart$core.bool _value;

  const Boolean.$true() : _value = true;
  const Boolean.$false() : _value = false;

  @$dart$core.override
  $dart$core.String toString() => _value.toString();

  // Dart runtime

  static Boolean instance($dart$core.bool value)
    => value == null ? null : (value ? $true : $false);

  static $dart$core.bool nativeValue(Boolean value)
    => value == null ? null : value._value;
}

const $true = const Boolean.$true();
const $false = const Boolean.$false();
