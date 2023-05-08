import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme.dart';
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
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: "Correo electrónico"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextFormField(
                    autocorrect: false,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: "Contraseña"),
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
                              builder: (context) => const PassRecover()));
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        left: MediaQuery.of(context).size.width * 0.08),
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
                              child: Text(
                                'Recuérdame',
                                style: SweetCakeTheme
                                    .loginTheme.textTheme.bodySmall,
                              ),
                            ),
                          ]),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
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
                                builder: (context) => const LoginMain()));
                      },
                      child: Text(
                        "Regresar",
                        style: SweetCakeTheme.loginTheme.textTheme.bodyMedium,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
