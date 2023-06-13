import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/users.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

//test@gmail.com
class UserService extends ChangeNotifier {
  String APIUSER = 'test@gmail.com';
  String APIPASS = 'test01';
  String BASEURL = '3.85.128.77:8000';

  List<Listado> listadousers = [];
  List<Listado> userlogeado = [];
  Listado? selectedUser;
  bool isLoading = true;
  bool isEditCreate = true;
  String typeuser = '';
  String authtoken = '';
  String _name = '';
  String _email = '';
  String _cargo = '';
  String _img = '';
  String _direccion = '';
  String _local = '';
  String _ntelefono = '';
  int userId = 0;

  String get name => _name;
  String get email => _email;
  String get cargo => _cargo;
  String get img => _img;
  String get direccion => _direccion;
  String get local => _local;
  String get ntelefono => _ntelefono;

  bool autenticado = false;

  UserService() {
    loadUsers();
  }

  bool isLoggedIn() {
    return autenticado;
  }

  Future<bool> login(String email, String password) async {
    if (email == null || password == null) return false;
    var url = Uri.http(
      BASEURL,
      'accounts/api/login/',
    );

    Map<String, String> body = {
      'email': email,
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
        final responseData = json.decode(response.body);

        if (responseData['email'] != email) {
          return false; // El correo electrónico es incorrecto
        }

        _name = responseData['username'];
        _email = responseData['email'];
        _cargo = responseData['tipo'];
        _img = responseData['imagen_user'];
        _direccion = responseData['direccion'];
        _local = responseData['local'];
        _ntelefono = responseData['ntelefono'];
        userId = responseData['id'];

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
      final usersMap = Users.fromJson(response.body);
      listadousers = usersMap.userslist;

      isLoading = false;
      notifyListeners();
    } else {}
  }

  resetPassword(String email) async {
    notifyListeners();
    // Construir la URL del endpoint de listado de usuarios
    var url = Uri.http(
      BASEURL,
      'accounts/reset_password/',
    );

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(
      url,
      body: email,
      headers: {
        'Content-Type': 'application/json',
        'authorization': basicAuth,
      },
    );
  }

  resetPasswordConfirm(String datos) async {
    notifyListeners();
    // Construir la URL del endpoint de listado de usuarios
    var url = Uri.http(
      BASEURL,
      'accounts/reset_password_confirm/',
    );

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(
      url,
      body: datos,
      headers: {
        'Content-Type': 'application/json',
        'authorization': basicAuth,
      },
    );
  }

  Future<String> updateUsers(Listado user) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'accounts/user_user_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: user.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    return '';
  }

  Future addUsers(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'accounts/user_user_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;

    // notifyListeners();
    isEditCreate = false;
  }

  deleteUser(String msg) async {
    final url = Uri.http(
      BASEURL,
      'accounts/user_user_delete_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
  }

  Future addUsersadmin(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'accounts/user_admin_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    // notifyListeners();

    isEditCreate = false;
  }
}
