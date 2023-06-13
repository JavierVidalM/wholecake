import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/users/users.dart';
import '../utilidades/sidebar.dart';

class UsersAddPage extends StatefulWidget {
  const UsersAddPage({Key? key}) : super(key: key);

  @override
  _UsersAddPageState createState() => _UsersAddPageState();
}

class _UsersAddPageState extends State<UsersAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController tipoController = TextEditingController(text: 'Cajero');
  TextEditingController rutController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController ntelefonoController = TextEditingController();
  TextEditingController nemergenciaController = TextEditingController();
  TextEditingController localController = TextEditingController();
  File? imagenUser;

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    userEmailController.dispose();
    tipoController.dispose();
    rutController.dispose();
    direccionController.dispose();
    ntelefonoController.dispose();
    nemergenciaController.dispose();
    localController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre(s) del empleado.';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre(s) no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el apellido(s).';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El Apellido(s) no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validateRut(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el RUT del empleado.';
    }
    if (value.length > 12) {
      return 'El RUT no puede superar los 12 caracteres.';
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

  String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese los datos correspondientes.';
    }
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      final bytes = imagenUser != null ? await imagenUser!.readAsBytes() : null;
      final base64 = bytes != null ? base64Encode(bytes) : "";
      final msg = jsonEncode({
        'first_name': userFirstNameController.text,
        'last_name': userLastNameController.text,
        'email': userEmailController.text,
        'tipo': tipoController.text,
        'rut': rutController.text,
        'direccion': direccionController.text,
        'ntelefono': ntelefonoController.text,
        'nemergencia': nemergenciaController.text,
        'local': localController.text,
        'imagen_user': base64,
      });
      await UserService().addUsers(msg);
      {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoadingScreen(),
          ),
        );

        Future.delayed(
          const Duration(
            milliseconds: 2300,
          ),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const UsersViewList(),
              ),
            );
          },
        );
      }
      ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Añadir empleado',
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
                          imagenUser = File(result.files.single.path!);
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
                        child: imagenUser != null
                            ? Image.file(
                                imagenUser!,
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
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: userFirstNameController,
                      decoration: const InputDecoration(hintText: 'Nombre(s)'),
                      validator: validateName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: userLastNameController,
                      decoration:
                          const InputDecoration(hintText: 'Apellido(s)'),
                      validator: validateLastName,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: userEmailController,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                        hintText: 'Correo electrónico',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: tipoController.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          tipoController.text = newValue ?? '';
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Cargo del empleado',
                      ),
                      items: <String>['Cajero', 'Pastelero']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: rutController,
                      decoration: const InputDecoration(hintText: 'RUT'),
                      validator: validateRut,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                      controller: direccionController,
                      decoration: const InputDecoration(
                        hintText: 'Dirección particular',
                      ),
                      validator: validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                        controller: ntelefonoController,
                        decoration: const InputDecoration(
                          hintText: 'Número de teléfono',
                        ),
                        validator: validatePhoneNumber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                        controller: nemergenciaController,
                        decoration: const InputDecoration(
                          hintText: 'Número de teléfono de emergencia',
                        ),
                        validator: validatePhoneNumber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: TextFormField(
                        controller: localController,
                        decoration: const InputDecoration(
                          hintText: 'Local de trabajo',
                        ),
                        validator: validateEmpty),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: _saveData,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              (MediaQuery.of(context).size.width * 0.6),
                              (MediaQuery.of(context).size.height * 0.07),
                            ),
                          ),
                          child: const Text('Guardar'),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoadingScreen(),
                              ),
                            );

                            Future.delayed(
                              const Duration(
                                milliseconds: 1300,
                              ),
                              () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const UsersViewList(),
                                  ),
                                );
                              },
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
                    ),
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
