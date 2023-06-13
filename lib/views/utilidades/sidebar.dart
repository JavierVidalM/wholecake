import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/insumos/insumos.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/ordenes_trabajo/orden_view.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:wholecake/views/proveedores/suppliers.dart';
import 'package:wholecake/views/users/user_profile_view.dart';
import 'package:wholecake/views/ventas/sells.dart';
import '../../services/users_services.dart';
import '../users/users_list.dart';
import 'utilidades.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
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
          title: const Text(
            "Estás a punto de cerrar sesión",
            style: TextStyle(color: SweetCakeTheme.pink3),
          ),
          content: const Text("¿Estás seguro de que quieres cerrar la sesión?"),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginUser(),
                        ),
                      );
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(
                        color: SweetCakeTheme.blue2,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 90,
                                        height: 90,
                                        margin: const EdgeInsets.all(10),
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
                                              style:
                                                  const TextStyle(fontSize: 20),
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

                    //PANTALLA DE INICIO

                    ListTile(
                      leading: const Icon(Icons.home_outlined),
                      title: const Text("Inicio"),
                      onTap: () =>
                          // Navigator.pushNamed(context, '/HomePage'),
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      ),
                    ),

                    //PANTALLA LISTADO DE USUARIOS

                    ListTile(
                      leading: const Icon(Icons.person_outline_rounded),
                      title: const Text("Usuarios"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );

                        Future.delayed(
                          const Duration(
                            milliseconds: 2000,
                          ),
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UsersViewList(),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    //PANTALLA LISTA DE ORDENES DE COMPRA

                    ListTile(
                      leading: const Icon(Icons.inventory_rounded),
                      title: const Text("Órdenes de compra"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );

                        Future.delayed(
                          const Duration(
                            milliseconds: 2000,
                          ),
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PurchaseList(),
                              ),
                            );
                          },
                        );
                      },
                    ),

                    // PANTALLA LISTADO DE ORDENES DE TRABAJO

                    ListTile(
                      leading: const Icon(Icons.coffee_maker_outlined),
                      title: const Text("Órdenes de trabajo"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );

                        Future.delayed(
                          const Duration(
                            milliseconds: 2300,
                          ),
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const OrdenesView(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    ExpansionTile(
                      leading: const Icon(Icons.inventory_2_outlined),
                      title: const Text("Inventario"),
                      children: [
                        // PANTALLA DE LISTADO DE INSUMOS

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            leading: const Icon(Icons.input_rounded),
                            title: const Text("Insumos"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ListadoInsumos(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // PANTALLA DE PRODUCTOS POR EXPIRAR

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            leading:
                                const Icon(Icons.report_gmailerrorred_rounded),
                            title: const Text("Por Expirar"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const ToExpire(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        //PANTALLA LISTADO DE PRODUCTOS

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            leading: const Icon(Icons.cake_outlined),
                            title: const Text("Productos"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProductsView(),
                                    ),
                                  );
                                },
                              );
                            },
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

                        // PANTALLA DE CATEGORÍA DE PRODUCTOS

                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: ListTile(
                            leading: const Icon(Icons.category_outlined),
                            title: const Text("Categorías"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CategoryView(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // PANTALLA DE LISTADO DE PROVEEDORES

                    ListTile(
                      leading: const Icon(Icons.local_shipping_outlined),
                      title: const Text("Proveedores"),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoadingScreen(),
                          ),
                        );

                        Future.delayed(
                          const Duration(
                            milliseconds: 1800,
                          ),
                          () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SuppliersView(),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    // if (user.cargo == 'cajero')
                    ExpansionTile(
                      leading: const Icon(Icons.point_of_sale),
                      title: const Text("Módulo de ventas"),
                      children: [
                        // PANTALLA DE CREAR VENTAS

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            leading:
                                const Icon(Icons.add_shopping_cart_rounded),
                            title: const Text("Generar Ventas"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SellsAdd(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        // PANTALLA DE LISTADO DE VENTAS

                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: ListTile(
                            leading: const Icon(Icons.checklist_rounded),
                            title: const Text("Listado de ventas"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 2300,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SellsView(),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(height: MediaQuery.of(context).size.height * 0.005),
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
      ),
    );
  }
}
