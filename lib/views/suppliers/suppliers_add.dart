import 'package:flutter/material.dart';

import 'package:wholecake/views/suppliers/suppliers_add.dart';

class SuppliersAdd extends StatelessWidget {
  const SuppliersAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Información del proveedor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const SuppliersAddPagePage(title: 'Información del proveedor'),
    );
  }
}

class SuppliersAddPagePage extends StatefulWidget {
  const SuppliersAddPagePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<SuppliersAddPagePage> createState() => SuppliersAddPagePageState();
}

class SuppliersAddPagePageState extends State<SuppliersAddPagePage> {
  TextEditingController rutproveedorController = TextEditingController();
  TextEditingController nombreproveedorController = TextEditingController();
  TextEditingController tipoproductoproveedorController =
      TextEditingController();
  TextEditingController marcaproductoproveedorController =
      TextEditingController();
  TextEditingController correoproveedorController = TextEditingController();
  TextEditingController costoproductoproveedorController =
      TextEditingController();
  TextEditingController numeroproveedorController = TextEditingController();

  @override
  void dispose() {
    rutproveedorController.dispose();
    nombreproveedorController.dispose();
    tipoproductoproveedorController.dispose();
    marcaproductoproveedorController.dispose();
    correoproveedorController.dispose();
    costoproductoproveedorController.dispose();
    numeroproveedorController.dispose();
    super.dispose();
  }

  void _saveData() {
    // Aquí es donde guardarías la información en la base de datos
    print('Nombre: ${rutproveedorController.text}');
    print('Fecha de elaboración: ${nombreproveedorController.text}');
    print('Fecha de vencimiento: ${tipoproductoproveedorController.text}');
    print('Descripción: ${marcaproductoproveedorController.text}');
    print('Descripción: ${correoproveedorController.text}');
    print('Descripción: ${costoproductoproveedorController.text}');
    print('Descripción: ${numeroproveedorController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Información del proveedor'),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              children: [
                InputTextField(
                  hintText: 'Rut Proveedor',
                  labelText: 'Rut Proveedor',
                  controller: rutproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Nombre  Proveedor',
                  labelText: 'Nombre Proveedor',
                  controller: nombreproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Tipo  producto',
                  labelText: 'Tipo producto',
                  controller: tipoproductoproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Marca  producto',
                  labelText: 'Marca producto',
                  controller: marcaproductoproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Correo  Proveedor',
                  labelText: 'Correo Proveedor',
                  controller: correoproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Costo del producto',
                  labelText: 'Costo del producto',
                  controller: costoproductoproveedorController,
                ),
                const SizedBox(
                  height: 20,
                ),
                InputTextField(
                  hintText: 'Número proveedor',
                  labelText: 'Número proveedor',
                  controller: numeroproveedorController,
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
