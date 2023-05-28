import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wholecake/providers/producto_form_provider.dart';
import 'package:wholecake/services/productos_services.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';
import 'package:wholecake/theme/theme.dart';

import 'bar_graph/bar_graph.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // List<double> weeklySummary = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_SW.png',
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: Consumer<ProductService>(
        builder: (context, value, child) {
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
                  left: MediaQuery.of(context).size.height * 0.03,
                  right: MediaQuery.of(context).size.height * 0.03,
                ),
                child: Theme(
                  data: SweetCakeTheme.graphCardTheme,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: const Card(
                      child: Padding(
                        padding: EdgeInsets.only(top: 15.0),
                        child: MyBarGraph(
                          maxY: 30,
                          monAmount: 10,
                          tueAmount: 12,
                          wedAmount: 15,
                          thuAmount: 5,
                          friAmount: 7,
                          satAmount: 18,
                          sunAmount: 23,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
