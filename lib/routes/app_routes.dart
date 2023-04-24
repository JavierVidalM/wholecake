import 'package:flutter/material.dart';
import 'package:wholecake/views/views.dart';

class AppRoutes {
  static const initialRoute = 'LoginMain';

  static Map<String, Widget Function(BuildContext)> routes = {
    //Pantallas del Login
    'LoginMain': (dynamic context) => const LoginMain(),
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

    'ProvidersAdd': (BuildContext context) => const SupppliersAdd(),
    'ProvidersView': (BuildContext context) => const SupppliersView(),
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
