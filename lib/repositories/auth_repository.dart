import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:unified_login/errors/login_errors.dart';
import 'package:unified_login/errors/recover_errors.dart' as recover;
import 'package:unified_login/models/credentials.dart';
import 'package:unified_login/models/user_dto.dart';
import 'package:unified_login/records/login_record.dart';
import 'package:unified_login/records/recover_record.dart';
import 'package:unified_login/utils/client/client_interface.dart';

abstract interface class AuthRepository {
  Future<LoginRecord> login(Credentials credentials);
  Future<RecoverRecord> recoverPassword(String username);
}

final class AuthRepositoryImpl implements AuthRepository {
  final Client _client;

  AuthRepositoryImpl(this._client);

  @override
  Future<LoginRecord> login(Credentials credentials) async {
    try {
      final deviceInfo = await DeviceInfoPlugin().androidInfo;
      // final token = 'Basic ${base64.encode(utf8.encode("${credentials.email.value}:${credentials.password}"))}';

      final result = await _client.post(
        "/login",
        {
          'username': credentials.email.value,
          'password': credentials.password,
          'mac': deviceInfo.id,
        },
        // headers: {"Authorization": token},
      );

      if (result.statusCode == 200) {
        // return (user: LoginTokenAdapter.fromMap(result.data["data"]), error: null);
        return (user: UserDto.fromJson(result.data['data']['user']), error: null);
      }

      if (result.statusCode == 403) {
        return (user: null, error: InvalidCredential());
      }

      throw Exception("Unhandled request");
    } catch (e) {
      return (user: null, error: BadRequest(e.toString()));
    }
  }

  @override
  Future<RecoverRecord> recoverPassword(String username) async {
    try {
      final result = await _client.post("/reset_password", {"username": username});

      if (result.statusCode == 204) {
        return (success: true, error: null);
      }

      if (result.statusCode == 400) {
        return (success: false, error: recover.NotFound());
      }

      throw Exception("Unhandled request");
    } catch (e) {
      return (success: false, error: recover.BadRequest(e.toString()));
    }
  }
}
