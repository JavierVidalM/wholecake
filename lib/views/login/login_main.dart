import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login.dart';

class LoginMain extends StatelessWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: SweetCakeTheme.loginTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const LoginUser()));
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
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => const SigninUser()),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          (MediaQuery.of(context).size.width * 0.75),
                          (MediaQuery.of(context).size.height * 0.08),
                        ),
                      ),
                      child: Text(
                        "Registrarse",
                        style: SweetCakeTheme.loginTheme.textTheme.titleLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
