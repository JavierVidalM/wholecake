import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:wholecake/views/proveedores/suppliers.dart';
import 'package:wholecake/views/ventas/sells.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/views/utilidades/utilidades.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/insumos/insumos.dart';

class AppRoutes {
  static const initialRoute = '/';

  static Map<String, Widget Function(BuildContext)> routes = {
    //Pantallas del Login
    '/': (BuildContext context) => const LoginMain(),
    '/LoginUser': (BuildContext context) => const LoginUser(),
    // '/SigninUser': (BuildContext context) => const SigninUser(),

    //Pantalla de inicio
    '/HomePage': (BuildContext context) => const HomePage(),

    '/Inventory': (BuildContext context) => Inventory(),
    '/Inputs': (BuildContext context) => const ListadoInsumos(),
    '/ToExpire': (BuildContext context) => const ToExpire(),

    //Pantallas de producto
    '/ProductsView': (BuildContext context) => const ProductsView(),
    '/ProductsAdd': (BuildContext context) => const ProductsAdd(),
    // '/ProductsEdit': (BuildContext context) => ProductsEdit(),
    '/CategoryList': (BuildContext context) => const CategoryView(),

    // '/SuppliersAdd': (BuildContext context) => const SuppliersAdd(),
    '/SuppliersView': (BuildContext context) => const SuppliersView(),
    '/InputsRecipt': (BuildContext context) => InputsReciptSupplies(),
    '/PurchaseOrders': (BuildContext context) => PurchaseOrders(),
    '/PurchaseList': (BuildContext context) => PurchaseList(),

    //Pantallas de ventas
    '/SellsView': (BuildContext context) => SellsView(),
    '/SellsDetail': (BuildContext context) => SellsDetail(),

    //Pantalla de users
    // '/UsersList': (BuildContext context) => const UsersList(),
    // '/UsersAdd': (BuildContext context) => const UsersAdd(),
    '/UsersEdit': (BuildContext context) => const UsersEdit(),
    //Pantalla de error
    '/Error': (BuildContext context) => const ErrorPage(),
    //Pantalla de carga
    '/LoadingScreen': (BuildContext context) => const LoadingScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}
