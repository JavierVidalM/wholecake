import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ordendetrabajo.dart';
import 'package:wholecake/models/supplies.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/services/supplies_services.dart';
import 'package:wholecake/services/ordentrabajo_services.dart';
import 'package:wholecake/models/categoria.dart';
import 'dart:convert';
import 'dart:typed_data';

class OrdenEdit extends StatefulWidget {
  @override
  _OrdenEditState createState() => _OrdenEditState();
}

Future<void> _refresh() async {
  await SuppliesService().loadSupplies();
}

class _OrdenEditState extends State<OrdenEdit> {
  late OrdenTrabajoService _ordenTrabajoService;
  final TextEditingController _fechaElaboracionController =
      TextEditingController();
  final TextEditingController _fechaVencimientoController =
      TextEditingController();
  final TextEditingController _categoriaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  bool isSelected = false;
  Map<int, SuppliesList> insumosOrden = {};
  List<TextEditingController> cantidadControllers = [];

  Future<void> _guardarOrden(selectedOrdenTrabajo, listadoInsumo) async {
    Map<String, dynamic> jsonData = {
      'producto_id': selectedOrdenTrabajo.id,
      "fecha_elaboracion": selectedOrdenTrabajo.fechaElaboracion,
      "fecha_vencimiento": selectedOrdenTrabajo.fechaVencimiento,
      "estado": selectedOrdenTrabajo.estadoProducto,
      "categoria": selectedOrdenTrabajo.categoria,
      "trabajador": 1,
      "insumos": listadoInsumo
    };

    final msg = jsonEncode(jsonData);
    await OrdenTrabajoService().updateTrabajo(msg);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdenEdit(),
      ),
    );
    setState(() {
      insumosOrden = {};
    });
  }

  @override
  void initState() {
    super.initState();
    _ordenTrabajoService =
        Provider.of<OrdenTrabajoService>(context, listen: false);
    loadOrdenDetails();
  }

  void loadOrdenDetails() {
    final ordentrabajoService =
        Provider.of<OrdenTrabajoService>(context, listen: false);
    final orden = ordentrabajoService.listaTrabajos.firstWhere(
      (orden) => orden.id == widget,
      orElse: () => ListTrabajo(
          id: 0,
          nombreProducto: '',
          precioProducto: 0,
          fechaElaboracion: '',
          fechaVencimiento: '',
          categoria: 0,
          estadoProducto: '',
          cantidadProducto: 0,
          lote: '',
          imagen: '',
          ordenesTrabajo: []),
    );
    _fechaVencimientoController.text = orden.fechaVencimiento!;
    _fechaElaboracionController.text = orden.fechaElaboracion!;
    _categoriaController.text = orden.categoria.toString();
    _estadoController.text = orden.estadoProducto;
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
          title: const Text("Aún no hay insumos en la orden"),
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

  String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, seleccione una categoría.';
    }
    return null;
  }

  void confirmarEliminarInsumo(BuildContext context, SuppliesList insumo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar insumo'),
          content: const Text('¿Desea eliminar este insumo de la orden?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                eliminarInsumo(insumo);
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

  void eliminarInsumo(SuppliesList insumo) {
    setState(() {
      insumosOrden.remove(insumo.suppliesId);
    });
  }

  void detalleOrdenTrabajo(BuildContext context, Map<int, SuppliesList> insumo,
      ListTrabajo? selectedOrdenTrabajo) async {
    List<SuppliesList> insumosOrden = insumo.values.toList();
    // final ordentrabajoService =
    //     Provider.of<OrdenTrabajoService>(context, listen: false);
    // final orden = ordentrabajoService.listaTrabajos.firstWhere(
    //   (orden) => orden.id == widget,
    //   orElse: () => ListTrabajo(
    //       id: 0,
    //       nombreProducto: '',
    //       precioProducto: 0,
    //       fechaElaboracion: '',
    //       fechaVencimiento: '',
    //       categoria: 0,
    //       estadoProducto: '',
    //       cantidadProducto: 0,
    //       lote: '',
    //       imagen: '',
    //       ordenesTrabajo: []),
    // );
    // print(selectedOrdenTrabajo!.toJson());
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // print(selectedOrdenTrabajo?.id);
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
              Text(selectedOrdenTrabajo!.nombreProducto),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 10,
              ),
            ],
          ),
          content: Column(
            children: insumosOrden.map((item) {
              int quantityInCart = insumosOrden
                  .where((insumo) => insumo.suppliesId == item.suppliesId)
                  .length;
              Uint8List bytes =
                  Uint8List.fromList(base64.decode(item.imagen_supplies));
              Image imagenInsumo = Image.memory(bytes);
              int index = insumosOrden.indexOf(item);
              TextEditingController controller = cantidadControllers[index];

              return ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      image: imagenInsumo.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(item.nombreInsumo),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
                        confirmarEliminarInsumo(context, item);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Estado'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: DropdownButtonFormField<String>(
                        value: 'Elaboracion',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Seleccione un estado";
                          }
                        },
                        onChanged: (value) =>
                            selectedOrdenTrabajo.estadoProducto = value!,
                        items: <String>[
                          'Elaboracion',
                          'Listo',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Categoría'),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Consumer<ProductService>(
                        builder: (context, listacat, _) {
                          ListElement? categoriaSeleccionada;
                          return DropdownButtonFormField<ListElement>(
                            validator: (ListElement? value) =>
                                validateCategory(value?.nombre),
                            hint: const Text('Selecciona una categoría'),
                            value: categoriaSeleccionada,
                            onChanged: (ListElement? nuevaCategoria) {
                              setState(() {
                                _categoriaController.text =
                                    nuevaCategoria!.categoriaId.toString();
                                selectedOrdenTrabajo.categoria =
                                    nuevaCategoria.categoriaId;
                              });
                            },
                            items: listacat.listadocategorias.map((categoria) {
                              return DropdownMenuItem<ListElement>(
                                value: categoria,
                                child: Text(categoria.nombre),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text("Fecha de elaboración"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Theme(
                        data: SweetCakeTheme.calendarTheme,
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialValue: selectedOrdenTrabajo.fechaElaboracion,
                          dateLabelText: 'Fecha de elaboración',
                          onChanged: (value) =>
                              selectedOrdenTrabajo.fechaElaboracion = value,
                          //validator: validateExpirationDate,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Fecha de Vencimiento"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: Theme(
                        data: SweetCakeTheme.calendarTheme,
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          initialValue: selectedOrdenTrabajo.fechaVencimiento,
                          dateLabelText: 'Fecha de vencimiento',
                          onChanged: (value) =>
                              selectedOrdenTrabajo.fechaVencimiento = value,
                          //validator: validateExpirationDate,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            TextButton(
              onPressed: () {
                List<Map<String, dynamic>> listaInsumos = [];
                for (var i = 0; i < insumosOrden.length; i++) {
                  var insumo = insumosOrden[i];
                  var controller = cantidadControllers[i];
                  listaInsumos.add({
                    'insumo_id': insumo.suppliesId,
                    'cantidad_utilizada': int.parse(controller.text),
                  });
                }
                _guardarOrden(selectedOrdenTrabajo, listaInsumos);
                Navigator.pop(context);
              },
              child: const Text("Actualizar orden"),
            ),
          ],
        );
      },
    );
  }

  void agregarAlCarrito(SuppliesList insumo) {
    setState(() {
      if (insumosOrden.containsKey(insumo.suppliesId)) {
        insumosOrden[insumo.suppliesId]!.cantidad++;
      } else {
        insumo.cantidad = 1;
        insumosOrden[insumo.suppliesId] = insumo;
        cantidadControllers.add(TextEditingController(text: '1'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedOrdenTrabajo = _ordenTrabajoService.selectedordenTrabajo;
    final insumoProvider = Provider.of<SuppliesService>(context);

    if (insumoProvider.isLoading) return const LoadingScreen();
    bool cartWithProducts = insumosOrden.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Módulo de insumos',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.04),
            child: IconButton(
              onPressed: () async {
                if (insumosOrden.isEmpty) {
                  sinProductos(context);
                } else {
                  detalleOrdenTrabajo(
                      context, insumosOrden, selectedOrdenTrabajo);
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
                              insumosOrden.length.toString(),
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
      body: Consumer<SuppliesService>(builder: (context, listado, child) {
        final listaInsumos = listado.suppliesList;

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.66,
                ),
                itemCount: listaInsumos.length,
                itemBuilder: (context, index) {
                  final insumo = listaInsumos[index];
                  Uint8List bytes =
                      Uint8List.fromList(base64.decode(insumo.imagen_supplies));
                  Image imagenInsumo = Image.memory(bytes);

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
                                    image: imagenInsumo.image,
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
                                  agregarAlCarrito(insumo);
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
