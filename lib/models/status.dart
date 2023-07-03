abstract base class Status {
  final String message;

  Status(this.message);
}

final class Ready extends Status {
  Ready() : super("");
}

final class Loading extends Status {
  Loading() : super("");
}

final class Error extends Status {
  Error(String message) : super(message);
}

final class Success extends Status {
  Success(String message) : super(message);
}
