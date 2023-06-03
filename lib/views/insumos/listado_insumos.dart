import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/supplies.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/ordenes_compra/purchase_orders.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'dart:convert';
import 'dart:typed_data';
//////////////////////////////////////////////////////////////////agregar nueva ruta del editar
// import 'package:wholecake/views/suppliers/suppliers_edit.dart';
import '../../services/supplies_services.dart';

class ListadoInsumos extends StatefulWidget {
  const ListadoInsumos({Key? key}) : super(key: key);

  @override
  _ListadoInsumosState createState() => _ListadoInsumosState();
}

Future<void> _refresh() {
  return Future.delayed(Duration(seconds: 2));
}

SuppliesList? suppliesSeleccionada;

// void filterProducts(String category) {
//     final listadoView = Provider.of<SuppliesService>();
//     listadoView.filterProductsByCategory(category);
//   }

class _ListadoInsumosState extends State<ListadoInsumos> {
  int? _selectedCategory = null;

  Future<String?> filterPopup(SuppliesService listacat) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Filtro"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.02,
                  bottom: MediaQuery.of(context).size.height * 0.01,
                )),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Filtrar",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );

  Future<void> deletePopup(int suppliesId, SuppliesList) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "¿Estás seguro de que deseas eliminar el Insumo?",
          textAlign: TextAlign.center,
        ),
        content:
            const Text("Esta acción no podrá deshacerse una vez completada."),
        actions: [
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
                'id': suppliesId,
              });
              await SuppliesService().deleteSupplies(msg);
              setState(() {
                SuppliesList.removeWhere(
                    (supplies) => supplies.suppliesId == suppliesId);
              });
            },
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> cargandoPantalla() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Diálogo sin cierre por el usuario"),
        content: const Text("Este diálogo no se puede cerrar por el usuario."),
        actions: [
          TextButton(
            onPressed: () {
              // Acción del botón
              Navigator.of(context).pop();
            },
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<SuppliesService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final List<SuppliesList> prod = listadoView.suppliesList;
    final listacat = Provider.of<SuppliesService>(context);

    return ChangeNotifierProvider(
      create: (_) => SuppliesService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Listado de Insumos',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<SuppliesService>(
          builder: (context, listado, child) {
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
                              // Expanded(
                              //   child: ListTile(
                              //     title: const Text('Buscar'),
                              //     onTap: () {
                              //       showSearch(
                              //         context: context,
                              //         delegate: ProductSearch(
                              //             listadoView.listadosuppliers,),
                              //       );
                              //     },
                              //   ),
                              // ),
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
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => const SuppliersAddPage(),
                          //   ),
                          // );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                      itemCount: listado.suppliesList.length,
                      itemBuilder: (context, index) {
                        final supplies = listado.suppliesList[index];
                          Uint8List bytes = Uint8List.fromList(
                          base64.decode(supplies.imagen_supplies));
                      Image image = Image.memory(bytes);
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.03,
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    bottom: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              supplies.nombreInsumo,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  // listadoView.selectedSupplies =
                                                  //     listado
                                                  //         .suppliesList[index]
                                                  //         .copy();
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //         SuppliersEdit(),
                                                  //   ),
                                                  // );
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  deletePopup(
                                                    supplies.suppliesId,
                                                    listado.suppliesList,
                                                  );
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Insumo: ${supplies.nombreInsumo.toString().padRight(10)}',
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Estado: ${supplies.estado.toString().padRight(10)}',
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Fecha Llegada: ${supplies.fechaLlegada.toString().padRight(10)}',
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
