import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/views/ordenes_compra/suppliers_purchase_edit.dart';
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
  final int? _selectedCategory = null;
  Future<String?> filterPopup(OrdencompraService listacat) =>
      showDialog<String>(
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
              await OrdencompraService().deleteOrdenCompra(msg);
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
    final listadoView = Provider.of<OrdencompraService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final List<ListOdc> prod = listadoView.listaOrdenes;
    final listacat = Provider.of<OrdencompraService>(context);

    return ChangeNotifierProvider(
      create: (_) => OrdencompraService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Ordenes de Compra',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<OrdencompraService>(
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
                      print(listaOdc.fecha);
                      final listaprov = Provider.of<SuppliersService>(context);
                      ListSup nombrecat = ListSup(
                          supplierId: 0,
                          nombreProveedor: '',
                          rut: '',
                          tipoInsumo: '',
                          correoProveedor: '',
                          telefonoProveedor: '',
                          imagen_insumo: '');
                      for (var categoria in listaprov.listadosuppliers) {
                        if (categoria.supplierId == listaOdc.proveedor) {
                          nombrecat = categoria;
                          break;
                        }
                      }
                      // Convertir la fecha original a un objeto DateTime
                      DateTime fecha = DateTime.parse(listaOdc.fecha);

                      // Formatear la fecha en el formato deseado
                      String fechaFormateada = DateFormat('dd/MM/yyyy-HH:mm:ss').format(fecha);
                      Uint8List bytes = Uint8List.fromList(
                          base64.decode(nombrecat.imagen_insumo));
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
                                  right:
                                      MediaQuery.of(context).size.width * 0.03,
                                  top:
                                      MediaQuery.of(context).size.height * 0.01,
                                  bottom:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                            'Proveedor a cargo:${nombrecat.nombreProveedor}',
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
                                                        PurchaseEdit(),
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
                                    SizedBox(height: 5),
                                    Text(
                                      'Insumo: ${nombrecat.tipoInsumo.toString().padRight(10)}',
                                    ),
                                    SizedBox(height: 5),
                                                                        Text(
                                      'Cantidad: ${listaOdc.cantidad}',
                                    ),
                                    SizedBox(height: 5),
                                                                        Text(
                                      'Costo Total: ${listaOdc.costotal.toString().padRight(10)}',
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Fecha: ${fechaFormateada.padRight(10)}',
                                    ),
                                    SizedBox(height: 10),
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
