abstract base class LoginError implements Exception {
  final String message;

  LoginError(this.message);
}

final class InvalidCredential extends LoginError {
  InvalidCredential() : super("Usuário ou senha inválidos.");
}

final class InvalidData extends LoginError {
  InvalidData(String field) : super("O campo $field é inválido.");
}

final class BadRequest extends LoginError {
  BadRequest(String message) : super(message);
}
