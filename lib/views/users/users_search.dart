import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/users.dart';
import 'package:wholecake/services/services.dart';
import 'package:wholecake/services/suppliers_services.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:wholecake/views/users/users.dart';

class UserSearch extends SearchDelegate<Listado> {
  late final List<Listado> usr;

  UserSearch(this.usr);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close_rounded),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(
            context,
            Listado(
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
              imagen_user: '',
            ),
          );
        },
        icon: const Icon(Icons.arrow_back_ios_new_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    final listadoView = Provider.of<UserService>(context);
    final List<Listado> searchUsers = listadoView.listadousers;
    List<Listado> matchQuery = [];
    for (var user in searchUsers) {
      if (user.userFirstName.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
          user.userLastName.toLowerCase().contains(
                query.toLowerCase(),
              )) {
        matchQuery.add(user);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_user),
        );
        Image image = Image.memory(
          bytes,
          fit: BoxFit.cover,
        );
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text('${result.userFirstName} ${result.userLastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Cargo: ${result.tipo}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersEdit(
                      userId: result.userId,
                    ),
                  ),
                );
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final listadoView = Provider.of<UserService>(context);
    final List<Listado> searchUsers = listadoView.listadousers;
    List<Listado> matchQuery = [];
    for (var user in searchUsers) {
      if (user.userFirstName.toLowerCase().contains(
                query.toLowerCase(),
              ) ||
          user.userLastName.toLowerCase().contains(
                query.toLowerCase(),
              )) {
        matchQuery.add(user);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        Uint8List bytes = Uint8List.fromList(
          base64.decode(result.imagen_user),
        );
        Image image = Image.memory(
          bytes,
          fit: BoxFit.cover,
        );
        return Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.015,
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              leading: SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: image,
                ),
              ),
              title: Text('${result.userFirstName} ${result.userLastName}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'Cargo: ${result.tipo}',
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              onTap: () {
                print(result.userId);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UsersEdit(
                      userId: result.userId,
                    ),
                  ),
                );
              },
            ),
            const Divider(
              height: 1,
            ),
          ],
        );
      },
    );
  }
}
