import 'package:flutter/material.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/routes/app_routes.dart';
import 'package:wholecake/views/products/products.dart';

// var myDefaultBackground = Color.fromARGB(255, 189, 224, 254);

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 196, 228),
      child: Column(children: [
        DrawerHeader(child: Icon(Icons.favorite)),

        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Inicio'),
          ),
        ),
        // ListTile(
        //   leading: Icon(Icons.home_outlined),
        //   title: Text('Inicio'),
        // ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Inventario'),
        ),
        ListTile(
          leading: Icon(Icons.check_box),
          title: Text('Recepcion  de  Insumos'),
        ),
        ListTile(
          leading: Icon(Icons.report),
          title: Text('Pronta Caducacion'),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProductsView()));
          },
          child: ListTile(
            leading: Icon(Icons.breakfast_dining),
            title: Text('Productos'),
          ),
        ),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Proveedores'),
        ),
        ListTile(
          leading: Icon(Icons.phone_android_rounded),
          title: Text('Modulo de Ventas'),
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
        ),
      ]),
    );
  }
}
