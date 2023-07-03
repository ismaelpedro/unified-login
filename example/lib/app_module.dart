import 'package:example/app_store.dart';
import 'package:example/home_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unified_login/login_module.dart';

final loginModule = LoginModule(
  baseUrl: "https://authenticator-s.ceartico.com/api/v1/auth",
  loginRoutePath: "/",
  redirectTo: "/home/",
  logoPath: "assets/images/prime.png",
  callback: Modular.get<AppStore>().setToken,
  theme: ThemeData(
    scaffoldBackgroundColor: Colors.blue[800],
    appBarTheme: const AppBarTheme(backgroundColor: Colors.orange),
  ),
);

final class AppModule extends Module {
  @override
  List<Bind> get binds => [Bind.singleton((i) => AppStore())];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          "/",
          module: loginModule,
        ),
        ModuleRoute("/home", module: HomeModule()),
      ];
}
