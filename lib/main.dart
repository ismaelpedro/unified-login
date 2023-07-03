import 'package:flutter/material.dart';
import 'package:unified_login/login_module.dart';

void main() {
  runApp(
    LoginModule(
      baseUrl: '',
      onLogin: () => debugPrint("Login efetuado com sucesso"),
      pathLogoBottom: '',
      pathLogoTop: '',
      version: '',
    ),
  );
}
