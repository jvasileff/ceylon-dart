library ceylon.language;

import 'dart:core' as $dart$core;
import 'dart:math' as $dart$math;
import "../../../build/modules-dart/main/ceylon/dart/runtime/model/1.3.1-SNAPSHOT/ceylon.dart.runtime.model-1.3.1-SNAPSHOT.dart" as $ceylon$dart$runtime$model;
import "../../../build/modules-dart/main/ceylon/language/1.3.1-DP5-SNAPSHOT/ceylon.language-1.3.1-DP5-SNAPSHOT.dart";

/////////////////////////////////////////////////
//
// ceylon.language::LazyIterable
//
/////////////////////////////////////////////////

class LazyIterable extends impl$BaseIterable {
  $ceylon$dart$runtime$model.runtime$TypeDescriptor Element;
  $dart$core.int count_;
  $dart$core.Function generate; // Object(Integer)
  Iterable spread_;

  LazyIterable(this.Element, this.count_, this.generate, this.spread_) {}

  @$dart$core.override
  Iterator iterator()
    =>  new LazyIterator(Element, count_, generate, spread_);
}

class LazyIterator implements Iterator {
  final $dart$core.int count;
  final $dart$core.Function generate;
  final Iterable spread;

  $dart$core.int index = 0;
  Iterator rest;

  LazyIterator($ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      this.count, this.generate, this.spread) {}

  Iterator flatten()
      =>  rest;

  $dart$core.Object next() {
    if (rest != null) {
      while (rest is LazyIterator) {
        var replacement = (rest as LazyIterator).flatten();
        if (replacement != null) {
          rest = replacement;
        } else {
          break;
        }
      }
      return rest.next();
    }
    else if (index >= count) {
      return $package$finished;
    }
    else {
      $dart$core.Object result = generate(index++);
      if (index == count && spread != null) {
        rest = spread.iterator();
      }
      return result;
    }
  }
}

/////////////////////////////////////////////////
//
// ceylon.language::Boolean
//
/////////////////////////////////////////////////

$dart$core.bool $dartBool(Boolean value)
  =>  value == null ? null : (value == $true ? true : false);

Boolean $ceylonBoolean($dart$core.bool value)
  =>  value == null ? null : (value ? $true : $false);

/////////////////////////////////////////////////
//
// ceylon.language::Character
//
/////////////////////////////////////////////////

Character $package$characterFromInteger($dart$core.int integer)
  =>  characterFromInteger(integer);

Character characterFromInteger($dart$core.int integer)
  =>  new Character.$fromInt(integer);

class Character extends BaseCharacter implements dart$$Object, Comparable, Enumerable {

  Character(Character character) : super(character.integer) {}

  Character.$fromInt($dart$core.int integer) : super(integer) {}
}

/////////////////////////////////////////////////
//
// ceylon.language::Float
//
/////////////////////////////////////////////////

$dart$core.double $dartDouble(Float value)
  =>  value == null ? null : value._float;

Float $ceylonFloat($dart$core.double value)
  =>  value == null ? null : new Float(value);

/////////////////////////////////////////////////
//
// ceylon.language::Integer
//
/////////////////////////////////////////////////

$dart$core.int $dartInt(Integer value)
  =>  value == null ? null : value._integer;

Integer $ceylonInteger($dart$core.int value)
  =>  value == null ? null : new Integer(value);

$dart$core.int $package$intRightArithmeticShift($dart$core.int integer, $dart$core.int shift)
  =>  intRightArithmeticShift(integer, shift);

$dart$core.int intRightArithmeticShift($dart$core.int integer, $dart$core.int shift)
  =>  (integer.toSigned(32) >> (shift & 0x1F)).toSigned(32);

$dart$core.int $package$intRightLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  intRightLogicalShift(integer, shift);

$dart$core.int intRightLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  ((integer & 0xFFFFFFFF) >> (shift & 0x1F)).toUnsigned(32);

$dart$core.int $package$intLeftLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  intLeftLogicalShift(integer, shift);

$dart$core.int intLeftLogicalShift($dart$core.int integer, $dart$core.int shift)
  =>  (integer << (shift & 0x1F)).toSigned(32);

$dart$core.int $package$intNot($dart$core.int integer)
  =>  intNot(integer);

$dart$core.int intNot($dart$core.int integer)
  =>  (~integer).toSigned(32);

$dart$core.int $package$intOr($dart$core.int integer, $dart$core.int other)
  =>  intOr(integer, other);

$dart$core.int intOr($dart$core.int integer, $dart$core.int other)
  =>  integer.toSigned(32) | other.toSigned(32);

$dart$core.int $package$intAnd($dart$core.int integer, $dart$core.int other)
  =>  intAnd(integer, other);

$dart$core.int intAnd($dart$core.int integer, $dart$core.int other)
  =>  integer.toSigned(32) & other.toSigned(32);

$dart$core.int intXor($dart$core.int integer, $dart$core.int other)
  =>  integer.toSigned(32) ^ other.toSigned(32);

$dart$core.int $package$intXor($dart$core.int integer, $dart$core.int other)
  =>  intXor(integer, other);

$dart$core.bool $package$intGet($dart$core.int integer, $dart$core.int index)
  =>  intGet(integer, index);

$dart$core.bool intGet($dart$core.int integer, $dart$core.int index) {
  if (index < 0 || index > 31) {
    return false;
  }
  return integer.toSigned(32) & (1<<index) != 0;
}

$dart$core.int $package$intPow($dart$core.int integer, $dart$core.int other)
  =>  intPow(integer, other);

$dart$core.int intPow($dart$core.int integer, $dart$core.int other) {
  if (other < 0) {
    if (integer == -1) {
      return other % 2 == 0 ? 1 : -1;
    }
    if (integer == 1) {
      return integer;
    }
    throw new AssertionError("exponent must not be negative");
  }
  return $dart$math.pow(integer, other);
}

$dart$core.int $package$intSet($dart$core.int integer, $dart$core.int index, $dart$core.bool bit)
  =>  intSet(integer, index, bit);

$dart$core.int intSet($dart$core.int integer, $dart$core.int index, $dart$core.bool bit) {
  if (index < 0 || index > 31) {
    return integer.toSigned(32);
  }
  $dart$core.int mask = (1 << index).toSigned(32);
  if (bit) {
    return integer.toSigned(32) | mask;
  }
  else {
    return integer.toSigned(32) & ~mask;
  }
}

$dart$core.int $package$intFlip($dart$core.int integer, $dart$core.int index)
  =>  intFlip(integer, index);

$dart$core.int intFlip($dart$core.int integer, $dart$core.int index) {
  if (index < 0 || index > 31) {
    return integer.toSigned(32);
  }
  $dart$core.int mask = (1 << index).toSigned(32);
  return integer.toSigned(32) ^ mask;
}

/////////////////////////////////////////////////
//
// ceylon.language::String
//
/////////////////////////////////////////////////

$dart$core.String $dartString(String value)
  =>  value == null ? null : value._val;

String $ceylonString($dart$core.String value)
  =>  value == null ? null : new String.withString(value);

class String extends BaseString implements Summable, Comparable, Ranged {

  String(Iterable characters) : super(characters) {}

  String.withString($dart$core.String s) : super.withString(s) {}

  @$dart$core.override
  String get self
    =>  this;

  @$dart$core.override
  String operator +(String other)
    =>  new String.withString(_val + other._val);

  @$dart$core.override
  $dart$core.bool operator >(String other)
    =>  _val.compareTo(other._val) > 0;

  @$dart$core.override
  $dart$core.bool operator <(String other)
    =>  _val.compareTo(other._val) < 0;

  @$dart$core.override
  $dart$core.bool operator >=(String other)
    =>  _val.compareTo(other._val) >= 0;

  @$dart$core.override
  $dart$core.bool operator <=(String other)
    =>  _val.compareTo(other._val) <= 0;
}

/////////////////////////////////////////////////
//
// ceylon.language::Throwable
//
/////////////////////////////////////////////////

class Throwable extends BaseThrowable {
  Throwable([$dart$core.Object description = $package$dart$default,
             $dart$core.Object cause = $package$dart$default]) : this.$w(
    $dart$core.identical(description, $package$dart$default)
        ? null : description,
    $dart$core.identical(cause, $package$dart$default)
        ? null : cause);

  Throwable.$w([$dart$core.String description, Throwable cause])
      : super(description, cause) {}
}

/////////////////////////////////////////////////
//
// ceylon.language::Tuple
//
/////////////////////////////////////////////////

Tuple tupleTrailing(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Other,
      Iterable initial,
      $dart$core.Object element)
  // FIXME type args; impossible this way.
  =>  new Tuple.$trailing(null, First, null, initial, element);

Tuple $package$tupleTrailing(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Other,
      Iterable initial,
      $dart$core.Object element)
  =>  tupleTrailing(Element, First, Other, initial, element);

Tuple tupleOfElements(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      Iterable rest)
  =>  new Tuple.$ofElements(Element, First, Rest, rest);

Tuple $package$tupleOfElements(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      Iterable rest)
  =>  tupleOfElements(Element, First, Rest, rest);

Tuple tupleWithList([
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      $dart$core.List list,
      $dart$core.Object rest = dart$default])
  =>  new Tuple.$withList(Element, First, Rest, list, rest);

Tuple $package$tupleWithList([
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      $dart$core.List list,
      $dart$core.Object rest = dart$default])
  =>  tupleWithList(Element, First, Rest, list, rest);

class Tuple extends BaseTuple {

  Tuple([$ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      $dart$core.Object first,
      $dart$core.Object rest = dart$default])
        : super(Element, First, Rest, first, rest) {}

  Tuple.$trailing(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      Iterable initial,
      $dart$core.Object element)
        : super.trailing(Element, First, Rest, initial, element);

  Tuple.$ofElements(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      Iterable rest)
        : super.ofElements(Element, First, Rest, rest) {}

  Tuple.$withList([
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Element,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor First,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Rest,
      $dart$core.List list,
      $dart$core.Object rest = dart$default])
        : super.withList(Element, First, Rest, list, rest) {}

  Tuple get thisTuple => this;
}

/////////////////////////////////////////////////
//
// ceylon.language::printStackTrace
//
/////////////////////////////////////////////////

void printStackTrace([Throwable exception, $dart$core.Object write = dart$default]) {
  // TODO if the stackTrace is not available, should we just print <null> or something instead?
  if (null == exception.stackTrace) {
    try { throw exception; } catch (e) {}
  }
  if (write == dart$default) {
    process.writeLine(exception.stackTrace.toString());
  }
  else {
    (write as Callable).f($ceylonString(exception.stackTrace.toString()));
  }
}

/////////////////////////////////////////////////
//
// ceylon.language::$run
//
/////////////////////////////////////////////////

$run(
    $dart$core.List<$dart$core.String> arguments,
    $ceylon$dart$runtime$model.json$LazyJsonModule mod) {

  // initialize processArguments and run the program

  var runDeclaration;
  if (arguments.isEmpty) {
    runDeclaration = mod.nameAsString == "default"
        ? "::run" : mod.nameAsString + "::run";
    processArguments = $package$empty;
  }
  else if (arguments[0].startsWith("\$ceylon\$run=")) {
    runDeclaration = arguments[0].substring(12);
    if (arguments.length == 1) {
        processArguments = $package$empty;
    }
    else {
        processArguments = new ArraySequence(new Array.withList(
            arguments.skip(1).map((s) => $ceylonString(s)).toList(growable: false)));
    }
  }
  else {
    runDeclaration = mod.nameAsString == "default"
        ? "::run" : mod.nameAsString + "::run";
    processArguments = new ArraySequence(new Array.withList(
        arguments.map((s) => $ceylonString(s)).toList(growable: false)));
  }
  var success = mod.runApplication(runDeclaration);
  if (!success) {
    $dart$core.print("Could not find toplevel function '$runDeclaration'.");
    process.exit(1);
  }
}

/////////////////////////////////////////////////
//
// Marker Interfaces:
//
//    ceylon.language.dart::Object
//    ceylon.language.dart::Basic
//    ceylon.language.dart::Identifiable
//
/////////////////////////////////////////////////

abstract class dart$$Object {
  // used for 'super.string' from within an interface
  static $dart$core.String $get$string([final dart$$Object $this])
    => "Instance of '" + className($this) + "'";
}
abstract class dart$$Identifiable extends dart$$Object {}
abstract class dart$$Basic extends dart$$Identifiable {}

/////////////////////////////////////////////////
//
// ceylon.language::Callable
// ceylon.language::flatten
// ceylon.language::unflatten
//
/////////////////////////////////////////////////

abstract class Callable {
  $dart$core.Function get f;
  $dart$core.Function get s;
}

class dart$Callable implements dart$$Object, $dart$core.Function, Callable {
  final $dart$core.Function _function;
  final $dart$core.int _variadicIndex;

  $dart$core.bool operator ==($dart$core.Object other) => false;

  dart$Callable([
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Arguments,
    $dart$core.Function this._function,
    $dart$core.int this._variadicIndex = -1]);

  // for non-spread calls `f()`
  $dart$core.Function get f => _variadicIndex == -1 ? _function : this;

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    if (invocation.memberName == #call) {
      // There is no spread argument (this is the "f" function)

      // For interop, dart$Calable's may be used directly as Functions, so handle the
      // non-variadic case that is normally avoided in `get f` above.
      if (_variadicIndex == -1) {
        return $dart$core.Function.apply(_function, invocation.positionalArguments, null);
      }

      var inArgs = invocation.positionalArguments;
      var outArgs = new $dart$core.List(_variadicIndex + 1);

      var initialLength = $dart$math.min(_variadicIndex, inArgs.length);

      if (initialLength > 0) {
        outArgs.setRange(0, initialLength, inArgs);
      }

      if (inArgs.length > initialLength) {
        // The rest form the variadic parameter
        outArgs[_variadicIndex] = new Tuple.$withList(
              // FIXME type args
              null, null, null, inArgs.sublist(initialLength));
      }
      else {
        // Fill with default values
        outArgs.fillRange(initialLength, _variadicIndex, dart$default);
        outArgs[_variadicIndex] = empty;
      }

      return $dart$core.Function.apply(_function, outArgs, null);
    }
    else if (invocation.memberName == #s) {
      // The last of inArgs is a spread argument

      var inArgs = invocation.positionalArguments;

      if (_variadicIndex == -1) {
        // Not variadic
        var seq = inArgs.last as Sequential;
        var outSize = inArgs.length + seq.size - 1;
        var initialLength = inArgs.length - 1;
        var outArgs = new $dart$core.List(outSize);

        // Copy non-spread args
        if (initialLength > 0) {
          outArgs.setRange(0, initialLength, inArgs);
        }

        // Add more from the spread arg
        var outIndex = initialLength;
        var seqIndex = 0;
        while (seqIndex < seq.size) {
          outArgs[outIndex] = seq.getFromFirst(seqIndex);
          outIndex++;
          seqIndex++;
        }

        return $dart$core.Function.apply(_function, outArgs, null);
      }
      else if (inArgs.length == _variadicIndex + 1) {
        // Variadic index lines up with spread index. Simply forward the positional arguments.
        return $dart$core.Function.apply(_function, invocation.positionalArguments, null);
      }
      else {
        // Populate outArgs for the invocation.
        var seq = inArgs.last as Sequential;
        var outArgs = new $dart$core.List(_variadicIndex + 1);

        var initialLength = $dart$math.min(_variadicIndex, inArgs.length - 1);

        if (initialLength > 0) {
          outArgs.setRange(0, initialLength, inArgs);
        }

        if (initialLength < _variadicIndex) {
          var outIndex = initialLength;
          var seqIndex = 0;

          // Add more from the spread arg
          while (outIndex < _variadicIndex && seqIndex < seq.size) {
            outArgs[outIndex] = seq.getFromFirst(seqIndex);
            outIndex++;
            seqIndex++;
          }

          if (seqIndex < seq.size) {
            // Include the rest in the variadic
            outArgs[_variadicIndex]
                = seq.spanFrom(new Integer(_variadicIndex - initialLength));
          }
          else {
            // Fill with default values
            outArgs.fillRange(outIndex, _variadicIndex, dart$default);
            outArgs[_variadicIndex] = empty;
          }
        }
        else {
          // Create new tuple with tail of inArgs and entire spread
          outArgs[_variadicIndex]
              = new Tuple.$withList(
                  // FIXME type args
                  null, null, null,
                  inArgs.sublist(initialLength, inArgs.length - 1), seq);
        }

        return $dart$core.Function.apply(_function, outArgs, null);
      }
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

Callable flatten(
  $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
  $ceylon$dart$runtime$model.runtime$TypeDescriptor Args,
  Callable tupleFunction) {
  if (tupleFunction is dart$UnflatFunction) {
    return tupleFunction.flatFunction;
  }
  return new dart$FlatFunction(Return, Args, tupleFunction);
}

Callable unflatten(
  $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
  $ceylon$dart$runtime$model.runtime$TypeDescriptor Args,
  Callable flatFunction) {
  if (flatFunction is dart$FlatFunction) {
    return flatFunction.tupleFunction;
  }
  return new dart$UnflatFunction(Return, Args, flatFunction);
}

class dart$FlatFunction implements dart$$Object, $dart$core.Function, Callable {
  final Callable tupleFunction;

  dart$FlatFunction(
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Arguments,
    Callable this.tupleFunction);

  $dart$core.bool operator ==($dart$core.Object other) => false;

  // for non-spread calls `f()`, always use noSuchMethod.

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    var inArgs = invocation.positionalArguments;
    if (invocation.memberName == #f || invocation.memberName == #call) {
      var tuple = invocation.positionalArguments.length > 0
          ? new Tuple.$withList(
              // FIXME type args
              null, null, null, inArgs, empty) : empty;

      return tupleFunction.f(tuple);
    }
    else if (invocation.memberName == #s) {
      // Simply create a tuple with all arguments
      if (inArgs.length == 1) {
        return tupleFunction.f(inArgs.first);
      }
      else {
        // assert(inArgs > 1)
        return tupleFunction.f(new Tuple.$withList(
                // FIXME type args
                null, null, null,
                inArgs.sublist(0, inArgs.length - 1), inArgs.last), null);
      }
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

class dart$UnflatFunction implements dart$$Object, $dart$core.Function, dart$Callable {
  final Callable flatFunction;

  dart$UnflatFunction(
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
    $ceylon$dart$runtime$model.runtime$TypeDescriptor Arguments,
    Callable this.flatFunction);

  $dart$core.bool operator ==($dart$core.Object other) => false;

  // for non-spread calls `f()`, always use noSuchMethod.

  // for spread calls `s()`, always use noSuchMethod.

  noSuchMethod($dart$core.Invocation invocation) {
    var inArgs = invocation.positionalArguments;
    if (invocation.memberName == #f || invocation.memberName == #call) {
      // There will always be exactly one argument, which is a sequence
      return flatFunction.s(inArgs.first);
    }
    else if (invocation.memberName == #s) {
      // There will always be exactly one argument, which is a sequence holding a sequential
      return flatFunction.s(inArgs.first.first);
    }
    else {
      super.noSuchMethod(invocation);
    }
  }
}

Callable $package$flatten(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Args,
      Callable tupleFunction)
  =>  flatten(Return, Args, tupleFunction);

Callable $package$unflatten(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Return,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor Args,
      Callable flatFunction)
  =>  unflatten(Return, Args, flatFunction);

/////////////////////////////////////////////////
//
// ceylon.language.dart::default
//
/////////////////////////////////////////////////

class dart$Default {
  const dart$Default();
}

const dart$default = const dart$Default();

const $package$dart$default = dart$default;

/////////////////////////////////////////////////
//
// ceylon.language.impl.meta
//
/////////////////////////////////////////////////

meta$model$Function impl$meta$model$createFunction(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createFunction(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$Function $package$impl$meta$model$createFunction(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$FunctionImpl(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$Method impl$meta$model$createMethod(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createMethod(containerTP, typeTP, argumentsTP, modelReference);

meta$model$Method $package$impl$meta$model$createMethod(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$MethodImpl(containerTP, typeTP, argumentsTP, modelReference);

meta$model$Value impl$meta$model$createValue(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor getTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor setTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createValue(getTP, setTP, modelReference, qualifyingInstance);

meta$model$Value $package$impl$meta$model$createValue(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor getTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor setTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$ValueImpl(getTP, setTP, modelReference, qualifyingInstance);

meta$model$Attribute impl$meta$model$createAttribute(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor getTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor setTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createAttribute(containerTP, getTP, setTP, modelReference);

meta$model$Attribute $package$impl$meta$model$createAttribute(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor getTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor setTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$AttributeImpl(containerTP, getTP, setTP, modelReference);

meta$model$CallableConstructor impl$meta$model$createCallableConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createCallableConstructor(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$CallableConstructor $package$impl$meta$model$createCallableConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$CallableConstructorImpl(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$Class impl$meta$model$createClass(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createClass(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$Class $package$impl$meta$model$createClass(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$ClassImpl(typeTP, argumentsTP, modelReference, qualifyingInstance);

meta$model$Interface impl$meta$model$createInterface(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createInterface(typeTP, modelReference, qualifyingInstance);

meta$model$Interface $package$impl$meta$model$createInterface(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$InterfaceImpl(typeTP, modelReference, qualifyingInstance);

meta$model$IntersectionType impl$meta$model$createIntersectionType(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createIntersectionType(typeTP, modelReference);

meta$model$IntersectionType $package$impl$meta$model$createIntersectionType(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$IntersectionTypeImpl(typeTP, modelReference);

meta$model$MemberClass impl$meta$model$createMemberClass(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createMemberClass(containerTP, typeTP, argumentsTP, modelReference);

meta$model$MemberClass $package$impl$meta$model$createMemberClass(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$MemberClassImpl(containerTP, typeTP, argumentsTP, modelReference);

meta$model$MemberInterface impl$meta$model$createMemberInterface(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createMemberInterface(containerTP, typeTP, modelReference);

meta$model$MemberInterface $package$impl$meta$model$createMemberInterface(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$MemberInterfaceImpl(containerTP, typeTP, modelReference);

meta$model$MemberClassCallableConstructor impl$meta$model$createMemberClassCallableConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createMemberClassCallableConstructor(containerTP, typeTP, argumentsTP, modelReference);

meta$model$MemberClassCallableConstructor $package$impl$meta$model$createMemberClassCallableConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor argumentsTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$MemberClassCallableConstructorImpl(containerTP, typeTP, argumentsTP, modelReference);

meta$model$MemberClassValueConstructor impl$meta$model$createMemberClassValueConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createMemberClassValueConstructor(containerTP, typeTP, modelReference);

meta$model$MemberClassValueConstructor $package$impl$meta$model$createMemberClassValueConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor containerTP,
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$MemberClassValueConstructorImpl(containerTP, typeTP, modelReference);

meta$model$UnionType impl$meta$model$createUnionType(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  $package$impl$meta$model$createUnionType(typeTP, modelReference);

meta$model$UnionType $package$impl$meta$model$createUnionType(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference)
  =>  new impl$meta$model$UnionTypeImpl(typeTP, modelReference);

meta$model$ValueConstructor impl$meta$model$createValueConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  $package$impl$meta$model$createValueConstructor(typeTP, modelReference, qualifyingInstance);

meta$model$ValueConstructor $package$impl$meta$model$createValueConstructor(
      $ceylon$dart$runtime$model.runtime$TypeDescriptor typeTP,
      $ceylon$dart$runtime$model.Type modelReference,
      $dart$core.Object qualifyingInstance)
  =>  new impl$meta$model$ValueConstructorImpl(typeTP, modelReference, qualifyingInstance);
