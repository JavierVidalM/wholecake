import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/ordenes_trabajo/orden_view.dart';
import 'dart:convert';
import 'dart:io';
import '../../services/ordentrabajo_services.dart';

class CrearOrdenAddPage extends StatefulWidget {
  const CrearOrdenAddPage({Key? key}) : super(key: key);

  @override
  _CrearOrdenAddPageState createState() => _CrearOrdenAddPageState();
}

class _CrearOrdenAddPageState extends State<CrearOrdenAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController nombreController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  TextEditingController estadoProductoController = TextEditingController();
  TextEditingController loteController = TextEditingController();
  File? imagen;

  @override
  void dispose() {
    nombreController.dispose();
    cantidadController.dispose();
    precioController.dispose();
    categoriaController.dispose();
    estadoProductoController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final bytes = imagen != null ? await imagen!.readAsBytes() : null;
      final base64 = bytes != null ? base64Encode(bytes) : "";
      final msg = jsonEncode({
        'nombre_producto': nombreController.text,
        'precio_producto': precioController.text,
        'categoria': categoriaController.text,
        'estado_producto': estadoProductoController.text,
        'cantidad_producto': cantidadController.text,
        'imagen': base64,
        'admin': 11,
      });
      await OrdenTrabajoService().addOrdenTrabajo(msg);
      print('saved');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrdenesView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Crear Orden de Trabajo',
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
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
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      controller: nombreController,
                      decoration: const InputDecoration(hintText: 'Nombre'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      //validator: validateRut,
                      controller: precioController,
                      decoration: const InputDecoration(hintText: 'Precio'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      //validator: validateProducto,
                      controller: categoriaController,
                      decoration: const InputDecoration(
                          hintText: 'Categoria del producto'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      //validator: validateEmail,
                      controller: estadoProductoController,
                      decoration: const InputDecoration(hintText: 'Estado'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      controller: cantidadController,
                      decoration: const InputDecoration(hintText: 'Cantidad'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: Row(
                          children: [
                            // Expanded(
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               const ProductsView(),
                            //         ),
                            //       );
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       minimumSize: Size(
                            //         (MediaQuery.of(context).size.width * 0.6),
                            //         (MediaQuery.of(context).size.height * 0.07),
                            //       ),
                            //     ),
                            //     child: const Text('Volver'),
                            //   ),
                            // ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _saveData();
                                  }
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
