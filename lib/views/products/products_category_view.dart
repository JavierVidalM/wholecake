import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/products/products_filter_view.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:wholecake/views/utilities/loading_screen.dart';
import 'package:wholecake/views/products/products_add.dart';
import 'package:wholecake/views/products/products_edit.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 2));
}

class _CategoryViewState extends State<CategoryView> {
  Future deletePopup() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text(
              "Estás seguro de que deseas elimiar el producto?",
              textAlign: TextAlign.center,
            ),
            content: const Text(
                "Esta acción no podrá deshacerse una vez completada"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Cancelar",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  "Eliminar",
                  style: TextStyle(color: Colors.red, fontSize: 18),
                ),
              ),
            ],
          ));

  @override
  Widget build(BuildContext context) {
    final listacat = Provider.of<ProductService>(context);
    if (listacat.isLoading) return const LoadingScreen();

    return ChangeNotifierProvider(
      create: (_) => ProductService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Listado de categorías',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<ProductService>(
          builder: (context, listado, child) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text('Buscar'),
                                  onTap: () {},
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Lógica para buscar
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => const ProductsAdd()),
                          // );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Divider(height: MediaQuery.of(context).size.height * 0.005),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: listado.listadocategorias.length,
                      itemBuilder: (context, index) {
                        final category = listado.listadocategorias[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              category.nombre,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // listacat.selectedCategory =
                                                  //     listado.listadocategorias[
                                                  //             index]
                                                  //         .copy();
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           ProductsEdit()),
                                                  // );
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  // final msg = jsonEncode({
                                                  //   'id': product.productoId
                                                  // });
                                                  // await ProductService()
                                                  //     .deleteProducto(msg);
                                                  // setState(() {
                                                  //   listado.listadoproductos
                                                  //       .removeAt(index);
                                                  // });
                                                  deletePopup();
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
