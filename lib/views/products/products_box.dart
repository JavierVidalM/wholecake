import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  const MyBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: Color(0xFFFFB5D7), borderRadius: BorderRadius.circular(20)),
        child: Column(children: [
          //cantidad
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Color(0xFFFFB5D7),
                    borderRadius: BorderRadius.circular(12)),
                child: Text(
                  '35',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
          //foto de producto
          Padding(
            padding: const EdgeInsets.all(24.0),
          ),
        ]),
      ),
    );
  }
}
