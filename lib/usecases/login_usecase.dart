import 'package:unified_login/errors/login_errors.dart';
import 'package:unified_login/models/credentials.dart';
import 'package:unified_login/records/login_record.dart';
import 'package:unified_login/repositories/auth_repository.dart';

abstract interface class LoginUsecase {
  Future<LoginRecord> call(Credentials credentials);
}

final class LoginUsecaseImpl implements LoginUsecase {
  final AuthRepository _repository;

  LoginUsecaseImpl(this._repository);

  @override
  Future<LoginRecord> call(Credentials credentials) async {
    if (!credentials.email()) {
      return (user: null, error: InvalidData("email"));
    }

    return await _repository.login(credentials);
  }
}
