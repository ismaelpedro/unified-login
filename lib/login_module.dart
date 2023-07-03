import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/controllers/recover_controller.dart';
import 'package:unified_login/pages/recovery_page.dart';
import 'package:unified_login/repositories/auth_repository.dart';
import 'package:unified_login/usecases/login_usecase.dart';
import 'package:unified_login/usecases/recovery_password_usecase.dart';
import 'package:unified_login/utils/client/client_interface.dart';
import 'package:unified_login/utils/client/dio_client.dart';
import 'package:unified_login/utils/client/track_interceptor.dart';

import 'pages/login_page.dart';

final getIt = GetIt.instance;

final navigatorKey = GlobalKey<NavigatorState>();

void setupGetIt(
  String baseUrl,
  String redirectTo,
  Function(String token) callback,
) {
  getIt.registerLazySingleton<Client>(() => DioClient(baseUrl, interceptors: [TrackInterceptor()]));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecaseImpl(getIt()));
  getIt.registerLazySingleton<RecoveryPasswordUsecase>(() => RecoveryPasswordUsecaseImpl(getIt()));
  getIt.registerLazySingleton(() => LoginController(getIt(), redirectTo, callback));
  getIt.registerLazySingleton(() => RecoverController(getIt(), redirectTo));
}

class LoginModule extends StatelessWidget {
  final String baseUrl;
  final String loginRoutePath;
  final String redirectTo;
  final String logoPath;
  final Function(String token) callback;
  final ThemeData theme;

  LoginModule({
    super.key,
    required this.baseUrl,
    required this.loginRoutePath,
    required this.redirectTo,
    required this.logoPath,
    required this.callback,
    ThemeData? theme,
  }) : theme = theme ?? ThemeData() {
    setupGetIt(baseUrl, redirectTo, callback);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      routes: {
        '/': (_) => LoginPage(logoPath),
        '/recovery-password': (_) => const RecoveryPage(),
      },
      theme: theme,
    );
  }
}
