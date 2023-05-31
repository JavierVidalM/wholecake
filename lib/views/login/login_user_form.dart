import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login_main.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:wholecake/services/users_services.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({Key? key}) : super(key: key);

  @override
  PasswordRecoveryScreenState createState() => PasswordRecoveryScreenState();
}

class PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
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
                    top: MediaQuery.of(context).size.height * 0.06,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Correo electrónico",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextField(
                    controller: codeController,
                    decoration: InputDecoration(
                      hintText: "Código",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Nueva contraseña",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                    right: MediaQuery.of(context).size.width * 0.08,
                    left: MediaQuery.of(context).size.width * 0.08,
                  ),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirmar contraseña",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      final msg = jsonEncode({
                        'email': emailController.text,
                        'reset_code': codeController.text,
                        'new_password': newPasswordController.text,
                      });
                      Provider.of<UserService>(context, listen: false)
                          .resetPasswordConfirm(msg);
                      Navigator.pushNamed(context, '/LoginMain');
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        MediaQuery.of(context).size.width * 0.75,
                        MediaQuery.of(context).size.height * 0.08,
                      ),
                    ),
                    child: Text(
                      "Recuperar contraseña",
                      style: SweetCakeTheme.loginTheme.textTheme.titleLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginMain()),
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
