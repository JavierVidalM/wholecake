// import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:intl/intl.dart';

class SellsView extends StatefulWidget {
  @override
  _SellsViewState createState() => _SellsViewState();
}

class _SellsViewState extends State<SellsView> {
  List rangoFechasVentas = [];

  void _filtroFecha() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
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
      body: Consumer<VentasService>(builder: (context, listadoVentas, child) {
        final filterSells = listadoVentas.listadoventas.where((venta) {
          return rangoFechasVentas.isEmpty ||
              rangoFechasVentas.contains(venta.fecha);
        }).toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _filtroFecha();
                  },
                  icon: const Icon(Icons.calendar_month_rounded),
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
              ],
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: filterSells.length,
                  itemBuilder: (context, index) {
                    final venta = rangoFechasVentas[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 100,
                        child: ListTile(
                          leading: Text(venta.idVenta),
                          title: Text(venta.fecha),
                          trailing: Text(
                            NumberFormat.currency(
                              locale: 'es',
                              symbol: '\$',
                              decimalDigits: 0,
                              customPattern: '\$ #,##0',
                            ).format(double.parse(venta.total.toString())),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        );
      }),
    );
  }
}
