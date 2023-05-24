import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/views/products/products_edit.dart';
import 'package:wholecake/services/productos_services.dart';
import 'dart:convert';
import 'dart:typed_data';

class ProductSearch extends SearchDelegate<Listado> {
  late final List<Listado> prod;

  ProductSearch(this.prod);

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
            Listado(
                productoId: 0,
                nombre: '',
                fechaElaboracion: '',
                fechaVencimiento: '',
                precio: 0,
                categoria: 0,
                imagen: '',
                estado: '',
                cantidad:0,
                lote:''),
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    final List<Listado> searchProducts = listadoView.listadoproductos;
    List<Listado> matchQuery = [];
    for (var product in searchProducts) {
      if (product.nombre.toLowerCase().contains(
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
          base64.decode(result.imagen),
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
              title: Text(result.nombre),
              onTap: () {
                // result.copy();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsEdit(
                      productId: result.productoId,
                    ),
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
    final listadoView = Provider.of<ProductService>(context);
    final List<Listado> searchProducts = listadoView.listadoproductos;
    List<Listado> matchQuery = [];
    for (var product in searchProducts) {
      if (product.nombre.toLowerCase().contains(
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
          base64.decode(result.imagen),
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
              title: Text(result.nombre),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsEdit(
                      productId: result.productoId,
                    ),
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
