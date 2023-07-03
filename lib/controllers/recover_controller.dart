import 'package:flutter/material.dart';
import 'package:unified_login/models/status.dart';
import 'package:unified_login/usecases/recovery_password_usecase.dart';

class RecoverController extends ChangeNotifier {
  final RecoveryPasswordUsecase _usecase;

  RecoverController(this._usecase);

  Status status = Ready();

  String username = "";

  bool get validate {
    return username.isNotEmpty;
  }

  void _setStatus(Status newStatus) {
    status = newStatus;
    notifyListeners();
  }

  Future<void> recover() async {
    _setStatus(Loading());

    final result = await _usecase(username);

    if (result.error != null) {
      _setStatus(Error(result.error!.message));
    }

    if (result.success) {
      _setStatus(Success("Email de recuperação enviado com sucesso"));
      // Navigator.pushReplacementNamed(navigatorKey.currentContext!, _redirectTo);
    }
  }
}
