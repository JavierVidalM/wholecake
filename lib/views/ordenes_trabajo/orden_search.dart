import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ordendetrabajo.dart';
import 'package:wholecake/services/ordentrabajo_services.dart';
import 'package:wholecake/views/ordenes_trabajo/ordenes_edit.dart';
import 'dart:convert';
import 'dart:typed_data';

class OrdenTrabajoSearch extends SearchDelegate<ListTrabajo> {
  late final List<ListTrabajo> ordenCompra;

  OrdenTrabajoSearch(this.ordenCompra);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close_rounded),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
            context,
            ListTrabajo(
                id: 0,
                nombreProducto: '',
                precioProducto: 0,
                estadoProducto: '',
                cantidadProducto: 0,
                lote: '',
                categoria: 0,
                imagen: '',
                ordenesTrabajo: []));
      },
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final listadoView = Provider.of<OrdenTrabajoService>(context);
    final List<ListTrabajo> searchOrdenT = listadoView.listaTrabajos;
    List<ListTrabajo> matchQuery = [];
    for (var ordenT in searchOrdenT) {
      if (ordenT.nombreProducto.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ordenT);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(base64.decode(result.imagen));
        Image image = Image.memory(bytes, fit: BoxFit.cover);
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text(
                result.nombreProducto,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                listadoView.selectedordenTrabajo = matchQuery[index].copy();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdenEdit(),
                  ),
                );
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listadoView = Provider.of<OrdenTrabajoService>(context);
    final List<ListTrabajo> searchOrdenT = listadoView.listaTrabajos;
    List<ListTrabajo> matchQuery = [];
    for (var ordenT in searchOrdenT) {
      if (ordenT.nombreProducto.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ordenT);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(base64.decode(result.imagen));
        Image image = Image.memory(bytes, fit: BoxFit.cover);
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.015,
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text(
                result.nombreProducto,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                listadoView.selectedordenTrabajo = matchQuery[index].copy();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdenEdit(),
                  ),
                );
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
