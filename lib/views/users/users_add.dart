import 'package:flutter/material.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/theme/theme_constant.dart';
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
        primaryColor: MyTheme.primary,
        scaffoldBackgroundColor: Color.fromARGB(255, 189, 224, 254),
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
          title: Text(
            'Añadir Usuario',
            style: TextStyle(
              color: Color(0xFF5D2A42),
              fontSize: 24,
            ),
          ),
          backgroundColor: Color(0xFFFFB5D7),
          centerTitle: true,
          titleSpacing: 0,
        ),
        drawer: SideBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                TextFormField(
                  controller: rutusersController,
                  decoration: InputDecoration(
                    hintText: 'RUT',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nombreusersController,
                  decoration: InputDecoration(
                    hintText: 'Nombre Completo',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: localusersController,
                  decoration: InputDecoration(
                    hintText: 'Local',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cargousersController,
                  decoration: InputDecoration(
                    hintText: 'Cargo',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: correousersController,
                  decoration: InputDecoration(
                    hintText: 'Correo Electronico',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: numerotelefonousersController,
                  decoration: InputDecoration(
                    hintText: 'Numero de Telefono',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contactoemergenciausersController,
                  decoration: InputDecoration(
                    hintText: 'Contacto de Emergencia',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                      fontSize: 14,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: _saveData,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFFC4E3),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.save, color: Colors.white),
                            const SizedBox(width: 1),
                            Expanded(
                              child: Text(
                                'Guardar',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5D2A42),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFFFB5D7),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            const SizedBox(width: 1),
                            Expanded(
                              child: Text(
                                'Volver',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5D2A42),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
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
    required border,
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
