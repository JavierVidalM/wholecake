import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:wholecake/views/utilities/sidebar.dart';

import '../../services/productos_services.dart';

class PurchaseOrders extends StatefulWidget {
  const PurchaseOrders({Key? key}) : super(key: key);

  @override
  _PurchaseOrdersState createState() => _PurchaseOrdersState();
}

class _PurchaseOrdersState extends State<PurchaseOrders> {
  TextEditingController ordenIdController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController costotalController = TextEditingController();

  @override
  void dispose() {
    ordenIdController.dispose();
    fechaController.dispose();
    cantidadController.dispose();
    proveedorController.dispose();
    costotalController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final msg = jsonEncode({
      'Id': ordenIdController.text,
      'Fecha': fechaController.text,
      'Cantidad': cantidadController.text,
      'Proveedor': proveedorController.text,
      'Costo Total': costotalController.text,
    });
    await ProductService().addOrdenCompra(msg);
    print('saved');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SuppliersView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Orden de Compra',
          style: TextStyle(
            color: Color(0xFF5D2A42),
            fontSize: 24,
          ),
        ),
        backgroundColor: const Color(0xFFFFB5D7),
        centerTitle: true,
        titleSpacing: 0,
      ),
      drawer: const SideBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextField(
                    controller: ordenIdController,
                    decoration: const InputDecoration(hintText: 'ID de Orden'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextField(
                    controller: fechaController,
                    decoration:
                        const InputDecoration(hintText: 'Fecha de Orden'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextField(
                    controller: cantidadController,
                    decoration:
                        const InputDecoration(hintText: 'Cantidad del Pedido'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextField(
                    controller: proveedorController,
                    decoration:
                        const InputDecoration(hintText: 'Seleccione Proveedor'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02),
                  child: TextField(
                    controller: costotalController,
                    decoration: const InputDecoration(hintText: 'Costo Total'),
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
                                builder: (context) => PurchaseList(),
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
    );
  }
}
