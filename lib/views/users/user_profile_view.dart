import 'dart:convert';
import 'dart:typed_data';
import 'package:wholecake/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
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

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideBar(),
      body: Consumer<UserService>(
        builder: (context, user, _) {
          Uint8List bytes = Uint8List.fromList(base64.decode(user.img));
          Image image = Image.memory(bytes);
          return Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: AppBar(
                  elevation: 0,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.1,
                ),
              ),
              SizedBox(
                // color: Colors.green,
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width * 1,
                child: Center(
                  child: Text(
                    "Perfil del usuario",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Center(
                heightFactor: 1,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Card(
                      elevation: 5,
                      borderOnForeground: true,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              width: 150,
                              height: 150,
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: image.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              user.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                            child: Divider(
                              color: SweetCakeTheme.blue2,
                              height: 2,
                              indent: 50,
                              endIndent: 50,
                              thickness: 2,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Email : ${user.email}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Cargo: ${user.cargo}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Local:  ${user.local}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Dirección:  ${user.direccion}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              "Número de teléfono:  ${user.ntelefono}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.05),
                      child: GestureDetector(
                        onTap: () {
                          logoutPopup(context, user);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.logout,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.03),
                              child: const Text(
                                "Cerrar sesión",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
