import 'package:flutter/material.dart';
import 'package:wholecake/providers/providers.dart';
import 'package:wholecake/views/login/login_main.dart';
// import 'package:wholecake/views/pruebas.dart';

void main() {
  runApp(ProviderState());
}

class ProviderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Proveedores(),
          lazy: false,
        ),
      ],
      child: const MyfirstWidget(),
    );
  }
}

class MyfirstWidget extends StatelessWidget {
  const MyfirstWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: LoginMain());
  }
}
