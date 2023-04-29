import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/productos.dart';

class ProductService extends ChangeNotifier {
  String APIUSER = 'migueslaxl';
  String APIPASS = 'kissisl0ve';
  String BASEURL = '3.85.128.77:8000';
  List<Listado> listadoproductos = [];
  Listado? selectedProduct;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  ProductService() {
    loadProductos();
  }

  loadProductos() async {
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'productos/productos_productos_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    print(response.body);
    final ProductosMap = Productos.fromJson(response.body);
    listadoproductos = ProductosMap.listado;
    notifyListeners();
  }

  // Future editOrCreateProduct(Listado product) async {
  //   print('aca toy');
  //   isEditCreate = true;
  //   notifyListeners();
  //   if (product.productoId == null) {
  //     await this.addProducto(product);
  //   } else {
  //     // await this.updateProduct(product);
  //   }

  //   isEditCreate = false;
  //   notifyListeners();
  // }

  addProducto(String msg) async {
    final url = Uri.http(
      BASEURL,
      'productos/productos_productos_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
  }

  deleteProducto(String msg) async {
        final url = Uri.http(
      BASEURL,
      'productos/productos_productos_delete_rest/',
    );
        String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
            final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    print(decodeResp);
    
  }
}
