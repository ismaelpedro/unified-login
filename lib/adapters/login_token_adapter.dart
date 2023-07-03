import 'package:unified_login/models/login_token.dart';

final class LoginTokenAdapter extends LoginToken {
  LoginTokenAdapter(super.accessToken, super.refreshToken);

  factory LoginTokenAdapter.fromMap(Map<String, dynamic> source) {
    return LoginTokenAdapter(source["access_token"], source["refresh_token"]);
  }
}
