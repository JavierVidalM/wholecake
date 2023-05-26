import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/supplies.dart';

class SuppliesService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
  String BASEURL = '3.85.128.77:8000';

  List<SuppliesList> suppliesList = [];
  SuppliesList? selectedSupplies;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  SuppliesService() {
    loadSupplies();
  }

//INSUMOS
  Future<void> loadSupplies() async {
    isLoading = true;
    notifyListeners();

    var url = Uri.http(BASEURL, 'supplies/supplies_list_rest');
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));

    final response = await http.get(url, headers: {'authorization': basicAuth});
    if (response.statusCode == 200) {
      final suppliesMap = Supplies.fromJson(response.body);
      suppliesList = suppliesMap.suppliesList;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> listSuppliescorrecto() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'supplies/supplies_list_rest_estadocorrecto',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final suppliesMap = Supplies.fromJson(response.body);
    suppliesList = suppliesMap.suppliesList;
    isLoading = false;
    notifyListeners();
  }

  Future<void> listSuppliesprogreso() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'supplies/supplies_list_rest_estadoprogreso',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final suppliesMap = Supplies.fromJson(response.body);
    suppliesList = suppliesMap.suppliesList;
    isLoading = false;
    notifyListeners();
  }

  Future<String> updateSupplies(SuppliesList supplies) async {
    final url = Uri.http(
      BASEURL,
      'supplies/supplies_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: supplies.toJson(), headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    return '';
  }

  deleteSupplies(String msg) async {
    final url = Uri.http(
      BASEURL,
      'supplies/supplies_delete_rest/',
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
