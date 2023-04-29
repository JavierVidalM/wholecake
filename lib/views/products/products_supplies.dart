import 'package:flutter/material.dart';
import 'package:wholecake/constants.dart';
import 'package:wholecake/views/products/products_box.dart';

class Supplies extends StatefulWidget {
  const Supplies({Key? key}) : super(key: key);

  @override
  State<Supplies> createState() => _SuppliesState();
}

class _SuppliesState extends State<Supplies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBDE0FE),
      appBar: AppBar(
        title: Text("Insumos"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFB5D7),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        titleTextStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 30,
            color: Color.fromARGB(255, 93, 42, 66)),
      ),
      drawer: myDrawer,
      body: Column(
        children: [
          //4 cajas arriba
          AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              width: double.infinity,
              child: GridView.builder(
                itemCount: 8,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return MyBox();
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
