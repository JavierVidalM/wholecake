// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:intl/intl.dart';
import '../../services/ordencompra_services.dart';
import '../../services/suppliers_services.dart';

class PurchaseList extends StatefulWidget {
  const PurchaseList({Key? key}) : super(key: key);

  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  Future<void> deletePopup(int ordenId, listOdc) async {
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
              await OrdencompraService().deleteOrdenCompra(msg);
              setState(() {
                listOdc.removeWhere(
                    (ordenDeCompa) => ordenDeCompa.ordenId == ordenId);
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
    final listadoView = Provider.of<OrdencompraService>(context);
    if (listadoView.isLoading) return const LoadingScreen();

    return ChangeNotifierProvider(
      create: (_) => OrdencompraService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ordenes de Compra',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: IconButton(
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
            ),
          ],
        ),
        drawer: const SideBar(),
        body: Consumer<OrdencompraService>(
          builder: (context, listado, child) {
            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: listado.listaOrdenes.length,
                    itemBuilder: (context, index) {
                      final listaOdc = listado.listaOrdenes[index];
                      final listaprov = Provider.of<SuppliersService>(context);
                      ListSup proveedor = ListSup(
                          supplierId: 0,
                          nombreProveedor: '',
                          rut: '',
                          tipoInsumo: '',
                          correoProveedor: '',
                          telefonoProveedor: '',
                          imagen_insumo: '');
                      for (var prov in listaprov.listadosuppliers) {
                        if (prov.supplierId == listaOdc.proveedor) {
                          proveedor = prov;
                          break;
                        }
                      }
                      DateTime fecha = DateTime.parse(listaOdc.fecha);
                      String fechaFormateada =
                          DateFormat('dd/MM/yyyy - HH:mm:ss').format(fecha);
                      Uint8List bytes = Uint8List.fromList(
                          base64.decode(proveedor.imagen_insumo));
                      Image image = Image.memory(bytes);
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 110,
                                height: 110,
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
                                  image: DecorationImage(
                                    image: image.image,
                                    fit: BoxFit.cover,
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
                                            'Proveedor a cargo:${proveedor.nombreProveedor}',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                listadoView.selectedOdc =
                                                    listado.listaOrdenes[index]
                                                        .copy();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PurchaseEdit(),
                                                  ),
                                                );
                                              },
                                              icon: const Icon(Icons.edit),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                deletePopup(
                                                  listaOdc.ordenId,
                                                  listado.listaOrdenes,
                                                );
                                              },
                                              icon: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Insumo: ${proveedor.tipoInsumo.toString().padRight(10)}',
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Cantidad: ${listaOdc.cantidad}',
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      NumberFormat.currency(
                                        locale: 'es',
                                        symbol: '\$',
                                        decimalDigits: 0,
                                        customPattern: '\$ #,##0',
                                      ).format(
                                        double.parse(
                                          listaOdc.costotal.toString(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Fecha: ${fechaFormateada.padRight(10)}',
                                    ),
                                    const SizedBox(height: 10),
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
