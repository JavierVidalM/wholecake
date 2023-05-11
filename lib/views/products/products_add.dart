import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../utilities/loading_screen.dart';

class ProductsAdd extends StatelessWidget {
  const ProductsAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agregar productos',
      debugShowCheckedModeBanner: false,
      home: const ProductsAddPage(title: 'Agregar productos'),
      theme: SweetCakeTheme.mainTheme,
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
      'imagen': base64,
      'estado': 'true',
    });
    await ProductService().addProducto(msg);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const ProductsView()));
  }

  Future<String?> popUp() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: const Text("Ingrese la categoría"),
            content: TextField(
              controller: categoriaController,
              onChanged: (value) {},
              autofocus: true,
            ),
            actions: [
              ElevatedButton(
                onPressed: () =>
                    Navigator.of(context).pop(categoriaController.text),
                child: const Text("Agregar"),
              )
            ],
          ));

  String _selectedItem = 'Tortas';

  @override
  Widget build(BuildContext context) {
    final listadoCategorias = Provider.of<ProductService>(context);
    if (listadoCategorias.isLoading) return const LoadingScreen();

    // for (int cat =0; cat<listadoCategorias.listadocategorias.length; cat++) {
    //   String catList = listadoCategorias.listadocategorias[cat];
    // },

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agregar Productos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF909090),
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
              decoration:
                  const InputDecoration(hintText: 'Nombre del producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<dynamic>(
                    value: _selectedItem,
                    items: <dynamic>[listadoCategorias.listadocategorias]
                        .map((value) {
                      return DropdownMenuItem<dynamic>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 0), // Agrega un margen izquierdo
                          // child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      setState(() {
                        _selectedItem = newvalue!;
                      });
                      categoriaController.text = newvalue!.toString();
                    },
                    borderRadius: BorderRadius.circular(20),
                    icon: const Icon(Icons.expand_more),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Theme(
              data: SweetCakeTheme.calendarTheme,
              child: DateTimePicker(
                useRootNavigator: true,
                dateHintText: 'Fecha Elaboración',
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                controller: fechaElaboracionController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Theme(
              data: SweetCakeTheme.calendarTheme,
              child: DateTimePicker(
                dateHintText: 'Fecha Vencimiento',
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                controller: fechaVencimientoController,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              keyboardType: const TextInputType.numberWithOptions(),
              controller: precioController,
              onChanged: (value) {
                // Aquí puede agregar la lógica para actualizar el valor del controlador
              },
              decoration: const InputDecoration(hintText: 'Precio'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _saveData();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductsView()));
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductsView()),
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
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.2),
              child: TextButton(
                onPressed: () async {
                  await popUp();
                },

                // style: ElevatedButton.styleFrom(
                //   minimumSize: Size(0,0,
                // ),
                child: Text(
                  '',
                  style: TextStyle(fontSize: 0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
