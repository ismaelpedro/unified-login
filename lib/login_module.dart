import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/controllers/recover_controller.dart';
import 'package:unified_login/repositories/auth_repository.dart';
import 'package:unified_login/usecases/login_usecase.dart';
import 'package:unified_login/usecases/recovery_password_usecase.dart';
import 'package:unified_login/utils/client/client_interface.dart';
import 'package:unified_login/utils/client/dio_client.dart';
import 'package:unified_login/utils/client/track_interceptor.dart';

import 'pages/login_page.dart';
import 'pages/recovery_page.dart';

final getIt = GetIt.instance;

final navigatorKey = GlobalKey<NavigatorState>();

void setupGetIt(
  String baseUrl,
) {
  getIt.registerLazySingleton<Client>(() => DioClient(baseUrl, interceptors: [TrackInterceptor()]));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecaseImpl(getIt()));
  getIt.registerLazySingleton<RecoveryPasswordUsecase>(() => RecoveryPasswordUsecaseImpl(getIt()));
  getIt.registerLazySingleton(() => LoginController(getIt()));
  getIt.registerLazySingleton(() => RecoverController(getIt()));
}

class LoginModule extends StatelessWidget {
  final String baseUrl;
  final ThemeData theme;
  final String version;
  final VoidCallback onLogin;
  final String pathLogoTop;
  final String pathLogoBottom;

  LoginModule({
    super.key,
    required this.baseUrl,
    required this.version,
    required this.onLogin,
    required this.pathLogoTop,
    required this.pathLogoBottom,
    ThemeData? theme,
  }) : theme = theme ?? ThemeData() {
    setupGetIt(baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unified Login',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
      navigatorKey: navigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_) => LoginPage(
                  onLogin: settings.arguments as Function(),
                  pathLogoBottom: settings.arguments as String,
                  pathLogoTop: settings.arguments as String,
                  version: settings.arguments as String,
                );
            break;

          case '/recovery-password':
            builder = (_) => const RecoveryPage();
            break;

          default:
            throw Exception('Rota inválida: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
      theme: theme,
    );
  }
}
