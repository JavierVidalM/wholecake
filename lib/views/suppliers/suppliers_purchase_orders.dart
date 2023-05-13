import 'package:flutter/material.dart';

class PurchaseOrders extends StatefulWidget {
  @override
  _PurchaseOrdersState createState() => _PurchaseOrdersState();
}

class _PurchaseOrdersState extends State<PurchaseOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ordenes de Compra',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(hintText: 'Fecha'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Tipo de Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Marca del Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Cantidad del Producto'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Costo por unidad'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: 'Costo Total'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Realizar Orden'),
              style: TextButton.styleFrom(
                  textStyle: TextStyle(fontSize: 15),
                  minimumSize: Size(180, 50),
                  padding: EdgeInsets.all(20)),
            ),
          ],
        ),
      ),
    );
  }
}
