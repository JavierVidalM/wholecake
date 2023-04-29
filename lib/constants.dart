import 'package:flutter/material.dart';

var myDefaultBackground = Color.fromARGB(255, 189, 224, 254);

var myDrawer = Drawer(
  backgroundColor: Color.fromARGB(255, 255, 196, 228),
  child: Column(children: [
    DrawerHeader(child: Icon(Icons.favorite)),
    ListTile(
      leading: Icon(Icons.home_outlined),
      title: Text('Inicio'),
    ),
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
    ListTile(
      leading: Icon(Icons.breakfast_dining),
      title: Text('Productos'),
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
