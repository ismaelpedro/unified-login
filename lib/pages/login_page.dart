import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/design_system/app_colors.dart';
import 'package:unified_login/models/user.dart';

class LoginPage extends StatefulWidget {
  final String version;
  final Function(User?)? onLogin;
  final String pathLogoTop;
  final String pathLogoBottom;

  const LoginPage({
    super.key,
    required this.version,
    required this.onLogin,
    required this.pathLogoTop,
    required this.pathLogoBottom,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginController controller;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false, isFormValid = kDebugMode, ocultPassword = true;

  @override
  void initState() {
    controller = GetIt.I.get<LoginController>();
    super.initState();
  }

  void toggleLoading(bool value) => setState(() => isLoading = value);
  void togglePassword() => setState(() => ocultPassword = !ocultPassword);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 250,
                child: Image.asset(
                  // AppAssets.gqHealth,
                  widget.pathLogoTop,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                onChanged: () {
                  setState(() {
                    isFormValid = formKey.currentState?.validate() ?? false;
                  });
                },
                child: Column(
                  children: [
                    IgnorePointer(
                      ignoring: isLoading,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: controller.nameEC,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person, color: Colors.black),
                          labelText: 'Usuário',
                          labelStyle: TextStyle(
                            color: AppColors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        // onChanged: setName,
                      ),
                    ),
                    IgnorePointer(
                      ignoring: isLoading,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: controller.passwordEC,
                        obscureText: ocultPassword,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                        // onFieldSubmitted: (_) => widget.onLogin(controller.nameEC.text, controller.passwordEC.text),
                        // onFieldSubmitted: (_) => controller.login(widget.onLogin),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            child: FaIcon(
                              FontAwesomeIcons.lock,
                              color: Colors.black,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              ocultPassword ? Icons.visibility : Icons.visibility_off,
                              color: Colors.black,
                            ),
                            onPressed: () => togglePassword(),
                          ),
                          labelText: 'Senha',
                          labelStyle: const TextStyle(
                            color: Colors.grey,
                            fontSize: 20.0,
                          ),
                        ),
                        // onChanged: _store.setPassword,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => controller.login(widget.onLogin),
                  // onPressed: !isLoading && isFormValid ? () => widget.onLogin(controller.nameEC.text, controller.passwordEC.text) : null,
                  child: isLoading
                      ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                      : const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Column(
            children: [
              Text(
                'Versão ${widget.version}',
                style: const TextStyle(
                  color: AppColors.grey,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('made by'),
                  Image.asset(
                    widget.pathLogoBottom,
                    width: 120,
                    height: 50,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
