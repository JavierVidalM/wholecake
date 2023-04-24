// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class LoginMain extends StatefulWidget {
  const LoginMain({Key? key}) : super(key: key);

  @override
  _LoginMainState createState() => _LoginMainState();
}

class _LoginMainState extends State<LoginMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            // width: MediaQuery.of(context).size.width,
            children: const [
              Text(
                "Sweet Cake",
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Iniciar Sesión"),
            ),
          ),
        ],
      ),
    );
  }
}
