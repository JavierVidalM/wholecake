import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';
// import 'lista_ejemplo.dart';
import 'package:wholecake/services/productos_services.dart';
import 'dart:convert';
import 'dart:typed_data';

class SellsView extends StatefulWidget {
  const SellsView({super.key});

  @override
  _SellsViewState createState() => _SellsViewState();
}

Future<void> _refresh() async {
  // await ProductService().loadNoSeQueWea();
}

class _SellsViewState extends State<SellsView> {
  bool isSelected = false;
  List selectedCategories = [];

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

  Future<void> detalleVenta(BuildContext context, productselected) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          contentPadding: const EdgeInsets.only(right: 0, left: 0),
          insetPadding: const EdgeInsets.all(0),
          // titlePadding: EdgeInsets.all(10),
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
            children: productselected.map((item) {
              final int quantityInCart = productselected
                  .where((product) => product.id == item.id)
                  .length;
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(item.image),
                ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final listado = Provider.of<ProductService>(context);
    final listadoProductos = listado.listadoproductos;
    final listacat = Provider.of<ProductService>(context);

    List productselected = [];
    Map<Listado, int> cartQuantities = {};
    Map<Listado, int> cartItems = {};

    final filterProducts = listado.listadoproductos.where((product) {
      return productselected.isEmpty ||
          productselected.contains(product.categoria);
    }).toList();

    if (listado.isLoading) return const LoadingScreen();
    bool cartWithProducts = false;
    // bool isInCart = false;
    if (productselected.isNotEmpty) {
      cartWithProducts = !cartWithProducts;
    }
    // if (productselected.isNotEmpty) {
    //   isInCart = !isInCart;
    // }
    List listadoCategorias = [];
    for (var producto in listadoProductos) {
      if (!listadoCategorias.contains(producto.categoria)) {
        listadoCategorias.add(producto.categoria);
      }
    }

    final filteredProducts = listadoProductos.where(
      (product) {
        return selectedCategories.isEmpty ||
            selectedCategories.contains(product.categoria);
      },
    ).toList();

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
                    detalleVenta(context, productselected);
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
                              productselected.length.toString(),
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
      body: Column(
        children: [
          Stack(
            children: [
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child:
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Wrap(
                  spacing: 10.0, // Espacio horizontal entre los chips
                  runSpacing: 10.0,
                  children: listadoCategorias.map((categoria) {
                    return FilterChip(
                      selected: listadoCategorias.contains(categoria),
                      label: Text(categoria.toString()),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedCategories.add(categoria);
                          } else {
                            selectedCategories.remove(categoria);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              // ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.01,
                  right: 0,
                  child: const Icon(Icons.arrow_forward_ios_rounded))
            ],
          ),
          const Divider(
            height: 1,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 0.66),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                String nombrecat = '';
                for (var categoria in listacat.listadocategorias) {
                  if (categoria.categoriaId == product.categoria) {
                    nombrecat = categoria.nombre;
                    break;
                  }
                }

                final int? quantityInCart =
                    cartItems.containsKey(product) ? cartItems[product] : 0;
                // final int quantityInCart = productselected
                //     .where((item) => item.id == product.id)
                //     .length;

                Uint8List bytes =
                    Uint8List.fromList(base64.decode(product.imagen));
                Image image = Image.memory(bytes);

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
                                  image: image.image,
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
                              ).format(double.parse(product.precio.toString())),
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
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
                      detalleVenta(context, productselected);
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
