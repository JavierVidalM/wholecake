// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:wholecake/models/users.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:provider/provider.dart';

class UsersViewList extends StatefulWidget {
  const UsersViewList({Key? key}) : super(key: key);

  @override
  _UsersViewListState createState() => _UsersViewListState();
}

Future<void> _refresh() async {
  await UserService().loadUsers();
}

class _UsersViewListState extends State<UsersViewList> {
  List selectedUser = [];
  String? _cargoSeleccionado;
  List<String> cargoOptions = ['Cajero', 'Pastelero', 'Admin'];

  Future<String?> filterPopup() => showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Filtro"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: const Text("Cargo"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Selecciona una cargo'),
                            value: _cargoSeleccionado,
                            onChanged: (String? nuevoCargo) {
                              setState(() {
                                _cargoSeleccionado = nuevoCargo;
                              });
                            },
                            items: ['Cajero', 'Pastelero', 'Admin']
                                .map((categoria) {
                              return DropdownMenuItem<String>(
                                value: categoria,
                                child: Text(categoria),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _cargoSeleccionado = null;
                            clearFilter();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.filter_alt_off_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            updateCargoUsers();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Filtrar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

  void updateCargoUsers() {
    selectedUser.clear();
    if (_cargoSeleccionado != null) {
      selectedUser.add(_cargoSeleccionado!);
    }
    setState(() {});
  }

  void clearFilter() {
    selectedUser.clear();
    setState(() {});
  }

  Future<void> deletePopup(int userId, List<Listado> list) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            const Text("¿Estás seguro de que deseas eliminar a este usuario?"),
        content:
            const Text("Esta acción no se puede deshacer una vez completada"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              "Cancelar",
              style: TextStyle(fontSize: 18),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final msg = jsonEncode({'id': userId});

              await UserService().deleteUser(msg);
              setState(() {
                list.removeWhere((users) => users.userId == userId);
              });
            },
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cargandoPantalla() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Diálogo sin cierre por el usuario"),
        content: const Text("Este diálogo no se puede cerrar por el usuario."),
        actions: [
          TextButton(
            onPressed: () {
              // Acción del botón
              Navigator.of(context).pop();
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<UserService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    return ChangeNotifierProvider(
      create: (_) => UserService(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          ),
          title: Text(
            'Listado de usuarios',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        body: Consumer<UserService>(
          builder: (context, listado, child) {
            final filterUser = listado.listadousers.where((user) {
              return selectedUser.isEmpty || selectedUser.contains(user.tipo);
            }).toList();
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          filterPopup();
                        },
                        icon: const Icon(Icons.filter_alt_outlined),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text('Buscar'),
                                  onTap: () {
                                    showSearch(
                                      context: context,
                                      delegate:
                                          UserSearch(listadoView.listadousers),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showSearch(
                                    context: context,
                                    delegate:
                                        UserSearch(listadoView.listadousers),
                                  );
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UsersAddPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Divider(height: MediaQuery.of(context).size.height * 0.005),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: filterUser.length,
                      itemBuilder: (context, index) {
                        final users = filterUser[index];
                        Uint8List bytes =
                            Uint8List.fromList(base64Decode(users.imagen_user));
                        Image image = Image.memory(bytes, fit: BoxFit.cover);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.03,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: image.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              users.userName,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  listadoView.selectedUser =
                                                      listado
                                                          .listadousers[index]
                                                          .copy();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          UsersEdit(
                                                        userId: users.userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  deletePopup(users.userId,
                                                      listado.listadousers);
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Nombre ${users.userName.toString().padRight(10)}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Correo ${users.userEmail.toString().padRight(10)}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Cargo ${users.tipo.toString().padRight(10)}'),
                                      const SizedBox(height: 10),
                                      Text(
                                          'Número telefono ${users.ntelefono.toString().padRight(10)}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
