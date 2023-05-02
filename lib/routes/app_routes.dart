import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:wholecake/views/sells/sells.dart';
import 'package:wholecake/views/error.dart';
import 'package:wholecake/views/users/usersroutes.dart';

class AppRoutes {
  static const initialRoute = '/LoginMain';

  static Map<String, Widget Function(BuildContext)> routes = {
    //Pantallas del Login
    '/LoginMain': (context) => const LoginMain(),
    '/LoginUser': (context) => const LoginUser(),
    '/SigninUser': (context) => const SigninUser(),

    //Pantalla de inicio
    '/HomePage': (BuildContext context) => const HomePage(),

    '/Inventory': (BuildContext context) => Inventory(),
    '/Inputs': (BuildContext context) => const Supplies(),
    '/ToExpire': (BuildContext context) => ToExpire(),

    //Pantallas de producto
    '/ProductsView': (BuildContext context) => const ProductsView(),
    '/ProductsAdd': (BuildContext context) => const ProductsAdd(),
    '/ProductsEdit': (BuildContext context) => ProductsEdit(),

    '/SuppliersAdd': (BuildContext context) => SuppliersAdd(),
    '/SuppliersView': (BuildContext context) => SuppliersView(),
    '/InputsRecipt': (BuildContext context) => InputsRecipt(),
    '/PurchaseOrders': (BuildContext context) => PurchaseOrders(),
    '/PurchaseList': (BuildContext context) => PurchaseList(),

    //Pantallas de ventas
    '/SellsView': (BuildContext context) => SellsView(),
    '/SellsDetail': (BuildContext context) => SellsDetail(),

    //Pantalla de error
    '/Error': (BuildContext context) => const ErrorPage(),
    //Pantalla de users
    '/UsersList': (BuildContext context) => const UsersList(),
    '/UsersAdd': (BuildContext context) => const UsersAdd(),
    '/UsersEdit': (BuildContext context) => const UsersEdit(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}
