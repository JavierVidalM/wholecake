import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:wholecake/services/productos_services.dart';
import 'dart:convert';
import 'dart:typed_data';

class SellsAdd extends StatefulWidget {
  const SellsAdd({Key? key}) : super(key: key);

  @override
  _SellsAddState createState() => _SellsAddState();
}

Future<void> _refresh() async {
  await ProductService().loadProductos();
}

class _SellsAddState extends State<SellsAdd> {
  bool isSelected = false;
  List selectedCategories = [];
  Map<int, Listado> productosCarrito = {};
  List<TextEditingController> cantidadControllers = [];

  Future<void> _guardarVenta(List<Map<String, dynamic>> listadoVenta) async {
    Map<String, dynamic> jsonData = {
      'productos': listadoVenta,
    };

    final msg = jsonEncode(jsonData);
    await VentasService().addVentas(msg);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SellsAdd(),
      ),
    );
    setState(() {
      productosCarrito = {};
    });
  }

  @override
  void dispose() {
    cantidadControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

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
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void confirmarEliminarProducto(BuildContext context, Listado producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar producto'),
          content: const Text('¿Desea eliminar este producto del carrito?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                eliminarProducto(producto);
                Navigator.of(context).pop();
              },
              child: const Text('Eliminar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void eliminarProducto(Listado producto) {
    setState(() {
      productosCarrito.remove(producto.productoId);
    });
  }

  void detalleVenta(BuildContext context, Map<int, Listado> products) async {
    List<Listado> productosCarrito = products.values.toList();

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
            children: productosCarrito.map((item) {
              int quantityInCart = productosCarrito
                  .where((product) => product.productoId == item.productoId)
                  .length;
              Uint8List bytes = Uint8List.fromList(base64.decode(item.imagen));
              Image imagenProducto = Image.memory(bytes);
              int index = productosCarrito.indexOf(item);
              TextEditingController controller = cantidadControllers[index];

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
                title: Text(item.nombre),
                subtitle: Text(
                  NumberFormat.currency(
                    locale: 'es',
                    symbol: '\$',
                    decimalDigits: 0,
                    customPattern: '\$ #,##0',
                  ).format(
                    double.parse(
                      item.precio.toString(),
                    ),
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      // child: Text(quantityInCart.toString()),
                      child: Container(
                        height: 50,
                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.numberWithOptions(),
                          controller: controller,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        confirmarEliminarProducto(context, item);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                List<Map<String, dynamic>> listaProductos = [];
                for (var i = 0; i < productosCarrito.length; i++) {
                  var product = productosCarrito[i];
                  var controller = cantidadControllers[i];
                  listaProductos.add({
                    'id': product.productoId,
                    'cantidad': int.parse(controller.text),
                  });
                }

                _guardarVenta(listaProductos);
                Navigator.pop(context);
              },
              child: const Text("Generar venta"),
            ),
          ],
        );
      },
    );
  }

  void agregarAlCarrito(Listado producto) {
    setState(() {
      if (productosCarrito.containsKey(producto.productoId)) {
        productosCarrito[producto.productoId]!.cantidad++;
      } else {
        producto.cantidad = 1;
        productosCarrito[producto.productoId] = producto;
        cantidadControllers.add(TextEditingController(text: '1'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productoProvider = Provider.of<ProductService>(context);
    final listadoProductos = productoProvider.listadoproductos;

    if (productoProvider.isLoading) return const LoadingScreen();
    bool cartWithProducts = productosCarrito.isNotEmpty;
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
                if (productosCarrito.isEmpty) {
                  sinProductos(context);
                } else {
                  detalleVenta(context, productosCarrito);
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
                                color: Colors.white,
                                fontSize: 12,
                              ),
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
                      spacing: 10.0,
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
                  crossAxisCount: 3,
                  childAspectRatio: 0.66,
                ),
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
                                ).format(product.precio),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 8.0,
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  agregarAlCarrito(product);
                                },
                                child: const Text('Agregar'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wholecake/models/productos.dart';
// import 'package:wholecake/services/ventas_services.dart';
// import 'package:wholecake/theme/theme_constant.dart';
// import 'package:wholecake/views/utilidades/loading_screen.dart';
// import 'package:wholecake/views/utilidades/sidebar.dart';
// import 'package:intl/intl.dart';
// import 'package:wholecake/services/productos_services.dart';
// import 'dart:convert';
// import 'dart:typed_data';

// class SellsAdd extends StatefulWidget {
//   const SellsAdd({super.key});

//   @override
//   _SellsAddState createState() => _SellsAddState();
// }

// Future<void> _refresh() async {
//   await ProductService().loadProductos();
// }

// class _SellsAddState extends State<SellsAdd> {
//   bool isSelected = false;
//   List selectedCategories = [];
//   List<Listado> productosCarrito = [];

//   Future<void> _guardarVenta(List<Map<String, dynamic>> listadoVenta) async {
//     Map<String, dynamic> jsonData = {
//       'productos': listadoVenta,
//     };
//     final msg = jsonEncode(jsonData);
//     await VentasService().addVentas(msg);
//     Navigator.pushNamed(context, '/SellsAdd');
//     productosCarrito = [];
//   }

//   void sinProductos(BuildContext context) async {
//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Aún no hay productos en el carrito"),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Aceptar"))
//           ],
//         );
//       },
//     );
//   }

//   Future<void> detalleVenta(
//       BuildContext context, List<Listado> products) async {
//     List productSelected = List.from(products);

//     await showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           scrollable: true,
//           contentPadding: const EdgeInsets.only(right: 0, left: 0),
//           insetPadding: const EdgeInsets.all(0),
//           title: Column(
//             children: [
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 height: 1,
//               ),
//               const Text('Carrito de compras'),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 height: 10,
//               ),
//             ],
//           ),
//           content: Column(
//             children: productSelected.map((item) {
//               final int quantityInCart = productosCarrito
//                   .where((product) => product.productoId == item.productoId)
//                   .length;
//               Uint8List bytes = Uint8List.fromList(base64.decode(item.imagen));
//               Image imagenProducto = Image.memory(bytes);
//               return ListTile(
//                 leading: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(200),
//                     shape: BoxShape.rectangle,
//                     image: DecorationImage(
//                       image: imagenProducto.image,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 title: Text(item.nombre),
//                 subtitle: Text(
//                   NumberFormat.currency(
//                     locale: 'es',
//                     symbol: '\$',
//                     decimalDigits: 0,
//                     customPattern: '\$ #,##0',
//                   ).format(
//                     double.parse(
//                       item.precio.toString(),
//                     ),
//                   ),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       NumberFormat.currency(
//                         locale: 'es',
//                         symbol: '\$',
//                         decimalDigits: 0,
//                         customPattern: '\$ #,##0',
//                       ).format(
//                         double.parse(
//                           (quantityInCart * item.precio).toString(),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Text(quantityInCart.toString()),
//                     ),
//                   ],
//                 ),
//               );
//             }).toList(),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 List<Map<String, dynamic>> listaProductos = [];
//                 for (var product in productosCarrito) {
//                   listaProductos.add({
//                     'id': product.productoId,
//                     'cantidad': productosCarrito
//                         .where((p) => p.productoId == product.productoId)
//                         .length,
//                   });
//                 }

//                 _guardarVenta(listaProductos);
//                 Navigator.pop(context);
//               },
//               child: const Text("Generar venta"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final productoProvider = Provider.of<ProductService>(context);
//     // while (ProductService().isLoading != false) return const LoadingScreen();
//     final listadoProductos = productoProvider.listadoproductos;

//     if (productoProvider.isLoading) return const LoadingScreen();
//     bool cartWithProducts = false;
//     // bool isInCart = false;
//     if (productosCarrito.isNotEmpty) {
//       cartWithProducts = !cartWithProducts;
//     }
//     List listadoCategorias = [];
//     for (var producto in listadoProductos) {
//       if (!listadoCategorias.contains(producto.categoria)) {
//         listadoCategorias.add(producto.categoria);
//       }
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Módulo de ventas',
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(
//                 right: MediaQuery.of(context).size.width * 0.04),
//             child: IconButton(
//               onPressed: () async {
//                 if (productosCarrito.isEmpty == false) {
//                   {
//                     detalleVenta(context, productosCarrito);
//                   }
//                 } else {
//                   sinProductos(context);
//                 }
//               },
//               icon: Stack(
//                 children: [
//                   const Icon(
//                     Icons.shopping_cart_outlined,
//                     size: 35,
//                   ),
//                   Visibility(
//                     visible: cartWithProducts,
//                     child: Positioned(
//                       child: ClipOval(
//                         child: Container(
//                           color: const Color(0xFFF95959),
//                           width: 15,
//                           height: 15,
//                           child: Center(
//                             child: Text(
//                               productosCarrito.length.toString(),
//                               style: const TextStyle(
//                                   color: Colors.white, fontSize: 12),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//         toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//       ),
//       drawer: const SideBar(),
//       body: Consumer<ProductService>(builder: (context, listado, child) {
//         final filterProducts = listado.listadoproductos.where((product) {
//           return selectedCategories.isEmpty ||
//               selectedCategories.contains(product.categoria);
//         }).toList();

//         return Column(
//           children: [
//             Stack(
//               children: [
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Wrap(
//                       spacing: 10.0, // Espacio horizontal entre los chips
//                       runSpacing: 10.0,
//                       children:
//                           productoProvider.listadocategorias.map((categoria) {
//                         return FilterChip(
//                           selected: selectedCategories
//                               .contains(categoria.categoriaId),
//                           label: Text(categoria.nombre),
//                           onSelected: (selected) {
//                             setState(() {
//                               if (selected) {
//                                 selectedCategories.add(categoria.categoriaId);
//                               } else {
//                                 selectedCategories
//                                     .remove(categoria.categoriaId);
//                               }
//                             });
//                           },
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   bottom: 0,
//                   right: 0,
//                   child: Container(
//                     width: 30,
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.centerRight,
//                         end: Alignment.centerLeft,
//                         colors: [
//                           Colors.grey.withOpacity(0.5),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const Divider(
//               height: 1,
//             ),
//             Expanded(
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, childAspectRatio: 0.66),
//                 itemCount: filterProducts.length,
//                 itemBuilder: (context, index) {
//                   final product = filterProducts[index];
//                   Uint8List bytes =
//                       Uint8List.fromList(base64.decode(product.imagen));
//                   Image imagenProducto = Image.memory(bytes);

//                   return Card(
//                     color: SweetCakeTheme.blue,
//                     elevation: 8,
//                     margin: const EdgeInsets.all(5),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.all(5),
//                           child: Column(
//                             children: [
//                               Container(
//                                 width: 90,
//                                 height: 90,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(200),
//                                   shape: BoxShape.rectangle,
//                                   image: DecorationImage(
//                                     image: imagenProducto.image,
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                               Text(
//                                 product.nombre,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.center,
//                               ),
//                               Text(
//                                 NumberFormat.currency(
//                                   locale: 'es',
//                                   symbol: '\$',
//                                   decimalDigits: 0,
//                                   customPattern: '\$ #,##0',
//                                 ).format(
//                                     double.parse(product.precio.toString())),
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.w400),
//                               ),
//                             ],
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             setState(
//                               () {
//                                 productosCarrito.add(product);
//                               },
//                             );
//                           },
//                           child: const Icon(Icons.add),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height * 0.1,
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     if (productosCarrito.isEmpty == false) {
//                       {
//                         detalleVenta(context, productosCarrito);
//                       }
//                     } else {
//                       return sinProductos(context);
//                     }
//                   },
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: Size(
//                       (MediaQuery.of(context).size.width * 0.6),
//                       (MediaQuery.of(context).size.height * 0.7),
//                     ),
//                   ),
//                   child: const Text('Pasar por el carrito'),
//                 ),
//               ),
//             )
//           ],
//         );
//       }),
//     );
//   }
// }
