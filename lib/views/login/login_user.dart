import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:wholecake/views/login/login_recover.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({super.key});
  @override
  LoginUserState createState() => LoginUserState();
}

class LoginUserState extends State<LoginUser> {
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffbde0fe),
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
                  top: MediaQuery.of(context).size.height * 0.12,
                  right: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                child: const TextField(
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
                  top: MediaQuery.of(context).size.height * 0.06,
                  right: MediaQuery.of(context).size.width * 0.02,
                  left: MediaQuery.of(context).size.width * 0.02,
                ),
                child: TextFormField(
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Contraseña",
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
                    top: MediaQuery.of(context).size.height * 0.02),
                child: TextButton(
                  child: const Text(
                    '¿Olvidó su contraseña?',
                    style: TextStyle(color: Color(0xFF3681AB), fontSize: 18),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PassRecover()));
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0),
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: const Color(0xFF909090),
                              disabledColor: const Color(0xFF909090),
                            ),
                            child: Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value!;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              checkColor: const Color(0xFFBDE0FE),
                              activeColor: const Color(0xFF3681AB),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _rememberMe = !_rememberMe;
                              });
                            },
                            child: const Text(
                              'Recuérdame',
                              style: TextStyle(
                                  color: Color(0xFF909090), fontSize: 18),
                            ),
                          ),
                        ]),
                  )),
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
                    "Iniciar sesión",
                    style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 22),
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
