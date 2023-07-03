// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/controllers/recover_controller.dart';
import 'package:unified_login/pages/recovery_page.dart';
import 'package:unified_login/repositories/auth_repository.dart';
import 'package:unified_login/usecases/login_usecase.dart';
import 'package:unified_login/usecases/recovery_password_usecase.dart';
import 'package:unified_login/utils/client/dio_client.dart';
import 'package:unified_login/utils/client/track_interceptor.dart';

import 'pages/login_page.dart';

final class LoginModule extends Module {
  final String baseUrl;
  final String loginRoutePath;
  final String redirectTo;
  final String logoPath;
  final Function(String token) callback;
  late final ThemeData theme;

  LoginModule({
    required this.baseUrl,
    required this.loginRoutePath,
    required this.redirectTo,
    required this.logoPath,
    required this.callback,
    ThemeData? theme,
  }) {
    theme = theme ?? ThemeData();
  }

  @override
  List<Bind> get binds => [
        Bind.factory((i) => DioClient(baseUrl, interceptors: [TrackInterceptor()])),
        Bind.factory((i) => AuthRepositoryImpl(i())),
        Bind.factory((i) => LoginUsecaseImpl(i())),
        Bind.factory((i) => RecoveryPasswordUsecaseImpl(i())),
        Bind.factory((i) => LoginController(i(), redirectTo, callback)),
        Bind.factory((i) => RecoverController(i(), loginRoutePath)),
        Bind.factory((i) => theme),
      ];

  @override
  List<ModularRoute> get routes => [
        // ChildRoute("/", child: (_, __) => const LoginPage()),
        ChildRoute("/", child: (_, __) => LoginPage(logoPath)),
        ChildRoute("/recovery-password", child: (_, __) => const RecoveryPage()),
      ];
}
