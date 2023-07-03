import 'package:artico_dependencies/artico_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:unified_login/controllers/recover_controller.dart';
import 'package:unified_login/models/status.dart';

class RecoveryPage extends StatefulWidget {
  const RecoveryPage({super.key});

  @override
  State<RecoveryPage> createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final controller = GetIt.I.get<RecoverController>();

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
                  "Enviando email de recuperação...",
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
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Recuperação de senha"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                onChanged: (value) => controller.username = value,
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
              ElevatedButton(
                onPressed: controller.recover,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fixedSize: const Size(double.maxFinite, 50),
                ),
                child: const Text("Enviar email"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
