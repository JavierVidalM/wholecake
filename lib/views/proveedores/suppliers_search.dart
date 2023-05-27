import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/services/suppliers_services.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:wholecake/views/proveedores/suppliers_edit.dart';

class SupplierSearch extends SearchDelegate<ListSup> {
  late final List<ListSup> sup;

  SupplierSearch(this.sup);

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
            ListSup(
                supplierId: 0,
                nombreProveedor: '',
                rut: '',
                tipoInsumo: '',
                correoProveedor: '',
                telefonoProveedor: 0,
                imagen_insumo: ''),
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    final listadoView = Provider.of<SuppliersService>(context);
    final List<ListSup> searchSuppliers = listadoView.listadosuppliers;
    List<ListSup> matchQuery = [];
    for (var supplier in searchSuppliers) {
      if (supplier.nombreProveedor.toLowerCase().contains(
            query.toLowerCase(),
          )) {
        matchQuery.add(supplier);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_insumo),
        );
        Image image = Image.memory(bytes);
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: image,
              ),
              title: Text(result.nombreProveedor),
              onTap: () {
                // // result.copy();
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SuppliersEdit(
                //         // supplierId: result.supplierId,
                //         ),
                //   ),
                // );
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
    final listadoView = Provider.of<SuppliersService>(context);
    final List<ListSup> searchProducts = listadoView.listadosuppliers;
    List<ListSup> matchQuery = [];
    for (var product in searchProducts) {
      if (product.nombreProveedor.toLowerCase().contains(
            query.toLowerCase(),
          )) {
        matchQuery.add(product);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_insumo),
        );
        Image image = Image.memory(bytes);
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: image,
              ),
              title: Text(result.nombreProveedor),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SuppliersEdit(
                //         // supplierId: result.supplierId,
                //         ),
                //   ),
                // );
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
