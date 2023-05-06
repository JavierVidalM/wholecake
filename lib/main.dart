import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/routes/app_routes.dart';
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
          create: (_) => ProductService(),
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
        theme: SweetCakeTheme.myTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.initialRoute,
        routes: AppRoutes.routes,
        onGenerateRoute: AppRoutes.onGenerateRoute);
  }
}
