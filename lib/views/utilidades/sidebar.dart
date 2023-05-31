import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/insumos/insumos.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:wholecake/views/proveedores/suppliers.dart';
import 'package:wholecake/views/users/user_profile_view.dart';
import 'package:wholecake/views/utilidades/utilidades.dart';
import 'package:wholecake/views/ventas/sells.dart';
import '../../services/users_services.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  // final name = 'ola';
  // String getUserinfo(BuildContext context) {
  //   final userService = Provider.of<UserService>(context, listen: true);
  //   final name = userService.name;
  //   final cargo = userService.cargo;
  //   return name;
  // }

  String getProductCount(BuildContext context) {
    final productService = Provider.of<ProductService>(context, listen: false);
    final productCount = productService.listadoproductos.length;
    return productCount.toString();
  }

  Future<void> logoutPopup(BuildContext context, user) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Estás a punto de cerrar sesión",
              style: TextStyle(color: SweetCakeTheme.pink3),
            ),
            content: Text("¿Estás seguro de que quieres cerrar la sesión?"),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancelar",
                        style: TextStyle(color: SweetCakeTheme.warning),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // user.logout();
                        // Navigator.pushNamed(context, '/LoginUser');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginUser()));
                      },
                      child: const Text(
                        "Aceptar",
                        style: TextStyle(color: SweetCakeTheme.blue2),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: SweetCakeTheme.sidebarTheme,
        child: Drawer(
          child: Consumer<UserService>(
            builder: (context, user, _) {
              Uint8List bytes = Uint8List.fromList(base64.decode(user.img));
              Image image = Image.memory(bytes);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const UserProfileView(),
                            ),
                          );
                          // Navigator.pushNamed(context, '/UserProfileView');
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                          child: DrawerHeader(
                            padding: EdgeInsets.zero,
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            width: 90,
                                            height: 90,
                                            margin: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                image: image.image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          // child: SizedBox(
                                          //   width: 90,
                                          //   height: 90,
                                          //   child: ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(100),
                                          //       child: Image(image: image),
                                          //     // child: Image.network(
                                          //     //   'https://img1.ak.crunchyroll.com/i/spire4/5b954f7af990b40acc4f3f410a3a5f9d1664298859_large.jpg',
                                          //     ),
                                          //   ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              "Bienvenido",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                bottom: 8.0,
                                                right: 25.0),
                                            child: Flexible(
                                              child: Text(
                                                user.name,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 30,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                          leading: const Icon(Icons.home_outlined),
                          title: const Text("Inicio"),
                          onTap: () =>
                              // Navigator.pushNamed(context, '/HomePage'),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()))),
                      ListTile(
                        leading: const Icon(Icons.person_outline_rounded),
                        title: const Text("Usuarios"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ErrorPage(),
                            ),
                          );
                        },
                      ),
                      ListTile(
                          leading: const Icon(Icons.inventory_rounded),
                          title: const Text("Ordenes de compra"),
                          onTap: () =>
                              // Navigator.pushNamed(context, '/PurchaseList'),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PurchaseList()))),
                      ExpansionTile(
                        leading: const Icon(Icons.inventory_2_outlined),
                        title: const Text("Inventario"),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: ListTile(
                                leading: const Icon(Icons.input_rounded),
                                title: const Text("Insumos"),
                                onTap: () =>
                                    // Navigator.pushNamed(context, '/ListadoInsumos'),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ListadoInsumos()))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: ListTile(
                                leading: const Icon(
                                    Icons.report_gmailerrorred_rounded),
                                title: const Text("Por Expirar"),
                                onTap: () =>
                                    // Navigator.pushNamed(context, '/ToExpire'),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ToExpire()))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: ListTile(
                              leading: const Icon(Icons.cake_outlined),
                              title: const Text("Productos"),
                              onTap: () =>
                                  // Navigator.pushNamed(context, '/ProductsView'),
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductsView())),
                              trailing: ClipOval(
                                child: Container(
                                    color: const Color(0xFFF95959),
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: Text(
                                        getProductCount(context),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            indent: 15,
                            endIndent: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 45),
                            child: ListTile(
                                leading: const Icon(Icons.category_outlined),
                                title: const Text("Categorías"),
                                onTap: () =>
                                    // Navigator.pushNamed(context, '/CategoryList'),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CategoryView()))),
                          ),
                        ],
                      ),
                      ListTile(
                          leading: const Icon(Icons.local_shipping_outlined),
                          title: const Text("Proveedores"),
                          onTap: () =>
                              // Navigator.pushNamed(context, '/SuppliersView'),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SuppliersView()))),
                      if (user.cargo == 'cajero')
                        ExpansionTile(
                          leading: const Icon(Icons.point_of_sale),
                          title: const Text("Módulo de ventas"),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: ListTile(
                                  leading: const Icon(
                                      Icons.add_shopping_cart_rounded),
                                  title: const Text("Generar Ventas"),
                                  onTap: () =>
                                      // Navigator.pushNamed(context, '/ListadoInsumos'),
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SellsAdd()))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 25),
                              child: ListTile(
                                leading: const Icon(Icons.checklist_rounded),
                                title: const Text("Listado de ventas"),
                                onTap: () =>
                                    // Navigator.pushNamed(context, '/ToExpire'),
                                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SellsView(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                          height: MediaQuery.of(context).size.height * 0.005),
                      ListTile(
                          leading: const Icon(Icons.logout),
                          title: const Text("Cerrar sesión"),
                          onTap: () {
                            logoutPopup(context, user);
                          }),
                    ],
                  ),
                ],
              );
            },
          ),
        ));
  }
}
