import 'package:flutter/material.dart';
import 'package:unified_login/login_module.dart';

void main() {
  runApp(
    LoginModule(
      baseUrl: "https://authenticator-s.ceartico.com/api/v1/auth",
      loginRoutePath: "/",
      redirectTo: "/",
      logoPath: "assets/images/prime.png",
      callback: (token) => print,
    ),
  );
}
