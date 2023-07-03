import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/models/credentials.dart';
import 'package:unified_login/models/status.dart';
import 'package:unified_login/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUsecase _usecase;

  LoginController(this._usecase);

  Status status = Ready();

  String username = "";
  String password = "";

  bool get validate {
    return username.isNotEmpty && password.isNotEmpty;
  }

  void _setStatus(Status newStatus) {
    status = newStatus;
    notifyListeners();
  }

  Future<void> login() async {
    _setStatus(Loading());

    final result = await _usecase(Credentials(Email(username), password));

    if (result.error != null) {
      _setStatus(Error(result.error!.message));
    }

    if (result.token != null) {
      _setStatus(Success("Login efetuado com sucesso"));
      // _callback(result.token!.accessToken);
      // Navigator.pushReplacementNamed(navigatorKey.currentContext!, _redirectTo);
    }
  }
}
