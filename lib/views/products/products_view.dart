import 'dart:convert';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/products/products_filter_view.dart';
import 'package:wholecake/views/utilities/sidebar.dart';
import 'package:wholecake/views/utilities/loading_screen.dart';
import 'package:wholecake/views/products/products_add.dart';
import 'package:wholecake/views/products/products_edit.dart';
import 'dart:typed_data';
import 'package:intl/intl.dart';

class ProductsView extends StatefulWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  _ProductsViewState createState() => _ProductsViewState();
}

Future<void> _refresh() async {
  await ProductService().loadProductos();
}

class _ProductsViewState extends State<ProductsView> {
  int? _selectedCategory;
  List productsSelected = [];

  Future<String?> filterPopup(ProductService listacat) => showDialog<String>(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Filtro"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.02,
                        bottom: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: const Text("Categoría"),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: DropdownButtonFormField<ListElement>(
                            hint: const Text('Selecciona una categoría'),
                            value: _selectedCategory != null
                                ? listacat.listadocategorias.firstWhere(
                                    (categoria) =>
                                        categoria.categoriaId ==
                                        _selectedCategory)
                                : null,
                            onChanged: (ListElement? nuevaCategoria) {
                              setState(() {
                                _selectedCategory = nuevaCategoria?.categoriaId;
                                print('la categoria es $_selectedCategory');
                              });
                            },
                            items: listacat.listadocategorias.map((categoria) {
                              return DropdownMenuItem<ListElement>(
                                value: categoria,
                                child: Text(categoria.nombre),
                              );
                            }).toList(),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _selectedCategory = null;
                            clearFilter();
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.filter_alt_off_outlined),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.width * 0.01,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            updateFilterProducts();
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Filtrar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

  void updateFilterProducts() {
    productsSelected.clear();
    if (_selectedCategory != null) {
      productsSelected.add(_selectedCategory!);
    }
    setState(() {});
  }

  void clearFilter() {
    productsSelected.clear();
    setState(() {});
  }

  Future<void> deletePopup(int productId, listadoProducto) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "¿Estás seguro de que deseas eliminar el producto?",
          textAlign: TextAlign.center,
        ),
        content:
            const Text("Esta acción no podrá deshacerse una vez completada."),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.01,
              right: MediaQuery.of(context).size.width * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final msg = jsonEncode({
                      'id': productId,
                    });
                    await ProductService().deleteProducto(msg);
                    setState(() {
                      listadoProducto.removeWhere(
                          (product) => product.productoId == productId);
                    });
                  },
                  child: const Text(
                    "Eliminar",
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> viewProductPopup(prodImage, prodName, prodCategory, prodElab,
      prodExpire, prodPrice, prodId, listado) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              titlePadding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: MediaQuery.of(context).size.width * 0.02),
              actionsPadding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.05),
              title: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close_rounded)),
                    ],
                  ),
                  SizedBox(
                    width: 250,
                    height: 250,
                    child: ClipOval(
                      child: prodImage,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                    color: SweetCakeTheme.pink1,
                    child: Table(
                      border: TableBorder(
                          top: BorderSide.none,
                          bottom: BorderSide.none,
                          left: BorderSide.none,
                          right: BorderSide.none,
                          horizontalInside:
                              BorderSide(width: 1, color: Colors.black12),
                          verticalInside:
                              BorderSide(width: 1, color: Colors.black12)),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Nombre producto'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(prodName),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Categoría'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(prodCategory),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Fecha Elaboración'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(prodElab),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Fecha Vencimiento'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(prodExpire),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Precio'),
                              ),
                            ),
                            TableCell(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  NumberFormat.currency(
                                    locale: 'es',
                                    symbol: '\$',
                                    decimalDigits: 0,
                                    customPattern: '\$ #,##0',
                                  ).format(double.parse(prodPrice.toString())),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.01),
                    //       child: Text("Producto: $prodName"),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.01),
                    //       child: Text("Categoria $prodCategory"),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.01),
                    //       child: Text("Fecha elaboración $prodElab"),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.01),
                    //       child: Text("Fecha vencimiento $prodExpire"),
                    //     ),
                    //     Padding(
                    //       padding: EdgeInsets.only(
                    //           top: MediaQuery.of(context).size.height * 0.01),
                    //       child: Text("Precio $prodPrice"),
                    //     ),
                    //   ],
                    // ),
                    ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {

                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deletePopup(prodId, listado);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    // final List<Listado> prod = listadoView.listadoproductos;
    final listacat = Provider.of<ProductService>(context);

    return ChangeNotifierProvider(
        create: (_) => ProductService(),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Listado de productos',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              toolbarHeight: MediaQuery.of(context).size.height * 0.1,
            ),
            drawer: const SideBar(),
            body: Consumer<ProductService>(
              builder: (context, listado, child) {
                final filterProducts =
                    listado.listadoproductos.where((product) {
                  return productsSelected.isEmpty ||
                      productsSelected.contains(product.categoria);
                }).toList();
                // final producto = listado.listadoproductos[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03,
                        vertical: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Row(
                        children: [
                          // Botón de filtro
                          IconButton(
                            onPressed: () {
                              filterPopup(listacat);
                            },
                            icon: const Icon(Icons.filter_alt_outlined),
                          ),
                          // Campo de entrada de texto y botón de búsqueda
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: const Text('Buscar'),
                                      onTap: () {
                                        showSearch(
                                          context: context,
                                          delegate: ProductSearch(
                                              listadoView.listadoproductos),
                                        );
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // Lógica para buscar
                                    },
                                    icon: const Icon(Icons.search),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProductsAdd()),
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: MediaQuery.of(context).size.height * 0.005),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: _refresh,
                        child: ListView.builder(
                          itemCount: filterProducts.length,
                          // itemCount: (productsSelected.isEmpty)
                          //     ? listado.listadoproductos.length
                          //     : productsSelected.length,
                          itemBuilder: (context, index) {
                            final product = filterProducts[index];
                            String nombrecat = '';
                            for (var categoria in listacat.listadocategorias) {
                              if (categoria.categoriaId == product.categoria) {
                                nombrecat = categoria.nombre;
                                break;
                              }
                            }
                            Uint8List bytes = Uint8List.fromList(
                                base64.decode(product.imagen));
                            Image image = Image.memory(bytes);
                            return GestureDetector(
                              onTap: () {
                                viewProductPopup(
                                    image,
                                    product.nombre,
                                    nombrecat,
                                    product.fechaElaboracion,
                                    product.fechaVencimiento,
                                    product.precio,
                                    product.productoId,
                                    listado.listadoproductos);
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 120,
                                        height: 120,
                                        margin: EdgeInsets.only(
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.01,
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          shape: BoxShape.rectangle,
                                          image: DecorationImage(
                                            image: image.image,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Card(
                                                color: SweetCakeTheme.pink1,
                                                elevation: 3,
                                                child: Table(
                                                  border: TableBorder(
                                                    top: BorderSide.none,
                                                    bottom: BorderSide.none,
                                                    left: BorderSide.none,
                                                    right: BorderSide.none,
                                                    horizontalInside:
                                                        BorderSide(
                                                            width: 1,
                                                            color:
                                                                Colors.black26),
                                                    verticalInside: BorderSide(
                                                        width: 1,
                                                        color: Colors.black26),
                                                  ),
                                                  defaultVerticalAlignment:
                                                      TableCellVerticalAlignment
                                                          .middle,
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                'Nombre producto'),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              product.nombre,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                'Categoría'),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                                '$nombrecat'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    TableRow(
                                                      children: [
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child:
                                                                Text('Precio'),
                                                          ),
                                                        ),
                                                        TableCell(
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    8.0),
                                                            child: Text(
                                                              NumberFormat
                                                                  .currency(
                                                                locale: 'es',
                                                                symbol: '\$',
                                                                decimalDigits:
                                                                    0,
                                                                customPattern:
                                                                    '\$ #,##0',
                                                              ).format(double
                                                                  .parse(product
                                                                      .precio
                                                                      .toString())),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                                //     Column(
                                                //   children: [
                                                //     Row(
                                                //       children: [
                                                //         Expanded(
                                                //           child: Text(
                                                //             product.nombre,
                                                //             maxLines: 2,
                                                //             overflow: TextOverflow
                                                //                 .ellipsis,
                                                //           ),
                                                //         ),
                                                //         Row(
                                                //           children: [
                                                //             IconButton(
                                                //               onPressed: () {
                                                //                 // filterProducts[index]
                                                //                 //     .copy();
                                                //                 print(product
                                                //                     .productoId);
                                                //                 Navigator.push(
                                                //                   context,
                                                //                   MaterialPageRoute(
                                                //                     builder: (context) =>
                                                //                         ProductsEdit(
                                                //                             productId:
                                                //                                 product.productoId),
                                                //                   ),
                                                //                 );
                                                //                 // Navigator.push(
                                                //                 //   context,
                                                //                 //   MaterialPageRoute(
                                                //                 //       builder: (context) =>
                                                //                 //           ProductsEdit()),
                                                //                 // );
                                                //               },
                                                //               icon: const Icon(
                                                //                   Icons.edit),
                                                //             ),
                                                //             IconButton(
                                                //               onPressed:
                                                //                   () async {
                                                //                 deletePopup(
                                                //                     product
                                                //                         .productoId,
                                                //                     listado
                                                //                         .listadoproductos);
                                                //               },
                                                //               icon: const Icon(
                                                //                   Icons.delete),
                                                //             ),
                                                //           ],
                                                //         ),
                                                //       ],
                                                //     ),
                                                //     SizedBox(
                                                //       height: 25,
                                                //       width:
                                                //           MediaQuery.of(context)
                                                //               .size
                                                //               .width,
                                                //       child: Text(
                                                //         'Categoría:$nombrecat',
                                                //         textAlign:
                                                //             TextAlign.start,
                                                //       ),
                                                //     ),

                                                //     // const SizedBox(height: 10),
                                                //     // Text(
                                                //     //   'Elaboración: ${product.fechaElaboracion.toString().substring(0, 10)}',
                                                //     // ),
                                                //     // const SizedBox(height: 5),
                                                //     // Text(
                                                //     //   'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
                                                //     // ),
                                                //     SizedBox(
                                                //       height: 25,
                                                //       width:
                                                //           MediaQuery.of(context)
                                                //               .size
                                                //               .width,
                                                //       child: Text(
                                                //         NumberFormat.currency(
                                                //           locale: 'es',
                                                //           symbol: '\$',
                                                //           decimalDigits: 0,
                                                //           customPattern:
                                                //               '\$ #,##0',
                                                //         ).format(double.parse(
                                                //             product.precio
                                                //                 .toString())),
                                                //       ),
                                                //     ),
                                                //   ],
                                                // ),
                                                ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            )));
  }
}

// import 'dart:convert';
// import 'package:date_time_picker/date_time_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wholecake/models/productos.dart';
// import 'package:wholecake/services/productos_services.dart';
// import 'package:wholecake/theme/theme.dart';
// import 'package:wholecake/views/products/products_filter_view.dart';
// import 'package:wholecake/views/utilities/sidebar.dart';
// import 'package:wholecake/views/utilities/loading_screen.dart';
// import 'package:wholecake/views/products/products_add.dart';
// import 'package:wholecake/views/products/products_edit.dart';
// import 'dart:typed_data';
// import 'package:intl/intl.dart';

// class ProductsView extends StatefulWidget {
//   const ProductsView({Key? key}) : super(key: key);

//   @override
//   _ProductsViewState createState() => _ProductsViewState();
// }

// Future<void> _refresh() {
//   return Future.delayed(Duration(seconds: 2));
// }

// String _selectedCategory = 'Seleccione categoría';
// String? _selectedDate;

// // void filterProducts(String category) {
// //     final listadoView = Provider.of<ProductService>();
// //     listadoView.filterProductsByCategory(category);
// //   }

// class _ProductsViewState extends State<ProductsView> {
//   String _selectedCategory = 'Seleccione categoría';

//   Future<String?> filterPopup() => showDialog<String>(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text("Filtro"),
//           content: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.02,
//                     bottom: MediaQuery.of(context).size.height * 0.01,
//                   ),
//                   child: const Text("Categoría"),
//                 ),
//                 DropdownButtonFormField<String>(
//                   value: _selectedCategory,
//                   items: <String>[
//                     'Seleccione categoría',
//                     'Tortas',
//                     'Tartaletas',
//                     'Pies',
//                     'Pasteles',
//                     'Dulces',
//                     'Masas',
//                   ].map((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 0),
//                         child: Text(value),
//                       ),
//                     );
//                   }).toList(),
//                   onChanged: (newvalue) {
//                     setState(() {
//                       _selectedCategory = newvalue!;
//                     });
//                   },
//                   borderRadius: BorderRadius.circular(20),
//                   icon: const Icon(Icons.expand_more),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).size.height * 0.02,
//                     bottom: MediaQuery.of(context).size.height * 0.01,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: EdgeInsets.only(
//                   bottom: MediaQuery.of(context).size.height * 0.02,
//                   right: MediaQuery.of(context).size.width * 0.03),
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context); // Cierra el AlertDialog

//                   // Llama a la función de filtrado de productos pasando las opciones seleccionadas
//                   // filterProducts(_selectedCategory);
//                 },
//                 child: const Text("filtrar"),
//               ),
//             )
//           ],
//         ),
//       );

//   // void productosBusqueda(List<> searchProductsList) {}

//   @override
//   Widget build(BuildContext context) {
//     final listadoView = Provider.of<ProductService>(context);
//     if (listadoView.isLoading) return const LoadingScreen();
//     print('douuuuu ${listadoView.listadoproductos}');
//     final List<Listado> prod = listadoView.listadoproductos;

//     return ChangeNotifierProvider(
//         create: (_) => ProductService(),
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 'Listado de productos',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               toolbarHeight: MediaQuery.of(context).size.height * 0.1,
//             ),
//             drawer: const SideBar(),
//             body: Consumer<ProductService>(
//               builder: (context, listado, child) {
//                 // final producto = listado.listadoproductos[index];
//                 return Column(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: MediaQuery.of(context).size.width * 0.03,
//                         vertical: MediaQuery.of(context).size.height * 0.01,
//                       ),
//                       child: Row(
//                         children: [
//                           // Botón de filtro
//                           IconButton(
//                             onPressed: () {
//                               filterPopup();
//                             },
//                             icon: const Icon(Icons.filter_alt_outlined),
//                           ),
//                           // Campo de entrada de texto y botón de búsqueda
//                           Expanded(
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: ListTile(
//                                       title: const Text('Buscar'),
//                                       onTap: () {
//                                         showSearch(
//                                           context: context,
//                                           delegate: ProductSearch(
//                                               listadoView.listadoproductos),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   IconButton(
//                                     onPressed: () {
//                                       // Lógica para buscar
//                                     },
//                                     icon: const Icon(Icons.search),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const ProductsAdd()),
//                               );
//                             },
//                             icon: const Icon(Icons.add),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Divider(height: MediaQuery.of(context).size.height * 0.005),
//                     Expanded(
//                       child: RefreshIndicator(
//                         onRefresh: _refresh,
//                         child: ListView.builder(
//                           itemCount: listado.listadoproductos.length,
//                           itemBuilder: (context, index) {
//                             final product = listado.listadoproductos[index];
//                             Uint8List bytes = Uint8List.fromList(
//                                 base64.decode(product.imagen));
//                             Image image = Image.memory(bytes);
//                             return Card(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(12),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 100,
//                                       height: 100,
//                                       margin: EdgeInsets.only(
//                                           right: MediaQuery.of(context)
//                                                   .size
//                                                   .width *
//                                               0.03,
//                                           top: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.01,
//                                           bottom: MediaQuery.of(context)
//                                                   .size
//                                                   .height *
//                                               0.01),
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         shape: BoxShape.rectangle,
//                                         image: DecorationImage(
//                                           image: image.image,
//                                           fit: BoxFit.fill,
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   product.nombre,
//                                                   maxLines: 2,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   IconButton(
//                                                     onPressed: () {
//                                                       listadoView
//                                                               .selectedProduct =
//                                                           listado
//                                                               .listadoproductos[
//                                                                   index]
//                                                               .copy();
//                                                       print(
//                                                           'este es el listado');
//                                                       print(listado
//                                                           .selectedProduct);
//                                                       Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 ProductsEdit()),
//                                                       );
//                                                     },
//                                                     icon: Icon(Icons.edit),
//                                                   ),
//                                                   IconButton(
//                                                     onPressed: () async {
//                                                       final msg = jsonEncode({
//                                                         'id': product.productoId
//                                                       });
//                                                       await ProductService()
//                                                           .deleteProducto(msg);
//                                                       setState(() {
//                                                         listado.listadoproductos
//                                                             .removeAt(index);
//                                                       });
//                                                     },
//                                                     icon: Icon(Icons.delete),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(height: 10),
//                                           Text(
//                                               'Categoría: ${product.categoria}'),
//                                           SizedBox(height: 10),
//                                           Text(
//                                             'Elaboración: ${product.fechaElaboracion.toString().substring(0, 10)}',
//                                           ),
//                                           SizedBox(height: 5),
//                                           Text(
//                                             'Vencimiento: ${product.fechaVencimiento.toString().substring(0, 10)}',
//                                           ),
//                                           SizedBox(height: 10),
//                                           Text(
//                                             NumberFormat.currency(
//                                               locale: 'es',
//                                               symbol: '\$',
//                                               decimalDigits: 0,
//                                               customPattern: '\$ #,##0',
//                                             ).format(double.parse(
//                                                 product.precio.toString())),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             )));
//   }
// }
