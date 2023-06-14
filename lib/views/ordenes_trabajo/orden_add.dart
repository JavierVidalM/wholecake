// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/ordenes_trabajo/orden_view.dart';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/services/ordentrabajo_services.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:provider/provider.dart';
import '../../services/productos_services.dart';
import '../../services/users_services.dart';

class OrdenAddPage extends StatefulWidget {
  const OrdenAddPage({Key? key}) : super(key: key);

  @override
  _OrdenAddPageState createState() => _OrdenAddPageState();
}

class _OrdenAddPageState extends State<OrdenAddPage> {
  int getUserId() {
    final user = Provider.of<UserService>(context, listen: false);
    return user.userId;
  }

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
        'admin': getUserId(),
      });
      await OrdenTrabajoService().addOrdenTrabajo(msg);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const OrdenesView()),
      );
    }
  }

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una categoría.';
    }
    return null;
  }

  String? validateNombre(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del producto.';
    }
    final nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validatePrecio(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el precio del producto.';
    }
    final priceRegExp = RegExp(r'^\d+(\.\d+)?$');
    if (!priceRegExp.hasMatch(value)) {
      return 'El precio debe ser un número válido.';
    }
    final price = double.parse(value);
    if (price < 0) {
      return 'El precio no puede ser negativo.';
    }
    return null;
  }

  String? validateEstado(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el estado del producto.';
    }

    final pattern = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$');
    if (!pattern.hasMatch(value)) {
      return 'El estado no debe contener números ni símbolos.';
    }

    if (value.toLowerCase() != 'elaboracion') {
      return 'El estado debe ser "Elaboracion".';
    }

    return null;
  }

  String? validateQuantity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese la cantidad del producto.';
    }
    final quantityRegExp = RegExp(r'^\d+$');
    if (!quantityRegExp.hasMatch(value)) {
      return 'La cantidad debe ser un número entero.';
    }
    final quantity = int.parse(value);
    if (quantity < 0) {
      return 'La cantidad no puede ser negativa.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    estadoProductoController.text = 'En elaboracion';
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      validator: validateNombre,
                      decoration: const InputDecoration(hintText: 'Nombre'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validatePrecio,
                      controller: precioController,
                      decoration: const InputDecoration(hintText: 'Precio'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: Consumer<ProductService>(
                      builder: (context, listacat, _) {
                        ListElement? categoriaSeleccionada;
                        return DropdownButtonFormField<ListElement>(
                          validator: (ListElement? value) =>
                              validateCategory(value?.nombre),
                          hint: const Text('Selecciona una categoría'),
                          value: categoriaSeleccionada,
                          onChanged: (ListElement? nuevaCategoria) {
                            setState(() {
                              categoriaController.text =
                                  nuevaCategoria!.categoriaId.toString();
                            });
                          },
                          items: listacat.listadocategorias.map((categoria) {
                            return DropdownMenuItem<ListElement>(
                              value: categoria,
                              child: Text(categoria.nombre),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      controller: estadoProductoController,
                      validator: validateEstado,
                      decoration: const InputDecoration(hintText: 'Estado'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validateQuantity,
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
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const OrdenesView(),
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
