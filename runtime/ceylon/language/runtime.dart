part of ceylon_language;

///////////////////////////////////////
//
// Capture boxes
//
///////////////////////////////////////

// Separate classes for bool, int, etc, aren't
// necessary on Dart, but using them anyway. And,
// to keep everything consistent, we'll have a
// box for core.String too.

class VariableBox<T> {
  T ref;
  VariableBox(T this.ref);
}

class VariableBoxBool {
  core.bool ref;
  VariableBoxBool(core.bool this.ref);
}

class VariableBoxInt {
  core.int ref;
  VariableBoxInt(core.int this.ref);
}

class VariableBoxDouble {
  core.double ref;
  VariableBoxDouble(core.double this.ref);
}

class VariableBoxString {
  core.String ref;
  VariableBoxString(core.String this.ref);
}

///////////////////////////////////////
//
// Default Argument
//
///////////////////////////////////////

class $Default {
  const $Default();
}

const $default = const $Default();
