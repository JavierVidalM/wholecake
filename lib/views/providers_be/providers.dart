import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ejemplos_pasteles_list_response.dart';

class Proveedores extends ChangeNotifier {
  String APIUSER = 'niko';
  String APIPASS = 'nicolas15';
  String BASEURL = '192.168.1.7:8000';
  List<Pastele> ListadoPastelesDisplay = [];
//constructor
  Proveedores() {
    print("Proveedor inicializado");
    getListEjemplos();
  }

  getListEjemplos() async {
    var url = Uri.http(
      BASEURL,
      'productos/productos_productos_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    print('a');
    final response = await http.get(url, headers: {'authorization': basicAuth});
    print('b');
    final ejemplosPastelesListResponse =
        EjemplosPastelesListResponse.fromJson(response.body);
    ListadoPastelesDisplay = ejemplosPastelesListResponse.pasteles;
    notifyListeners();
  }
}
