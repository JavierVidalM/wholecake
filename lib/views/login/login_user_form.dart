import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login.dart';
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

  bool isEmailValid = true;
  bool isCodeValid = true;
  bool isPasswordMatch = true;
  bool areFieldsFilled = true;

  void validateFields() {
    setState(() {
      isEmailValid = emailController.text.isNotEmpty &&
          RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
              .hasMatch(emailController.text);
      isCodeValid = codeController.text.isNotEmpty &&
          RegExp(r'^\d+$').hasMatch(codeController.text);
      isPasswordMatch =
          newPasswordController.text == confirmPasswordController.text;
      areFieldsFilled = emailController.text.isNotEmpty &&
          codeController.text.isNotEmpty &&
          newPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty;
    });
  }

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
                      errorText: isEmailValid ? null : 'Correo inválido',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Código",
                      errorText: isCodeValid ? null : 'Código inválido',
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
                    decoration: const InputDecoration(
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
                      errorText: isPasswordMatch
                          ? null
                          : 'Las contraseñas no coinciden',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.08,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      validateFields(); // Validar los campos antes de enviar la solicitud
                      if (isEmailValid &&
                          isCodeValid &&
                          isPasswordMatch &&
                          areFieldsFilled) {
                        final msg = jsonEncode({
                          'email': emailController.text,
                          'reset_code': codeController.text,
                          'new_password': newPasswordController.text,
                        });
                        Provider.of<UserService>(context, listen: false)
                            .resetPasswordConfirm(msg);
                        // Navigator.pushNamed(context, '/LoginMain');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginUser(),
                          ),
                        );
                      }
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
