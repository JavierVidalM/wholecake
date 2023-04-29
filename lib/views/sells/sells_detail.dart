import 'package:flutter/material.dart';

class SellsDetail extends StatefulWidget {
  @override
  _SellsDetailState createState() => _SellsDetailState();
}

class _SellsDetailState extends State<SellsDetail> {
  String nombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar Nombre'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Nombre actual:',
            ),
            Text(
              nombre,
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes agregar la lógica para cambiar el nombre
                setState(() {
                  nombre = 'Nuevo Nombre';
                });
              },
              child: Text('Cambiar nombre'),
            ),
          ],
        ),
      ),
    );
  }
}
