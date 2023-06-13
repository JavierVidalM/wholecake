import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:wholecake/views/login/login_password_recover.dart';
import 'package:wholecake/views/utilidades/utilidades.dart';
import '../../services/users_services.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});
  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SweetCakeTheme.loginTheme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo_SW.png',
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.12,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextField(
                    controller: userController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "Correo electrónico",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextFormField(
                    controller: passwordController,
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Contraseña",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04),
                  child: TextButton(
                    child: Text(
                      '¿Olvidó su contraseña?',
                      style: SweetCakeTheme.loginTheme.textTheme.bodyMedium,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PassRecover(),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Llamada al método de inicio de sesión en el servicio del usuario
                      Provider.of<UserService>(context, listen: false)
                          .login(
                        userController.text.toString(),
                        passwordController.text.toString(),
                      )
                          .then(
                        (loggedIn) {
                          if (loggedIn) {
                            // Si las credenciales son correctas, redirigir al HomePage
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoadingScreen(),
                                ),
                              );

                              Future.delayed(
                                const Duration(
                                  milliseconds: 1500,
                                ),
                                () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                },
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Row(
                                  children: [
                                    Icon(
                                      Icons.report_gmailerrorred_rounded,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 10.0,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Credenciales incorrectas",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                              "Revisa tu dirección correo electrónico o contraseña"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                duration: Duration(seconds: 2),
                                padding: EdgeInsets.all(20),
                              ),
                            );
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        (MediaQuery.of(context).size.width * 0.75),
                        (MediaQuery.of(context).size.height * 0.08),
                      ),
                    ),
                    child: Text(
                      "Iniciar sesión",
                      style: SweetCakeTheme.loginTheme.textTheme.titleLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginMain(),
                        ),
                      );
                    },
                    child: Text(
                      "Regresar",
                      style: SweetCakeTheme.loginTheme.textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
