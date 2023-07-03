abstract base class RecoverError implements Exception {
  final String message;

  RecoverError(this.message);
}

final class InvalidData extends RecoverError {
  InvalidData(String field) : super("O campo $field é inválido.");
}

final class NotFound extends RecoverError {
  NotFound() : super("O usuário não foi encontrado.");
}

final class BadRequest extends RecoverError {
  BadRequest(String message) : super(message);
}
