part of ceylon.language;

class Boolean {
  final $dart$core.bool _value;

  const Boolean.$true() : _value = true;
  const Boolean.$false() : _value = false;

  @$dart$core.override
  $dart$core.String toString() => _value.toString();
}

const $true = const Boolean.$true();
const $false = const Boolean.$false();
