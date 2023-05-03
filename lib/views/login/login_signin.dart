import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';

class SigninUser extends StatefulWidget {
  const SigninUser({super.key});

  @override
  State<SigninUser> createState() => _SigninUserState();
}

class _SigninUserState extends State<SigninUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFBDE0FE),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.1),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo_SW.png',
                            height: MediaQuery.of(context).size.height * 0.15,
                            // width: 150, // ajusta el ancho a tu preferencia
                          ),
                        ],
                      )),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                              hintText: "Nombre",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: const TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              hintText: "Rut",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: const TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: "Correo electrónico",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Contraseña",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: TextFormField(
                          autocorrect: false,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Repetir contraseña",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: "Código Administrador",
                              hintStyle: TextStyle(
                                  color: Color(0xFF909090), fontSize: 20),
                              fillColor: Color(0xFFBDE0FE),
                              filled: true,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 4.0)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF3681AB), width: 2.0))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFFB5D7),
                            minimumSize: Size(
                              (MediaQuery.of(context).size.width * 0.75),
                              (MediaQuery.of(context).size.height * 0.08),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Registrarse",
                            style: TextStyle(
                                color: Color(0xFFF0F0F0), fontSize: 22),
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
                                      builder: (context) => const LoginMain()));
                            },
                            child: const Text(
                              "Regresar",
                              style: TextStyle(
                                  color: Color(0xFF3681AB), fontSize: 20),
                            ),
                          )),
                    ],
                  )
                ]),
          ),
        ));
  }
}
