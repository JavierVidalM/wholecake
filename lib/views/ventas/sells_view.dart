import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/theme/theme_constant.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';

class SellsView extends StatefulWidget {
  @override
  _SellsViewState createState() => _SellsViewState();
}

class _SellsViewState extends State<SellsView> {
  List<String> rangoFechasVentas = [];

  void _filtroFecha() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2024),
    ).then((selectedDate) {
      if (selectedDate != null) {
        final formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
        setState(() {
          rangoFechasVentas.add(formattedDate);
        });
      }
    });
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
                Container(
                  color: SweetCakeTheme.blue,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _filtroFecha();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month_rounded),
                          Text("   Filtrar por fecha"),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filterSells.length,
                    itemBuilder: (context, index) {
                      final venta = filterSells[index];
                      return SizedBox(
                        // height: 100,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Vendedor asignado',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      Text("Nico Robin")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15.0),
                                  child: Container(
                                    height: 80,
                                    width: 1.0,
                                    color: SweetCakeTheme.blue2,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
