import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:wholecake/views/sells/sells.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:wholecake/views/users/users.dart';
import 'package:wholecake/views/supplies/products_supplies.dart';

import '../../services/users_services.dart';
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

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserService>();
    return Theme(
      data: SweetCakeTheme.sidebarTheme,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,  
          children: [
            Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(
                    user.name,
                    style: TextStyle(),
                  ),
                  accountEmail: Text(
                    "monkey@dluffy.com",
                    style: TextStyle(),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img1.ak.crunchyroll.com/i/spire4/5b954f7af990b40acc4f3f410a3a5f9d1664298859_large.jpg'),
                  ),
                ),
                ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text("Inicio"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        )),
                ListTile(
                    leading: const Icon(Icons.person_outline_rounded),
                    title: const Text("Usuarios"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        )),
                ListTile(
                    leading: const Icon(Icons.inventory_rounded),
                    title: const Text("Ordenes de compra"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PurchaseList()),
                        )),
                ExpansionTile(
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: const Text("Inventario"),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                          leading: const Icon(Icons.input_rounded),
                          title: const Text("Insumos"),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Supplies()), //Cambiar esto
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                          leading:
                              const Icon(Icons.report_gmailerrorred_rounded),
                          title: const Text("Por Expirar"),
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ToExpire()),
                              )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: ListTile(
                        leading: const Icon(Icons.cake_outlined),
                        title: const Text("Productos"),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductsView()),
                        ),
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
                          onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CategoryView()),
                              )),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined),
                  title: const Text("Proveedores"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SuppliersView()),
                  ),
                ),
                if(user.typeuser=='cajero')
                  ListTile(
                    leading: const Icon(Icons.point_of_sale_sharp),
                    title: const Text("Módulo de ventas"),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SellsView()),
                    ),
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SellsView()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
