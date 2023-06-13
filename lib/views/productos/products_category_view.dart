import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/models/categoria.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

Future<void> _refresh() {
  return ProductService().loadCategorias();
}

class _CategoryViewState extends State<CategoryView> {
  // TextEditingController idController = TextEditingController();
  TextEditingController nombreController = TextEditingController();

  @override
  void dispose() {
    // idController.dispose();
    nombreController.dispose();
    super.dispose();
  }

  Future<void> _saveData() async {
    final msg = jsonEncode({
      'nombre': nombreController.text,
    });
    await ProductService().addCategoria(msg);
    // Navigator.of(context).pop();
  }

  Future<void> _editData(id) async {
    // final editmsg = jsonEncode({
    //   'id': id,
    //   'nombre': nombreController.text,
    // });
    // await ProductService().updateCategoria(editmsg);
    // Navigator.of(context).pop();
  }

  Future deletePopup(id,listadocategorias) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Estás seguro de que deseas elimiar el producto?",
            textAlign: TextAlign.center,
          ),
          content:
              const Text("Esta acción no podrá deshacerse una vez completada"),
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
                  'id': id,
                });
                await ProductService().deleteCategoria(msg);
                setState(() {
                  listadocategorias.removeWhere(
                      (product) => product.categoriaId== id);
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

  Future<String?> editCategoryPopup(categoryid) => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Ingrese la categoría"),
          content: TextFormField(
            onChanged: (value) {
              setState(() {
                nombreController.text = value;
              });
            },
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar",
                  //cambia el color
                  style: TextStyle(color: Colors.red, fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                _editData(categoryid);
                final msg = jsonEncode({
                  'id': categoryid,
                  'nombre': nombreController.text,
                });
                // Navigator.of(context).pop();
                ProductService().updateCategoria(msg);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CategoryView(),
                  ),
                );
              },
              child: const Text("Editar", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      );
  Future<String?> addCategoryPopup() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Agregar categoría"),
          content: TextFormField(
            controller: nombreController,
            decoration:
                const InputDecoration(hintText: "Nombre de la categoría"),
            // onChanged: (value) {},
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancelar",
                  //cambia el color
                  style: TextStyle(color: Colors.red, fontSize: 18)),
            ),
            TextButton(
              onPressed: () {
                _saveData();
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const CategoryView(),
                  ),
                );
              },
              child: const Text("Agregar", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final listacat = Provider.of<ProductService>(context);
    if (listacat.isLoading) return const LoadingScreen();

    return ChangeNotifierProvider(
      create: (_) => ProductService(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Listado de categorías',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<ProductService>(
          builder: (context, list, child) {
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Row(
                    children: [
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
                                  onTap: () {},
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
                          addCategoryPopup();
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
                      itemCount: list.listadocategorias.length,
                      itemBuilder: (context, index) {
                        final category = list.listadocategorias[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                              category.nombre,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  editCategoryPopup(
                                                      category.categoriaId);
                                                },
                                                icon: const Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  deletePopup(category.categoriaId,list.listadocategorias);
                                                },
                                                icon: const Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
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
