import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/categoria.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme.dart';
import 'package:wholecake/views/productos/products.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'dart:typed_data';
import 'dart:convert';
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
        actionsPadding:
            EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text("Producto: $prodName"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text("Categoria $prodCategory"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text("Fecha elaboración $prodElab"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text("Fecha vencimiento $prodExpire"),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01),
                  child: Text("Precio $prodPrice"),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {},
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<ProductService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
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
            final filterProducts = listado.listadoproductos.where((product) {
              return productsSelected.isEmpty ||
                  productsSelected.contains(product.categoria);
            }).toList();
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
                      itemBuilder: (context, index) {
                        final product = filterProducts[index];
                        String nombrecat = '';
                        for (var categoria in listacat.listadocategorias) {
                          if (categoria.categoriaId == product.categoria) {
                            nombrecat = categoria.nombre;
                            break;
                          }
                        }
                        Uint8List bytes =
                            Uint8List.fromList(base64.decode(product.imagen));
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
                            child: Row(
                              children: [
                                Container(
                                  width: 130,
                                  height: 130,
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                      image: image.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.15,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text(product.nombre),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text("Categoría: $nombrecat"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text(
                                            "Cantidad: ${product.cantidad}"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01),
                                        child: Text(
                                          NumberFormat.currency(
                                            locale: 'es',
                                            symbol: '\$',
                                            decimalDigits: 0,
                                            customPattern: '\$ #,##0',
                                          ).format(double.parse(
                                              product.precio.toString())),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 40,
                                          height: 50,
                                          child: IconButton(
                                            onPressed: () {
                                              // filterProducts[index]
                                              //     .copy();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductsEdit(
                                                          productId: product
                                                              .productoId),
                                                ),
                                              );
                                            },
                                            icon: const Icon(Icons.edit),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 50,
                                          child: IconButton(
                                            onPressed: () async {
                                              deletePopup(product.productoId,
                                                  listado.listadoproductos);
                                            },
                                            icon: const Icon(
                                                Icons.delete_outline_rounded),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
