import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';

class PassRecover extends StatefulWidget {
  const PassRecover({super.key});
  @override
  PassRecoverState createState() => PassRecoverState();
}

class PassRecoverState extends State<PassRecover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffbde0fe),
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
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.18,
                ),
                child: const Text("Recupere su contraseña",
                    style: TextStyle(color: Color(0xFF3681AB), fontSize: 22)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  left: MediaQuery.of(context).size.height * 0.02,
                  right: MediaQuery.of(context).size.height * 0.02,
                ),
                child: const Text(
                    "Escriba su correo electrónico y le enviaremos a su correo los pasos a seguir para recuperar su contraseña.",
                    style: TextStyle(color: Color(0xFF2C2C2C), fontSize: 16)),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.04,
                  right: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: "Correo electrónico",
                      hintStyle:
                          TextStyle(color: Color(0xFF909090), fontSize: 20),
                      fillColor: Color(0xFFBDE0FE),
                      filled: true,
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF3681AB), width: 4.0)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF3681AB), width: 2.0))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginUser()));
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
                    "Recuperar contraseña",
                    style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 20),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginUser()));
                    },
                    child: const Text(
                      "Regresar",
                      style: TextStyle(color: Color(0xFF3681AB), fontSize: 20),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
