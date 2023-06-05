import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wholecake/models/users.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/models/users.dart';

class SigninUser extends StatefulWidget {
  const SigninUser({Key? key}) : super(key: key);

  @override
  _SigninUserState createState() => _SigninUserState();
}

class _SigninUserState extends State<SigninUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController rutController = TextEditingController();
  TextEditingController direccionController = TextEditingController();
  TextEditingController ntelefonoController = TextEditingController();
  TextEditingController nemergenciaController = TextEditingController();
  TextEditingController localController = TextEditingController();
  File? imagen_user;

  @override
  void dispose() {
    userFirstNameController.dispose();
    userLastNameController.dispose();
    userEmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    rutController.dispose();
    direccionController.dispose();
    ntelefonoController.dispose();
    nemergenciaController.dispose();
    localController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el nombre del empleado.';
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'El nombre no debe contener números ni símbolos.';
    }
    return null;
  }

  String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese el Apellido(s).';
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
      if (passwordController.text != confirmPasswordController.text) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Las contraseñas no coinciden.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      final bytes =
          imagen_user != null ? await imagen_user!.readAsBytes() : null;
      final base64 = bytes != null ? base64Encode(bytes) : "";
      final msg = jsonEncode({
        'first_name': userFirstNameController.text,
        'last_name': userLastNameController.text,
        'email': userEmailController.text,
        'password': passwordController.text,
        'rut': rutController.text,
        'direccion': direccionController.text,
        'ntelefono': ntelefonoController.text,
        'nemergencia': nemergenciaController.text,
        'local': localController.text,
        'imagen_user': base64
      });

      await UserService().addUsersadmin(msg);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginUser()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SweetCakeTheme.loginTheme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_SW.png',
                        height: MediaQuery.of(context).size.height * 0.15,
                        // width: 150, // ajusta el ancho a tu preferencia
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  setState(() {
                                    imagen_user =
                                        File(result.files.single.path!);
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
                                  child: imagen_user != null
                                      ? Image.file(
                                          imagen_user!,
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
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              controller: userFirstNameController,
                              decoration: const InputDecoration(
                                hintText: "Nombre(s)",
                              ),
                              validator: validateName,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              controller: userLastNameController,
                              decoration: const InputDecoration(
                                hintText: "Apellido(s)",
                              ),
                              validator: validateLastName,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: userEmailController,
                              decoration: const InputDecoration(
                                hintText: "Correo electrónico",
                              ),
                              validator: validateEmail,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: rutController,
                              decoration: const InputDecoration(
                                hintText: "RUT",
                              ),
                              validator: validateRut,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: direccionController,
                              decoration: const InputDecoration(
                                hintText: "Dirección particular",
                              ),
                              validator: validateEmpty,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: ntelefonoController,
                              decoration: const InputDecoration(
                                hintText: "Numero de telefono",
                              ),
                              validator: validatePhoneNumber,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: nemergenciaController,
                              decoration: const InputDecoration(
                                hintText: "Numero de telefono de emergencia",
                              ),
                              validator: validatePhoneNumber,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: localController,
                              decoration: const InputDecoration(
                                hintText: "Local correspondiente",
                              ),
                              validator: validateEmpty,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              autocorrect: false,
                              obscureText: true,
                              decoration:
                                  const InputDecoration(hintText: 'Contraseña'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, ingrese una contraseña.';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              right: MediaQuery.of(context).size.width * 0.08,
                              left: MediaQuery.of(context).size.width * 0.08,
                            ),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              autocorrect: false,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  hintText: 'Confirmar contraseña'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, confirme su contraseña.';
                                }
                                if (value != passwordController.text) {
                                  return 'Las contraseñas no coinciden.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.03),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _saveData();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  (MediaQuery.of(context).size.width * 0.75),
                                  (MediaQuery.of(context).size.height * 0.08),
                                ),
                              ),
                              child: Text(
                                'Registrarse',
                                style: SweetCakeTheme
                                    .loginTheme.textTheme.titleLarge,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height *
                                      0.03),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginMain()));
                                },
                                child: Text(
                                  "Regresar",
                                  style: SweetCakeTheme
                                      .loginTheme.textTheme.bodyMedium,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
