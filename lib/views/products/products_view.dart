import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
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

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 2));
}

String? _selectedDate;
ListElement? categoriaSeleccionada;

// void filterProducts(String category) {
//     final listadoView = Provider.of<ProductService>();
//     listadoView.filterProductsByCategory(category);
//   }

class _ProductsViewState extends State<ProductsView> {
  int? _selectedCategory = null;

  Future<String?> filterPopup(ProductService listacat) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Filtro"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                    bottom: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: const Text("Categoría"),
                ),
                DropdownButtonFormField<ListElement>(
                  hint: const Text('Selecciona una categoría'),
                  value: categoriaSeleccionada,
                  onChanged: (ListElement? nuevaCategoria) {
                    setState(() {
                      _selectedCategory = nuevaCategoria!.categoriaId;
                      print('la categoria es ${_selectedCategory}');
                    });
                  },
                  items: listacat.listadocategorias.map((categoria) {
                    return DropdownMenuItem<ListElement>(
                      value: categoria,
                      child: Text(categoria.nombre),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Filtrar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> deletePopup(int productId, listadoProducto) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "¿Estás seguro de que deseas eliminar el producto?",
          textAlign: TextAlign.center,
        ),
        content:
            const Text("Esta acción no podrá deshacerse una vez completada."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancelar",
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final msg = jsonEncode({
                'id': productId,
              });
              await ProductService().deleteProducto(msg);
              setState(() {
                listadoProducto
                    .removeWhere((product) => product.productoId == productId);
              });
            },
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cargandoPantalla() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Diálogo sin cierre por el usuario"),
        content: const Text("Este diálogo no se puede cerrar por el usuario."),
        actions: [
          TextButton(
            onPressed: () {
              // Acción del botón
              Navigator.of(context).pop();
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final List<Listado> prod = listadoView.listadoproductos;
    final listacat = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
        create: (_) => ProductService(),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Listado de productos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            ),
            drawer: const SideBar(),
            body: Consumer<ProductService>(
              builder: (context, listado, child) {
                // final producto = listado.listadoproductos[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Row(
                        children: [
                          // Botón de filtro
                          IconButton(
                            onPressed: () {
                              filterPopup(listacat);
                            },
                            icon: const Icon(Icons.filter_alt_outlined),
                          ),
                          // Campo de entrada de texto y botón de búsqueda
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
                                      onTap: () {
                                        showSearch(
                                          context: context,
                                          delegate: ProductSearch(
                                              listadoView.listadoproductos),
                                        );
                                      },
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProductsAdd()),
                              );
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
                          itemCount: listado.listadoproductos.length,
                          itemBuilder: (context, index) {
                            final product = listado.listadoproductos[index];
                            String nombrecat = '';
                            for (var categoria in listacat.listadocategorias) {
                              if (categoria.categoriaId == product.categoria) {
                                nombrecat = categoria.nombre;
                                break;
                              }
                            }
                            Uint8List bytes = Uint8List.fromList(
                                base64.decode(product.imagen));
                            Image image = Image.memory(bytes);
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      margin: EdgeInsets.only(
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: image.image,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
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
                                                  product.nombre,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      listadoView
                                                              .selectedProduct =
                                                          listado
                                                              .listadoproductos[
                                                                  index]
                                                              .copy();
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ProductsEdit()),
                                                      );
                                                    },
                                                    icon: Icon(Icons.edit),
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      deletePopup(
                                                          product.productoId,
                                                          listado
                                                              .listadoproductos);
                                                    },
                                                    icon: Icon(Icons.delete),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Text('Categoría:$nombrecat'),
                                          SizedBox(height: 10),
                                          Text(
                                            'Elaboración: ${product.fechaElaboracion.toString().substring(0, 10)}',
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            NumberFormat.currency(
                                              locale: 'es',
                                              symbol: '\$',
                                              decimalDigits: 0,
                                              customPattern: '\$ #,##0',
                                            ).format(double.parse(
                                                product.precio.toString())),
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
            )));
  }
}
