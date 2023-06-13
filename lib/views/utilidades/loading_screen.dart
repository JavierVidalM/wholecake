import 'package:flutter/material.dart';
import 'package:wholecake/views/utilidades/sidebar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
