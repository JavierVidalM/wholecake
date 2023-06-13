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

class UsersEdit extends StatefulWidget {
  final int userId;
  const UsersEdit({Key? key, required this.userId}) : super(key: key);

  @override
  _UsersEditState createState() => _UsersEditState();
}

class _UsersEditState extends State<UsersEdit> {
  List<String> cargoOptions = ['Cajero', 'Pastelero', 'Admin', 'cajero'];
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
          'Editar producto',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: InkWell(
                    onTap: seleccionarImagen,
                    child: Container(
                      width: 80.0,
                      height: 80.0,
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
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Nombre(s)'),
                    TextFormField(
                      initialValue: user.userFirstName,
                      onChanged: (value) => user.userFirstName = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el nombre(s) del usuario.';
                        }
                        final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                        if (!nameRegExp.hasMatch(value)) {
                          return 'El nombre no debe contener números ni símbolos.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Nombre(s) del usuario',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Apellido(s)'),
                    TextFormField(
                      initialValue: user.userLastName,
                      onChanged: (value) => user.userLastName = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el Apellido(s) del usuario.';
                        }
                        final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
                        if (!nameRegExp.hasMatch(value)) {
                          return 'El nombre no debe contener números ni símbolos.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Apellido(s) del usuario',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Correo'),
                    TextFormField(
                      initialValue: user.userEmail,
                      onChanged: (value) => user.userEmail = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese una dirección de correo electrónico';
                        }

                        final emailRegExp = RegExp(
                            r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Por favor ingrese un correo válido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Correo del usuario',
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Cargo'),
                    DropdownButtonFormField<String>(
                      value: user.tipo,
                      onChanged: (value) => user.tipo = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, seleccione el cargo del empleado.';
                        }
                        return null;
                      },
                      items: cargoOptions.map((cargo) {
                        return DropdownMenuItem<String>(
                          value: cargo,
                          child: Text(cargo),
                        );
                      }).toList(),
                      decoration: const InputDecoration(
                        hintText: 'Cargo',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('RUT'),
                    TextFormField(
                      initialValue: user.rut,
                      onChanged: (value) => user.rut = value,
                      validator: (value) {
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
                      },
                      decoration: const InputDecoration(
                        hintText: 'RUT',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Dirección particular'),
                    TextFormField(
                      initialValue: user.direccion,
                      onChanged: (value) => user.direccion = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese la dirección del empleado.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Dirección',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Número de telefono'),
                    TextFormField(
                      initialValue: user.ntelefono.toString(),
                      onChanged: (value) => user.ntelefono = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el número de teléfono.';
                        }
                        final phoneRegExp = RegExp(r'^[+]?[0-9]{10,13}$');
                        if (!phoneRegExp.hasMatch(value)) {
                          return 'El número de teléfono no es válido.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Número de teléfono',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Número de emergencia'),
                    TextFormField(
                      initialValue: user.nemergencia.toString(),
                      onChanged: (value) => user.nemergencia = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el número de teléfono de emergencia.';
                        }
                        final phoneRegExp = RegExp(r'^[+]?[0-9]{10,13}$');
                        if (!phoneRegExp.hasMatch(value)) {
                          return 'El número de teléfono no es válido.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Número de teléfono',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Local'),
                    TextFormField(
                      initialValue: user.local,
                      onChanged: (value) => user.local = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingrese el local del empleado.';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Local',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                      child: const Text('Volver'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
