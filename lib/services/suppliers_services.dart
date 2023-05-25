import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/models/supplies.dart';

class SuppliersService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
  String BASEURL = '3.85.128.77:8000';
  List<ListSup> listadosuppliers = [];

  ListSup? selectedSupplier;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  SuppliersService() {
    loadSuppliers();
  }

  loadSuppliers() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'suppliers/suppliers_suppliers_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final suppliersMap = Suppliers.fromJson(response.body);

    listadosuppliers = suppliersMap.listSup;
    isLoading = false;
    notifyListeners();
  }

  Future addSupplier(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'suppliers/suppliers_suppliers_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    final ListSup supplier = ListSup.fromJson(decodeResp);
    listadosuppliers.add(supplier);
    // notifyListeners();
    isEditCreate = false;
  }

  Future<String> updateSupplier(ListSup supplier) async {
    final url = Uri.http(
      BASEURL,
      'suppliers/suppliers_suppliers_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: supplier.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    //actualizamos el listado
    // final index = listadoproductos
    //     .indexWhere((element) => element.productoId == product.productoId);
    // listadoproductos[index] = product;
    return '';
  }

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
