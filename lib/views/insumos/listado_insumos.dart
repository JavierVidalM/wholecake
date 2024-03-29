// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/supplies.dart';
import 'package:wholecake/services/supplies_services.dart';
import 'package:wholecake/views/insumos/insumos_search.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/insumos/insumos.dart';

class ListadoInsumos extends StatefulWidget {
  const ListadoInsumos({Key? key}) : super(key: key);

  @override
  _ListadoInsumosState createState() => _ListadoInsumosState();
}

class _ListadoInsumosState extends State<ListadoInsumos> {
  Future<void> _refresh() async {
    await SuppliesService().loadSupplies();
  }

  bool ordenDescendiente = false;

  Future<void> deletePopup(
      int suppliesId, List<SuppliesList> suppliesList) async {
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
                suppliesList.removeWhere(
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

  @override
  Widget build(BuildContext context) {
    final listadoView = Provider.of<SuppliesService>(context);
    if (listadoView.isLoading) return const LoadingScreen();
    final listaInsumos = listadoView.suppliesList;

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
          builder: (context, suppliesList, child) {
            final listadoDescendiente = listaInsumos
              ..sort(
                (insumo1, insumo2) => ordenDescendiente
                    ? insumo1.cantidad.compareTo(insumo2.cantidad)
                    : insumo2.cantidad.compareTo(insumo1.cantidad),
              );
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(
                              () => ordenDescendiente = !ordenDescendiente);
                        },
                        icon: ordenDescendiente
                            ? const Icon(Icons.arrow_downward_rounded)
                            : const Icon(Icons.arrow_upward_rounded),
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
                                      delegate: InsumosSearch(listaInsumos),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showSearch(
                                    context: context,
                                    delegate: InsumosSearch(listaInsumos),
                                  );
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
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
                      itemCount: listaInsumos.length,
                      itemBuilder: (context, index) {
                        final supplies = listadoDescendiente[index];
                        Uint8List bytes = Uint8List.fromList(
                          base64.decode(supplies.imagen_supplies),
                        );
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
                                                  listadoView.selectedSupplies =
                                                      listadoView
                                                          .suppliesList[index]
                                                          .copy();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          const InputsReciptSupplies(),
                                                    ),
                                                  );
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  deletePopup(
                                                    supplies.suppliesId,
                                                    listadoView.suppliesList,
                                                  );
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Insumo: ${supplies.nombreInsumo.toString().padRight(10)}',
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Estado: ${supplies.estado.toString().padRight(10)}',
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Fecha Llegada: ${supplies.fechaLlegada.toString().padRight(10)}',
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Cantidad: ${supplies.cantidad.toString().padRight(10)}',
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
