import 'package:flutter/material.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/proveedores/suppliers.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/home/home.dart';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/users/users_list.dart';

import '../../services/productos_services.dart';
import '../../services/suppliers_services.dart';

class SuppliersAddPage extends StatefulWidget {
  const SuppliersAddPage({Key? key}) : super(key: key);

  @override
  _SuppliersAddPageState createState() => _SuppliersAddPageState();
}

class _SuppliersAddPageState extends State<SuppliersAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController rutproveedorController = TextEditingController();
  TextEditingController nombreproveedorController = TextEditingController();
  TextEditingController tipoproductoController = TextEditingController();
  TextEditingController correoproveedorController = TextEditingController();
  TextEditingController numerotelefonoController = TextEditingController();
  File? imagen_insumo;

  @override
  void dispose() {
    rutproveedorController.dispose();
    nombreproveedorController.dispose();
    tipoproductoController.dispose();
    correoproveedorController.dispose();
    numerotelefonoController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final bytes =
          imagen_insumo != null ? await imagen_insumo!.readAsBytes() : null;
      final base64 = bytes != null ? base64Encode(bytes) : "";
      final msg = jsonEncode({
        'rut': rutproveedorController.text,
        'nombre_proveedor': nombreproveedorController.text,
        'tipo_insumo': tipoproductoController.text,
        'correo_proveedor': correoproveedorController.text,
        'telefono_proveedor': numerotelefonoController.text,
        'imagen_insumo': base64,
      });
      await SuppliersService().addSupplier(msg);
      print('saved');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuppliersView()),
      );
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del producto.';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validateProducto(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el insumo.';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El insumo no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validateRut(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el RUT del proveedor.';
    }
    final rutRegExp = RegExp(
        r'^(\d{1,2}\.?\d{3}\.?\d{3}[-][0-9kK]{1}|[0-9]{1,2}[0-9]{3}[0-9]{3}[0-9kK]{1})$');
    if (!rutRegExp.hasMatch(value)) {
      return 'El RUT no es válido.';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor ingrese una dirección de correo electrónico';
    }

    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Por favor ingrese un correo válido';
    }

    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el número de teléfono.';
    }
    final phoneRegExp = RegExp(r'^[+]?[0-9]{10,13}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'El número de teléfono no es válido.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Listado de Proveedores',
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
                          imagen_insumo = File(result.files.single.path!);
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
                        child: imagen_insumo != null
                            ? Image.file(
                                imagen_insumo!,
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
                      validator: validateName,
                      controller: nombreproveedorController,
                      decoration: const InputDecoration(
                          hintText: 'Nombre del proveedor'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validateRut,
                      controller: rutproveedorController,
                      decoration:
                          const InputDecoration(hintText: 'RUT del proveedor'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validateProducto,
                      controller: tipoproductoController,
                      decoration:
                          const InputDecoration(hintText: 'Tipo de producto'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validateEmail,
                      controller: correoproveedorController,
                      decoration:
                          const InputDecoration(hintText: 'Correo electrónico'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02),
                    child: TextFormField(
                      validator: validatePhoneNumber,
                      controller: numerotelefonoController,
                      decoration:
                          const InputDecoration(hintText: 'Número de teléfono'),
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
                                      builder: (context) =>
                                          const SuppliersView(),
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
