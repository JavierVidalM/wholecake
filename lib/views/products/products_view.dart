import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/products/products_edit.dart';
import 'package:wholecake/views/views.dart';
import 'dart:typed_data';
class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<ProductService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Listado de productos'),
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: listado.listadoproductos.length,
        itemBuilder: (context, index) {
          final product = listado.listadoproductos[index];
          Uint8List bytes = Uint8List.fromList(base64.decode(product.imagen));
          Image image = Image.memory(bytes);
          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image:image.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.nombre,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    listado.selectedProduct =
                                        listado.listadoproductos[index].copy();
                                    print('este es el listado');
                                    print(listado.selectedProduct);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductsEdit()),
                                    );
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    final msg = jsonEncode(
                                        {'Eliminar ID': product.productoId});
                                    await ProductService().deleteProducto(msg);
                                    setState(() {
                                      listado.listadoproductos.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Elaboración: ${product.fechaElaboracion.toString().substring(0, 10)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Text(
                          product.productoId.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
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
