import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';

String _selectedItem = 'Tipo de usuario';

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
      body: Center(
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
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: DropdownButton<String>(
                        value: _selectedItem,
                        items: <String>[
                          'Tipo de usuario',
                          'Administrador',
                          'Pastelero',
                          'Vendedor'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 10), // Agrega un margen izquierdo
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedItem = newvalue!;
                          });
                        },
                        icon: Padding(
                          padding: EdgeInsets.only(
                              right:
                                  10), // Ajusta la posición del icono hacia la derecha
                          child: Icon(Icons.expand_more,
                              size: 36, color: Color(0xFF909090)),
                        ),
                        underline: Container(
                          height: 4,
                          color: Color(0xFF3681AB),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3681AB),
                        ),
                        dropdownColor: Color(0xFFF0F0F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                          hintText: "Nombre",
                          hintStyle:
                              TextStyle(color: Color(0xFF909090), fontSize: 20),
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
                          hintText: "Contraseña",
                          hintStyle:
                              TextStyle(color: Color(0xFF909090), fontSize: 20),
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
                          hintText: "Repetir contraseña",
                          hintStyle:
                              TextStyle(color: Color(0xFF909090), fontSize: 20),
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
                          hintText: "Código Administrador",
                          hintStyle:
                              TextStyle(color: Color(0xFF909090), fontSize: 20),
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
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
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
                        style:
                            TextStyle(color: Color(0xFFF0F0F0), fontSize: 22),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginMain()));
                        },
                        child: const Text(
                          "Regresar",
                          style:
                              TextStyle(color: Color(0xFF3681AB), fontSize: 18),
                        ),
                      )),
                ],
              )
            ]),
      ),
    );
  }
}
