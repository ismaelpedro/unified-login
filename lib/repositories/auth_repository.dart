import 'dart:convert';

import 'package:unified_login/adapters/login_token_adapter.dart';
import 'package:unified_login/errors/login_errors.dart';
import 'package:unified_login/errors/recover_errors.dart' as recover;
import 'package:unified_login/models/credentials.dart';
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
      final token = 'Basic ${base64.encode(utf8.encode("${credentials.email.value}:${credentials.password}"))}';
      final result = await _client.get("/login", headers: {"Authorization": token});

      if (result.statusCode == 200) {
        return (token: LoginTokenAdapter.fromMap(result.data["data"]), error: null);
      }

      if (result.statusCode == 403) {
        return (token: null, error: InvalidCredential());
      }

      throw Exception("Unhandled request");
    } catch (e) {
      return (token: null, error: BadRequest(e.toString()));
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
