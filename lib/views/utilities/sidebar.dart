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
    return Theme(
      data: SweetCakeTheme.sidebarTheme,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const UserAccountsDrawerHeader(
                  accountName: Text(
                    "Monkey D. Luffy",
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
                              builder: (context) => const UsersAdd()),
                        )),
                ListTile(
                    leading: const Icon(Icons.inventory_rounded),
                    title: const Text("Inventario"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Inventory()),
                        )),
                ListTile(
                    leading: const Icon(Icons.input_rounded),
                    title: const Text("Insumos"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage()), //Cambiar esto
                        )),
                ListTile(
                    leading: const Icon(Icons.report_gmailerrorred_rounded),
                    title: const Text("Por Expirar"),
                    onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ToExpire()),
                        )),
                ListTile(
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
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined),
                  title: const Text("Proveedores"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuppliersView()),
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
                    MaterialPageRoute(builder: (context) => const LoginMain()),
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
