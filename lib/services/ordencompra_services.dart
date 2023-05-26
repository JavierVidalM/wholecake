import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ordendecompra.dart';

class OrdencompraService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
  String BASEURL = '3.85.128.77:8000';
  List<ListOdc> listaOrdenes = [];
  ListOdc? selectedOdc;

  bool isLoading = true;
  bool isEditCreate = true;

//constructor
  OrdencompraService() {
    loadOrdenCompra();
  }

  //ordendecompra
  loadOrdenCompra() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'ordendc/ordendc_ordendc_list_rest',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final ordenMap = OrdenDeCompa.fromJson(response.body);
    listaOrdenes = ordenMap.listOdc;
    isLoading = false;
    notifyListeners();
  }

  Future addOrdenCompra(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'ordendc/ordendc_ordendc_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    final ListOdc odc = ListOdc.fromJson(decodeResp);
    listaOrdenes.add(odc);
    isEditCreate = false;
  }

  Future<String> updateOrdenCompra(ListOdc odc) async {
    final url = Uri.http(
      BASEURL,
      'ordendc/ordendc_ordendc_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: odc.toJson(), headers: {
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

  deleteOrdenCompra(String msg) async {
    final url = Uri.http(
      BASEURL,
      'ordendc/ordendc_ordendc_delete_rest/',
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
