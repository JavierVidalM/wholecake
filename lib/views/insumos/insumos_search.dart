import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/services.dart';
import 'dart:convert';
import 'dart:typed_data';
import '../../models/supplies.dart';
import 'insumos.dart';

class InsumosSearch extends SearchDelegate<SuppliesList> {
  late final List<SuppliesList> usr;

  InsumosSearch(this.usr);

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
              SuppliesList(
                  suppliesId: 0,
                  nombreInsumo: '',
                  fechaLlegada: '',
                  fechaVencimiento: '',
                  preciounidad: 0,
                  proveedor: '',
                  estado: '',
                  tipoInsumo: '',
                  numeroLote: '',
                  marcaProducto: '',
                  cantidad: 0,
                  imagen_supplies: ''));
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    final listadoView = Provider.of<SuppliesService>(context);
    final List<SuppliesList> searchInsumos = listadoView.suppliesList;
    List<SuppliesList> matchQuery = [];
    for (var insumo in searchInsumos) {
      if (insumo.nombreInsumo.toLowerCase().contains(
            query.toLowerCase(),
          )) {
        matchQuery.add(insumo);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_supplies),
        );
        Image image = Image.memory(
          bytes,
          fit: BoxFit.cover,
        );
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text(
                result.nombreInsumo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputsReciptSupplies(),
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
    final listadoView = Provider.of<SuppliesService>(context);
    final List<SuppliesList> searchInsumos = listadoView.suppliesList;
    List<SuppliesList> matchQuery = [];
    for (var insumo in searchInsumos) {
      if (insumo.nombreInsumo.toLowerCase().contains(
            query.toLowerCase(),
          )) {
        matchQuery.add(insumo);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_supplies),
        );
        Image image = Image.memory(
          bytes,
          fit: BoxFit.cover,
        );
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text(
                result.nombreInsumo,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InputsReciptSupplies(),
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
