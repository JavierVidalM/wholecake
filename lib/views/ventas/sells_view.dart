import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:wholecake/services/productos_services.dart';
import 'dart:convert';
import 'dart:typed_data';

class SellsView extends StatefulWidget {
  const SellsView({super.key});

  @override
  _SellsViewState createState() => _SellsViewState();
}

Future<void> _refresh() async {
  await ProductService().loadProductos();
}

class _SellsViewState extends State<SellsView> {
  bool isSelected = false;
  List selectedCategories = [];
  List<Listado> productosCarrito = [];

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
      },
    );
  }

  Future<void> detalleVenta(
      BuildContext context, List<Listado> products) async {
    final productSelected = List.from(products);

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.only(right: 0, left: 0),
          insetPadding: const EdgeInsets.all(0),
          title: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 1,
              ),
              const Text('Carrito de compras'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 10,
              ),
            ],
          ),
          content: Column(
            children: productSelected.map((item) {
              final int quantityInCart = productosCarrito
                  .where((product) => product.productoId == item.productoId)
                  .length;
              Uint8List bytes = Uint8List.fromList(base64.decode(item.imagen));
              Image imagenProducto = Image.memory(bytes);
              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imagenProducto.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // leading: Text(item.imagen),
                title: Text(item.nombre),
                subtitle: Text(NumberFormat.currency(
                  locale: 'es',
                  symbol: '\$',
                  decimalDigits: 0,
                  customPattern: '\$ #,##0',
                ).format(double.parse(item.precio.toString()))),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      NumberFormat.currency(
                        locale: 'es',
                        symbol: '\$',
                        decimalDigits: 0,
                        customPattern: '\$ #,##0',
                      ).format(
                        double.parse(
                          (quantityInCart * item.precio).toString(),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantityInCart > 1) {
                            productosCarrito.removeLast();
                          } else {
                            productosCarrito.removeWhere((product) =>
                                product.productoId == item.productoId);
                          }
                        });
                      },
                      icon: const Icon(Icons.remove),
                    ),
                    Text(quantityInCart.toString()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          productosCarrito.add(item.copy());
                        });
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
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
    );
  }

  // Future<void> detalleVenta(
  //     BuildContext context, List<Listado> products) async {
  //   final productSelected = List.from(products);

  //   await showDialog<void>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         scrollable: true,
  //         contentPadding: const EdgeInsets.only(right: 0, left: 0),
  //         insetPadding: const EdgeInsets.all(0),
  //         title: Column(
  //           children: [
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.8,
  //               height: 1,
  //             ),
  //             const Text('Carrito de compras'),
  //             SizedBox(
  //               width: MediaQuery.of(context).size.width * 0.8,
  //               height: 10,
  //             ),
  //           ],
  //         ),
  //         content: Column(
  //           children: productSelected.map((item) {
  //             final int quantityInCart = productosCarrito
  //                 .where((product) => product.productoId == item.productoId)
  //                 .length;
  //             return ListTile(
  //               leading: ClipRRect(
  //                 borderRadius: BorderRadius.circular(100),
  //                 child: Image.asset(item.image),
  //               ),
  //               title: Text(item.name),
  //               subtitle: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text('Categoría: ${item.category}'),
  //                   Text('Precio: ${NumberFormat.currency(
  //                     locale: 'es',
  //                     symbol: '\$',
  //                     decimalDigits: 0,
  //                     customPattern: '\$ #,##0',
  //                   ).format(double.parse(item.price.toString()))}'),
  //                 ],
  //               ),
  //               trailing: ClipRRect(
  //                 borderRadius: BorderRadius.circular(10),
  //                 child: Container(
  //                   width: 30,
  //                   height: 30,
  //                   color: Colors.white,
  //                   child: Center(
  //                     child: Text(
  //                       quantityInCart.toString(),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //             child: const Text("Aceptar"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductService>(context);
    final listadoProductos = productoProvider.listadoproductos;

    final filterProducts = listadoProductos.where((product) {
      return selectedCategories.isEmpty ||
          selectedCategories.contains(product.categoria);
    }).toList();

    if (productoProvider.isLoading) return const LoadingScreen();
    bool cartWithProducts = false;
    // bool isInCart = false;
    if (productosCarrito.isNotEmpty) {
      cartWithProducts = !cartWithProducts;
    }
    List listadoCategorias = [];
    for (var producto in listadoProductos) {
      if (!listadoCategorias.contains(producto.categoria)) {
        listadoCategorias.add(producto.categoria);
      }
    }

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
                if (productosCarrito.isEmpty == false) {
                  {
                    detalleVenta(context, productosCarrito);
                  }
                } else {
                  sinProductos(context);
                }
              },
              icon: Stack(
                children: [
                  const Icon(
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
                              productosCarrito.length.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ),
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
      body: Consumer<ProductService>(builder: (context, listado, child) {
        final filterProducts = listado.listadoproductos.where((product) {
          return selectedCategories.isEmpty ||
              selectedCategories.contains(product.categoria);
        }).toList();

        return Column(
          children: [
            Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Wrap(
                      spacing: 10.0, // Espacio horizontal entre los chips
                      runSpacing: 10.0,
                      children:
                          productoProvider.listadocategorias.map((categoria) {
                        return FilterChip(
                          selected: selectedCategories
                              .contains(categoria.categoriaId),
                          label: Text(categoria.nombre),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedCategories.add(categoria.categoriaId);
                              } else {
                                selectedCategories
                                    .remove(categoria.categoriaId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [
                          Colors.grey.withOpacity(0.5),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(
              height: 1,
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.66),
                itemCount: filterProducts.length,
                itemBuilder: (context, index) {
                  final product = filterProducts[index];
                  Uint8List bytes =
                      Uint8List.fromList(base64.decode(product.imagen));
                  Image imagenProducto = Image.memory(bytes);

                  return Card(
                    color: SweetCakeTheme.blue,
                    elevation: 8,
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
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
                                    image: imagenProducto.image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(
                                product.nombre,
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
                                    double.parse(product.precio.toString())),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(
                                  () {
                                    productosCarrito.add(product);
                                  },
                                );
                              },
                              child: const Icon(Icons.add),
                            ),
                          ],
                        )
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
                    if (productosCarrito.isEmpty == false) {
                      {
                        detalleVenta(context, productosCarrito);
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
        );
      }),
    );
  }
}
