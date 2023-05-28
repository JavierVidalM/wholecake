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
  String APIUSER = 'test';
  String APIPASS = 'test01';
  String BASEURL = '3.85.128.77:8000';

  bool isLoading = true;
  bool isEditCreate = true;
  String typeuser = '';
  String authtoken = '';
  String _name = 'a';
  String get name => _name;
  bool autenticado = false;

  set name(String value) {
    _name = value;
    print('ola${_name}');
    notifyListeners(); // Notificar a los widgets dependientes
  }

  bool isLoggedIn() {
    return autenticado;
  }

  Future<bool> login(String username, String password) async {
    _name = username;
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
    print("respuesta: ${response.body}");
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      authtoken = responseData['token'];
      _name = responseData['username'];
      typeuser = responseData['tipo'];
      autenticado = true;
      isLoading = false;
      loadUsers();
      notifyListeners();
      return true;
    } else {
      autenticado = false;
      return false;
    }
  }

  void logout() {
    // Restablecer la autenticación
    autenticado = false;
    authtoken = '';
    _name = 'no ai na';
    typeuser = '';

    // Resto de la lógica de cierre de sesión

    notifyListeners();
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
        print('nombre ${name}');
      } else {
        // Manejar el error de solicitud según corresponda
      }
    } catch (error) {
      // Manejar el error de conexión o cualquier otra excepción
    }
  }
}
