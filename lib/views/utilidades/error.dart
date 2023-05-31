import 'package:flutter/material.dart';
import 'package:wholecake/views/home/home_page.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_SW.png',
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/error_SW.png',
            height: kToolbarHeight * 5,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Text(
              'Ups, aquí no hay nada',
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C2C2C)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              'Por favor intente más tarde,\n si el problema persiste contacte con un administrador',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Color(0xFF2C2C2C)),
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(
                (MediaQuery.of(context).size.width * 0.6),
                (MediaQuery.of(context).size.height * 0.07),
              ),
            ),
            child: const Text('Volver al inicio'),
          ),
        ],
      ),
    );
  }
}
