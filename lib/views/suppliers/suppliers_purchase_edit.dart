import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/utilities/sidebar.dart';

class PurchaseEdit extends StatefulWidget {
  final int ordenId;

  const PurchaseEdit({Key? key, required this.ordenId}) : super(key: key);

  @override
  _PurchaseEditState createState() => _PurchaseEditState();
}

class _PurchaseEditState extends State<PurchaseEdit> {
  TextEditingController ordenIdController = TextEditingController();
  TextEditingController fechaController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController proveedorController = TextEditingController();
  TextEditingController costotalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadOrdenCompra();
  }

  void loadOrdenCompra() {
    final productService = Provider.of<ProductService>(context, listen: false);
    final odc = productService.listaOrdenes.firstWhere(
      (odc) => odc.ordenId == widget.ordenId,
      orElse: () => ListOdc(
        ordenId: 0,
        fecha: '',
        cantidad: '',
        costotal: '',
        proveedor: 0,
      ),
    );
    _ordenIdController.text = odc.ordenId;
    _fechaController.text = odc.fecha.toString();
    _cantidadController.text = odc.cantidad.toString();
    _proveedorController.text = odc.proveedor;
    _costotalController.text = odc.costotal;
  }

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final product = productService.listaOrdenes.firstWhere(
      (odc) => odc.ordenId == widget.ordenId,
      orElse: () => ListOdc(
        ordenId: 0,
        fecha: '',
        cantidad: '',
        costotal: '',
        proveedor: 0,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar Orden',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('OrdenId'),
                TextFormField(
                  initialValue: odc.ordenId,
                  onChanged: (value) => odc.ordenId = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El ID es obligatorio';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'ID de la Orden',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Fecha'),
                Theme(
                  data: SweetCakeTheme.calendarTheme,
                  child: DateTimePicker(
                    initialValue: product.fecha,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    // onChanged: (val) => print(val),
                    validator: (val) {
                      product.fecha = val!;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cantidad'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: product.cantidad.toString(),
                  onChanged: (value) {
                    if (int.tryParse(value) == null) {
                      product.cantidad = 0;
                    } else {
                      product.cantidad = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Cantidad Total',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Costo'),
                TextFormField(
                  keyboardType: TextInputType.number,
                  initialValue: product.costotal.toString(),
                  onChanged: (value) {
                    if (int.tryParse(value) == null) {
                      product.costotal = 0;
                    } else {
                      product.costotal = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Costo Total',
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Proveedor'),
                TextFormField(
                  initialValue: odc.proveedor,
                  onChanged: (value) => odc.proveedor = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El Proveedor es Obligatorio';
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Proveedor de la Orden',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Actualizar el producto
                odc.ordenId = _ordenIdController.text;
                odc.fecha = _fechaController.text;
                odc.cantidad = int.parse(_cantidadController.text);
                odc.costo = int.parse(_costotalController);
                odc.proveedor = _fechaController.text;

                productService.updateOrdenCompra(odc).then((value) {
                  // Lógica después de actualizar el producto
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PurchaseList()),
                );
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(
                  (MediaQuery.of(context).size.width * 0.6),
                  (MediaQuery.of(context).size.height * 0.07),
                ),
              ),
              child: const Text('Guardar'),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PurchaseList()),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
