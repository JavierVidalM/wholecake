import 'package:flutter/material.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/users/users_list.dart';

class UsersAdd extends StatelessWidget {
  const UsersAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Información del usuario',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const UsersAddPagePage(title: 'Información del usuario'),
    );
  }
}

class UsersAddPagePage extends StatefulWidget {
  const UsersAddPagePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<UsersAddPagePage> createState() => UsersAddPagePageState();
}

class UsersAddPagePageState extends State<UsersAddPagePage> {
  TextEditingController rutusersController = TextEditingController();
  TextEditingController nombreusersController = TextEditingController();
  TextEditingController localusersController = TextEditingController();
  TextEditingController cargousersController = TextEditingController();
  TextEditingController correousersController = TextEditingController();
  TextEditingController numerotelefonousersController = TextEditingController();
  TextEditingController contactoemergenciausersController =
      TextEditingController();
  File? imagen;

  @override
  void dispose() {
    rutusersController.dispose();
    nombreusersController.dispose();
    localusersController.dispose();
    cargousersController.dispose();
    correousersController.dispose();
    numerotelefonousersController.dispose();
    contactoemergenciausersController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final bytes = imagen != null ? await imagen!.readAsBytes() : null;
    final base64 = bytes != null ? base64Encode(bytes) : "";
    final msg = jsonEncode({
      // Aquí es donde guardarías la información en la base de datos
      'nombre': nombreusersController.text,
      'rut': rutusersController.text,
      'local': localusersController.text,
      'cargo': cargousersController.text,
      'correo': correousersController.text,
      'numero': numerotelefonousersController.text,
      'contacto emergencia': contactoemergenciausersController.text,
      'imagen': base64
    });
    await UserService().UsersAdd(msg);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UsersList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Crear usuario'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                InputTextField1(
                  hintText: 'Rut ',
                  labelText: 'Rut ',
                  controller: rutusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Nombre  completo',
                  labelText: 'Nombre completo',
                  controller: nombreusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Local',
                  labelText: 'Local',
                  controller: localusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Cargo',
                  labelText: 'Cargo',
                  controller: cargousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Correo  ',
                  labelText: 'Correo ',
                  controller: correousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Numero de telefono',
                  labelText: 'Numero de telefono',
                  controller: numerotelefonousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField1(
                  hintText: 'Contacto de emergencia',
                  labelText: 'Contacto de emergencia',
                  controller: contactoemergenciausersController,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Volver')),
                ElevatedButton(
                  onPressed: _saveData,
                  child: const Text('Guardar'),
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
                  icon: const Icon(Icons.image),
                  label: const Text(
                    'Seleccionar imagen',
                    style: TextStyle(color: Color(0xFF5D2A42)),
                  ),
                ),
              ],
            )));
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
        border: const UnderlineInputBorder(),
      ),
      controller: controller,
    );
  }
}
