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

  List<Listado> listadousers = [];
  List<Listado> userlogeado = [];
  bool isLoading = true;
  bool isEditCreate = true;
  String typeuser = '';
  String authtoken = '';
  String _name = 'a';
  String _cargo = '';
  String get name => _name;
  String get cargo => _cargo;
  bool autenticado = false;

  UserService() {
    loadUsers();
  }

  bool isLoggedIn() {
    return autenticado;
  }

  Future<bool> login(String username, String password) async {
    var url = Uri.http(
      BASEURL,
      'accounts/api/login/',
    );

    Map<String, String> body = {
      'username': username,
      'password': password,
    };

    return http
        .post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(body),
    )
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        final responseData = json.decode(response.body);
        _name = responseData['username'];
        _cargo = responseData['tipo'];
        notifyListeners();
        return true;
      } else {
        return false;
      }
    });
  }

  loadUsers() async {
    notifyListeners();
    // Construir la URL del endpoint de listado de usuarios
    var url = Uri.http(
      BASEURL,
      'accounts/user_user_list_rest/',
    );

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': basicAuth,
      },
    );
    if (response.statusCode == 200) {
      // Obtener los datos de la respuesta en formato JSON
      final responseData = json.decode(response.body);

      isLoading = false;
      notifyListeners();
    } else {
      print('cago el userlist');
    }
  }
}
