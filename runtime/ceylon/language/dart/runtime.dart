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
