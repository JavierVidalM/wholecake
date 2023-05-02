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
  final String _baseUrl = 'migueslaxl';
  final String _user = 'kissisl0ve';
  final String _pass = '3.85.128.77:8000';
  List<Listado> userslist = []; //cargaremos el listado de productos
  Listado? selectedUser; //cargaremos el producto seleccionado
  bool isLoading = true;
  bool isEditCreate = true;
  UserService() {
    loadUsers();
  }

  
  Future loadUsers() async {
    isLoading = true;
    notifyListeners();
    final url = Uri.http(
      _baseUrl,
      'accounts/user_user_list_rest/',
    );
    String basicAuth = 'Basic' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final UsersMap = Users.fromJson(response.body);
    userslist = UsersMap.userslist;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Listado users) async {
    isEditCreate = true;
    notifyListeners();
    if (users.userId == null) {
    } else {
      await this.UpdateUsers(users);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future UpdateUsers(Listado users) async {
    isEditCreate = true;
    notifyListeners();
    if (users.userId == null) {
      //creamos
    } else {
      await this.UpdateUsers(users);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future<String> userUpdate(Listado users) async {
    final url = Uri.http(
      _baseUrl,
      'accounts/user_user_update_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: users.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);

    //actualizamos el listado
    final index =
        userslist.indexWhere((element) => element.userId == users.userId);
    userslist[index] = users;

    return '';
  }

  UsersAdd(String msg) async {
    final url = Uri.http(
      _baseUrl,
      'accounts/user_user_update_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
  }

  UsersDelete(String msg) async {
    final url = Uri.http(
      _baseUrl,
      'accounts/user_user_update_rest/',
    );
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$_user:$_pass'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
  }
}
