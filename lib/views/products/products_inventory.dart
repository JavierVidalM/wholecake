import 'package:flutter/material.dart';

class InsumosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insumos'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                child: Text('Insumos'),
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 181, 216),
                    primary: Color.fromARGB(255, 93, 42, 66),
                    textStyle: TextStyle(fontSize: 15),
                    minimumSize: Size(180, 50),
                    padding: EdgeInsets.all(20)),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Pronta Caducacion'),
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 181, 216),
                      primary: Color.fromARGB(255, 93, 42, 66),
                      textStyle: TextStyle(fontSize: 15),
                      minimumSize: Size(180, 50))),
              ElevatedButton(
                  onPressed: () {},
                  child: Text('Productos'),
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 181, 216),
                    primary: Color.fromARGB(255, 93, 42, 66),
                    textStyle: TextStyle(fontSize: 15),
                    minimumSize: Size(180, 50),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
