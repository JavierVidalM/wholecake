import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/users_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/login/login.dart';

class PassRecover extends StatefulWidget {
  const PassRecover({Key? key}) : super(key: key);

  @override
  PassRecoverState createState() => PassRecoverState();
}

class PassRecoverState extends State<PassRecover> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController correoController = TextEditingController();

  @override
  void dispose() {
    correoController.dispose();
    super.dispose();
  }

  void showSnackbarSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.mark_email_read_outlined,
              color: Colors.white,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Correo enviado",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 4),
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.green[400],
        showCloseIcon: true,
      ),
    );
  }

  void showSnackbarError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.report_gmailerrorred_rounded,
              color: Colors.white,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Revisa tus datos",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.all(20),
        backgroundColor: Colors.red[400],
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      showSnackbarError(
          'Por favor ingrese una dirección de correo electrónico');
      return '';
    }
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value)) {
      showSnackbarError('Por favor ingrese un correo válido');
      return '';
    }
    if (emailRegExp.hasMatch(value) && value.isNotEmpty) {
      showSnackbarSuccess('Por favor revisa tu bandeja de correo electrónico');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: SweetCakeTheme.loginTheme,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
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
                      top: MediaQuery.of(context).size.height * 0.18,
                    ),
                    child: Text(
                      "Recupere su contraseña",
                      style: SweetCakeTheme.loginTheme.textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Text(
                      "Escriba su correo electrónico y le enviaremos a su correo los pasos a seguir para recuperar su contraseña.",
                      style: SweetCakeTheme.loginTheme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.04,
                      right: MediaQuery.of(context).size.width * 0.08,
                      left: MediaQuery.of(context).size.width * 0.08,
                    ),
                    child: TextFormField(
                      controller: correoController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Correo electrónico",
                      ),
                      validator: validateEmail,
                      onSaved: (value) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.15,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _formKey.currentState!.save();

                        if (_formKey.currentState!.validate()) {
                          final msg = jsonEncode({
                          'email': correoController.text,

                          });
                          Provider.of<UserService>(context,listen: false).resetPassword(msg);
                          Navigator.pushNamed(context, '/LoginUser');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(
                          MediaQuery.of(context).size.width * 0.75,
                          MediaQuery.of(context).size.height * 0.08,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                            builder: (context) => const LoginUser(),
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
      ),
    );
  }
}
