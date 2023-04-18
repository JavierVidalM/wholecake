import 'package:flutter/material.dart';
import 'package:wholecake/error.dart';

void main() {
  // ejecutemos nuestro widgets a traves de la función runApp() note que al insertar esta función
  // esta sera importada de material, puede que por defecto le aparezca de cupertino, pero tratemos
  // por ahora dejarala de material
  runApp(const MyfirstWidget()); //quite el const y vea el warning
}

// crearemos nuestro primer widgets de la siguiente forma
class MyfirstWidget extends StatelessWidget {
  const MyfirstWidget({Key? key})
      : super(key: key); //constructor constante, quitelo y vea el warning
  @override
  Widget build(BuildContext context) {
    //necesitamos retornar algo, esto debe ser un widgets, por ahora retornaremos Material.
    return const MaterialApp(
        //quite const y vea los warning que aparecerán
        debugShowCheckedModeBanner:
            false, //nos permite sacar el mensaje debug quitelo y vea que sucede
        home: ErrorPage());
  }
}
