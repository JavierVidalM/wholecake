import 'package:flutter/material.dart';
import 'package:wholecake/views/login/login_signin.dart';
import 'package:wholecake/views/login/login_user.dart';
import 'package:wholecake/views/home/home_page.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

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
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo_SW.png',
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.17),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/LoginUser');
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
                      top: MediaQuery.of(context).size.height * 0.08),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/SigninUser');
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
                      style: TextStyle(color: Color(0xFFF0F0F0), fontSize: 22),
                    ),
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
