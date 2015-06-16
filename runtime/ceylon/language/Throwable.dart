part of ceylon.language;

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
      core.String message = dart$default,
      Throwable cause = dart$default]) : this.$(
          core.identical(message, dart$default) ? null : message,
          core.identical(cause, dart$default) ? null : cause);

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
    _suppressed = _suppressed.withTrailing(suppressed);
  }

  Sequential get suppressed
    =>  _suppressed;

  void printStackTrace() {
    // Note: stackTrace is only available after `throw`
    print(stackTrace);
  }
}
