import 'dart:convert';
import 'dart:io';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/pruebas.dart';

class ProductsAdd extends StatelessWidget {
  const ProductsAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agregar productos',
      color: Color(0xFFFFB5D7),
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
  TextEditingController precioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  File? imagen;

  @override
  void dispose() {
    nombreController.dispose();
    fechaElaboracionController.dispose();
    fechaVencimientoController.dispose();
    precioController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final bytes = imagen != null ? await imagen!.readAsBytes() : null;
    final base64 = bytes != null ? base64Encode(bytes) : "";
    final msg = jsonEncode({
      'nombre': nombreController.text,
      'categoria': categoriaController.text,
      'fecha_elaboracion': fechaElaboracionController.text,
      'fecha_vencimiento': fechaVencimientoController.text,
      'precio': precioController.text,
      'imagen': base64
    });
    await ProductService().addProducto(msg);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ProductsView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFBDE0FE),
      appBar: AppBar(
        title: const Text('Agregar Productos'),
        backgroundColor: Color(0xFFFFB5D7),
      ),
      drawer: SideBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: NetworkImage(''),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            InputTextField(
              hintText: 'Nombre Producto',
              labelText: 'Nombre Producto',
              controller: nombreController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Categoría',
              labelText: 'Categoría',
              controller: categoriaController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Fecha de elaboración',
              labelText: 'Fecha de elaboración',
              controller: fechaElaboracionController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Fecha de vencimiento',
              labelText: 'Fecha de vencimiento',
              controller: fechaVencimientoController,
            ),
            const SizedBox(
              height: 20,
            ),
            InputTextField(
              hintText: 'Precio',
              labelText: 'Precio',
              controller: precioController,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  setState(() {
                    imagen = File(result.files.single.path!);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFB5D7),
              ),
              icon: Icon(Icons.image),
              label: Text(
                'Seleccionar imagen',
                style: TextStyle(color: Color(0xFF5D2A42)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ProductsView()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFB5D7),
              ),
              child: const Text(
                'Guardar',
                style: TextStyle(color: Color(0xFF5D2A42)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductsView()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFFB5D7),
              ),
              child: const Text(
                'Volver',
                style: TextStyle(color: Color(0xFF5D2A42)),
              ),
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
