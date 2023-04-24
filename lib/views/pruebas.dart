import 'package:wholecake/views/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pruebas extends StatelessWidget {
  const Pruebas({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<Proveedores>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("PASTELES"),
        ),
        body: ListView.separated(
          itemCount: listado.ListadoPastelesDisplay
              .length, //tripulacion.length,//establece el tamaño
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.people_rounded),
            title: Text(listado.ListadoPastelesDisplay[index]
                .nombre), //Text(tripulacion[index]),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              /*
              final route = MaterialPageRoute(
                builder: ((context) => const PageDetailView())
                );
              Navigator.push(context, route);
              */
              //Navigator.pushReplacement(context, newRoute) investigue para que sirve
              Navigator.pushNamed(context, 'detalle');
            },
          ),
          separatorBuilder: (_, __) => const Divider(),
        ));
  }
}
