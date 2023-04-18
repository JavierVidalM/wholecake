import 'package:wholecake/views/pages.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'LoginMain';

  static Map<String, Widget Function(BuildContext)> routes = {
    //Pantallas del Login
    'LoginMain': (BuildContext context) => const LoginMain(),
    'LoginUser': (BuildContext context) => const LoginUser(),
    'SigninUser': (BuildContext context) => const SigninUser(),

    //Pantalla de inicio
    'MainPage': (BuildContext context) => const MainPage(),

    'Inventory': (BuildContext context) => const Inventory(),
    'Inputs': (BuildContext context) => const Supplies(),
    'ToExpire': (BuildContext context) => const ToExpire(),

    //Pantallas de producto
    'ProductsView': (BuildContext context) => const ProductsView(),
    'ProductsAdd': (BuildContext context) => const ProductsAdd(),
    'ProductsEdit': (BuildContext context) => const ProductsEdit(),

    'ProvidersAdd': (BuildContext context) => const ProvidersAdd(),
    'ProvidersView': (BuildContext context) => const ProvidersView(),
    'InputsRecipt': (BuildContext context) => const InputsRecipt(),
    'PurchaseOrders': (BuildContext context) => const PurchaseOrders(),
    'PurchaseList': (BuildContext context) => const PurchaseList(),

    //Pantallas de ventas
    'SellsView': (BuildContext context) => const SellsView(),
    'SellsDetail': (BuildContext context) => const SellsDetail(),

    //Pantalla de error
    'Error': (BuildContext context) => const ErrorPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const ErrorPage(),
    );
  }
}
