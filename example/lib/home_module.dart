import 'package:example/app_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

final class HomeModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/", child: (_, __) => const HomePage()),
      ];
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final appStore = Modular.get<AppStore>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("You are logged successfully"),
            Text(
              "Your access token is: ${appStore.token}",
              style: const TextStyle(fontSize: 25),
            ),
            ElevatedButton(
              onPressed: () => Modular.to.navigate("/"),
              child: const Text("Go back to Login Page"),
            )
          ],
        ),
      ),
    );
  }
}
