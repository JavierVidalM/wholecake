import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:wholecake/services/productos_services.dart';

import '../../providers/producto_form_provider.dart';

class ProductsEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductoScreenBody(
        productService: productService,
        title: 'Editar Producto',
      ),
    );
  }
}

class _ProductoScreenBody extends StatefulWidget {
  const _ProductoScreenBody(
      {Key? key, required this.title, required ProductService productService})
      : super(key: key);
  final String title;

  @override
  State<_ProductoScreenBody> createState() => _ProductoScreenBodyPageState();
}

class _ProductoScreenBodyPageState extends State<_ProductoScreenBody> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaElaboracionController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    fechaElaboracionController.dispose();
    fechaVencimientoController.dispose();
    precioController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  void _saveData() {
    // Aquí es donde guardarías la información en la base de datos
    print('Nombre: ${nombreController.text}');
    print('Fecha de elaboración: ${fechaElaboracionController.text}');
    print('Fecha de vencimiento: ${fechaVencimientoController.text}');
    print('Precio: ${precioController.text}');
    print('Categoria: ${categoriaController.text}');
  }

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    nombreController.text = product.nombre;
    fechaElaboracionController.text =
        DateFormat('dd-MM-yyyy').format(product.fechaElaboracion);
    fechaVencimientoController.text =
        DateFormat('dd-MM-yyyy').format(product.fechaVencimiento);
    precioController.text = product.precio;
    categoriaController.text = product.categoria;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Productos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            InputTextField1(
              hintText: 'Nombre',
              labelText: 'Nombre',
              controller: nombreController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField1(
              hintText: 'Fecha de elaboración',
              labelText: 'Fecha de elaboración',
              controller: fechaElaboracionController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField1(
              hintText: 'Fecha de vencimiento',
              labelText: 'Fecha de vencimiento',
              controller: fechaVencimientoController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField1(
              hintText: 'Precio',
              labelText: 'Precio',
              controller: precioController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField1(
              hintText: 'Categoria',
              labelText: 'Categoria',
              controller: categoriaController,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _saveData,
              child: const Text('Guardar'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}

class InputTextField1 extends StatelessWidget {
  const InputTextField1({
    Key? key,
    required this.hintText,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      controller: controller,
    );
  }
}
