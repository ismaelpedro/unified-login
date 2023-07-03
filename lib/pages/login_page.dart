import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/controllers/login_controller.dart';
import 'package:unified_login/models/status.dart';

class LoginPage extends StatefulWidget {
  final String _path;

  const LoginPage(this._path, {super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = GetIt.I.get<LoginController>();
  final theme = GetIt.I.get<ThemeData>();
  final _formKey = GlobalKey<FormState>();

  bool showPassword = false;

  final _overlayLoading = OverlayEntry(
    builder: (context) {
      return Center(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SpinKitDoubleBounce(
                  size: 50,
                  color: Colors.white,
                ),
                Text(
                  "Entrando...",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  @override
  void initState() {
    super.initState();

    controller.addListener(
      () => setState(() {
        if (controller.status is Loading && !_overlayLoading.mounted) {
          Overlay.of(context).insert(_overlayLoading);
        }

        if ((controller.status is Success || controller.status is Error) && _overlayLoading.mounted) {
          _overlayLoading.remove();
          ScaffoldMessenger.maybeOf(context)?.showSnackBar(
            SnackBar(
              content: Text(controller.status.message),
              duration: const Duration(seconds: 2),
              backgroundColor: controller.status is Success ? Colors.green : Colors.red,
            ),
          );
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Theme(
      data: theme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: Image.asset(
                      widget._path,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      TextFormField(
                        onChanged: (value) => controller.username = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo não pode ser vazio!";
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Nome de usuário",
                          filled: true,
                          suffixIcon: IconButton(icon: const FaIcon(FontAwesomeIcons.user), onPressed: () {}),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 255, 251, 251),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onChanged: (value) => controller.password = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Campo não pode ser vazio!";
                          }

                          return null;
                        },
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          filled: true,
                          suffixIcon: IconButton(
                              icon: FaIcon(showPassword ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              }),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(0, 255, 251, 251),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: !controller.validate || controller.status is Loading
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              await controller.login();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    child: const Text("Entrar"),
                  ),
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, "/recovery-password"),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.grey.shade100,
                      fixedSize: const Size(double.maxFinite, 50),
                    ),
                    child: const Text("Esqueceu sua senha?"),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
