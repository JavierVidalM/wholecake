import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final String elaborationDate;
  final String expirationDate;
  final String description;

  Product({
    required this.name,
    required this.elaborationDate,
    required this.expirationDate,
    required this.description,
  });
}

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  final products = [
    Product(
      name: 'Producto 1',
      elaborationDate: '01/01/2022',
      expirationDate: '01/01/2023',
      description: 'Descripción del producto 1',
    ),
    Product(
      name: 'Producto 2',
      elaborationDate: '01/01/2022',
      expirationDate: '01/01/2023',
      description: 'Descripción del producto 2',
    ),
    Product(
      name: 'Producto 3',
      elaborationDate: '01/01/2022',
      expirationDate: '01/01/2023',
      description: 'Descripción del producto 3',
    ),
    Product(
      name: 'Producto 4',
      elaborationDate: '01/01/2022',
      expirationDate: '01/01/2023',
      description: 'Descripción del producto 4',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de productos'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Lógica para editar el producto
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              // Lógica para eliminar el producto
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Elaboración: ${product.elaborationDate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Vencimiento: ${product.expirationDate}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Listado de productos',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ProductsView(),
    );
  }
}
