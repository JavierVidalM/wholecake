import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wholecake/models/users.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/views/users/users_list.dart';
import 'package:wholecake/services/users_services.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

import '../utilidades/utilidades.dart';

class UsersEdit extends StatefulWidget {
  final int userId;
  const UsersEdit({Key? key, required this.userId}) : super(key: key);

  @override
  _UsersEditState createState() => _UsersEditState();
}

class _UsersEditState extends State<UsersEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> cargoOptions = ['Cajero', 'Pastelero', 'Admin'];
  late int userId;

  File? imageSelected;

  Future<void> seleccionarImagen() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        imageSelected = File(result.files.single.path!);
      });
    }
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

  @override
  Widget build(BuildContext context) {
    final usersService = Provider.of<UserService>(context);
    final user = usersService.listadousers.firstWhere(
      (user) => user.userId == widget.userId,
      orElse: () => Listado(
          userId: 0,
          userName: '',
          userFirstName: '',
          userLastName: '',
          userEmail: '',
          tipo: '',
          rut: '',
          local: '',
          direccion: '',
          ntelefono: '',
          nemergencia: '',
          imagen_user: ''),
    );
    ImageProvider image;
    if (imageSelected != null) {
      image = FileImage(imageSelected!);
    } else if (user.imagen_user.isNotEmpty) {
      Uint8List bytes = Uint8List.fromList(base64.decode(user.imagen_user));
      image = MemoryImage(bytes);
    } else {
      image = const AssetImage('assets/images/default.jpg');
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Editar usuario',
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
                              onTap: seleccionarImagen,
                              child: Container(
                                width: 110.0,
                                height: 110.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: ClipOval(
                                  child: imageSelected != null
                                      ? Image.file(
                                          imageSelected!,
                                          width: 80.0,
                                          height: 80.0,
                                          fit: BoxFit.cover,
                                        )
                                      : const SizedBox(),
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
                                initialValue: user.userFirstName,
                                onChanged: (value) =>
                                    user.userFirstName = value,
                                validator: validateName,
                                decoration: InputDecoration(
                                  hintText: user.userFirstName,
                                ),
                              ),
                            ),
                          ),
                          const Text('Apellido(s)'),
                          Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.005,
                              bottom: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: TextFormField(
                                initialValue: user.userLastName,
                                onChanged: (value) => user.userLastName = value,
                                validator: validateLastName,
                                decoration: InputDecoration(
                                  hintText: user.userLastName,
                                ),
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
                      initialValue: user.userEmail,
                      onChanged: (value) => user.userEmail = value,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        hintText: user.userEmail,
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
                      value: user.tipo,
                      onChanged: (value) => user.tipo = value!,
                      items: cargoOptions.map((cargo) {
                        return DropdownMenuItem<String>(
                          value: cargo,
                          child: Text(cargo),
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
                      initialValue: user.rut,
                      onChanged: (value) => user.rut = value,
                      validator: validateRut,
                      decoration: InputDecoration(
                        hintText: user.rut,
                      ),
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
                      initialValue: user.direccion,
                      onChanged: (value) => user.direccion = value,
                      validator: validateEmpty,
                      decoration: InputDecoration(
                        hintText: user.direccion,
                      ),
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
                      initialValue: user.ntelefono.toString(),
                      onChanged: (value) => user.ntelefono = value,
                      validator: validatePhoneNumber,
                      decoration: InputDecoration(
                        hintText: user.ntelefono.toString(),
                      ),
                    ),
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
                      initialValue: user.nemergencia.toString(),
                      onChanged: (value) => user.nemergencia = value,
                      validator: validatePhoneNumber,
                      decoration: InputDecoration(
                        hintText: user.nemergencia.toString(),
                      ),
                    ),
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
                      initialValue: user.local,
                      onChanged: (value) => user.local = value,
                      validator: validateEmpty,
                      decoration: InputDecoration(
                        hintText: user.local,
                      ),
                    ),
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
                      onPressed: () async {
                        await usersService.updateUsers(user);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UsersViewList()),
                        );
                      },
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
