import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/models/suppliers.dart';

class ProductService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
  String BASEURL = '3.85.128.77:8000';
  List<Listado> listadoproductos = [];
  List<ListElement> listadocategorias = [];
  List<ListSup> listadosuppliers = [];

  Listado? selectedProduct;
  ListElement? selectedCategory;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  ProductService() {
    loadProductos();
    loadCategorias();
    loadSuppliers();
  }

  loadProductos() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'productos/productos_productos_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final ProductosMap = Productos.fromJson(response.body);
    listadoproductos = ProductosMap.listado;
    isLoading = false;
    notifyListeners();
  }

  Future editOrCreateProduct(Listado product) async {
    isEditCreate = true;
    notifyListeners();
    if (product.productoId == null) {
    } else {
      await this.updateProduct(product);
    }

    isEditCreate = false;
    notifyListeners();
  }

  Future addProducto(String msg) async {
    notifyListeners();
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
    final Listado producto = Listado.fromJson(decodeResp);
    listadoproductos.add(producto);
    // notifyListeners();
    await loadProductos(); //
    isEditCreate = false;
  }

  Future<String> updateProduct(Listado product) async {
    final url = Uri.http(
      BASEURL,
      'productos/productos_productos_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: product.toJson(), headers: {
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
  }

  loadCategorias() async {
    isLoading = true;
    notifyListeners();
    var url = Uri.http(
      BASEURL,
      'productos/productos_categoria_list_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.get(url, headers: {'authorization': basicAuth});
    final categoriasMap = Categorias.fromJson(response.body);
    listadocategorias = categoriasMap.list;
    isLoading = false;
    notifyListeners();
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
    await loadProductos(); //
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
