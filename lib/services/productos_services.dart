import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wholecake/models/ordendecompra.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/models/supplies.dart';

class ProductService extends ChangeNotifier {
  String APIUSER = 'sweetcake';
  String APIPASS = 'pasteldetula';
  String BASEURL = '3.85.128.77:8000';
  List<Listado> listadoproductos = [];
  List<ListElement> listadocategorias = [];
  List<ListSup> listadosuppliers = [];
  List<ListOdc> listaOrdenes = [];
  List<SuppliesList> suppliesList = [];

  Listado? selectedProduct;
  ListElement? selectedCategory;
  ListSup? selectedSupplier;
  SuppliesList? selectedSupplies;
  bool isLoading = true;
  bool isEditCreate = true;
//constructor
  ProductService() {
    loadProductos();
    loadCategorias();
    loadOrdenCompra();
    loadSupplies();
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
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
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

  Future addCategoria(String msg) async {
    notifyListeners();
    final url = Uri.http(
      BASEURL,
      'productos/productos_categoria_add_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
    final ListElement categoria = ListElement.fromJson(decodeResp);
    listadocategorias.add(categoria);
    // notifyListeners();
    await loadProductos(); //
    isEditCreate = false;
  }

  Future<String> updateCategoria(ListElement categoria) async {
    final url = Uri.http(
      BASEURL,
      'productos/productos_categoria_update_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: categoria.toJson(), headers: {
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

  deleteCategoria(String msg) async {
    final url = Uri.http(
      BASEURL,
      'productos/productos_categoria_delete_rest/',
    );
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$APIUSER:$APIPASS'));
    final response = await http.post(url, body: msg, headers: {
      'authorization': basicAuth,
      'Content-Type': 'application/json; charset=UTF-8',
    });
    final decodeResp = response.body;
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
    // notifyListeners();
    await loadProductos(); //
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
