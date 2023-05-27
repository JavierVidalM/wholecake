import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

class UserProfileView extends StatefulWidget {
  const UserProfileView({super.key});

  @override
  State<UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: AppBar(
              // title: Text(
              //   "Perfil del usuario",
              //   style: Theme.of(context).textTheme.titleLarge,
              // ),
              elevation: 2,
              // toolbarHeight: MediaQuery.of(context).size.height * 0.15,
            ),
          ),
          Container(
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
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.95,
                child: Card(
                  elevation: 5,
                  borderOnForeground: true,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, right: 10.0),
                            child: IconButton(
                                onPressed: () {
                                  print("Aqui va la pantalla pa editar");
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: SweetCakeTheme.blue,
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(500),
                          child: Image.network(
                            'https://img1.ak.crunchyroll.com/i/spire4/5b954f7af990b40acc4f3f410a3a5f9d1664298859_large.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "Monkey D. Luffy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "monkeydluffy@kaisokuo.com",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
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
                top: MediaQuery.of(context).size.height * 0.5,
                left: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      print("No sé alguna wea hará esto");
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Icon(
                            Icons.edit,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Text(
                            "Editar perfil",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      print("No sé alguna wea hará esto");
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Icon(
                            Icons.edit,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Text(
                            "Editar perfil",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      print("No sé alguna wea hará esto");
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Icon(
                            Icons.edit,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Text(
                            "Editar perfil",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      print("No sé alguna wea hará esto");
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
                          child: const Icon(
                            Icons.logout,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.05),
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
      ),
      drawer: const SideBar(),
    );
  }
}
