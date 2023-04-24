// import 'package:flutter/material.dart';
// // import 'package:wholecake/views/provider/provider.dart';
// import 'package:wholecake/views/providers/providers.dart';
// import 'package:wholecake/views/pruebas.dart';

// void main() {
//   // ejecutemos nuestro widgets a traves de la función runApp() note que al insertar esta función
//   // esta sera importada de material, puede que por defecto le aparezca de cupertino, pero tratemos
//   // por ahora dejarala de material
//   runApp(ProviderState()); //quite el const y vea el warning
// }

// class ProviderState extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => Proveedores(),
//           lazy: false,
//         ),
//       ],
//       child: const MyfirstWidget(),
//     );
//   }
// }

// // crearemos nuestro primer widgets de la siguiente forma
// class MyfirstWidget extends StatelessWidget {
//   const MyfirstWidget({Key? key})
//       : super(key: key); //constructor constante, quitelo y vea el warning
//   @override
//   Widget build(BuildContext context) {
//     //necesitamos retornar algo, esto debe ser un widgets, por ahora retornaremos Material.
//     return const MaterialApp(
//         //quite const y vea los warning que aparecerán
//         debugShowCheckedModeBanner:
//             false, //nos permite sacar el mensaje debug quitelo y vea que sucede
//         home: Pruebas());
//   }
// }

import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/login/login_signin.dart';
import 'package:wholecake/views/login/login_user.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginUser(),
    );
  }
}
