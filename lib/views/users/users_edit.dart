import 'package:flutter/material.dart';
import 'package:wholecake/models/users.dart';
import 'package:wholecake/views/users/users_add.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/providers/user_form_provider.dart';
import 'package:file_picker/file_picker.dart';

class UsersEdit extends StatelessWidget {
  const UsersEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Información del users',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const UsersEditPagePage(title: 'Información del users'),
    );
  }
}

class UsersEditPagePage extends StatefulWidget {
  const UsersEditPagePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<UsersEditPagePage> createState() => UsersEditPagePageState();
}

class UsersEditPagePageState extends State<UsersEditPagePage> {
  TextEditingController rutusersController = TextEditingController();
  TextEditingController nombreusersController = TextEditingController();
  TextEditingController tipoproductousersController = TextEditingController();
  TextEditingController marcaproductousersController = TextEditingController();
  TextEditingController correousersController = TextEditingController();
  TextEditingController costoproductousersController = TextEditingController();
  TextEditingController numerousersController = TextEditingController();
  TextEditingController contactoemergenciausersController =
      TextEditingController();

  @override
  void dispose() {
    rutusersController.dispose();
    nombreusersController.dispose();
    tipoproductousersController.dispose();
    marcaproductousersController.dispose();
    correousersController.dispose();
    costoproductousersController.dispose();
    numerousersController.dispose();
    contactoemergenciausersController.dispose();
    super.dispose();
  }

  void _saveData() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Información del sexo'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                InputTextField(
                  hintText: 'Rut users',
                  labelText: 'Rut users',
                  controller: rutusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Nombre  users',
                  labelText: 'Nombre users',
                  controller: nombreusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Tipo  producto',
                  labelText: 'Tipo producto',
                  controller: tipoproductousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Marca  producto',
                  labelText: 'Marca producto',
                  controller: marcaproductousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Correo  users',
                  labelText: 'Correo users',
                  controller: correousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Costo del producto',
                  labelText: 'Costo del producto',
                  controller: costoproductousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Número users',
                  labelText: 'Número users',
                  controller: numerousersController,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop,
                    child: const Text('Volver'))
              ],
            )));
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
        border: UnderlineInputBorder(),
      ),
      controller: controller,
    );
  }
}
