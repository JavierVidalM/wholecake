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

    // Verificar la presencia del guion
    if (!value.contains('-')) {
      return 'El RUT debe contener un guión.';
    }

    // Verificar que no haya puntos en el RUT
    if (value.contains('.')) {
      return 'El RUT no debe contener puntos.';
    }

    // Eliminar el guion del RUT
    value = value.replaceAll('-', '');

    // Verificar la longitud del RUT
    if (value.length > 9 || value.length < 8) {
      return 'El RUT no es válido.';
    }

    // Obtener el dígito verificador
    String dv = value.substring(value.length - 1);
    value = value.substring(0, value.length - 1);

    // Verificar el dígito verificador
    int rut = int.parse(value);
    int suma = 0;
    int factor = 2;

    while (rut > 0) {
      suma += (rut % 10) * factor;
      rut ~/= 10;
      factor = factor % 7 == 0 ? 2 : factor + 1;
    }

    int dvCalculado = 11 - (suma % 11);
    String dvString = dvCalculado == 11
        ? '0'
        : dvCalculado == 10
            ? 'K'
            : dvCalculado.toString();

    if (dv.toUpperCase() != dvString.toUpperCase()) {
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

    // Eliminar cualquier caracter que no sea número
    value = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Verificar la longitud del número de teléfono
    if (value.length != 9) {
      return 'El número de teléfono debe tener exactamente 9 dígitos.';
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
        title: Text(
          'Añadir empleado',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.06),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.height *
                                      0.02),
                              child: const Text('Imagen'),
                            ),
                            InkWell(
                              onTap: () async {
                                final result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.image,
                                );
                                if (result != null) {
                                  setState(() {
                                    imagenUser =
                                        File(result.files.single.path!);
                                  });
                                }
                              },
                              child: Container(
                                width: 110.0,
                                height: 110.0,
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
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Nombre(s)'),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextFormField(
                                controller: userFirstNameController,
                                decoration: const InputDecoration(
                                    hintText: 'Matías Lucas'),
                                validator: validateName,
                              ),
                            ),
                          ),
                          const Text('Apellido(s)'),
                          Padding(
                            padding: EdgeInsets.only(
                                top:
                                    MediaQuery.of(context).size.height * 0.005),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextFormField(
                                controller: userLastNameController,
                                decoration: const InputDecoration(
                                    hintText: 'Vasquez Barahona'),
                                validator: validateLastName,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Correo electrónico'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      controller: userEmailController,
                      validator: validateEmail,
                      decoration: const InputDecoration(
                        hintText: 'tucorreo@ejemplo.cl',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Cargo del usuario'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: DropdownButtonFormField<String>(
                      value: tipoController.text,
                      onChanged: (String? newValue) {
                        setState(() {
                          tipoController.text = newValue ?? '';
                        });
                      },
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
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('RUT (sin puntos y con guión)'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      controller: rutController,
                      decoration:
                          const InputDecoration(hintText: 'Ej: 12345678-9'),
                      validator: validateRut,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Dirección particular'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                      controller: direccionController,
                      decoration: const InputDecoration(
                        hintText: 'Avenida Pedro de Valdivia 425',
                      ),
                      validator: validateEmpty,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Número de teléfono'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                        controller: ntelefonoController,
                        decoration: const InputDecoration(
                          hintText: '9 12345678',
                        ),
                        validator: validatePhoneNumber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Número de emergencia'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                        controller: nemergenciaController,
                        decoration: const InputDecoration(
                          hintText: '9 12345678',
                        ),
                        validator: validatePhoneNumber),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.01,
                        left: MediaQuery.of(context).size.width * 0.01),
                    child: const Text('Local de trabajo'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.005,
                    ),
                    child: TextFormField(
                        controller: localController,
                        decoration: const InputDecoration(
                          hintText: 'Ej: Pastelería RGG Providencia',
                        ),
                        validator: validateEmpty),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }
}
