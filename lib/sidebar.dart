import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/products/products.dart';
import 'package:wholecake/views/sells/sells.dart';
import 'package:wholecake/views/suppliers/suppliers.dart';
import 'package:wholecake/views/users/users.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

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
                UserAccountsDrawerHeader(
                  accountName: const Text(
                    "Monkey D. Luffy",
                    style: TextStyle(),
                  ),
                  accountEmail: const Text(
                    "monkey@dluffy.com",
                    style: TextStyle(),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.network(
                        'https://img1.ak.crunchyroll.com/i/spire4/5b954f7af990b40acc4f3f410a3a5f9d1664298859_large.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              builder: (context) => const UsersList()),
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
                        )),
                ListTile(
                  leading: const Icon(Icons.local_shipping_outlined),
                  title: const Text("Proveedores"),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuppliersView()),
                  ),
                  trailing: ClipOval(
                    child: Container(
                        color: const Color(0xFFF95959),
                        width: 20,
                        height: 20,
                        child: const Center(
                          child: Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        )),
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
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
