import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/models/ventas.dart';

import 'package:wholecake/services/users_services.dart';
// import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/services/ventas_services.dart';
import 'package:wholecake/views/login/login.dart';
import 'package:wholecake/views/utilidades/loading_screen.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/theme/theme.dart';

import 'bar_graph/bar_graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String totalLunes = '';
  String totalMartes = '';
  String totalMiercoles = '';
  String totalJueves = '';
  String totalViernes = '';
  String totalSabado = '';
  String totalDomingo = '';

  bool cargando = true;
  Future _carga() async {
    if (UserService().isLoading != false) {
      return const LoadingScreen();
    } else {
      cargando = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (cargando != true) {
    //   _carga();
    // } else {
    return ChangeNotifierProvider(
      create: (_) => VentasService(),
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/logo_SW.png',
            height: MediaQuery.of(context).size.height * 0.08,
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        ),
        drawer: const SideBar(),
        body: Consumer<VentasService>(
          builder: (context, ventas, child) {
            final listadoVentas = ventas.listadoventas;
            final ventasSemana = obtenerVentasSemana(listadoVentas);
            final maxY =
                (obtenerMaximoVentasSemana(ventasSemana) / 1000).ceil() * 1000;
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Resumen",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.01,
                    left: MediaQuery.of(context).size.height * 0.01,
                    right: MediaQuery.of(context).size.height * 0.01,
                  ),
                  child: Theme(
                    data: SweetCakeTheme.graphCardTheme,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: MyBarGraph(
                            maxY: maxY.toDouble(),
                            monAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.monday,
                            ),
                            tueAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.tuesday,
                            ),
                            wedAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.wednesday,
                            ),
                            thuAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.thursday,
                            ),
                            friAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.friday,
                            ),
                            satAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.saturday,
                            ),
                            sunAmount: obtenerVentaDia(
                              ventasSemana,
                              DateTime.sunday,
                            ),
                          ),
//                           child: MyBarGraph(
//   maxY: maxY.toDouble(),
//   monAmount: obtenerVentaDia(ventasSemana, DateTime.monday),
//   tueAmount: obtenerVentaDia(ventasSemana, DateTime.tuesday),
//   wedAmount: obtenerVentaDia(ventasSemana, DateTime.wednesday),
//   thuAmount: obtenerVentaDia(ventasSemana, DateTime.thursday),
//   friAmount: obtenerVentaDia(ventasSemana, DateTime.friday),
//   satAmount: obtenerVentaDia(ventasSemana, DateTime.saturday),
//   sunAmount: obtenerVentaDia(ventasSemana, DateTime.sunday),
//   totalLunes: totalLunes,
//   totalMartes: totalMartes,
//   totalMiercoles: totalMiercoles,
//   totalJueves: totalJueves,
//   totalViernes: totalViernes,
//   totalSabado: totalSabado,
//   totalDomingo: totalDomingo,
// ),
                        ),
                      ),
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

List<Listventa> obtenerVentasSemana(List<Listventa> listadoVentas) {
  final fechaActual = DateTime.now();
  final inicioSemana =
      fechaActual.subtract(Duration(days: fechaActual.weekday - 1));
  final finSemana = inicioSemana.add(Duration(days: 6));
  return listadoVentas.where((venta) {
    return venta.fecha.isAfter(inicioSemana) && venta.fecha.isBefore(finSemana);
  }).toList();
}

double obtenerVentaDia(List<Listventa> ventas, int diaSemana) {
  return ventas
      .where((venta) => venta.fecha.weekday == diaSemana)
      .map((venta) => venta.total)
      .fold(0, (previousValue, ventaTotal) => previousValue + ventaTotal);
}

double obtenerMaximoVentasSemana(List<Listventa> ventas) {
  double maximo = 0;
  for (int i = DateTime.monday; i <= DateTime.sunday; i++) {
    final ventaDia = obtenerVentaDia(ventas, i);
    if (ventaDia > maximo) {
      maximo = ventaDia;
    }
  }
  return maximo;
}
//}
