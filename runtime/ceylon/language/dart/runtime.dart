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
  core.bool ref;
  dart$VariableBoxBool(core.bool this.ref);
}

class dart$VariableBoxInt {
  core.int ref;
  dart$VariableBoxInt(core.int this.ref);
}

class dart$VariableBoxDouble {
  core.double ref;
  dart$VariableBoxDouble(core.double this.ref);
}

class dart$VariableBoxString {
  core.String ref;
  dart$VariableBoxString(core.String this.ref);
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

String dart$nativeToCeylonString(core.String value)
  =>  value == null ? null : new String(value);

core.String dart$ceylonStringToNative(String value)
  =>  value == null ? null : value._value;

Integer dart$nativeToCeylonInteger(core.int value)
  =>  value == null ? null : new Integer(value);

core.int dart$ceylonIntegerToNative(Integer value)
  =>  value == null ? null : value._value;

Float dart$nativeToCeylonFloat(core.double value)
  =>  value == null ? null : new Float(value);

core.double dart$ceylonFloatToNative(Float value)
  =>  value == null ? null : value._value;

Boolean dart$nativeToCeylonBoolean(core.bool value)
  =>  value == null ? null : (value ? $true : $false);

core.bool dart$ceylonBooleanToNative(Boolean value)
  =>  value == null ? null : value._value;

///////////////////////////////////////
//
// Misc
//
///////////////////////////////////////

class dart$Callable implements Callable {

  final core.Function $delegate$;

  dart$Callable(core.Function this.$delegate$);
}
