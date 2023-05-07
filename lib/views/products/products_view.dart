import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/views/products/products_add.dart';
import 'package:wholecake/views/products/products_edit.dart';
import 'dart:typed_data';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 2));
}

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<ProductService>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Listado de productos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: SideBar(),
        body: Column(children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20, top: 5),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProductsAdd()));
              },
              label: Text('Agregar'),
              icon: Icon(Icons.add),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: listado.listadoproductos.length,
                itemBuilder: (context, index) {
                  final product = listado.listadoproductos[index];
                  Uint8List bytes =
                      Uint8List.fromList(base64.decode(product.imagen));
                  Image image = Image.memory(bytes);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                                right: MediaQuery.of(context).size.width * 0.03,
                                top: MediaQuery.of(context).size.height * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: image.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product.nombre,
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            listado.selectedProduct = listado
                                                .listadoproductos[index]
                                                .copy();
                                            print('este es el listado');
                                            print(listado.selectedProduct);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsEdit()),
                                            );
                                          },
                                          icon: Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            final msg = jsonEncode(
                                                {'id': product.productoId});
                                            await ProductService()
                                                .deleteProducto(msg);
                                            setState(() {
                                              listado.listadoproductos
                                                  .removeAt(index);
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
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
                                ),
                                SizedBox(height: 10),
                                Text(
                                  product.productoId.toString(),
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
            ),
          )
        ]));
  }
}
