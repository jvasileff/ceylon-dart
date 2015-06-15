part of ceylon.language;

class Exception extends Throwable {
  Exception.$(
      core.String message,
      Throwable cause)
      : super(message, cause);

  Exception([
      core.String message = $default,
      Throwable cause = $default]) : this.$(
          core.identical(message, $default) ? null : message,
          core.identical(cause, $default) ? null : cause);
}
