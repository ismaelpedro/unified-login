import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unified_login/login_module.dart';

void main() {
  runApp(
    ModularApp(
      module: LoginModule(
        baseUrl: "https://authenticator-s.ceartico.com/api/v1/auth",
        loginRoutePath: "/",
        redirectTo: "/",
        logoPath: "assets/images/prime.png",
        callback: (token) => print,
      ),
      child: MaterialApp.router(
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ),
    ),
  );
}
