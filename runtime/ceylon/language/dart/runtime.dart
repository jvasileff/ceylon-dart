part of ceylon.language;

///////////////////////////////////////
//
// Capture boxes
//
///////////////////////////////////////

// Separate classes for bool, int, etc, aren't
// necessary on Dart, but using them anyway. And,
// to keep everything consistent, we'll have a
// box for core.String too.

class dart$VariableBox<T> {
  T ref;
  dart$VariableBox(T this.ref);
}

class dart$VariableBoxBool {
  $dart$core.bool ref;
  dart$VariableBoxBool($dart$core.bool this.ref);
}

class dart$VariableBoxInt {
  $dart$core.int ref;
  dart$VariableBoxInt($dart$core.int this.ref);
}

class dart$VariableBoxDouble {
  $dart$core.double ref;
  dart$VariableBoxDouble($dart$core.double this.ref);
}

class dart$VariableBoxString {
  $dart$core.String ref;
  dart$VariableBoxString($dart$core.String this.ref);
}

///////////////////////////////////////
//
// Default Argument
//
///////////////////////////////////////

class dart$Default {
  const dart$Default();
}

const dart$default = const dart$Default();

///////////////////////////////////////
//
// Boxing Helpers
//
///////////////////////////////////////

String dart$nativeToCeylonString($dart$core.String value)
  =>  value == null ? null : new String(value);

$dart$core.String dart$ceylonStringToNative(String value)
  =>  value == null ? null : value._value;

Integer dart$nativeToCeylonInteger($dart$core.int value)
  =>  value == null ? null : new Integer(value);

$dart$core.int dart$ceylonIntegerToNative(Integer value)
  =>  value == null ? null : value._value;

Float dart$nativeToCeylonFloat($dart$core.double value)
  =>  value == null ? null : new Float(value);

$dart$core.double dart$ceylonFloatToNative(Float value)
  =>  value == null ? null : value._value;

Boolean dart$nativeToCeylonBoolean($dart$core.bool value)
  =>  value == null ? null : (value ? $true : $false);

$dart$core.bool dart$ceylonBooleanToNative(Boolean value)
  =>  value == null ? null : value._value;

///////////////////////////////////////
//
// Misc
//
///////////////////////////////////////

class dart$Callable implements Callable {

  final $dart$core.Function $delegate$;

  dart$Callable($dart$core.Function this.$delegate$);
}
