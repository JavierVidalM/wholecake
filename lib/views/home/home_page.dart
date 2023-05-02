import 'package:flutter/material.dart';
import 'package:wholecake/sidebar.dart';

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
      backgroundColor: const Color(0xFFBDE0FE),
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_SW.png',
          height: MediaQuery.of(context).size.height * 0.08,
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFB5D7),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: SideBar(),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
            Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Column(
                  children: const [
                    Text(
                      "Resumen",
                      style: TextStyle(color: Color(0xFF2C2C2C), fontSize: 24),
                    ),
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              child: SizedBox(
                width: 300,
                height: 350,
                child: Card(
                  child: Row(
                    children: [const Text("hola")],
                  ),
                  // child: MyBarGraph(),
                ),
              ), // ),// child: LineChart(LineChartData())
            ),
          ])),
    );
  }
}
