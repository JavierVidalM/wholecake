import 'dart:math';
import 'package:provider/provider.dart';

import 'lista_ejemplo.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SellsView extends StatefulWidget {
  const SellsView({super.key});

  @override
  _SellsViewState createState() => _SellsViewState();
}

Future<void> _refresh() async {
  // await ProductService().loadNoSeQueWea();
}

class _SellsViewState extends State<SellsView> {
  List<ProductoEjemplo> productselected = [];
  Map<ProductoEjemplo, int> cartQuantities = {};
  Map<ProductoEjemplo, int> cartItems = {};

  void sinProductos(BuildContext context) async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Aún no hay productos en el carrito"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Aceptar"))
            ],
          );
        });
  }

  Future<void> detalleVenta(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder:
          // (BuildContext context) {
          //   return AlertDialog(
          //     title: Text('Carrito de compras'),
          //     content:
          //     Column(
          //       children: productselected.map((item) => Text(item.name)).toList(),
          //     ),
          //     actions: [
          //       TextButton(
          //         onPressed: () {
          //           Navigator.pop(context);
          //         },
          //         child: const Text("Aceptar"),
          //       ),
          //     ],
          //   );
          // },

          (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          title: Text('Carrito de compras'),
          content: Column(
            children: productselected.map((item) {
              final int quantityInCart = productselected
                  .where((product) => product.id == item.id)
                  .length;
              return ListTile(
                leading: Image.asset(item.image),
                title: Text(item.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Categoría: ${item.category}'),
                    Text('Precio: ${NumberFormat.currency(
                      locale: 'es',
                      symbol: '\$',
                      decimalDigits: 0,
                      customPattern: '\$ #,##0',
                    ).format(double.parse(item.price.toString()))}'),
                    // Text('Cantidad: $quantityInCart'),
                  ],
                ),
                trailing: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 30,
                    height: 30,
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        quantityInCart.toString(),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },

      //     (BuildContext context) {
      //   return AlertDialog(
      //     actionsAlignment: MainAxisAlignment.center,
      //     actionsPadding: const EdgeInsets.only(bottom: 10),
      //     contentPadding: const EdgeInsets.all(10),
      //     insetPadding: const EdgeInsets.all(20),
      //     scrollable: true,
      //     title: Column(
      //       children: [
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             IconButton(
      //                 onPressed: () {
      //                   Navigator.of(context).pop();
      //                 },
      //                 icon: const Icon(Icons.close_rounded)),
      //           ],
      //         ),
      //         const Text('Detalle de esta venta'),
      //       ],
      //     ),
      //     content: SizedBox(
      //       width: double.maxFinite,
      //       height: MediaQuery.of(context).size.height * 0.6,
      //       child: ListView.builder(
      //         itemCount: listaVenta,
      //         itemBuilder: (BuildContext context, int index) {
      //           final product = productselected[productselected.length];
      //           return Column(
      //             children: [
      //               ListTile(
      //                 leading: ClipRRect(
      //                   borderRadius: BorderRadius.circular(100),
      //                   child: Image.asset(product.image),
      //                 ),
      //                 title: Text(product.name,
      //                     style: const TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         color: SweetCakeTheme.pink3)),
      //                 contentPadding: const EdgeInsets.all(5),
      //                 subtitle: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       product.category,
      //                       style:
      //                           const TextStyle(fontWeight: FontWeight.normal),
      //                     ),
      //                     Text(
      //                       NumberFormat.currency(
      //                         locale: 'es',
      //                         symbol: '\$',
      //                         decimalDigits: 0,
      //                         customPattern: '\$ #,##0',
      //                       ).format(double.parse(product.price.toString())),
      //                     ),
      //                   ],
      //                 ),
      //                 trailing: IconButton(
      //                     onPressed: () {},
      //                     icon: Icon(
      //                       Icons.delete_outline_rounded,
      //                       color: Colors.red[300],
      //                       size: 40,
      //                     )),

      //                 // trailing: ClipOval(
      //                 //   child: Container(
      //                 //     color: Colors.white,
      //                 //     width: 50,
      //                 //     height: 50,
      //                 //     child: Center(
      //                 //       child: Text('${product.quantity}'),
      //                 //     ),
      //                 //   ),
      //                 // ),
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   IconButton(
      //                     onPressed: () {},
      //                     icon: const Icon(Icons.remove_circle_outline_rounded),
      //                   ),
      //                   ClipRRect(
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(10)),
      //                     child: Container(
      //                       color: Colors.white,
      //                       width: 50,
      //                       height: 30,
      //                       child: Center(
      //                         child: Text('${product.quantity}'),
      //                       ),
      //                     ),
      //                   ),
      //                   IconButton(
      //                     onPressed: () {},
      //                     icon: const Icon(Icons.add_circle_outline_rounded),
      //                   ),
      //                 ],
      //               ),
      //               const Divider(),
      //             ],
      //           );
      //         },
      //       ),
      //     ),
      //     actions: [
      //       ElevatedButton(
      //         onPressed: () {},
      //         style: ElevatedButton.styleFrom(
      //           minimumSize: Size(
      //             (MediaQuery.of(context).size.width * 0.3),
      //             (MediaQuery.of(context).size.height * 0.06),
      //           ),
      //         ),
      //         child: const Text('Emitir boleta'),
      //       )
      //     ],
      //   );
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool cartWithProducts = false;
    // bool isInCart = false;
    if (productselected.isNotEmpty) {
      cartWithProducts = !cartWithProducts;
    }
    // if (productselected.isNotEmpty) {
    //   isInCart = !isInCart;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Módulo de ventas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.04),
            child: IconButton(
              onPressed: () async {
                if (productselected.isEmpty == false) {
                  {
                    detalleVenta(context);
                  }
                } else {
                  sinProductos(context);
                }
              },
              icon: Stack(
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 35,
                  ),
                  Visibility(
                    visible: cartWithProducts,
                    child: Positioned(
                      child: ClipOval(
                        child: Container(
                            color: const Color(0xFFF95959),
                            width: 15,
                            height: 15,
                            child: Center(
                              child: Text(
                                productselected.length.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.66),
              itemCount: pastryProducts.length,
              itemBuilder: (context, index) {
                final product = pastryProducts[index];
                final int? quantityInCart =
                    cartItems.containsKey(product) ? cartItems[product] : 0;
                // final int quantityInCart = productselected
                //     .where((item) => item.id == product.id)
                //     .length;
                return Card(
                  color: SweetCakeTheme.blue,
                  elevation: 8,
                  margin: EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(200),
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: AssetImage(product.image),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'es',
                                      symbol: '\$',
                                      decimalDigits: 0,
                                      customPattern: '\$ #,##0',
                                    ).format(
                                        double.parse(product.price.toString())),
                                    style:
                                        TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      productselected.add(product);
                                    },
                                  );
                                },
                                child: const Icon(Icons.add),
                              ),
                              // Container(
                              //   color: Colors.green,
                              //   child:
                              // )
                            ],
                          )
                        ],
                      ),
                      // Visibility(
                      //   visible: isInCart,
                      //   child: Container(
                      //       width: 0,
                      //       height: 0,
                      //       margin: EdgeInsets.all(5),
                      //       // color: Colors.green,
                      //       child: Icon(
                      //         Icons.circle,
                      //         color: Colors.green[300],
                      //       )),
                      // )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  if (productselected.isEmpty == false) {
                    {
                      detalleVenta(context);
                    }
                  } else {
                    return sinProductos(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    (MediaQuery.of(context).size.width * 0.6),
                    (MediaQuery.of(context).size.height * 0.7),
                  ),
                ),
                child: const Text('Pasar por el carrito'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
