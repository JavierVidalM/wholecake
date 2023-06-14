// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import '../../services/suppliers_services.dart';
import '../../models/suppliers.dart';
import '../../services/ordencompra_services.dart';

class PurchaseOrders extends StatefulWidget {
  const PurchaseOrders({Key? key}) : super(key: key);

  @override
  _PurchaseOrdersState createState() => _PurchaseOrdersState();
}

class _PurchaseOrdersState extends State<PurchaseOrders> {
  TextEditingController ordenIdController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController costotalController = TextEditingController();

  @override
  void dispose() {
    ordenIdController.dispose();
    cantidadController.dispose();
    proveedorController.dispose();
    costotalController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final msg = jsonEncode({
      'cantidad': cantidadController.text,
      'proveedor': proveedorController.text,
      'costotal': costotalController.text,
    });
    await OrdencompraService().addOrdenCompra(msg);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PurchaseList()));
  }

  String? validateProveedor(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione un Proveedor.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SuppliersService(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Crear Orden de Compra',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          ),
          drawer: const SideBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: const Text('Cantidad del pedido'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: TextField(
                        controller: cantidadController,
                        decoration: const InputDecoration(
                            hintText: 'Cantidad del Pedido'),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: const Text('Proveedor'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.005),
                      child: Consumer<SuppliersService>(
                        builder: (context, listacat, __) {
                          ListSup? proveedorSeleccionado;
                          return DropdownButtonFormField<ListSup>(
                            validator: (ListSup? value) =>
                                validateProveedor(value?.nombreProveedor),
                            hint: const Text('Selecciona un Proveedor'),
                            value: proveedorSeleccionado,
                            onChanged: (ListSup? nuevoSup) {
                              setState(() {
                                proveedorController.text =
                                    nuevoSup!.supplierId.toString();
                              });
                            },
                            items: listacat.listadosuppliers.map((proveedor) {
                              return DropdownMenuItem<ListSup>(
                                value: proveedor,
                                child: Text(proveedor.nombreProveedor),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                          left: MediaQuery.of(context).size.width * 0.01),
                      child: const Text('Costo total'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.005,
                      ),
                      child: TextField(
                        controller: costotalController,
                        decoration:
                            const InputDecoration(hintText: 'Costo Total'),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                _saveData();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  (MediaQuery.of(context).size.width * 0.6),
                                  (MediaQuery.of(context).size.height * 0.07),
                                ),
                              ),
                              child: const Text('Guardar'),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const PurchaseList(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  (MediaQuery.of(context).size.width * 0.6),
                                  (MediaQuery.of(context).size.height * 0.07),
                                ),
                              ),
                              child: const Text('Volver'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
