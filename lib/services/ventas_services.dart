import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ventas.dart';

class VentasService extends ChangeNotifier {
  String APIUSER = 'test';
  String APIPASS = 'test01';
  String BASEURL = '3.85.128.77:8000';
  List<Listventa> listadoventas = [];

  Listventa? selectedVenta;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  VentasService() {
    loadVentas();
  }

  loadVentas() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'ventas/ventas_ventas_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final suppliersMap = Ventas.fromJson(response.body);
    listadoventas = suppliersMap.listventas;
    isLoading = false;
    notifyListeners();
  }

  Future addVentas(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'ventas/ventas_ventas_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    notifyListeners();
    isEditCreate = false;
  }
  deleteVentas(String msg) async {
    final url = Uri.http(
      BASEURL,
      'ventas/ventas_ventas_delete_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    notifyListeners();
  }
}
