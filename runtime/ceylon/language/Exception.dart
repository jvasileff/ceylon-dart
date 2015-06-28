part of ceylon.language;

class Exception extends Throwable {
  Exception.$(
      $dart$core.String message,
      Throwable cause)
      : super(message, cause);

  Exception([
      $dart$core.String message = dart$default,
      Throwable cause = dart$default]) : this.$(
          $dart$core.identical(message, dart$default) ? null : message,
          $dart$core.identical(cause, dart$default) ? null : cause);
}
