import 'package:flutter/material.dart';
import 'package:wholecake/views/utilities/sidebar.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      ),
      drawer: const SideBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
