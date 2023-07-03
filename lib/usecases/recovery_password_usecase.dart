import 'package:unified_login/errors/recover_errors.dart';
import 'package:unified_login/records/recover_record.dart';
import 'package:unified_login/repositories/auth_repository.dart';

abstract interface class RecoveryPasswordUsecase {
  Future<RecoverRecord> call(String username);
}

final class RecoveryPasswordUsecaseImpl implements RecoveryPasswordUsecase {
  final AuthRepository _repository;

  RecoveryPasswordUsecaseImpl(this._repository);

  @override
  Future<RecoverRecord> call(String username) async {
    if (username.isEmpty) {
      return (success: false, error: InvalidData("username"));
    }

    return await _repository.recoverPassword(username);
  }
}
