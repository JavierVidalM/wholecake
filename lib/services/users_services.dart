import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/users.dart';

// 'accounts/user_user_add_rest/'
// 'accounts/user_user_list_rest/'
// 'accounts/user_user_update_rest/'
// 'accounts/user_user_delete_rest/'
// 'accounts/user_user_add_rest/'

class UserService extends ChangeNotifier {
  String APIUSER = 'niko';
  String APIPASS = 'nicolas15';
  String BASEURL = '192.168.1.10:8000';

  bool isLoading = true;
  bool isEditCreate = true;
  String typeuser = '';
  String authtoken = '';
  String _name='a';
  String get name => _name;

  Future<bool> login(String username, String password) async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'accounts/api/login/',
    );

    Map<String, String> body = {
      'username': username,
      'password': password,
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      authtoken = responseData['token'];
      _name = responseData['username'];
      typeuser = responseData['tipo'];

      isLoading = false;
      notifyListeners();
      loadUsers();
      return true;
    } else {
      return false;
    }
  }

  loadUsers() async {
    // Construir la URL del endpoint de listado de usuarios
    var url = Uri.http(
      BASEURL,
      'accounts/user_user_list_rest/',
    );

    try {
      // Realizar la solicitud GET para obtener el listado de usuarios
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $authtoken',
          // Agrega cualquier encabezado de autenticación requerido, como el token de acceso
        },
      );
      if (response.statusCode == 200) {
        // Obtener los datos de la respuesta en formato JSON
        final responseData = json.decode(response.body);

        // Procesar los datos de respuesta según tus necesidades
        // Por ejemplo, crear objetos Listado y agregarlos a la lista userslist

        isLoading = false;
        notifyListeners();
      } else {
        // Manejar el error de solicitud según corresponda
      }
    } catch (error) {
      // Manejar el error de conexión o cualquier otra excepción
    }
  }
}
