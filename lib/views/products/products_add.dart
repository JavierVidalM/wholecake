import 'dart:convert';
import 'dart:io';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:file_picker/file_picker.dart';

class ProductsAdd extends StatelessWidget {
  const ProductsAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agregar productos',
      debugShowCheckedModeBanner: false,
      home: const ProductsAddPage(title: 'Agregar productos'),
      theme: SweetCakeTheme.myTheme,
    );
  }
}

class ProductsAddPage extends StatefulWidget {
  const ProductsAddPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<ProductsAddPage> createState() => _ProductsAddPageState();
}

class _ProductsAddPageState extends State<ProductsAddPage> {
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
        title: Text(
          'Agregar Productos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: SideBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.04,
              ),
              child: InkWell(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                  );
                  if (result != null) {
                    setState(() {
                      imagen = File(result.files.single.path!);
                    });
                  }
                },
                child: Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF909090),
                  ),
                  child: ClipOval(
                    child: imagen != null
                        ? Image.file(
                            imagen!,
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.add,
                            size: 40.0,
                            color: Color(0xFFC0C0C0),
                          ),
                  ),
                ),
              ),
            ),
            TextField(
              controller: nombreController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: InputDecoration(hintText: 'Nombre del producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: categoriaController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: InputDecoration(hintText: 'Categoría'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fechaElaboracionController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: InputDecoration(hintText: 'Fecha de elaboración'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: fechaVencimientoController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: InputDecoration(hintText: 'Fecha de Vencimiento'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(),
              controller: precioController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: InputDecoration(hintText: 'Precio'),
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
                minimumSize: Size(
                  (MediaQuery.of(context).size.width * 0.6),
                  (MediaQuery.of(context).size.height * 0.07),
                ),
              ),
              child: const Text('Guardar'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProductsView()));
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
      ),
    );
  }
}
