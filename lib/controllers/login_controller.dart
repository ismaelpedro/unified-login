// ignore_for_file: unused_element, unnecessary_null_comparison

import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/models/credentials.dart';
import 'package:unified_login/models/status.dart';
import 'package:unified_login/models/user.dart';
import 'package:unified_login/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUsecase _usecase;

  LoginController(this._usecase);

  Status status = Ready();

  final nameEC = TextEditingController(text: kDebugMode ? 'ismael_cat' : '');
  final passwordEC = TextEditingController(text: kDebugMode ? '1234' : '');

  bool get validate => nameEC.text.isNotEmpty && passwordEC.text.isNotEmpty;

  void _setStatus(Status newStatus) {
    status = newStatus;
    notifyListeners();
  }

  Future<void> login(Function(User?)? onLogin) async {
    final result = await _usecase(Credentials(Email(nameEC.text), passwordEC.text));

    onLogin!(result.user);

    if (result.user != null && onLogin != null) {
      onLogin(result.user);
    }
    return;
  }
}
