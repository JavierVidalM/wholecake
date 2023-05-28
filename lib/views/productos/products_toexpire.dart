import 'package:flutter/material.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/productos/products_edit.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class ToExpire extends StatefulWidget {
  const ToExpire({Key? key});

  @override
  _ToExpireState createState() => _ToExpireState();
}

Future<void> _refresh() {
  return Future.delayed(const Duration(seconds: 2));
}

ListElement? catSelect;

class _ToExpireState extends State<ToExpire> {
  int? _selectedCategory;

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
                  value: catSelect,
                  onChanged: (ListElement? nuevaCategoria) {
                    setState(() {
                      _selectedCategory = nuevaCategoria!.categoriaId;
                      // print('la categoria es ${_selectedCategory}');
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

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final List<Listado> prod = listadoView.listadoproductos;
    final listacat = Provider.of<ProductService>(context);
    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Prontos a caducar',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Consumer<ProductService>(
        builder: (context, listado, child) {
          final productosPorCaducar = listado.listadoproductos.where((product) {
            final fechaVencimiento = DateTime.parse(product.fechaVencimiento);
            final diasRestantes = fechaVencimiento.difference(now).inDays;
            return diasRestantes <= 2;
          }).toList();
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
                  ],
                ),
              ),
              Divider(height: MediaQuery.of(context).size.height * 0.005),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: productosPorCaducar.length,
                    itemBuilder: (context, index) {
                      final product = productosPorCaducar[index];
                      String nombrecat = '';
                      for (var categoria in listacat.listadocategorias) {
                        if (categoria.categoriaId == product.categoria) {
                          nombrecat = categoria.nombre;
                          break;
                        }
                      }
                      Uint8List bytes =
                          Uint8List.fromList(base64.decode(product.imagen));
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
                                    right: MediaQuery.of(context).size.width *
                                        0.03,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                    image: image.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.nombre,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text('Categoría:$nombrecat'),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Elaboración: ${product.fechaElaboracion.toString().substring(0, 10)}',
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
                                    ),
                                    const SizedBox(height: 10),
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
      ),
    );
  }
}