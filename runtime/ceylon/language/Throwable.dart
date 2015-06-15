part of ceylon_language;

 class Throwable extends core.Error {
  core.String _description;
  final Throwable cause;

  Sequential _suppressed = empty;

  Throwable.$(
        core.String message,
        Throwable this.cause) {
    this._description = message;
  }

  Throwable([
      core.String message = $default,
      Throwable cause = $default]) : this.$(
          core.identical(message, $default) ? null : message,
          core.identical(cause, $default) ? null : cause);

  core.String get message {
    if (_description != null) {
      return _description;
    }
    else if (cause != null) {
      return cause.message;
    }
    return "";
  }

  core.String toString() {
    return className(this) + " \"$message\"";
  }

  void addSuppressed(Throwable suppressed) {
    // TODO don't use Tuple's internal API
    _suppressed = new Tuple(suppressed, _suppressed);
  }

  Sequential get suppressed
    =>  _suppressed;

  void printStackTrace() {
    // Note: stackTrace is only available after `throw`
    print(stackTrace);
  }
}
