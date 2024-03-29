// ignore_for_file: use_build_context_synchronously, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import '../../models/categoria.dart';

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
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController fechaVencimientoController = TextEditingController();
  TextEditingController cantidadController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController categoriaController = TextEditingController();
  File? imagen;

  @override
  void dispose() {
    nombreController.dispose();
    fechaVencimientoController.dispose();
    cantidadController.dispose();
    precioController.dispose();
    categoriaController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    DateTime hoyconhora = DateTime.now();
    String hoy = DateFormat('yyyy-MM-dd').format(hoyconhora);
    final bytes = imagen != null ? await imagen!.readAsBytes() : null;
    final base64 = bytes != null ? base64Encode(bytes) : "";
    final msg = jsonEncode({
      'nombre': nombreController.text,
      'categoria': int.parse(categoriaController.text),
      'fecha_elaboracion': hoy,
      'fecha_vencimiento': fechaVencimientoController.text,
      'cantidad': cantidadController.text,
      'precio': precioController.text,
      'imagen': base64,
      'estado': 'true',
    });
    await ProductService().addProducto(msg);
    // Navigator.pushNamed(context, "/ProductsView");
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
        ),
      );

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del producto.';
    }
    final nameRegExp = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validatePrice(String? value) {
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

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una categoría.';
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

  String? validateExpirationDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una fecha de vencimiento.';
    }
    final selectedDate = DateFormat('yyyy-MM-dd').parse(value);
    final currentDate = DateTime.now();
    if (selectedDate.isBefore(currentDate)) {
      return 'La fecha de vencimiento no puede ser anterior a la fecha actual.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ProductService(),
        child: Scaffold(
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Column(
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
                          validator: validateName,
                          decoration: const InputDecoration(
                              hintText: 'Nombre del producto'),
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
                              items:
                                  listacat.listadocategorias.map((categoria) {
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
                        child: Theme(
                          data: SweetCakeTheme.calendarTheme,
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            dateLabelText: 'Fecha de vencimiento',
                            controller: fechaVencimientoController,
                            validator: validateExpirationDate,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: TextFormField(
                          controller: cantidadController,
                          validator: validateQuantity,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(hintText: 'Cantidad'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.02),
                        child: TextFormField(
                          controller: precioController,
                          validator: validatePrice,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(hintText: 'Precio'),
                        ),
                      ),
                    ],
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
                                      builder: (context) =>
                                          const ProductsView(),
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
            ),
          ),
        ));
  }
}
