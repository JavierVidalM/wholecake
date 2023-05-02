import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Monedas',
      theme: ThemeData.dark(),
      home: const ConversionMonedas(),
    );
  }
}

class ConversionMonedas extends StatefulWidget {
  const ConversionMonedas({Key? key}) : super(key: key);

  @override
  _ConversionMonedasState createState() => _ConversionMonedasState();
}

class _ConversionMonedasState extends State<ConversionMonedas> {
  double _montoCLP = 1000.0;
  double _montoUF = 0.0;
  double _montoUSD = 0.0;
  double _montoEUR = 0.0;
  final String _urlAPI = 'https://mindicador.cl/api';

  Future<Map<String, dynamic>> _obtenerTasaDeCambio() async {
    final response = await http.get(Uri.parse(_urlAPI));
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Monedas'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _obtenerTasaDeCambio(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final Map<String, dynamic> data = snapshot.data!;
            final double tasaUF = data['uf']['valor'];
            final double tasaUSD = data['dolar']['valor'];
            final double tasaEUR = data['euro']['valor'];
            _montoUF = _montoCLP / tasaUF;
            _montoUSD = _montoCLP / tasaUSD;
            _montoEUR = _montoCLP / tasaEUR;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Monto en CLP',
                    ),
                    keyboardType: TextInputType.numberWithOptions(),
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _montoCLP = double.tryParse(value) ?? 0.0;
                      });
                    },
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Monto en UF: $_montoUF',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Monto en USD: $_montoUSD',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Monto en EUR: $_montoEUR',
                    style: const TextStyle(fontSize: 20.0),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Ocurrió un error al obtener la tasa de cambio.',
                style: TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
