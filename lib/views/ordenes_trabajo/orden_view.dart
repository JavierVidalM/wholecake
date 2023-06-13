import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/suppliers.dart';
import 'package:wholecake/models/ordendetrabajo.dart';
import 'package:wholecake/services/ordentrabajo_services.dart';
import 'package:wholecake/views/ordenes_trabajo/ordentrabajo.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'dart:typed_data';

class OrdenesView extends StatefulWidget {
  const OrdenesView({Key? key}) : super(key: key);

  @override
  _OrdenesViewState createState() => _OrdenesViewState();
}

Future<void> _refresh() async {
  await OrdenTrabajoService().loadOrdenTrabajo();
}

ListSup? supplierSeleccionada;

// void filterProducts(String category) {
//     final listadoView = Provider.of<ProductService>();
//     listadoView.filterProductsByCategory(category);
//   }

class _OrdenesViewState extends State<OrdenesView> {
  Future<String?> filterPopup(OrdenTrabajoService listaorden) =>
      showDialog<String>(
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

  Future<void> deletePopup(int id, ListTrabajo) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "¿Estás seguro de que deseas eliminar el proveedor?",
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
    final listadoView = Provider.of<OrdenTrabajoService>(context);
    if (listadoView.isLoading) return const LoadingScreen();

    return ChangeNotifierProvider(
      create: (_) => OrdenTrabajoService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Listado ordenes de trabajo',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<OrdenTrabajoService>(
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
                                      delegate: OrdenTrabajoSearch(
                                          listadoView.listaTrabajos),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showSearch(
                                    context: context,
                                    delegate: OrdenTrabajoSearch(
                                        listadoView.listaTrabajos),
                                  );
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
                                builder: (context) => const OrdenAddPage()),
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
                      itemCount: listado.listaTrabajos.length,
                      itemBuilder: (context, index) {
                        final ordendetrabajo = listado.listaTrabajos[index];
                        Uint8List bytes = Uint8List.fromList(
                            base64.decode(ordendetrabajo.imagen));
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
                                      bottom:
                                          MediaQuery.of(context).size.height *
                                              0.01),
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
                                              ordendetrabajo.nombreProducto,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  listadoView
                                                          .selectedordenTrabajo =
                                                      listado
                                                          .listaTrabajos[index]
                                                          .copy();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdenEdit()),
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  deletePopup(ordendetrabajo.id,
                                                      listado.listaTrabajos);
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Nombre: ${ordendetrabajo.nombreProducto.toString().padRight(10)}',
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Estado: ${ordendetrabajo.estadoProducto.toString().padRight(10)}',
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Precio: ${ordendetrabajo.precioProducto.toString().padRight(10)}',
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
