import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/productos.dart';
import 'package:wholecake/models/supplies.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:wholecake/services/supplies_services.dart';
import 'dart:convert';
import 'dart:typed_data';

class OrdenAdd extends StatefulWidget {
  const OrdenAdd({super.key});

  @override
  _OrdenAddState createState() => _OrdenAddState();
}

Future<void> _refresh() async {
  await SuppliesService().loadSupplies();
}

class _OrdenAddState extends State<OrdenAdd> {
  bool isSelected = false;
  List selectedCategories = [];
  List<SuppliesList> productosCarrito = [];

  Future<void> _guardarVenta(List<Map<String, dynamic>> listadoVenta) async {
    Map<String, dynamic> jsonData = {
      'productos': listadoVenta,
    };
    final msg = jsonEncode(jsonData);
    await VentasService().addVentas(msg);
    Navigator.pushNamed(context, '/SellsAdd');
    productosCarrito = [];
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
                child: const Text("Aceptar"))
          ],
        );
      },
    );
  }

  Future<void> detalleVenta(
      BuildContext context, List<SuppliesList> insumos) async {
    List productSelected = List.from(insumos);

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
                  .where((insumo) => insumo.suppliesId == item.suppliesId)
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
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (quantityInCart > 1) {
                            productosCarrito.removeLast();
                          } else {
                            productosCarrito.removeWhere((insumo) =>
                                insumo.suppliesId == item.suppliesId);
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
                List<Map<String, dynamic>> listaProductos = [];
                for (var insumo in productosCarrito) {
                  listaProductos.add({
                    'id': insumo.suppliesId,
                    'cantidad': productosCarrito
                        .where((p) => p.suppliesId == insumo.suppliesId)
                        .length,
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

  @override
  Widget build(BuildContext context) {
    final insumoProvider = Provider.of<SuppliesService>(context);
    // while (ProductService().isLoading != false) return const LoadingScreen();
    final listaInsumos = insumoProvider.suppliesList;

    if (insumoProvider.isLoading) return const LoadingScreen();
    bool cartWithProducts = false;
    // bool isInCart = false;
    if (productosCarrito.isNotEmpty) {
      cartWithProducts = !cartWithProducts;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Asignar insumos',
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
      body: Consumer<SuppliesService>(builder: (context, listado, child) {
        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.99),
                itemCount: listaInsumos.length,
                itemBuilder: (context, index) {
                  final insumo = listaInsumos[index];
                  Uint8List bytes =
                      Uint8List.fromList(base64.decode(insumo.imagen_supplies));
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
                                insumo.nombreInsumo,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                insumo.cantidad.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(
                              () {
                                productosCarrito.add(insumo);
                              },
                            );
                          },
                          child: const Icon(Icons.add),
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
