import 'package:flutter/material.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/home/home.dart';
import 'dart:convert';
import 'dart:io';
import 'package:wholecake/views/users/users_list.dart';

class UsersAdd extends StatelessWidget {
  const UsersAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SweetCakeTheme.mainTheme,
      title: 'Información del usuario',
      home: const UsersAddPagePage(),
    );
  }
}

class UsersAddPagePage extends StatefulWidget {
  const UsersAddPagePage({Key? key}) : super(key: key);
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
          title: Text('Añadir Usuario',
              style: Theme.of(context).textTheme.titleLarge),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
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
                TextFormField(
                  controller: rutusersController,
                  decoration: const InputDecoration(hintText: 'RUT'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nombreusersController,
                  decoration:
                      const InputDecoration(hintText: 'Nombre Completo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: localusersController,
                  decoration: const InputDecoration(hintText: 'Local'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: cargousersController,
                  decoration: const InputDecoration(hintText: 'Cargo'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: correousersController,
                  decoration:
                      const InputDecoration(hintText: 'Correo Electronico'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: numerotelefonousersController,
                  decoration:
                      const InputDecoration(hintText: 'Numero de Telefono'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contactoemergenciausersController,
                  decoration:
                      const InputDecoration(hintText: 'Contacto de Emergencia'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _saveData();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      (MediaQuery.of(context).size.width * 0.6),
                      (MediaQuery.of(context).size.height * 0.07),
                    ),
                  ),
                  child: const Text('Guardar'),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
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
              ],
            )));
  }
}
