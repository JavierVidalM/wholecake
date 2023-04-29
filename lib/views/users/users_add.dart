import 'package:flutter/material.dart';

import 'package:wholecake/views/users/users_add.dart';

void main() {
  runApp(const UsersAdd());
}

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

  void _saveData() {
    // Aquí es donde guardarías la información en la base de datos
    print('Nombre: ${rutusersController.text}');
    print('Fecha de elaboración: ${nombreusersController.text}');
    print('Fecha de vencimiento: ${localusersController.text}');
    print('Descripción: ${cargousersController.text}');
    print('Descripción: ${correousersController.text}');
    print('Descripción: ${numerotelefonousersController.text}');
    print('Descripción: ${contactoemergenciausersController.text}');
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
                InputTextField(
                  hintText: 'Rut ',
                  labelText: 'Rut ',
                  controller: rutusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Nombre  completo',
                  labelText: 'Nombre completo',
                  controller: nombreusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Local',
                  labelText: 'Local',
                  controller: localusersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Cargo',
                  labelText: 'Cargo',
                  controller: cargousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Correo  ',
                  labelText: 'Correo ',
                  controller: correousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Numero de telefono',
                  labelText: 'Numero de telefono',
                  controller: numerotelefonousersController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
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
