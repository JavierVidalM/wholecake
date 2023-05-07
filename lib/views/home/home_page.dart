import 'package:flutter/material.dart';
import 'package:wholecake/sidebar.dart';
import 'package:wholecake/theme/theme.dart';

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
      drawer: SideBar(),
      body: ListView(
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
                  // width: MediaQuery.of(context).size.width * 0.01,
                  height: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Center(
                      child: Text('Aquí irá un gráfico'),
                    ), // child: MyBarGraph(),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
