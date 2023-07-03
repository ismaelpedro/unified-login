import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/design_system/app_colors.dart';

class LoginPage extends StatefulWidget {
  final String version;
  final Function(String, String) onLogin;
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
  bool isLoading = false, isFormValid = kDebugMode, ocultPassword = true;

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController(text: kDebugMode ? 'ismael_cat' : '');
  final passwordEC = TextEditingController(text: kDebugMode ? '1234' : '');

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
                  isFormValid = formKey.currentState?.validate() ?? false;
                },
                child: Column(
                  children: [
                    Observer(
                      builder: (_) {
                        return IgnorePointer(
                          ignoring: isLoading,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: nameEC,
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
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return IgnorePointer(
                          ignoring: isLoading,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: passwordEC,
                            obscureText: ocultPassword,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                            onFieldSubmitted: (_) => widget.onLogin(nameEC.text, passwordEC.text),
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
                        );
                      },
                    ),
                  ],
                ),
              ),
              Observer(
                builder: (_) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 32),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: !isLoading && isFormValid ? () => widget.onLogin(nameEC.text, passwordEC.text) : null,
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
                  );
                },
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
              // FutureBuilder(
              //   // future: _utils.getVersionApp(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const ShimmerContainer(
              //         width: 100,
              //         height: 30,
              //       );
              //     }

              //     return Text(
              //       // 'Versão ${_utils.version}',
              //       widget.version,
              //       style: const TextStyle(
              //         color: AppColors.grey,
              //         fontSize: 17,
              //       ),
              //     );
              //   },
              // ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('made by'),
                  Image.asset(
                    // AppAssets.goAhead,
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
