import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/products/products_filter_view.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:wholecake/views/utilities/loading_screen.dart';
import 'package:wholecake/views/suppliers/suppliers_add.dart';
import 'package:wholecake/views/suppliers/suppliers_edit.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import '../../models/categoria.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  final int? _selectedCategory = null;
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

  Future<void> deletePopup(int ordenId, ListOdc) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "¿Estás seguro de que deseas eliminar la Orden de Compra?",
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
                'id': ordenId,
              });
              await ProductService().deleteOrdenCompra(msg);
              setState(() {
                ListOdc.removeWhere(
                    (OrdenDeCompa) => OrdenDeCompa.ordenId == ordenId);
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

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final List<ListOdc> prod = listadoView.listaOrdenes;
    final listacat = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ordenes de Compra',
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
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PurchaseOrders(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Divider(height: MediaQuery.of(context).size.height * 0.005),
                Expanded(
                  child: ListView.builder(
                    itemCount: listado.listaOrdenes.length,
                    itemBuilder: (context, index) {
                      final listaOdc = listado.listaOrdenes[index];
                      String ordenOdc = '';
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
                                  right:
                                      MediaQuery.of(context).size.width * 0.03,
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  shape: BoxShape.rectangle,
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
                                            listaOdc.proveedor.toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                listadoView.selectedSupplier =
                                                    listado
                                                        .listadosuppliers[index]
                                                        .copy();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SuppliersEdit(),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                deletePopup(
                                                  listaOdc.ordenId,
                                                  listado.listaOrdenes,
                                                );
                                              },
                                              icon: Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Orden ID: ${listaOdc.ordenId.toString().padRight(10)}',
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Fecha: ${listaOdc.fecha.toString().padRight(10)}',
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Proveedor: ${listaOdc.proveedor.toString().padRight(10)}',
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
              ],
            );
          },
        ),
      ),
    );
  }
}
