import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ventas.dart';

class VentasService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
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
    // notifyListeners();
    isEditCreate = false;
  }

  // Future<String> updateSupplier(ListSup supplier) async {
  //   final url = Uri.http(
  //     BASEURL,
  //     'suppliers/suppliers_suppliers_update_rest/',
  //   );
  //   String basicAuth =
  //       'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
  //   final response = await http.post(url, body: supplier.toJson(), headers: {
  //     'authorization': basicAuth,
  //     'Content-Type': 'application/json; charset=UTF-8',
  //   });
  //   final decodeResp = response.body;
  //   //actualizamos el listado
  //   // final index = listadoproductos
  //   //     .indexWhere((element) => element.productoId == product.productoId);
  //   // listadoproductos[index] = product;
  //   return '';
  // }

  deleteSupplier(String msg) async {
    final url = Uri.http(
      BASEURL,
      'suppliers/suppliers_suppliers_delete_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
  }
}
