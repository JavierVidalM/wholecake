import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDE0FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC4E3),
        title: Container(
          alignment: Alignment.center,
          child: Image.asset('assets/images/logo_SW.png'),
          height: kToolbarHeight * 0.9,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 25),
          Image.asset(
            'assets/images/error_SW.png',
            height: kToolbarHeight * 5,
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              print('Error al cargar la imagen: $exception');
              return const Text('Error al cargar la imagen');
            },
          ),
          const SizedBox(height: 50),
          const Text(
            'Ups, aquí no hay nada',
            style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C2C2C)),
          ),
          const SizedBox(height: 20),
          const Text(
            'Por favor intente más tarde,\n si el problema persiste contacte con un administrador',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Color(0xFF2C2C2C)),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFFFFB5D7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Container(
              width: 230,
              height: 70,
              alignment: Alignment.center,
              child: const Text(
                'Reintentar',
                style: TextStyle(fontSize: 23, color: Color(0xFF5D2A42)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
