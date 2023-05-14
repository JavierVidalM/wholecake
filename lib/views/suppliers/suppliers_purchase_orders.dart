import 'package:flutter/material.dart';
import 'package:wholecake/views/home/home.dart';
import 'package:wholecake/views/utilities/sidebar.dart';

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
          'Ordenes de compra',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      (MediaQuery.of(context).size.width * 0.6),
                      (MediaQuery.of(context).size.height * 0.07),
                    ),
                  ),
                  child: const Text('Realizar orden'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(
                      (MediaQuery.of(context).size.width * 0.6),
                      (MediaQuery.of(context).size.height * 0.07),
                    ),
                  ),
                  child: const Text('Volver'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
