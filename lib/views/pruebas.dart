import 'package:wholecake/services/productos_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class  Pruebas extends StatelessWidget {
  const Pruebas ({ Key? key }) : super(key: key);
  
@override
Widget build(BuildContext context) {
  final listado = Provider.of<ProductService>(context);
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(),
    child: Scaffold(
      appBar: AppBar(
        title: const Text("PASTELES"),
      ),
      body: ListView.separated(
        itemCount: listado.listadoproductos.length,
        itemBuilder: (context, index) => ListTile(
          leading: const Icon(Icons.people_rounded),
          title: Text(listado.listadoproductos[index].nombre),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),                        
          onTap: (){              
            Navigator.pushNamed(context, 'detalle');
          },
        ), 
        separatorBuilder: (_ , __) => const Divider(), 
      )
    ),
  );
}

}
