// ignore_for_file: prefer_interpolation_to_compose_strings, unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ordendetrabajo.dart';

class OrdenTrabajoService extends ChangeNotifier {
  String APIUSER = 'test';
  String APIPASS = 'test01';
  String BASEURL = '3.85.128.77:8000';
  List<ListTrabajo> listaTrabajos = [];
  ListTrabajo? selectedordenTrabajo;

  bool isLoading = true;
  bool isEditCreate = true;
  OrdenTrabajoService() {
    loadOrdenTrabajo();
  }
  loadOrdenTrabajo() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'ordentrabajo/ordentrabajo_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final ordenMap = OrdenTrabajo.fromJson(response.body);
    listaTrabajos = ordenMap.listTrabajos;
    isLoading = false;
    notifyListeners();
  }

  Future addOrdenTrabajo(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'ordentrabajo/ordentrabajo_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    // final ListTrabajo odt = ListTrabajo.fromJson(decodeResp);
    // listaTrabajos.add(odt);
    notifyListeners();
    isEditCreate = false;
  }

  Future<String> updateTrabajo(String msg) async {
    final url = Uri.http(
      BASEURL,
      'ordentrabajo/ordentrabajo_edit_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    // print(response.body);
    //actualizamos el listado
    // final index = listadoproductos
    //     .indexWhere((element) => element.productoId == product.productoId);
    // listadoproductos[index] = product;
    return '';
  }

  // deleteOrdenCompra(String msg) async {
  //   final url = Uri.http(
  //     BASEURL,
  //     'ordendc/ordendc_ordendc_delete_rest/',
  //   );
  //   String basicAuth =
  //       'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
  //   final response = await http.post(url, body: msg, headers: {
  //     'authorization': basicAuth,
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   });
  //   final decodeResp = response.body;
  // }
}
