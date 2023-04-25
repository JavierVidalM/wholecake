import 'package:flutter/material.dart';
import 'dart:io';


void main() {
  runApp(const ProductsAdd());
}

class ProductsAdd extends StatelessWidget {
  const ProductsAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agregar productos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const ProductsAddPagePage(title: 'Agregar productos'),
    );
  }
}

class ProductsAddPagePage extends StatefulWidget {
  const ProductsAddPagePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProductsAddPagePage> createState() => _ProductsAddPagePageState();
}

class _ProductsAddPagePageState extends State<ProductsAddPagePage> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaElaboracionController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();

  @override
  void dispose() {
    nombreController.dispose();
    fechaElaboracionController.dispose();
    fechaVencimientoController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  void _saveData() {
    // Aquí es donde guardarías la información en la base de datos
    print('Nombre: ${nombreController.text}');
    print('Fecha de elaboración: ${fechaElaboracionController.text}');
    print('Fecha de vencimiento: ${fechaVencimientoController.text}');
    print('Descripción: ${descripcionController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Productos'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            InputTextField(
              hintText: 'Nombre',
              labelText: 'Nombre',
              controller: nombreController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
              hintText: 'Fecha de elaboración',
              labelText: 'Fecha de elaboración',
              controller: fechaElaboracionController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
              hintText: 'Fecha de vencimiento',
              labelText: 'Fecha de vencimiento',
              controller: fechaVencimientoController,
            ),
            const SizedBox(
              height: 10,
            ),
            InputTextField(
              hintText: 'Descripción',
              labelText: 'Descripción',
              controller: descripcionController,
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

class InputTextField extends StatelessWidget {
  const InputTextField({
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