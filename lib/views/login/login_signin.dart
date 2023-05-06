import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:file_picker/file_picker.dart';

class SigninUser extends StatefulWidget {
  const SigninUser({Key? key}) : super(key: key);
  @override
  State<SigninUser> createState() => _SigninUserState();
}

class _SigninUserState extends State<SigninUser> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController apellidoController = TextEditingController();
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController admincodeController = TextEditingController();
  File? imagen;

  @override
  void dispose() {
    nombreController.dispose();
    apellidoController.dispose();
    correoController.dispose();
    passwordController.dispose();
    admincodeController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final msg = jsonEncode({
      'nombre': nombreController.text,
      'apellido': apellidoController.text,
      'correo': correoController.text,
      'password': passwordController.text,
      'admincode': admincodeController.text,
      'imagen': base64
    });
    await UserService().UsersAdd(msg);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginUser()));
  }

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
                          top: MediaQuery.of(context).size.height * 0.05),
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
                          top: MediaQuery.of(context).size.height * 0.03,
                          right: MediaQuery.of(context).size.width * 0.08,
                          left: MediaQuery.of(context).size.width * 0.08,
                        ),
                        child: InkWell(
                          onTap: () async {
                            final result = await FilePicker.platform.pickFiles(
                              type: FileType.image,
                            );
                            if (result != null) {
                              setState(() {
                                imagen = File(result.files.single.path!);
                              });
                            }
                          },
                          child: Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF909090),
                            ),
                            child: ClipOval(
                              child: imagen != null
                                  ? Image.file(
                                      imagen!,
                                      width: 80.0,
                                      height: 80.0,
                                      fit: BoxFit.cover,
                                    )
                                  : const Icon(
                                      Icons.add,
                                      size: 40.0,
                                      color: Color(0xFFC0C0C0),
                                    ),
                            ),
                          ),
                        ),
                      ),

                      // Padding(
                      //   padding: EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * 0.03,
                      //     right: MediaQuery.of(context).size.width * 0.08,
                      //     left: MediaQuery.of(context).size.width * 0.08,
                      //   ),
                      //   child: InkWell(
                      //     onTap: () async {
                      //       final result = await FilePicker.platform.pickFiles(
                      //         type: FileType.image,
                      //       );
                      //       if (result != null) {
                      //         setState(() {
                      //           imagen = File(result.files.single.path!);
                      //         });
                      //       }
                      //     },
                      //     child: Container(
                      //       width: 80.0,
                      //       height: 80.0,
                      //       decoration: const BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         color: Color(0xFF909090),
                      //       ),
                      //       child: const Icon(
                      //         Icons.person_outline_outlined,
                      //         size: 40.0,
                      //         color: Color(0xFFC0C0C0),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
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
                          decoration: InputDecoration(
                              hintText: "Apellido",
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
