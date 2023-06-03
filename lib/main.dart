import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/ordencompra_services.dart';
import 'package:wholecake/services/ordentrabajo_services.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/routes/app_routes.dart';
import 'package:wholecake/services/suppliers_services.dart';
import 'package:wholecake/services/supplies_services.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/theme/theme.dart';

void main() {
  runApp(ProviderState());
}

class ProviderState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SuppliersService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => VentasService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => OrdencompraService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SuppliesService(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => OrdenTrabajoService(),
          lazy: false,
        ),
      ],
      child: const MyfirstWidget(),
    );
  }
}

class MyfirstWidget extends StatelessWidget {
  const MyfirstWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return const MaterialApp(
    //     debugShowCheckedModeBanner: false, home: ProductsView());

    return MaterialApp(
      theme: SweetCakeTheme.mainTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onGenerateRoute,
    );
  }
}
