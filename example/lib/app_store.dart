import 'dart:developer';

final class AppStore {
  String _accessToken = "";

  String get token => _accessToken;

  void setToken(String token) {
    log(token, name: "Setting up Token");
    _accessToken = token;
  }
}
