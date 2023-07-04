import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/controllers/recover_controller.dart';
import 'package:unified_login/models/user.dart';
import 'package:unified_login/repositories/auth_repository.dart';
import 'package:unified_login/usecases/login_usecase.dart';
import 'package:unified_login/usecases/recovery_password_usecase.dart';
import 'package:unified_login/utils/client/dio_client.dart';

import 'pages/login_page.dart';
import 'pages/recovery_page.dart';
import 'utils/client/client_interface.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();

void setupGetIt(
  String baseUrl,
) {
  if (!getIt.isRegistered<Client>()) {
    getIt.registerLazySingleton<Client>(() => DioClient(
          baseUrl,
          // interceptors: [TrackInterceptor()],
        ));
  }

  if (!getIt.isRegistered<AuthRepository>()) {
    getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt()));
  }

  if (!getIt.isRegistered<LoginUsecase>()) {
    getIt.registerLazySingleton<LoginUsecase>(() => LoginUsecaseImpl(getIt()));
  }

  if (!getIt.isRegistered<RecoveryPasswordUsecase>()) {
    getIt.registerLazySingleton<RecoveryPasswordUsecase>(() => RecoveryPasswordUsecaseImpl(getIt()));
  }

  if (!getIt.isRegistered<LoginController>()) {
    getIt.registerLazySingleton<LoginController>(() => LoginController(getIt()));
  }

  if (!getIt.isRegistered<RecoverController>()) {
    getIt.registerLazySingleton<RecoverController>(() => RecoverController(getIt()));
  }
}

class LoginModule extends StatelessWidget {
  final String baseUrl;
  final ThemeData theme;
  final String version;
  final Function(User?)? onLogin;
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case '/':
            builder = (_) => LoginPage(
                  onLogin: onLogin,
                  pathLogoBottom: pathLogoBottom,
                  pathLogoTop: pathLogoTop,
                  version: version,
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
