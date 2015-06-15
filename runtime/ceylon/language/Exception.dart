part of ceylon.language;

class Exception extends Throwable {
  Exception.$(
      core.String message,
      Throwable cause)
      : super(message, cause);

  Exception([
      core.String message = dart$default,
      Throwable cause = dart$default]) : this.$(
          core.identical(message, dart$default) ? null : message,
          core.identical(cause, dart$default) ? null : cause);
}
