import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import '../../models/ventas.dart';

class SellsView extends StatefulWidget {
  const SellsView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SellsViewState createState() => _SellsViewState();
}

class _SellsViewState extends State<SellsView> {
  List<String> rangoFechasVentas = [];

  Future<void> detalleBoleta(Listventa venta) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: Text(
            'Boleta nro: ${DateFormat('ddMMyy').format(venta.fecha)}${venta.idVenta}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Vendedor: ${venta.vendedor}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Fecha: ${DateFormat('dd/MM/yyyy').format(venta.fecha)}'),
            Text('Hora: ${DateFormat('HH:mm').format(venta.fecha)}'),
            const SizedBox(height: 10),
            const Text('Productos:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const Divider(
              color: SweetCakeTheme.blue2,
            ),
            for (final producto in venta.productos)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nombre: ${producto.nombre}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Cantidad: ${producto.cantidad}'),
                  Text('Precio Unitario: ${producto.precioUnitario}'),
                  Text('Precio Total: ${producto.precioTotal}'),
                  const Divider(
                    color: SweetCakeTheme.blue2,
                  ),
                ],
              ),
            Text('Total de esta venta: ${NumberFormat.currency(
              locale: 'es',
              symbol: '\$',
              decimalDigits: 0,
              customPattern: '\$ #,##0',
            ).format(venta.total)}'),
          ],
        ),
      ),
    );
  }

  Future<void> deletePopup(int idVenta, List<Listventa> ventas) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("¿Estás seguro de que deseas eliminar esta venta?"),
        content:
            const Text("Esta acción no se puede deshacer una vez completada"),
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
              final msg = jsonEncode({'id': idVenta});

              await VentasService().deleteVentas(msg);
              setState(() {
                ventas.removeWhere((venta) => venta.idVenta == idVenta);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Listado de ventas',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: ChangeNotifierProvider(
        create: (_) => VentasService(),
        child: Consumer<VentasService>(
          builder: (context, listadoVentas, child) {
            final filterSells = listadoVentas.listadoventas.where((venta) {
              final formattedFecha =
                  DateFormat('yyyy-MM-dd').format(venta.fecha);
              return rangoFechasVentas.isEmpty ||
                  rangoFechasVentas.contains(formattedFecha);
            }).toList();
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: filterSells.length,
                    itemBuilder: (context, index) {
                      final venta = filterSells[index];
                      return GestureDetector(
                        onTap: () {
                          detalleBoleta(venta);
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Vendedor asignado: ${venta.vendedor}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () => deletePopup(
                                            venta.idVenta,
                                            listadoVentas.listadoventas),
                                        icon: const Icon(
                                            Icons.delete_outline_rounded),
                                      ),
                                    ],
                                  ),
                                  const Divider(
                                    height: 20,
                                    endIndent: 15,
                                    thickness: 1,
                                    color: SweetCakeTheme.blue2,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Número de boleta: ${DateFormat('ddMMyy').format(venta.fecha)}${venta.idVenta}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Fecha: ${DateFormat('dd/MM/yyyy').format(venta.fecha)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        'Hora: ${DateFormat('HH:mm').format(venta.fecha)}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          'Total de esta venta: ${NumberFormat.currency(
                                        locale: 'es',
                                        symbol: '\$',
                                        decimalDigits: 0,
                                        customPattern: '\$ #,##0',
                                      ).format(
                                        double.parse(
                                          venta.total.toString(),
                                        ),
                                      )}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
